include <MCAD/boxes.scad>

//Pill box with sliding lid

/* [Outside Box Dimensions] */
//Box Width (min: 5 x Wall Thickness)
bX=24; 
//Box Depth (min: 5 x Wall Thickness)
bY=42; 
//Box Height (min: 5 x Wall Thickness)
bZ=12;
//Corner Radius (radius of the corner fillet inside and outside)
corner=2.5; 
//X Dividers (0 for no dividers)
col=0; 
//Y Dividers (0 for no dividers)
row=2; 
//Divider Wall Thickness
divWall=1.5;

/* [Wall Thickness] */
//Wall Thickness (min: 2mm)
wall=2.8;

/* [Lid] */
//Lid Lip Width (min: 1mm)
lip=2;
//Snugness of Lid (values approaching 1.0 result in a snugger fit)
snug=.99; 

/* [Catch] */
//Catch Height (height over the lip for the catch)
catch=1;

/* [Hidden] */
boxDim=[bX, bY, bZ]; 
over=.5; //amount to extend parts that need to have interference (such as dividers)
module xDiv(inSide){
  xInc=inSide[0]/col;
  for ( i = [1 : col-1] ) {
    translate([i*xInc, 0, 0])cube([divWall, inSide[1]+over, inSide[2]+over], center=true);
  }
}


module yDiv(inSide){
  yInc=inSide[1]/row;
  for (i = [1 : row-1] ) {
    translate([0, i*yInc, 0])cube([inSide[0]+over, divWall, inSide[2]+over], center=true);
  }
}

module drawBox () {
  innerBox=[bX-(2*wall), bY-(2*wall), bZ-(2*wall)+.22];
  echo("innerBox=", innerBox);
  union() {
    difference() {
      roundedBox(boxDim, corner, sidesonly=1, $fn=36);
      roundedBox(innerBox, corner, sidesonly=1, $fn=20);
      translate([0, -wall, bZ/2+.1]) cutLid(0);
    }
    translate([-innerBox[0]/2, 0, -over/2]) xDiv(innerBox);
    translate([0, -innerBox[1]/2, -over/2]) yDiv(innerBox);
  }
}

module cutLid(shorten, catch) {
  //Create a trapezoid lid 

  insideLip=wall*1.2; //lip inside the box for the lid to rest upon
  lX=bX-(2*wall)+insideLip;
  lY=bY-shorten;

  echo("inside lip=", insideLip/2);

  //polygon points
  p0=[0, 0];
  p1=[lX, 0];
  p2=[lX-lip, wall];
  p3=[lip, wall];

  // this needs to be less than 45 deg to be usable
  echo("Lip Overhang (degrees)=", atan(lip/wall));
  
  difference() {
    rotate([90,0,0])
      translate([-lX/2, -wall, 0]) 
      linear_extrude(height=lY, center=true) polygon([p0, p1, p2, p3], paths=[[0,1,2,3]]);
    if (catch==1) {
      translate([0, lY/2-wall/2, -wall+catch/2]) cube([lX*.8, catch*1.5, catch*1.3], center=true);
      //Add an additional slot to make it easier to slide open the lid
      translate([0, -lY/2+wall, wall/3]) cube([lX*.6, catch*1.5, catch*5], center=true);
    } else {
      echo("catch=false");
    }

  }
}

module drawCatch() {
  rad=catch/2;
  lX=bX-2*(wall+.2);

  union() {
    translate([-lX/3, 0, 0]) sphere(r=rad, $fn=20);
    translate([ lX/3, 0, 0]) sphere(r=rad, $fn=20);
    rotate([0,90,0])cylinder(h=lX/1.5, r=rad, center=true, $fn=20);
  }
}

module assemble() {
    union() {
      drawBox();
      //move the catch to the front of the box
      translate([0, -(bY/2)+wall/2, bZ/2-wall]) drawCatch();
    }
  //draw the lid (wall, 1) - second paramater specifies to add a hole for a catch
  translate([bX+10, 0, (-bZ/2)]) rotate([180, 0, 0]) scale([snug-.01, snug-.02, snug]) cutLid(wall, 1);
}

assemble();
