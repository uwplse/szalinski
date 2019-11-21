$fn=50;

// change these values
$socket_count = 2;
$socket_tap = 6;
$height = 40;

// better not touch there ¯\_(ツ)_/¯
$length = $socket_count * (22+10) + 25.5;
$width = 68.5;

difference() {
    // outside
    minkowski() {
        cube([$width-20, $length-20, $height-10]);
        sphere(r=10);
    }
    translate([-15, -15, -15]) {
        cube([$width + 30, $length + 30, 15]);
    }
    
    // inside cut
    difference() {
        translate([0, 0, -5]) {
            minkowski() {
                cube([$width-20, $length-20, $height-2.5-3-$socket_tap]);
                sphere(r=7.5, h=10);
            }
        }
        translate([$width/2-10, 0, $height-12]) {
            cylinder(r=6, h=25);
        }
        translate([$width/2-10, $length-20.5, $height-12]) {
            cylinder(r=6, h=25);
        }
    }
    
    // socket holes
    for (i = [0 : $socket_count-1]) {
        translate([5-0.25, 7.5 + i * 32, 0]) {
            socket();
        }        
    }
    
    // left screw hole
    translate([$width/2-10, 0, 0]) {
        screw();
    }
    // right screw hole
    translate([$width/2-10, $length-20.5, 0]) {
        screw();
    }
}

module screw() {
    translate([0, 0, $height-5]) {
        cylinder(r=4, h=10);
    }
    translate([0, 0, 0]) {
        cylinder(r=2, h=$height);
    }        
}

module socket() {
    translate([0, 0, 0]) {
        cube([39.5, 22, $height]);
    }
    translate([-2, 0, $height-$socket_tap]) {
        cube([43.5, 22, $socket_tap]);
    }
}