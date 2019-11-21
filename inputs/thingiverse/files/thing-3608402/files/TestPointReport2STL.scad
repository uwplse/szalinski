/*  This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <https://www.gnu.org/licenses/>.   
*/

/*
An OpenSCAD script to convert a csv file containing a pcb test point report - generated e.g. from Altium Designer, KiCAD, Eagle or any other PCB design software - into a 3D model of a holder for mounting test probes for electrical tests.

Documentation and the latest version of this script can be found at: https://github.com/5inf/TestPointReport2STL

*/

//////////////////////////////////////////////////////////
//////////////// CONFIGURE BELOW//////////////////////////
//////////////////////////////////////////////////////////

//data of testpoints
/* [test point data] */
testpointdata=[
/* paste testpoint data here */
["GND", "T13-1", [8.2118,11.7856,0], "Bottom", 0, "075-PRP259RS-S", "075-SDN250S"],
["+5.0V", "T1-1", [23.8252,25.1206,0], "Bottom", 0, "075-PRP259RS-S", "075-SDN250S"],
["NetJ1_1", "T2-1", [29.4386,34.925,0], "Bottom", 0, "075-PRP259RS-S", "075-SDN250S"],
["GND", "T3-1", [10.3124,25.527,0], "Bottom", 0, "075-PRP259RS-S", "075-SDN250S"],
["SDA", "T4-1", [29.464,33.3502,0], "Top", 0, "075-PRP259RS-S", "075-SDN250S"],
["SCL", "T5-1", [26.793,32.428,0], "Top", 0, "075-PRP259RS-S", "075-SDN250S"],
["-5.0V", "T6-1", [31.6774,9.1419,0], "Bottom", 0, "075-PRP259RS-S", "075-SDN250S"],
["", "M4", [5,5,0], "Both", 0, "", ""],
["", "M3", [5,35,0], "Both", 0, "", ""],
["", "M2", [35,5,0], "Both", 0, "", ""],
["", "M1", [35,35,0], "Both", 0, "", ""]
/* end of paste testpoint data here */
];

//Parameters for the simple rectangular testpoint holder block
/* [Simple] */
//build fixture for needles for top testpoints
buildtop=true; 
//build fixture for needles for top testpoints
buildbottom=true; 
//extra width of mounting sheet in x direction
borderx=20;         
//extra width of mounting sheet in y direction
bordery=10;         
//thickness of mounting block holding the test probes
sheetthickness=10;

//Advanced model generation
/* [Visual] */
//show the actual testpins
showpins=false; 
//the initial distance of the pins from the surface of the pcb
initialpindistance=1; 

//Generate mounting plates
drawmountingsystem=false;  

//include a second holder for the pcb top side
includetoppcbholder=false;

//load a pcb 3d model specified by pcb path below
showpcb = false;    
//path to loadable pcb file (note: OpenSCAD supports stl format only)
pcbpath="";         
//show a dummy pcb model
showpcbdummy = false; 
//show the test pad locations on the dummy pcb as a simple cylinder shape
showtestpads = false; //show the test pad locations on the dummy pcb as a simple cylinder shape
//thickness of the (dummy) PCB
pcbthickness=1.6;   

//Animation options
/* [Animation] */
//distance of movement of the pcb under test towards the bottom holder. The top holder moves twice as far.
movementdistance=5; 

/* [Hidden] */
//Data specific to the default QATech.com 075-SDN250S/075-PRP259RS-S test needles 
//minimum distance of test needle tip from where it is mounted
minpointheight=0;  
//maximum distance of test needle tip from where it is mounted
maxpointheight=6.35;  

//////////////////////////////////////////////////////////
/////////////// DO NOT EDIT BELOW ////////////////////////
//////////////////////////////////////////////////////////

timeoffset=initialpindistance/movementdistance;

span=maxpointheight-minpointheight;

pointstop=[for(v=testpointdata)if(v[3]!="Bottom")v];
//echo(pointstop);

pointsbottom=[for(v=testpointdata)if(v[3]!="Top")v];
//echo(pointsbottom);

maxx=max([for(v=testpointdata)v[2][0]]);
minx=min([for(v=testpointdata)v[2][0]]);
maxy=max([for(v=testpointdata)v[2][1]]);
miny=min([for(v=testpointdata)v[2][1]]);

maxtop=max([for(v=pointstop)v[2][2]]);
mintop=min([for(v=pointstop)v[2][2]]);
maxbottom=max([for(v=pointsbottom)v[2][2]]);
minbottom=min([for(v=pointsbottom)v[2][2]]);

maxdisttop=maxtop-mintop;
maxdistbottom=maxbottom-minbottom;

if(movementdistance>initialpindistance+span){
    echo ("ERROR: moving to far. Pins and setup might get damaged!");
}
if(movementdistance<initialpindistance+maxdisttop){
    echo ("ERROR: moving not far enough. Top pins might not all connect!");
}
if(movementdistance<initialpindistance+maxdistbottom){
    echo ("ERROR: moving not far enough. Bottom pins might not all connect!");
}

if(drawmountingsystem){
    //draw top block with interconnect pcb

    translate([0,0,0]){
        //WAMMountingTop(zpos=maxtop+span+2);
    }
    //draw top bcb holder (this holder is optional as one option to hold down the pcb.)
    if(includetoppcbholder){
    translate([0,0,0]){
        WAMMountingMiddle(zpos=+(-1.6+5)/2);
    }
}
    //draw bottom pcb holder
    translate([0,0,0]){
        WAMMountingMiddle(zpos=-(1.6+5)/2);
    }
    //draw bottom block with interconnect pcb
    //WAMMountingBottom(zpos=-maxbottom-span-9,movementdistance=movementdistance);
}


//center testpoints arround origin
translate([-(minx+maxx)/2,-(maxy+miny)/2,0]){
    
    //dummy PCB
    translate([0,0,0]){
        if(showpcbdummy){
            translate([minx-5,miny-5,-pcbthickness/2]){
                    color("Green",alpha=0.4)
                    cube([maxx-minx+10,maxy-miny+10,pcbthickness],center=false);
                }
        }
        //external pcb model
        if(showpcb){
            import(pcbpath);
        }
        //testpads
        if(showtestpads){
            union(){
                $fs=0.3;
            for(point=pointstop){
                color("Gold")
                translate([point[2][0],point[2][1],pcbthickness/2]){
                    difference(){
                        cylinder(d=point[4]+0.4,h=0.1);
                        translate([0,0,-1])cylinder(d=point[4],h=3);
                    }
                }
                }
            for(point=pointsbottom){
                color("Gold")
                translate([point[2][0],point[2][1],-pcbthickness/2-0.1]){
                    difference(){
                        cylinder(d=point[4]+0.4,h=0.1);
                        translate([0,0,-1])cylinder(d=point[4],h=3);
                    }
                }
                }
            }
        }
    }
    if(buildtop && !(pointstop==[])){
        if(maxdisttop>span){
            echo("ERROR: Span on top to high", span, maxdistbottom);
        }else{
            translate([0,0,0]){
        //the top holder and test pins
            translate([0,0,pcbthickness/2+initialpindistance])
            union(){
                difference(){
                    if(!drawmountingsystem){
                    translate([minx-borderx,miny-bordery,maxtop+span+2]){
                        //color("red",alpha=0.5)
               cube([maxx-minx+2*borderx,maxy-miny+2*bordery,sheetthickness],center=false);
                        }}else{
                    translate([+(minx+maxx)/2,+(maxy+miny)/2,0]){
                        WAMMountingTop(zpos=maxtop+span+2);                
                    }}
                    for(point=pointstop){
                        translate([point[2][0],point[2][1],0]){
                            pinhole(socket=point[6]);
                        }
                    }
                }

                if(showpins){
                    for(point=pointstop){
                        translate([point[2][0],point[2][1],point[2][2]]){
                            testpin(ontop=true,inset=point[2][2]+initialpindistance,probe=point[5],socket=point[6],movementdistance=movementdistance);
                        }
                    }
                }
            }
        }
    }
    }

    if(buildbottom && !(pointsbottom==[])){
        if(maxdistbottom>span){
            echo("ERROR: Span on bottom to high", span, maxdistbottom);
        }else{
            //the bottom holder and testpins
            translate([0,0,-pcbthickness/2-initialpindistance])
            union(){
                difference(){
                    if(!drawmountingsystem){
                    translate([minx-borderx,miny-bordery,-maxbottom-span-12]){
                        color("blue",alpha=0.5)
                        cube([maxx-minx+2*borderx,maxy-miny+2*bordery,sheetthickness],center=false);
                    }}else{
                    translate([+(minx+maxx)/2,+(maxy+miny)/2,0]){
                    WAMMountingBottom(zpos=-maxbottom-span-9,movementdistance=movementdistance);
                    }
                    }
                    for(point=pointsbottom){
                        translate([point[2][0],point[2][1],0]){
                            pinhole(socket=point[6]);
                        }
                    }
                }
                if(showpins){
                    for(point=pointsbottom){
                        translate([point[2][0],point[2][1],-point[2][2]])
                            testpin(ontop=false,inset=point[2][2]+initialpindistance,probe=point[5],socket=point[6],movementdistance=movementdistance);
                    }
                }
            }
        }
    }
}


/////////////////////////////////////
//models the complete test pin
module testpin(ontop=true,inset=0,probe="",socket="",inset=0,movementdistance=0){
    $fs=0.3;
    rotate([0,ontop?0:180,0]){
        probe(probe=probe,inset=inset,movementdistance=movementdistance);
        socket(socket=socket);
    }
}

//models the hole that gets drilled through the sheet
module pinhole(socket=""){
   $fs=0.3;
    if(socket=="050-SRB255P"){
       // QATech.com
       cylinder(h=1000,d=1.0,center=true);
   }else if(socket=="050-STB255P"){
       // QATech.com
       cylinder(h=1000,d=1.0,center=true);
   }else if(socket=="075-SDN250S"){
       // QATech.com socket 075-SDN250S
       cylinder(h=1000,d=1.35,center=true);
   }else if(socket=="075-PRP259RS-S"){
       //default: QATech.com socket 075-SDN250S
       cylinder(h=1000,d=1.35,center=true);
   }else{
       //default: QATech.com socket 075-SDN250S
       cylinder(h=1000,d=1.35,center=true);
   }   
}

module probe(probe="",inset=0,movementdistance=0){
   //Probe QATech.com 075-PRP259RS-S
    delay=inset/movementdistance;
    translate([0,0,0]){ 
       $fs=0.1;
       if(probe=="050-PTP2540S"){
           color("Gold")
           //tip part 1
           translate([0,0,0.53/2])sphere(d=0.53);
           //tip part 2
           color("Gold")
            translate([0,0,0.53/2])cylinder(h=2,d=0.53,center=false);
           //shaft 
           color("Gold")
           translate([0,0,2])cylinder(h=8,d=0.53,center=false);
        }else 
        if(probe=="050-PTP2541S"){
           color("Gold")
           //tip part 1
           translate([0,0,0])cylinder(h=2,d1=0,d2=0.53,center=false);
           //tip part 2
           //shaft 
           color("Gold")
           translate([0,0,2])cylinder(h=8,d=0.53,center=false);
        }else if(probe=="050-PRP2540S"){
           color("Gold")
           //tip part 1
           translate([0,0,0.53/2])sphere(d=0.53);
           color("Gold")
           //tip part 2
           translate([0,0,0.53/2])cylinder(h=2,d=0.53,center=false);
           //shaft 
           color("Gold")
           translate([0,0,2])cylinder(h=8,d=0.53,center=false);
        }else
        if(probe=="050-PRP2541S"){
           color("Gold")
           //tip part 1
           translate([0,0,0])cylinder(h=2,d1=0,d2=0.53,center=false);
           //tip part 2
           //shaft 
           color("Gold")
           translate([0,0,2])cylinder(h=8,d=0.53,center=false);
        }else if(probe=="075-PRP2501S"){
           color("Gold")
           //tip part 1
           translate([0,0,0])cylinder(h=1.27/2,d1=0,d2=1.17,center=false);
           //tip part 2
           color("Gold")
           translate([0,0,1.27/2])cylinder(h=1.27/2,d=1.17,center=false);
           //shaft 
           color("Gold")
           translate([0,0,1.27])cylinder(h=8,d=0.64,center=false);
       }else if(probe=="075-PRP2510S"){
           color("Gold")
           //tip part 1
           translate([0,0,0])cylinder(h=1.17,d=1.17,center=false);
           //tip part 2
           //shaft 
           color("Gold")
           translate([0,0,1.27])cylinder(h=8,d=0.64,center=false);
        }else if(probe=="075-PRP2520S"){
           color("Gold")
           //tip part 1
           translate([0,0,0])cylinder(h=2,d=0.64,center=false);
           //tip part 2
           //shaft 
           color("Gold")
           translate([0,0,1.27])cylinder(h=8,d=0.64,center=false);
       }else if(probe=="075-PRP2540S"){
           color("Gold")
           //tip part 1
           translate([0,0,0.64/2])sphere(d=0.64);
           //tip part 2
           color("Gold")
           translate([0,0,0.64/2])cylinder(h=2,d=0.64,center=false);
           //shaft 
           color("Gold")
           translate([0,0,2])cylinder(h=8,d=0.64,center=false); 
       }else if(probe=="075-PRP259RS-S"){
           color("Gold")
           //tip part 1
           //tip part 2
           translate([0,0,0])cylinder(h=2,d1=0,d2=0.64,center=false);
           //shaft 
           color("Gold")
           translate([0,0,2])cylinder(h=8,d=0.64,center=false);
       }else {//Default
           //tip part 1
           color("Blue")
           translate([0,0,-0.5])cylinder(h=0.5,d1=2,d2=3,center=false);
           //tip part 2
           color("Red")
           translate([0,0,0])cylinder(h=2,d1=3.5,d2=0.64,center=false);
           //shaft 
           color("Red")
           translate([0,0,2])cylinder(h=7.62,d=0.64,center=false);
       }
   }
}

module socket(socket=""){
   //Socket QATech.com 075-SDN250S 
   $fs=0.1;
   if(socket=="050-SRB255P"){
       color("Gray")
       // QATech.com
       translate([0,0,43.18-36.27])cylinder(h=40.41,d=0.95,center=false);
       translate([0,0,8+5.08])cylinder(h=1,d=1.0,center=false);
       color("blue")
       translate([0,0,8+7.37])cylinder(h=1,d=1.05,center=false);
       translate([0,0,8+11.71])cylinder(h=1,d=1.0,center=false);      
   }else if(socket=="050-STB255P"){
       color("Gray")
       // QATech.com
       translate([0,0,43.18-36.27])cylinder(h=31.83,d=0.95,center=false);
       translate([0,0,8+5.08])cylinder(h=1,d=1.0,center=false);
       color("fuchsia")
       translate([0,0,8+7.37])cylinder(h=1,d=1.05,center=false);
       translate([0,0,8+11.71])cylinder(h=1,d=1.0,center=false);      
   }else if(socket=="075-SDN250S"){
       // QATech.com 075-SDN250S
       color("Gray")
       translate([0,0,7.8])cylinder(h=29.72,d=1.021,center=false);
       color("yellow")
       translate([0,0,7.8+7.62])cylinder(h=1,d=1.46,center=false);      
   }else{
       //default: QATech.com 075-PRP259RS-S with socket 075-SDN250S
       color("red")
       translate([0,0,7.8])cylinder(h=29.72,d=1.021,center=false);
       color("red")
       translate([0,0,7.8+7.62])cylinder(h=1,d=1.46,center=false);
   }
}
///////////////////////////////////////////////////////

module WAMMountingTop(zpos=0){
    //WA-AP-100 pressure plate / Andruckplatte
    //TODO: correct hole positions
    translate([0,0,zpos+7]){
    difference(){
        color("White",alpha=0.2)
        cube([190,110,10], center=true);
        translate([90,-50,0])cylinder(d=1.6,h=10,center=true);
        translate([90,0,0])cylinder(d=1.6,h=10,center=true);
        translate([90,50,0])cylinder(d=1.6,h=10,center=true);
        translate([-90,-50,0])cylinder(d=1.6,h=10,center=true);
        translate([-90,0,0])cylinder(d=1.6,h=10,center=true);
        translate([-90,50,0])cylinder(d=1.6,h=10,center=true);
        translate([0,-20,0])cylinder(d=1.6,h=10,center=true);
        translate([0,20,0])cylinder(d=1.6,h=10,center=true);
    }
    //interconnect pcb
    translate([0,0,(10+1.6)/2])color("Green")cube([160,100,1.6], center=true); 
    // push rods  
    translate([-80,50,-22]){cylinder(d=8,h=22);}
    translate([80,50,-22]){cylinder(d=8,h=22);}
}
}

module WAMMountingMiddle(zpos=0){
    //WA-PAP-100 mounting plate / Prüflingsauflageplatte
    //TODO: correct hole positions
    //Comes with a dummy coutout as hole. Adjust this cutout according to the actual pcb outline
    translate([0,0,zpos+1.6])color("MediumSlateBlue",alpha=0.2)
    difference(){
        cube([190,110,5], center=true);
        //dummy pcb cutout
        translate([0,0,0])cube([38,38,5], center=true);
        translate([0,0,+2.5-1.6/2])cube([40.5,40.5,1.6], center=true);
        
        //mounting holes
        translate([80,50,0])cylinder(d=10,h=10,center=true);
        translate([-80,50,0])cylinder(d=10,h=10,center=true);
        
        translate([90,-5,0])cylinder(d=3,h=10,center=true);
        translate([90,-25,0])cylinder(d=3,h=10,center=true);
        translate([90,-45,0])cylinder(d=3,h=10,center=true);
        translate([-90,-5,0])cylinder(d=3,h=10,center=true);
        translate([-90,-25,0])cylinder(d=3,h=10,center=true);
        translate([-90,-45,0])cylinder(d=3,h=10,center=true);
        
        translate([90,20,0])cylinder(d=1.6,h=10,center=true);
        translate([90,10,0])cylinder(d=1.6,h=10,center=true);
        translate([90,0,0])cylinder(d=1.6,h=10,center=true);
        translate([90,-10,0])cylinder(d=1.6,h=10,center=true);
        translate([90,-20,0])cylinder(d=1.6,h=10,center=true);
        translate([90,-30,0])cylinder(d=1.6,h=10,center=true);
        translate([90,-40,0])cylinder(d=1.6,h=10,center=true);
        translate([90,-50,0])cylinder(d=1.6,h=10,center=true);
        translate([-90,20,0])cylinder(d=1.6,h=10,center=true);
        translate([-90,10,0])cylinder(d=1.6,h=10,center=true);
        translate([-90,0,0])cylinder(d=1.6,h=10,center=true);
        translate([-90,-10,0])cylinder(d=1.6,h=10,center=true);
        translate([-90,-20,0])cylinder(d=1.6,h=10,center=true);
        translate([-90,-30,0])cylinder(d=1.6,h=10,center=true);
        translate([-90,-40,0])cylinder(d=1.6,h=10,center=true);
        translate([-90,-50,0])cylinder(d=1.6,h=10,center=true);
    }
}

module WAMMountingBottom(zpos=0,movementdistance=0){
    //WA-M-1200 contact plate / Kontaktträgerplatte
    //TODO: correct hole positions
    translate([0,0,zpos]){
        difference(){
            color("Cornsilk")cube([190,110,10], center=true);
            translate([90,-5,0])cylinder(d=3,h=10,center=true);
            translate([90,-25,0])cylinder(d=3,h=10,center=true);
            translate([90,-45,0])cylinder(d=3,h=10,center=true);
            translate([-90,-5,0])cylinder(d=3,h=10,center=true);
            translate([-90,-25,0])cylinder(d=3,h=10,center=true);
            translate([-90,-45,0])cylinder(d=3,h=10,center=true);
       
            translate([90,20,0])cylinder(d=1.6,h=10,center=true);
            translate([90,10,0])cylinder(d=1.6,h=10,center=true);
            translate([90,0,0])cylinder(d=1.6,h=10,center=true);
            translate([90,-10,0])cylinder(d=1.6,h=10,center=true);
            translate([90,-20,0])cylinder(d=1.6,h=10,center=true);
            translate([90,-30,0])cylinder(d=1.6,h=10,center=true);
            translate([90,-40,0])cylinder(d=1.6,h=10,center=true);
            translate([90,-50,0])cylinder(d=1.6,h=10,center=true);
            translate([-90,20,0])cylinder(d=1.6,h=10,center=true);
            translate([-90,10,0])cylinder(d=1.6,h=10,center=true);
            translate([-90,0,0])cylinder(d=1.6,h=10,center=true);
            translate([-90,-10,0])cylinder(d=1.6,h=10,center=true);
            translate([-90,-20,0])cylinder(d=1.6,h=10,center=true);
            translate([-90,-30,0])cylinder(d=1.6,h=10,center=true);
            translate([-90,-40,0])cylinder(d=1.6,h=10,center=true);
            translate([-90,-50,0])cylinder(d=1.6,h=10,center=true);
            
            translate([-30,-50,0])cylinder(d=3.2,h=10,center=true);
            translate([30,-50,0])cylinder(d=3.2,h=10,center=true);
            translate([-30,50,0])cylinder(d=3.2,h=10,center=true);
            translate([30,50,0])cylinder(d=3.2,h=10,center=true);
        }
        //interconnect pcb
        translate([0,0,-(10+1.6)/2])color("Green")cube([160,100,1.6], center=true); 
        //guiding rods
        guidingRod([-90,-45,-2-(10+1.6)/2]);
        guidingRod([-90,45,-2-(10+1.6)/2]);
        guidingRod([90,-45,-2-(10+1.6)/2]);
        guidingRod([90,45,-2-(10+1.6)/2]);
        //bottom pcb holder distance spring rods
        distanceSpringRod([-88,-50,-1-(10+1.6)/2],movementdistance=movementdistance);
        distanceSpringRod([88,-50,-1-(10+1.6)/2],movementdistance=movementdistance);
        distanceSpringRod([88,50,-1-(10+1.6)/2],movementdistance=movementdistance);
        distanceSpringRod([-88,50,-1-(10+1.6)/2],movementdistance=movementdistance);
    }
}

module distanceSpringRod(pos=[0,0,0],movementdistance=0){
    translate(pos){
        color("DimGray")translate([0,0,-2])cylinder(d=3,h=15);
        translate([0,0,0]){
            color("Gold")translate([0,0,19.5])cylinder(d=3,h=2);
            color("Gold")translate([0,0,10])cylinder(d=1,h=10);
        }
    }
}
module guidingRod(pos=[0,0,0]){
    translate(pos){
        color("Black")translate([0,0,0])
            cylinder(d=3,h=25);
        }
}