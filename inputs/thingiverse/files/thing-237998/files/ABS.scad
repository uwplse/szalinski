/* [ Global ] */

// Position 1 (by keyring) Depth
d1=0; // [-1:Magnet,0,1,2,3]
// Position 1 Dimple
a1=0; // [-1:In,0,1:Out]
// Position 2 Depth
d2=0; // [-1:Magnet,0,1,2,3]
// Position 2 Dimple
a2=0; // [-1:In,0,1:Out]
// Position 3 Depth
d3=0; // [-1:Magnet,0,1,2,3]
// Position 3 Dimple
a3=0; // [-1:In,0,1:Out]
// Position 4 Depth
d4=0; // [-1:Magnet,0,1,2,3]
// Position 4 Dimple
a4=0; // [-1:In,0,1:Out]
// Position 5 (nearest tip of key) Depth
d5=0; // [-1:Magnet,0,1,2,3]
// Position 5 Dimple
a5=0; // [-1:In,0,1:Out]

// Margin to allow for print overrun - adjust to make key 2.4mm thick and 9mm high
m=0.2;

/* [Hidden] */

// preview[view:west, tilt:top diagonal]


d=[d1,d2,d3,d4,d5];
a=[a1,a2,a3,a4,a5];

w=2.4-m;		// width
h=9-m;		// height
l=32;		// length

r2=0.2;		// indents
i1=0.4;
i2=0.4;

$fn=100;

module key()
{
 intersection()
 {
  translate([-w,0,0.25])cube([w*3,l,4.5]);
  for(q=[0:4])translate([w-d[q]*i2-r2,l-25+(19/4)*q,2.5])
  {
   rotate([0,90,0])
   {
    difference()
    {
     cylinder(r1=3/2,r2=12/2,h=9/2);
     if(a[q]>0)cylinder(r1=1.5/2,r2=1/2,h=i1);
    }
    if(a[q]<0)translate([0,0,-i1+0.01])cylinder(r1=1/2,r2=1.5/2,h=i1);
    if(d[q]<0)translate([0,0,-1-0.4])cylinder(r=3/2+0.1,h=2);
   }
  }
 }

}

module guide()
{
 translate([-1,l,-h-1])rotate([30,0,0])cube([w+2,10,10]);
 translate([w/2+1.1,l-3,-0.5])rotate([0,0,35])hull()
 {
  cube([w+2,10,h/2]);
  translate([10,0,5])cube([w+2,10,h/2]);
 }
}

module hold(d=30,z=30)
{
 hull()
 {
  translate([-z/2,-d,0])cube([z,5,h/3]);
  translate([-w/2,-5,0])cube([w,5,h/3]);
 }
 hull()
 {
  translate([-z/2,-d,0])cube([z,5,h/3]);
  translate([-w/2,-5,2*h/3])cube([w,5,h/3]);
 }
 hull()
 {
  translate([-z/2,-d,0])cube([z,5,h/3]);
  translate([-w/2,-5,h/3])cube([w,1,h/3]);
 }
}

translate([-w/2,0,0])difference()
{
 translate([0,-5,0])cube([w,l+5,h]);
 //key();
 guide();
 translate([w,0,h])rotate([0,180,0])
 {
  key();
  guide();
 }
}
hold();
