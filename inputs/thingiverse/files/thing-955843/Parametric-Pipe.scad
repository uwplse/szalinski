// inner diameter
solidInner = 6;

// outer diameter
solidOuter = 12;

// thickness
solidThickness = 1;

// inner diameter
hollowInner = 8;

// outer diameter
hollowOuter = 10;

// thickness
hollowThickness = 10;

// offset
offset = -6;



module washer (inner, outer, thickness) {

    difference() {
        cylinder(d=outer, h=thickness, $fn=60);
        translate([0,0,-thickness])
        cylinder(d=inner, h=thickness*3, $fn=60);
    };
}

union() {
    washer (solidInner, solidOuter, solidThickness);
    translate ([0,0,offset]) washer (hollowInner, hollowOuter, hollowThickness);
}