/* ### Input Variables ### */

boundsX = 45;
boundsY = 20;

mountType = "square"; // "square" || "round"

/* ### What to render ### */

// topShell();
middleShell();
// bottomShell();

/* ### Constants ### */

mountPoleSize = 12;
thickness = 2;
pegDiameter = 5;

/* ########################################################### */
bounds = sqrt((boundsX * boundsX) + (boundsY * boundsY)); // the diagonal of the rectangle
outerDiameter =  bounds * 2;
height = bounds / 2;
pegRadius = (bounds / 2) * 1.2;
pegHeight =  height * 1.25;


module shell(d, h, hole, pegs, pegsHoles) {
    if(pegs) {
        for (a=[0:360/3:360]) {
            translate([sin(a) * pegRadius, cos(a) * pegRadius, 0]) rotate([0, 0, abs(a - 360) + 180]) peg();
        }
    }
    difference() {
        linear_extrude(height = h, convexity = 10, scale=[1.2,1.2], $fn=100) circle(d = d);
        translate([0, 0, 2]) 
            linear_extrude(height = height, convexity = 100, scale=[1.2,1.2], $fn=100) circle(d = d);
        if(pegsHoles) {
            for (a=[0:360/3:360]) {
                translate([sin(a + 360/6) * (pegRadius + 2) , cos(a + 360/6) * (pegRadius + 2), 0])
                    linear_extrude(height = height, $fn=100) circle(d = (pegDiameter + 1));
            }
        }
        if(hole) {
            linear_extrude(height = h, $fn=100) circle(d = bounds);
        }
    }
}

module peg(){
    // translate([0, 0, thickness]) rotate([0, 0, -90]) mountSideSupport(pegHeight * 0.4); // For added strength
    difference() {
        linear_extrude(height = pegHeight, $fn=100) circle(d = 5);
        translate([0, 0, pegHeight]) rotate([45, 0, 0])
            linear_extrude(height = pegDiameter * 3, center = true, $fn=100) square(size = pegDiameter, center = true);
        translate([0, pegDiameter * 1.1, pegHeight - pegDiameter * 2.1])
            rotate([45, 0, 0]) linear_extrude(height = pegDiameter, $fn=100) square(size = pegDiameter, center = true);
    }
}

module mountSideSupport(size) {
    triangle_points =[[0,0], [size,0],[0,size], [size * 0.2,size * 0.2], [size * 0.6, size * 0.2],[size * 0.2, size * 0.6]];
    triangle_paths =[[0,1,2], [3,4,5]];
    rotate([90, 0, 0]) linear_extrude(height = pegDiameter, center=true, $fn=100)  polygon(triangle_points, triangle_paths,10);
}


module topShell() {
    shell(outerDiameter, height, false, true, false);
}

module middleShell() {
    shell(outerDiameter, height, true, true, true);
}

module bottomShell() {
    shell(outerDiameter, height, false, false, true);
    size = mountPoleSize + thickness * 2;
    mountHeight = height * 1.5;
    difference() {
        if(mountType == "square") {
            difference() {
                linear_extrude(height = mountHeight, $fn=100) square(size = size, center=true);
                linear_extrude(height = mountHeight, $fn=100) square(size = mountPoleSize, center=true);
            }
           
        } else if(mountType == "round") {
            difference() {
                linear_extrude(height = mountHeight, $fn=100) circle(d = size, center=true);
                linear_extrude(height = mountHeight, $fn=100) circle(d = mountPoleSize, center=true);
            }
        }
        translate([0, 0, mountHeight * 0.8]) rotate([90, 0, 90]) 
            linear_extrude(height = size, center = true, $fn=100) circle(r = 1.5, center=true);
    }
    if(mountType == "square") {
        for (a=[0:360/4:360]) {
            translate([sin(a) * size/2.1, cos(a) * size/2.1, thickness]) rotate([0, 0, abs(a - 360) + 90])
                mountSideSupport((mountHeight - pegDiameter) * 0.6);
        }
    } else if(mountType == "round") {
        for (a=[0:360/3:360]) {
            translate([sin(a) * size/2.1, cos(a) * size/2.1, thickness]) rotate([0, 0, abs(a - 360) + 90])
                mountSideSupport((mountHeight - pegDiameter) * 0.6);
        }
    }
}