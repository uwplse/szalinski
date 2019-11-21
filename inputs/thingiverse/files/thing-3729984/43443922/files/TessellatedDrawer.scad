$fs=1;
$fa=1;

//The Number of Sides of the Drawer
numSides=6; //[3,4,5,6,7,8,9,10,11,12,13,14,15]

//Lenght of Each Side
sideLength=40;

//Depth of the Drawer
depth=75;

//Thickness of the Drawer Shell
shellThickness=5;

//Thickness of the Inner Drawer
drawerThickness=2;

//How Much Gap from Shell to Drawer
drawerSlop=.3;

//Select What Item to Show 1:Shell, 2:Drawer, 3:Knob, 4:Full Assembly
thingToShow=4; //[1,2,3,4]

if(thingToShow==1){
Shell(numSides,sideLength,depth,shellThickness);
}

if(thingToShow==2){
color("GREEN")Drawer(numSides,sideLength,depth,shellThickness,drawerThickness);
}

if(thingToShow==3){
Knob(numSides,sideLength,depth,shellThickness,drawerThickness);
}

if(thingToShow==4){
Shell(numSides,sideLength,depth,shellThickness);
color("GREEN")Drawer(numSides,sideLength,depth,shellThickness,drawerThickness);
Knob(numSides,sideLength,depth,shellThickness,drawerThickness);
}


module Shell(numSides=6,sideLength=100,depth=150,thickness=10){
    
    //Vars for Tabs and Grooves and Length Dia
    diameter=sideLength/sin(180/numSides);
    smallRad=diameter/2*cos(180/numSides);
    tabDia=thickness*.8;

    //-----------------The Main Outer Shell with Tabs and Grooves-----------------------------
    difference(){
        cylinder(h=depth,d=diameter,$fn=numSides,center=true);
        cylinder(h=depth+2,d=diameter-2*thickness,$fn=numSides,center=true);
        //cut grooves
        for(angle=[360/numSides:360/numSides*2:359]){
            rotate([0,0,angle])
            for(y=[-sideLength/4:sideLength/4:sideLength/4]){
                difference(){
                    rotate([0,0,180/numSides])
                    translate([smallRad-tabDia/4,y,0])
                    cylinder(h=depth+2,d=tabDia+.2,center=true);}
            }
        }
    }
        //add tabs on ends
        for(angle=[0:360/numSides*2:359]){
        rotate([0,0,angle])
        for(y=[-sideLength/4:sideLength/4:sideLength/4]){
            rotate([0,0,180/numSides])
            translate([smallRad+tabDia/4,y,0])
            cylinder(h=depth,d=tabDia,center=true);
        }
    }

        
    //---------------------------Back of Drawer-------------------------
    backThickness=thickness*.3;
    backDia=diameter*.5;
       
    // Create the center shape
    translate([0,0,-depth/2+backThickness/2]){
        difference(){
            cylinder(h=backThickness,d=backDia,$fn=numSides,center=true);
            cylinder(h=backThickness+2,d=backDia-2*backThickness,$fn=numSides,center=true);
            
        }
    }
    
    //Create the spokes coming out of the corners of center shape
    translate([0,0,-depth/2+backThickness/2])
    difference(){
        for(angle=[0:360/numSides:359]){
            rotate([0,0,angle])
            translate([diameter/4-thickness/2,0,0])
            cube([diameter/2-thickness,backThickness,backThickness],center=true);
        }
        cylinder(h=backThickness+2,d=backDia-2*backThickness,$fn=numSides,center=true);
    }
       
    
}

module Drawer(numSides=6,sideLength=100,depth=150,shellThickness=10,drawerThickness=2){
    
    //Vars for Tabs and Grooves and Length Dia
    diameter=sideLength/sin(180/numSides);
    smallRad=diameter/2*cos(180/numSides);
    tabDia=shellThickness*.4;
    backThickness=shellThickness*.3;
    
    drawerInnerDia=diameter-2*shellThickness-drawerSlop-drawerThickness*2;
    drawerInnerLen=depth-backThickness-drawerThickness*2;
    angleToFlat=90-180/numSides;
    
    pinThick=2;
    pinOffset=5;
    
    difference(){
        cylinder(h=depth-backThickness,d=diameter-2*shellThickness-drawerSlop,$fn=numSides,center=true);
        cylinder(h=drawerInnerLen,d=drawerInnerDia,$fn=numSides,center=true);
        rotate([0,0,angleToFlat]){
            translate([0,drawerInnerDia/2,0])cube([diameter,drawerInnerDia,drawerInnerLen],center=true);
            translate([pinOffset,0,(depth/2-backThickness)])
                cylinder(h=drawerThickness*4,d=pinThick,center=true);
            translate([-pinOffset,0,(depth/2-backThickness)])
                cylinder(h=drawerThickness*4,d=pinThick,center=true);
        }        
    }   
}

module Knob(numSides=6,sideLength=100,depth=150,shellThickness=10,drawerThickness=2){
    diameter=17;
    knobThick=5;
    pinThick=1.9;
    pinOffset=5;
    backThickness=shellThickness*.3;
    angleToFlat=90-180/numSides;
    
    rotate([0,0,angleToFlat]){
    translate([pinOffset,0,(depth/2-backThickness)])
        cylinder(h=drawerThickness*2,d=pinThick,center=true);
    translate([-pinOffset,0,(depth/2-backThickness)])
        cylinder(h=drawerThickness*2,d=pinThick,center=true);
    
     }  
    translate([0,0,(depth/2-backThickness)])
        cylinder(h=knobThick,d=diameter,$fn=numSides,center=false);
    
}






