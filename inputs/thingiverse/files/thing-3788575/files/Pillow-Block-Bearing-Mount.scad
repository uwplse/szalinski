
// The thickness of the mount
thickness=5;

/* [Hidden] */
w=35.89;
h=55;
r=5;
$fn=200;

module base(){
  grow=17;
  hull(){
    translate([r-grow,r,0])
      cylinder(r=r,h=thickness, center=true);

    translate([r-grow,h-r,0])
      cylinder(r=r,h=thickness, center=true);


    translate([w-r,h-r,0])
      cylinder(r=r,h=thickness, center=true);

    translate([w-r,r,0])
      cylinder(r=r,h=thickness, center=true);
    }
}

module pillow_holes(){
  translate([0,0,0])
    cylinder(d=9,h=10, center=true);

  translate([-31/2-3,0,0])
    cylinder(r=3,h=10, center=true);

  translate([31/2+3,0,0])
    cylinder(r=3,h=10, center=true);
}

difference(){
  base();
  hole_size=5.4;

  translate([7.3+(hole_size/2),6.3+hole_size/2,-1])
    cylinder(d=hole_size,h=10, center=true);
    
  translate([w-5.3-(hole_size/2),6.3+hole_size/2,-1])
    cylinder(d=hole_size,h=10, center=true);

  big_hole=9;
  translate([5.5+(big_hole/2),35.5+(big_hole/2),-1])
  cylinder(d=big_hole,h=10, center=true);
    
  translate([10,40,0])
    pillow_holes();    
}