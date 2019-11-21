/*
  Micro switch with roller

  Aaron Ciuffo (txoof)
  23 December 2015


*/
$fn=36; //curve refinement

/*[body]*/
// body X
bX=20;  
// body Y
bY=6.1;
// body Z
bZ=10;
// hole diameter
hD=2.5; 
holeFromBottom=1.8; //absolute distance of mounting hole from bottom of switch
holeFromEdge=4.3; //absolute distance of mounting hole from edge

/*[terminals]*/
// terminal X dimension
tX=.6;
// terminal Y dimension
tY=3.3;
// terminal Z dimension
tZ=4;
// position from edge
termFromEdge=1.5;


/*[switch arm]*/
//arm X
aX=18.5;
// arm Y
aY=4;
// arm Z
aZ=.3;
 //absolute distance of arm from edge
armFromEdge=3;
//absolute distance of roller over the arm
rollerOverArm=1;
//distance of arm over body
armOverBody=4;  
// add a roller
addRoller=1; //[0:1]
// roller diameter
rollerD=4;

/*[Hidden]*/
hR=hD/2; 
echo(hR);
hZ=bZ/2-hR-holeFromBottom; //place the hole
hX=bX/2-hR-holeFromEdge;
//hY=bX/2-hR-holeFromEdge;
rollerR=rollerD/2;
armAngle=asin(armOverBody/aX/2);

module body() {
  difference() {
    color("gray")
      cube([bX, bY, bZ], center=true);
    rotate([90, 0, 0])
      translate([hX, -hZ, 0])
      cylinder(r=hR, h=bY*1.5, center=true);
    rotate([90, 0, 0])
      translate([-hX, -hZ, 0])
        cylinder(r=hR, h=bY*1.5, center=true);
  }
}

module arm() {
  color("silver")
  union() {
    rotate([])
      cube([aX, aY, aZ], center=true);
    if (addRoller==1) {
      translate([aX/2-rollerR, 0, rollerR+rollerOverArm])
        rotate([90, 0, 0])
        cylinder(h=aY, r=rollerR, center=true);
      translate([aX/2-rollerR, 0, rollerR/2])
        cube([rollerD, rollerD, rollerR], center=true);
    }
  
  }
}

module terminals() {
  translate([0, 0, -bZ/2-tZ/2])
    cube([tX, tY, tZ], center=true);
  translate([bX/2-tX/2-termFromEdge, 0, -bZ/2-tZ/2])
    cube([tX, tY, tZ], center=true);
  translate([-1*(bX/2-tX/2-termFromEdge), 0, -bZ/2-tZ/2])
    cube([tX, tY, tZ], center=true);
}

module micro_switch() {
  //center on holes
  translate([0, 0, hZ])
  union() {
    body();
    translate([armFromEdge/2, 0, bZ/2+armOverBody/4])
      rotate([0, -armAngle, 0])
      arm();
    color("silver")
      terminals();
  }  
}

micro_switch();
