
diameter = 100; // base diameter in mm
height = 10; // coaster height in mm
thickness = 0.5; // wall thickness in mm

type = "cone"; // ["cone", "normal"]

hump = true;

quality = 200; // FN quality

$fn = quality;

module base_cone() {
    difference() {
        cylinder(height, r1=diameter/2, r2=diameter/2 + height);
        translate([0,0,thickness])
        cylinder(height, r1=diameter/2 - thickness, r2=diameter/2 + height - thickness);
    }
}

module base_normal() {
    difference() {
        cylinder(height, r=diameter/2);
        translate([0,0,thickness])
        cylinder(height, r=diameter/2 - thickness);
    }
}


if (type == "cone") {
    base_cone();
} else if (type == "normal") {
    base_normal();
}
