// Minimum needed is 0.02 to ensure properly punched holes. 
holeCreationOffset=0.05;
//How wide the extrusion is
extrusionWidth=20;//[15,20]
extrusionHeight=extrusionWidth;
//How thick the bracket will be, 3 is the default
bracketThickess=3; //[1:10]
bracketLength=extrusionWidth * 4;
triangle2=bracketLength/2;
// M3 or M5 holes
boltHoleDiameter=3.7;//[3.7,5.68]
boltHoleRadius=boltHoleDiameter/2;
squareDiagonal=(bracketLength*sqrt(2));

echo(squareDiagonal);

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

module cornerBracket(){
    difference (){
        color([0,0,1]) roundCornersCube(bracketLength, bracketLength,bracketThickess, 1);
        translate([extrusionWidth/2,extrusionWidth/2,0]) rotate([0,0,45]) cube([extrusionHeight, extrusionWidth * 2,bracketThickess + 1], center=true);
        translate([squareDiagonal/4,squareDiagonal/4,0])  rotate([0,0,45]) cube([bracketLength, bracketLength*2,bracketThickess + 1], center=true);
        
        translate(v = [ -(bracketLength/2) + (extrusionWidth/2), -(bracketLength/2) + (extrusionWidth) + extrusionWidth, 0 ]) cylinder_outer(bracketThickess * 2,boltHoleRadius,20);
        translate(v = [ -(bracketLength/2) + (extrusionWidth/2),-(bracketLength/2) + (extrusionWidth * 2)+ extrusionWidth , 0 ]) cylinder_outer(bracketThickess * 2,boltHoleRadius,20);


        translate(v = [ -(bracketLength/2) + (extrusionWidth ) + extrusionWidth,-(bracketLength/2) + (extrusionWidth/2), 0 ]) cylinder_outer(bracketThickess * 2,boltHoleRadius,20);
        translate(v = [ -(bracketLength/2) + (extrusionWidth * 2) + extrusionWidth,-(bracketLength/2) + (extrusionWidth/2), 0 ]) cylinder_outer(bracketThickess * 2,boltHoleRadius,20);
    }
    
}

cornerBracket();