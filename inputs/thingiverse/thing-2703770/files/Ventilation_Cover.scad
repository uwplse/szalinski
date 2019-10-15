echo(version=version());

h1=2;     //height of cover
d_out=60; //outer diameter
d_in=40;  //inner diameter
d_hole=3; //hole diameter

cover (h1,d_out/2,d_in/2,d_hole/2);

module cover (hi,r1,r2,r3){ 
    t1=r1/2+r2/2; // middle radius
    difference() {  //subtract
    cylinder(h = hi, r = r1); //outer
        translate([0, 0, 0])
     cylinder(h = hi/2, r = r1-2); //bottom
    translate([0, 0, -1])
      cylinder(h = hi*2, r = r2); //inner
    translate([t1, 0, 0])          
       cylinder(h = hi, r = r3); // first hole
    translate([-sin(30)*t1, cos(30)*t1, 0])  
       cylinder(h = hi, r = r3); //second hole
    translate([-sin(30)*t1, -cos(30)*t1, 0])
        cylinder(h = hi, r = r3); //third hole
  }
 }
 
