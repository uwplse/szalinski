//height in mm
hexHeight = 6.0;
// depending on your printer you will need some tolerance
hexSize = 11.8;

 // axle diameter
axleDiameter = 5.2;

// pin diameter
pinDiameter = 2;
// pin height
pinLength = 10.0;
// how deep the pin goes
pinDepth = 2;

// offset size, preferably bearing inner ring size
offsetDiameter = 6.2;
// bearing offset in mm, set to 0 for no offset
offsetHeight = 0.4;

/* [Hidden] */

// global curve detail
$fn=180; 

 module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}
   
   

difference(){
    union(){   
        cylinder_outer(hexHeight, hexSize/2, 6);
        cylinder(hexHeight + offsetHeight, d = offsetDiameter);
    }
    translate(v=[0,0,-1]){
        cylinder(hexHeight + offsetHeight + 2, d = axleDiameter);
    }
    translate(v=[0,0, hexHeight - pinDepth + pinDiameter/2]){
        union(){
            translate(v=[-pinLength/2,0,0]){
                rotate(a=[0,90,0]){   
                    cylinder(pinLength, d = pinDiameter);
                }
            }
            translate(v=[0,0, (pinDiameter + pinDepth + offsetHeight)/2]){
                cube([pinLength, pinDiameter, pinDiameter + pinDepth + offsetHeight], center=true);
            }
        }
    }
}


   