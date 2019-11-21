//The entire system here uses MM in sizes,
//This is used to make the holes slightly larger to allow for clean hole punches. 
holeCreationOffset=0.05;
// How wide you printer nozzle is
printerTipWidth=0.48; 
//How long you want your rods to be, this is for the measurement guidance
desiredRodLength=269; //38
// The diameter of the rods you are using for the Delta Rods
rodDiameter=4.65;
// How long the end piece is that connects to the rods and the effector
rodEndsLength=24.5;
// How wide your saw blade is, this should roughly be the thickness of the blade. This allows the blade to bee held snugly in the mitre channel.
bladeWidth=0.75;
// The diameter of the holes that are used for mounting 
mountingholeDiameter=3.5 + (printerTipWidth/2);
// How wide the bracket is, should be the width of the extrusion
mountingBracketWidth=20;
// how long the bracket is on the extrusion, this should roughly be 2 x the width of the extrusion
mountingBracketHeight=40;
//how thick the mounting bracket is
mountingBracketThickness=3;
// How wide the bracket is, should be the width of the extrusion
cuttingBracketWidth=20;
// how long the bracket is on the extrusion, this should roughly be 2 x the width of the extrusion
cuttingBracketHeight=40;
// How wide the bracket is, should be the width of the extrusion
cuttingBracketThickness=3;
partoffset=(mountingBracketWidth + mountingBracketWidth) /2;
mountingholeRadius=mountingholeDiameter/2;
rodRadius=(printerTipWidth + rodDiameter) / 2;
//Forumla to create the rod length information 
cutRodLength=desiredRodLength - (mountingBracketHeight/2) - ((cuttingBracketHeight/2) - bladeWidth) - (rodEndsLength *2);

module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn, center = true);
}
   
module cylinder_outerdual(height,radius,radiustwo,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r1=radius*fudge,r2=radiustwo*fudge,$fn=fn, center = true);
}
   
module cylinder_mid(height,radius,fn){
   fudge = (1+1/cos(180/fn))/2;
   cylinder(h=height,r=radius*fudge,$fn=fn, center = true);
}
   
module createMeniscus(h,radius) {// This module creates the shape that needs to be substracted from a cube to make its corners rounded.
    difference(){        //This shape is basicly the difference between a quarter of cylinder and a cube
       translate([radius/2+0.1,radius/2+0.1,0]){
          cube([radius+0.2,radius+0.1,h+0.2],center=true);         // All that 0.x numbers are to avoid "ghost boundaries" when substracting
       }

       cylinder(h=h+0.2,r=radius,$fn = 25,center=true);
    }
}

module roundCornersCube(x,y,z,r){  // Now we just substract the shape we have created in the four corners
    difference(){
       cube([x,y,z], center=true);

    translate([x/2-r,y/2-r]){  // We move to the first corner (x,y)
          rotate(0){  
             createMeniscus(z,r); // And substract the meniscus
          }
       }
       translate([-x/2+r,y/2-r]){ // To the second corner (-x,y)
          rotate(90){
             createMeniscus(z,r); // But this t�ime we have to rotate the meniscus 90 deg
          }
       }
          translate([-x/2+r,-y/2+r]){ // ... 
          rotate(180){
             createMeniscus(z,r);
          }
       }
          translate([x/2-r,-y/2+r]){
          rotate(270){
             createMeniscus(z,r);
          }
       }
    }
}


module deltaRodTemplate(){
    cuttingBracket();
    mountingBracket();
    echo("Mount the mounting bracket and then measure this far to mount the cutting bracket" );
    echo(cutRodLength);
    
}

module mountingBracket(){
    difference(){
        union(){
            translate([0,0,0]) roundCornersCube(mountingBracketWidth,mountingBracketHeight,mountingBracketThickness,3);
            difference(){
                translate([0,0,cuttingBracketWidth/4 + mountingBracketThickness/2]) roundCornersCube(cuttingBracketWidth,cuttingBracketWidth/2,cuttingBracketWidth/2,3);
                translate([0,bladeWidth/2,cuttingBracketWidth/2]) roundCornersCube(cuttingBracketWidth + holeCreationOffset,bladeWidth+holeCreationOffset,cuttingBracketWidth + holeCreationOffset,0);
                
            }
        }
        translate([0,mountingBracketHeight/4,0]) cylinder_mid(50,mountingholeRadius,360);
        translate([0,-mountingBracketHeight/4,0]) cylinder_mid(50,mountingholeRadius,360);
        translate([0,mountingBracketWidth/4,rodDiameter*1.5]) rotate(a=[90,0,0]) cylinder_mid(cuttingBracketWidth/2,rodRadius,360);
    }
    
}


module cuttingBracket(){
    difference(){
        union(){
            translate([-partoffset * 1.1,0,0]) roundCornersCube(cuttingBracketWidth,cuttingBracketHeight,cuttingBracketThickness,3);
            difference(){
                translate([-partoffset * 1.1,0,cuttingBracketWidth/4 + cuttingBracketThickness/2]) roundCornersCube(cuttingBracketWidth,cuttingBracketWidth/2,cuttingBracketWidth/2,3);
                translate([-partoffset * 1.1,0,cuttingBracketWidth/2]) roundCornersCube(cuttingBracketWidth + holeCreationOffset,bladeWidth+holeCreationOffset + holeCreationOffset,cuttingBracketWidth + holeCreationOffset,0);
                
            }
        }
        translate([-partoffset * 1.1,cuttingBracketHeight/4,0]) cylinder_mid(50,mountingholeRadius,360);
        translate([-partoffset * 1.1,-cuttingBracketHeight/4,0]) cylinder_mid(50,mountingholeRadius,360);
        translate([-partoffset * 1.1,0,rodDiameter*1.5]) rotate(a=[90,0,0]) cylinder_mid(50,rodRadius,360);

    }

}

deltaRodTemplate();