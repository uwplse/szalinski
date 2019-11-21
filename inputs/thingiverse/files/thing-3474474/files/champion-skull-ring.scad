

finger_size = 21.4; // [14:3,14.8:4,15.6:5,16.5:6,17.3:7,18.2:8,19:9,19.8:10,20.6:11,21.4:12,22.2:13]
ring_resolution = 100;


skull_resolution = ring_resolution * 0.3;


module innerCylinder() {
    translate([finger_size*0.035,0,0])
    cylinder(
        d=finger_size*1,
        h=finger_size,
        $fn = ring_resolution,
        center = true);
}

module swoopCutaway(){
    // The top swoop cutaway
    translate([finger_size*0.5,0,finger_size*2.6])
    rotate([90,0,0])
        cylinder(
            d=finger_size*5,
            h=finger_size*2,
            $fn = ring_resolution,
            center = true);
    // The bottom swoop cutaway
    translate([finger_size*0.5,0,-finger_size*2.6])
    rotate([90,0,0])
        cylinder(
            d=finger_size*5,
            h=finger_size*2,
            $fn = ring_resolution,
            center = true);
}

// Draw The Ring
difference() {
    
    // The outer cylinder
    cylinder(
        d=finger_size*1.2,
        h=finger_size,
        $fn = ring_resolution,
        center = true);
    
    // The inner Cylinder
    innerCylinder();
    
    swoopCutaway();
    
    // The rounding sphere cutaway
    difference() {
        sphere(
            r=finger_size*1,
            $fn = ring_resolution
        );
        sphere(
            r=finger_size*0.635,
            $fn = ring_resolution
        );
    }
    
    // The front plate cutaway
    translate([-finger_size*1.05,0,0])
        cube([finger_size,finger_size,finger_size],center=true);
}


module skullMain() {
    // the dome
    difference(){
        translate([0,0,finger_size*0.05])
        sphere(
            r=finger_size*0.31,
            $fn = skull_resolution
        );
        // crop
        translate([-finger_size*0.78,0,0])
            cube([finger_size,finger_size,finger_size],center=true);
    }
    
    // the jaw
    difference(){
        union(){
            // cheeks
            translate([-finger_size*0.19,finger_size*0.11,-finger_size*0.1])
            sphere(
                r=finger_size*0.08,
                $fn = skull_resolution
            );
            translate([-finger_size*0.19,-finger_size*0.11,-finger_size*0.1])
            sphere(
                r=finger_size*0.08,
                $fn = skull_resolution
            );
            
            difference() {
                translate([-finger_size*0.12,0,-finger_size*0.11])
                rotate([0,0,-10])
                cylinder(
                    d=finger_size*0.3,
                    h=finger_size*0.35,
                    $fn = skull_resolution,
                    center = true);
                translate([-finger_size*0.15,0,0]){
                    difference(){
                        sphere(
                            r=finger_size*0.35,
                            $fn = skull_resolution
                        );
                        sphere(
                            r=finger_size*0.288,
                            $fn = skull_resolution
                        );
                    }
                }
            }
        }
        // crop
        translate([-finger_size*0.76,0,0])
            cube([finger_size,finger_size,finger_size],center=true);
        
        // cheeks cutaways
        translate([-finger_size*0.26,finger_size*0.12,-finger_size*0.18])
        rotate([50,0,-30])
        cylinder(
            d=finger_size*0.1,
            h=finger_size*0.2,
            $fn = skull_resolution,
            center = true);
        translate([-finger_size*0.26,-finger_size*0.12,-finger_size*0.18])
        rotate([-50,0,30])
        cylinder(
            d=finger_size*0.1,
            h=finger_size*0.2,
            $fn = skull_resolution,
            center = true);
        
    }
    
}


module noseHole() {
    rotate([0,90,0])
    translate([finger_size*0.1,0,0])
    cylinder(
        d=finger_size*0.12,
        h=finger_size,
        $fn = skull_resolution,
        center = true);
}

module eyeHoles() {
    translate([0,finger_size*0.12,0])
    sphere(
        r=finger_size*0.09,
        $fn = skull_resolution
    );
    translate([0,-finger_size*0.12,0])
    sphere(
        r=finger_size*0.09,
        $fn = skull_resolution
    );
}
module skullEyes() {
    difference(){
        eyeHoles();
        
        rotate([-10,0,0])
        translate([0,-finger_size*.52,finger_size*.52])
            cube([finger_size,finger_size,finger_size],center=true);
        rotate([10,0,0])
        translate([0,finger_size*.52,finger_size*.52])
            cube([finger_size,finger_size,finger_size],center=true);
    }
}

// Draw The Skull
difference() {
    
    translate([-finger_size*0.35,0,0]){
        difference(){
            skullMain();
           
            noseHole();
            
            difference(){
                translate([-finger_size*0.27,0,finger_size*0.03]){
                    skullEyes();
                    
                }
            }
        }
    }
    
    innerCylinder();
    swoopCutaway();
    
}