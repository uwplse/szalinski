// Telescope Focus Tube Plug

// Diameter of eyepiece tube
od = 31.75; 

// Shoulder Height
shoulder = 2;

// Wall thickness
wt = 2;

// Hole for Alignment
hole = 1; // [1:Yes, 0:No]

$fa=5 * 1;
$fs=0.5 * 1;
top = od * 0.1;
bottom = od * 0.75;

difference()  {

union() {
    translate([0, 0, top * 0.49])
        cylinder(r=od/2 + shoulder, h = top, center=true);
    translate([0, 0, -bottom/2])
        cylinder(r = od/2, h = bottom, center=true);
}

union() {
    translate([0, 0, -bottom/2])
        cylinder(r=od/2-wt, h=bottom*1.01, center=true);
        if (hole == 1) {
            translate([0, 0, 0])  
                cylinder(r1 = 0.5*top, r2 = top*1.5, h = top*1.01);
        }
    }
}



    