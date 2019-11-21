// The amount added to a cut out to ensure a clean hole. 
holeCreationOffset=0.05;
// How thick the endstop is 
endstopThickness=3;
// How deep the recess is inside of the endstop, this is the cut out for the circuitry on the bottomside of the endstop PCB
endstopRecessDepth=1;
// How tall the recess is into the endstop part
endstopRecessHeight=10;
// How wide the recessed portion of the endstop is
endstopRecessWidth=15.5;
// How tall the over all endstop is
endstopHeight=25;
// How wide the endstop is, this should equal your aluminum extrusion width
endstopNarrowWidth=20;
// The shelf that is on the endstop, this is to offset the opticoupler by the amount needed to center the opticoupler
enstopShelfWidth=25;
// How tall the shelf is, this should be the height of the opticoupler
endstopShelfHeight=10;
endstopShelfOffset=enstopShelfWidth-endstopNarrowWidth;
// The offset for the opticouplers mounting holes, center to center
endstopBoltHoleWidth=19.5;
// The diameter of the mounting holes for the opticoupler
endstopBoltHoleDiameter=2.5;
// The diameter of the mounting holes for the endstop bracket itself
mountingBoltHoleDiameter=3;
mountingBoltHoleRadius=mountingBoltHoleDiameter/2;
endstopBoltHoleRadius=endstopBoltHoleDiameter/2;


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
             createMeniscus(z,r); // But this time we have to rotate the meniscus 90 deg
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


module endstop(){
    difference (){
        union(){
            roundCornersCube(endstopNarrowWidth,endstopHeight,endstopThickness,2);
            translate([endstopShelfOffset/2,endstopHeight/2,0]) roundCornersCube(enstopShelfWidth,endstopShelfHeight,endstopThickness,2);
        }
    translate([endstopShelfOffset/2,endstopHeight/2,(endstopThickness/2) - (endstopRecessDepth/2)]) cube([endstopRecessWidth,endstopRecessHeight + holeCreationOffset,endstopRecessDepth + holeCreationOffset], center=true);
        translate([endstopNarrowWidth/2 + endstopShelfOffset/2,endstopHeight/2,0]) cylinder_outer(20,endstopBoltHoleRadius,20); 
translate([-enstopShelfWidth/2 + endstopShelfOffset,endstopHeight/2,0]) cylinder_outer(20,endstopBoltHoleRadius,20); 
        
        translate([0,3,0]) cylinder_outer(20,mountingBoltHoleRadius,20); 
        translate([0,-endstopHeight/3,0]) cylinder_outer(20,mountingBoltHoleRadius,20);
    }
}


endstop();