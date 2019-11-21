// Size
id=50; // [20:100]
// Height (must be greater than Rounding Radius
h=16; // [14:40]
// Rounding Radius
rr=12.5; // [0:50]
// Shape
shape="circle"; // [circle,heart]
// Text (make it short)
text="MOM";
text_size=14;

/* [Hidden] */
rd=rr*2;
yoff=(shape=="heart"?-10:0);

difference() {
  *translate([-40,-40,-1.2]) cube([80,80,h]);
  union() {
    translate([0,yoff,-1.2]) linear_extrude(h) minkowski() {
      shape_profile();
      circle(d=rd+3,$fn=24);
    }
    for(z=[h-8:0.4:h-3])
    translate([0,yoff,z]) linear_extrude(z>=h-3.4?2:0.4) minkowski() {
      shape_profile();
      circle(d=rd+3+((z-(h-8))*0.8),$fn=24);
    }
  }
difference() {
  translate([0,yoff,rd/2]) mykowski(height=h-8,curve=rd/2)
    shape_profile();
  if(len(text)>0)
  translate([0,0,-.8]) mykowski(height=1,curve=1)
    text(text,spacing=1.05,size=text_size,valign="center",halign="center");
}
}

module mykowski(height=10,curve=2) {
  if(curve<=200) {
    minkowski() {
      linear_extrude(height,convexity=4) children(0);
      sphere(d=curve*2,$fn=24);
    }
  } else {
    
  }
}

module shape_profile(shape=shape,id=id)
{
   if(shape=="heart")
     heart_profile(id);
   else if(shape=="circle")
     circle(d=id,$fn=id*4);
}

module heart(id=id,h=20)
{
  linear_extrude(h,convexity=4) {
    heart_profile(id);
    
  }
}
module heart_profile(id=id)
{
  for(m=[0,1]) mirror([m,0]) hull() {
    translate([id*-.25,id*.25])
      circle(d=id/2,$fn=30);
    translate([0,id*-.40]) rotate([0,0,45]) square([1,1]);
    translate([0,id*.325]) square([1,1]);
  }
  *for(m=[0,1]) mirror([m,0]) translate([id*-.25,id*.25]) rotate([0,0,-45]) {
      circle(d=id/2,$fn=30);
      translate([0,id*-.25]) square([id/2,id/2]);
    }
}