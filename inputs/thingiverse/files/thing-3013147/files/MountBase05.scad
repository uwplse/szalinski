// in inches, distance between clips
base_length=2.0; //[1.5:0.25:4.5]

// in mm, extra spacing for slots/tabs
xy_tolerance=0.35; //[0.1:0.05:1.0]

// preview[view:south, tilt:top]

/* [Hidden] */
i2m=25.4; // inches to mm
rHole=2.35; //mm


// central block for mount, with holes
difference() {
    
translate([xy_tolerance,0,0]){
cube([1.5*i2m - 2*xy_tolerance, base_length*i2m, 3]);
    translate([0,(base_length/2-0.75)*i2m,0])
cube([1.5*i2m - 2*xy_tolerance, 1.5*i2m - 2*xy_tolerance, 5.3]);
}
    
    // tetrix holes
    translate([0.75*i2m - 8, base_length*i2m/2, -2])
    cylinder(h=10, r=rHole, $fn=16);
    translate([0.75*i2m + 8, base_length*i2m/2, -2])
    cylinder(h=10, r=rHole, $fn=16);
    translate([0.75*i2m , base_length*i2m/2 -8, -2])
    cylinder(h=10, r=rHole, $fn=16);
    translate([0.75*i2m, base_length*i2m/2 +8, -2])
    cylinder(h=10, r=rHole, $fn=16);
    
    // actobotics inner holes
    translate([0.75*i2m, base_length*i2m/2, -2])
    rotate(45)
    translate([0.77/2*i2m, 0, -2])
    cylinder(h=10, r=rHole, $fn=16);
    
    translate([0.75*i2m, base_length*i2m/2, -2])
    rotate(135)
    translate([0.77/2*i2m, 0, -2])
    cylinder(h=10, r=rHole, $fn=16);
    
    translate([0.75*i2m, base_length*i2m/2, -2])
    rotate(-45)
    translate([0.77/2*i2m, 0, -2])
    cylinder(h=10, r=rHole, $fn=16);
    
    translate([0.75*i2m, base_length*i2m/2, -2])
    rotate(-135)
    translate([0.77/2*i2m, 0, -2])
    cylinder(h=10, r=rHole, $fn=16);
    
    // actobotics outer holes
    translate([0.75*i2m, base_length*i2m/2, -2])
    rotate(45)
    translate([0.75*i2m, 0, -2])
    cylinder(h=10, r=rHole, $fn=16);
    
    translate([0.75*i2m, base_length*i2m/2, -2])
    rotate(135)
    translate([0.75*i2m, 0, -2])
    cylinder(h=10, r=rHole, $fn=16);
    
    translate([0.75*i2m, base_length*i2m/2, -2])
    rotate(-45)
    translate([0.75*i2m, 0, -2])
    cylinder(h=10, r=rHole, $fn=16);
    
    translate([0.75*i2m, base_length*i2m/2, -2])
    rotate(-135)
    translate([0.75*i2m, 0, -2])
    cylinder(h=10, r=rHole, $fn=16);
}

tabs();

translate([0,base_length*i2m,0])
rotate(180)
mirror([1,0,0])
tabs();


    
 module tabs() {
     
    halfTabs();
    
    translate([1.5*i2m,0,0])
    mirror([1,0,0]) 
    halfTabs();
}

module halfTabs() {

    translate([0,-2*3.2,0])
    translate([xy_tolerance,0,0])
    cube([.2*i2m -2*xy_tolerance,2*3.2+xy_tolerance, 3]);
    
    translate([0.75*i2m-13.36/2,-2*3.2,0])
    translate([xy_tolerance,0,0])
    cube([.15*i2m -2*xy_tolerance,2*3.2+xy_tolerance, 3]);
    
    translate([0.75*i2m-13.36/2-0.7,-3.2-0.7,0])
    translate([xy_tolerance,0,0])
    rotate(-70)
    cube([.13*i2m -2*xy_tolerance,1.2+xy_tolerance, 3]);
}
