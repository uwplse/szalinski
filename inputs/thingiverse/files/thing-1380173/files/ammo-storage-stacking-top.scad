//Basic definition:
//Higher number = more faces = smoother model = slower processing.
$fn=50; 

//Case definition: 6.5x55 Swedish Mauser
//Base diameter of casing/rim 
d0=12.2; 
h4=80;  

//Case scaling to allow oversized/fired cases
casescaling=1.01; 

//Block definition:
//Total number of cases you want
noOfCases=20;
//No of rows in the Y direction.
Rows=4;  
//Thickness of material outside hole
rim=3;  
//Total height of the block.
height=15;  
//Bottom thickness below round.
bottomthickness=2; 
//Height of locking pins 0=no pin. Minimum 4 rows is needed to have pins.
pinheight=2;  
//Chamfer distance of the hole 0=no chamfer
holechamfer=0.5;  
//Chamfer distance of the outside edge 0=no chamfer.
outerchamfer=1;

module corner(xpos,ypos,height,cornerradius,outerchamfer){
    translate([xpos,ypos,0])
    difference(){
      cylinder(h=height,r=cornerradius);
      translate([0,0,height])
         rotate_extrude(convexity=10)
             translate([cornerradius,0,0])
                circle(outerchamfer,$fn=4);  
     rotate_extrude(convexity=10)
         translate([cornerradius,0,0])
            circle(outerchamfer,$fn=4);  
    }   
}

module hole(xpos,ypos,zpos){
    translate([xpos,ypos,zpos]){
        cylinder(h=height,d=holediameter);
        translate([0,0,bottomthickness])
            rotate_extrude(convexity=10)
                translate([holediameter/2,0,0])
                    circle(holechamfer,$fn=4);
    }
}

function offset(rows)=(rows>1)?0:xoffset/2;

depth=height-bottomthickness;  //Seating dept of round in block. 
casesperrow=noOfCases/Rows; //No of cases in X direction. 

holediameter=d0*casescaling;
xoffset=holediameter+rim;
yoffset=xoffset*0.866;//Sqrt(3)/2=cos(30deg)
cornerradius=holediameter/2+rim;
xpin=(rim+xoffset-holediameter/2)/2;

x=xoffset*(casesperrow-0.5)+holediameter+2*rim-2*cornerradius;
y=yoffset*(Rows-1)+holediameter+2*rim-2*cornerradius;

difference(){

    hull()
    translate([cornerradius,cornerradius,0]){
        corner(0,0,height,cornerradius,outerchamfer);
        corner(0,y,height,cornerradius,outerchamfer);
        corner(x-offset(Rows),0,height,cornerradius,outerchamfer);
        corner(x-offset(Rows),y,height,cornerradius,outerchamfer);
    }
 
    translate([holediameter/2+rim,holediameter/2+rim,0]){
        for(i=[0:casesperrow-1]){
            for(j=[0:Rows-1]){
                hole((i+(j/2-floor(j/2)))*xoffset,j*yoffset,-bottomthickness);
            }
        }
    }
    if(Rows>3){
        translate([xpin,holediameter/2+rim,-0.5]){
            translate([0,yoffset,0]) cylinder(h=pinheight+1,d=xpin+0.1);
            translate([xoffset*casesperrow,yoffset*(floor((Rows-2)/2)*2),0]) cylinder(h=pinheight+1,d=xpin+0.1);
        }
    }
}


if(Rows>3){
    translate([xpin,holediameter/2+rim,height]){
        translate([0,yoffset,0]) cylinder(h=pinheight,d=xpin);
        translate([xoffset*casesperrow,yoffset*(floor((Rows-2)/2)*2),0]) cylinder(h=pinheight,d=xpin);
    }
}
