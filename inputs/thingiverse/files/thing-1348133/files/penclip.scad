// Width of base
baseWidth = 15;
// Length of base
baseLength = 25;
// Thickness of base
baseThickness = 2;

// Inner diameter for holding pen/marker
ID = 12.5;
// Thickness of C shaped clip
clipThickness = 1.6;
// Angle of opening in C shaped clip
clipAngle = 135;
// Circle detail (number of vertices)
$fn = 200;

OD = ID+clipThickness*2;

linear_extrude(baseLength) union() {
  translate([-baseWidth/2, 0]) square([baseWidth, baseThickness]);

  translate([0,ID/2+baseThickness]) {
    difference() {
      circle(d=OD,h=baseLength, center=true);
      circle(d=ID,h=baseLength+2, center=true);
      translate([0,0,-(baseLength+2)/2])
        rotate(90) pieSlice(OD, clipAngle);
    }

    R = (OD + ID)/4;
    d = (OD - ID)/2;
    rotate(90) mirrorY() translate([R*cos(clipAngle/2),R*sin(clipAngle/2)]) 
      circle(d=d, h=baseLength);
  }

}

module pieSlice(r,a) {
  x = r*cos(a/2);
  y = r*sin(a/2);
  if (a > 180)
    polygon([[0,0],[x,y],[x,r],[r,r],[r,-r],[x,-r],[x,-y]]);
  else
    polygon([[0,0],[x,y],[r,y],[r,-y],[x,-y]]);
}

module mirrorX() {
  for (i=[0:1]) mirror([i,0]) children();
}

module mirrorY() {
  for (i=[0:1]) mirror([0,i]) children();
}

module mirrorXY() {
  for (i=[0:1], j=[0:1]) mirror([i,0]) mirror([0,j]) children();
}

module mirrorZ() {
  for (i=[0:1]) mirror([0,0,i]) children();
}
