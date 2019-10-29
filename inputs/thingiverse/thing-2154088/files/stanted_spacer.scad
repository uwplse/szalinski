tolerance = 0.25;
// diameter
inner = 5 + tolerance;
// diameter
outer = 9;
angle = 20;
thickness = 3;

module washer (inner, outer, thickness, angle) {

    allthick = thickness + outer*tan(angle);
    
    difference() {
        cylinder(d=outer, h=allthick, $fn=50);
        translate([0,0,-allthick])
        cylinder(d=inner, h=allthick*3, $fn=50);
        
        translate([-outer/2, outer/2, thickness]) rotate([90-angle, 0, 0]) 
        cube(outer*outer, outer*outer, outer*outer);
    };
}

// dimensions in mm
washer (inner, outer, thickness, angle);