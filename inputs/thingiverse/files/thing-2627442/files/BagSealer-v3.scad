// Bag sealer v3 by DrLex, 2017/10- 2018/11
// Released under Creative Commons - Attribution license

// Length of the clip in millimeters
length = 10;

// Width of the open gap. The gap will become about 0.75mm narrower with the insert in place. A good value is the thickness of the folded bag plus 0.5mm.
gap = 0.8; //[.1:.05:3]

// Generate extra 'nubs' that make it easier to push the parts out of each other?
nubs = "yes"; //[yes,no]

// Enable this to create a stronger model (requires more material to print).
heavy_duty = "no"; //[yes,no]

// Generate what parts?
generate = "both"; //[both,clip,insert]

/* [Hidden] */
doNubs = nubs == "yes" ? true : false;
saveMaterial = heavy_duty == "yes" ? false : true;
shiftXtra = doNubs ? 1 : 0;
shiftClip = generate == "both" ? 7 + shiftXtra : 0;
shiftInsert = generate == "both" ? -(3 + shiftXtra) : 4;

if(generate == "both" || generate == "clip") {
    translate([0, shiftClip, 0]) {
        difference() {
            rotate([90, 0, 90]) linear_extrude(length, center=true, convexity=6) clipPoly(gap);
            translate([length/2+.1, 1.7+gap, 16.1]) rotate([0,45,0]) cube(3.5, center=true);
            translate([-length/2-.1, 1.7+gap, 16.1]) rotate([0,45,0]) cube(3.5, center=true);

            if(doNubs) {
                translate([length/2-1, -6.5, -.5]) cube([2, 2, 3.4]);
                translate([-length/2-1, -6.5, -.5]) cube([2, 2, 3.4]);
            }
        }
        if(doNubs) {
            translate([length/2, 0, 0]) nub(3);
            translate([-length/2, 0, 0]) mirror([1, 0, 0]) nub(3);
        }
    }
}
if(generate == "both" || generate == "insert") {
    translate([0, shiftInsert, 0]) {
        difference() {
            rotate([90, 0, 90]) linear_extrude(length, center=true, convexity=6) insertPoly();

            if(doNubs) {
                translate([length/2-3, -10, -.5]) cube([6, 4.12, 3.4]);
                translate([-length/2-3, -10, -.5]) cube([6, 4.12, 3.4]);
            }

            if(saveMaterial && length > 25) {
                translate([0, -9.5, -1]) {
                    hull() {
                        translate([-length/2 + 13, 0, 0]) cylinder(r=5, h=10, $fn=48);
                        translate([length/2 - 13, 0, 0]) cylinder(r=5, h=10, $fn=48);
                        translate([-length/2 + 7.7, .2, 0]) cube([1,1,10], h=10, center=true);
                        translate([length/2 - 7.7, .2, 0]) cube([1,1,10], h=10, center=true);
                    }
                }
            }
        }
        if(doNubs) {
            translate([length/2, -1.25, 0]) nub(2.6);
            translate([-length/2, -1.25, 0]) mirror([1, 0, 0]) nub(2.6);
        }
    }
}

module nub(h) {
    minkowski() {
        difference() {
            translate([-6, -7.5, 0]) cube([5, 3, h-1]);
            translate([0, -8.5, -.5]) cylinder(r=4, h=4, $fn=32);            
        }
        cylinder(r=1, h=1, $fn=16);
    }
}

module clipPoly(ox) {
    polygon(convexity=6, points=[
    [0.0, 1.2],
    [0.0, 10.45],
    [0.4, 11.7],
    [0.4, 12.7],
    [0.0, 13.95],
    [0.0, 16.0],
    [-0.79, 16.0],
    [-0.79, 3.4],
    [-0.99, 2.4],
    [-0.99, 1.2],
    [-2.24, 1.2],
    [-2.74, 1.72],
    [-2.74, 11.6],
    [-3.04, 11.6],
    [-3.04, 12.9299],
    [-2.74, 13.35],
    [-2.74, 15.2],
    [-3.2737, 16.0],
    [-3.89, 16.0],
    [-4.29, 15.6],
    [-4.29, 13.35],
    [-4.49, 12.9299],
    [-4.49, 11.7],
    [-4.29, 11.2799],
    [-4.29, 3.8146],
    [-4.3146, 3.6169],
    [-4.382, 3.4007],
    [-4.474, 3.224],
    [-5.106, 2.3078],
    [-5.198, 2.1311],
    [-5.2654, 1.9149],
    [-5.29, 1.7172],
    [-5.29, 0.48],
    [-5.2535, 0.2963],
    [-5.1494, 0.1406],
    [-4.9937, 0.0365],
    [-4.81, 0.0],

    [1.87+ox, 0.0],
    [2.0537+ox, 0.0365],
    [2.2094+ox, 0.1406],
    [2.3135+ox, 0.2963],
    [2.35+ox, 0.48],
    [2.35+ox, 1.7172],
    [2.3232+ox, 1.8854],
    [2.25+ox, 2.0621],
    [2.15+ox, 2.2],
    [2.05+ox, 2.3379],
    [1.9768+ox, 2.5146],
    [1.95+ox, 2.6828],
    [1.95+ox, 15.6],
    [1.55+ox, 16.0],
    [0.6883+ox, 16.0],
    [ox, 15.0],
    [ox, 14.1],
    [0.4+ox, 12.775],
    [0.4+ox, 11.625],
    [ox, 10.3],
    [ox, 1.2]
    ]);
}

module insertPoly() {
    polygon(convexity=4, points=[
        [0.0, 0.6],
        [0.0, 3.5],
        [-0.2783, 8.7],
        [-1.1, 10.496],
        [-1.1, 16.4],
        [-2.05, 16.4],
        [-2.65, 15.8],
        [-2.65, 6.8],
        [-2.95, 6.8],
        [-2.95, 5.67],
        [-2.65, 5.25],
        [-2.65, 3.1523],
        [-3.1583, 2.4],
        [-8.15, 2.4],
        [-8.3796, 2.3543],
        [-8.5743, 2.2243],
        [-8.7043, 2.0296],
        [-8.75, 1.8],
        [-8.75, 0.6],
        [-8.7043, 0.3704],
        [-8.5743, 0.1757],
        [-8.3796, 0.0457],
        [-8.15, 0.0],
        [-0.6, 0.0],
        [-0.3704, 0.0457],
        [-0.1757, 0.1757],
        [-0.0457, 0.3704]
    ]);
}