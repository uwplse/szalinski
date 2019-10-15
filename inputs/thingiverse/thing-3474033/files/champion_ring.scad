

finger_size = 17.7; // [14:3,14.8:4,15.6:5,16.5:6,17.3:7,18.2:8,19:9,19.8:10,20.6:11,21.4:12,22.2:13]
cylinder_resolution = 50;


module innerCylinder() {
    translate([finger_size*0.035,0,0])
    cylinder(
        d=finger_size*1,
        h=finger_size,
        $fn = cylinder_resolution,
        center = true);
}

module swoopCutaway(){
    // The top swoop cutaway
    translate([finger_size*0.5,0,finger_size*2.6])
    rotate([90,0,0])
        cylinder(
            d=finger_size*5,
            h=finger_size*2,
            $fn = cylinder_resolution*2,
            center = true);
    // The bottom swoop cutaway
    translate([finger_size*0.5,0,-finger_size*2.6])
    rotate([90,0,0])
        cylinder(
            d=finger_size*5,
            h=finger_size*2,
            $fn = cylinder_resolution*2,
            center = true);
}

// Draw The Ring
difference() {
    
    // The outer cylinder
    cylinder(
        d=finger_size*1.2,
        h=finger_size,
        $fn = cylinder_resolution,
        center = true);
    
    // The inner Cylinder
    innerCylinder();
    
    swoopCutaway();
    
    // The rounding sphere cutaway
    difference() {
        sphere(
            r=finger_size*1,
            $fn = cylinder_resolution
        );
        sphere(
            r=finger_size*0.635,
            $fn = cylinder_resolution
        );
    }
    
    // The front plate cutaway
    translate([-finger_size*1.05,0,0])
        cube([finger_size,finger_size,finger_size],center=true);
}

