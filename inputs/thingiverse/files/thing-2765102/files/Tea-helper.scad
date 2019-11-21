/* Tea Helper, a minimalist tool to mount upon your tea spoon so you can use it
 * to lift up the tea bag wire, preventing it from draining your cup through
 * capillary action.
 * By DrLex, 2018/01
 * Released under Creative Commons - Attribution license */

// How much of the spoon handle will be covered
height = 20;

// Width of the spoon handle at the widest point that is covered
width = 10;

// Maximum thickness of the spoon handle
thickness = 2.1;

// Gap for the wire, make this wide enough for the wire to pass through, but narrow enough to clamp it
gap = 0.6;

// Wall thickness
walls = 1.1;


/* [Hidden] */
w2 = width + 2 * walls;
t2 = thickness + 2 * walls;
h2 = height + walls;
halfwall = walls/2;

stubWidth = 2 * ((width + 1.25 * walls)/2 - gap)/3;
stubDepth = thickness + 1.25 * walls;

innerRadius = thickness > walls ? halfwall : thickness * .99 / 2;
innerDia = 2 * innerRadius;

// Due to the way in which OpenSCAD renders spheres, a sphere of given radius and resolution will be
// smaller than a perfect sphere by a factor cos(180/resolution), similar to how circles are approximated.
sphere16_correction = 1/cos(180/16);

difference() {
    minkowski() {
        cube([width, thickness, height*2], center=true);
        scale(sphere16_correction) sphere(walls, $fn=16);
    }

    minkowski() {
        cube([width - innerDia, thickness - innerDia, height*2], center=true);
        // By using a cylinder and resolution such that it has vertices on its X and Y axes, no correction is needed.
        translate([0, 0, -1]) cylinder(r=innerRadius, h=1, $fn=16);
    }

    translate([0,0,-h2]) cube([w2*2, t2*2, h2*2], center=true);
}

translate([0,0,h2-halfwall]) {
    prismHeight = (stubWidth + stubDepth)/2;
    scale([stubWidth, stubDepth, 4.5+halfwall]) translate([0, 0, .5]) cube(center=true);
    translate([0, 0, 4.5+halfwall]) scale([stubWidth, stubDepth, prismHeight]) prism();
    translate([stubWidth + gap, 0, 0]) scale([stubWidth, stubDepth, 3+halfwall]) translate([0, 0, .5]) cube(center=true);
    translate([stubWidth + gap, 0, 3+halfwall]) scale([stubWidth, stubDepth, prismHeight]) prism();
    translate([-stubWidth - gap, 0, 0]) scale([stubWidth, stubDepth, 3+halfwall]) translate([0, 0, .5]) cube(center=true);
    translate([-stubWidth - gap, 0, 3+halfwall]) scale([stubWidth, stubDepth, prismHeight]) prism();

//    octaBox(stubWidth, stubDepth, 5+halfwall);
//    translate([stubWidth + gap, 0, 0]) octaBox(stubWidth, stubDepth, 3+halfwall);
//    translate([-stubWidth - gap, 0, 0]) octaBox(stubWidth, stubDepth, 3+halfwall);
}

module prism()
{
    rotate([90, 0, 0]) translate([0, 0, -.5]) linear_extrude(1) polygon([[-.5, 0], [.5, 0], [0, .5]]);
}