//Width of the AC adapter. Apple MacBook adapters are 28.3mm wide (thick).
adapter_width = 28.3;
//Length of the AC adapter. Apple's 85W MagSafe 2 adapter is 80.1mm; the 45W MagSafe 1 adapter is 65.2mm.
adapter_length = 80.1;
//Vertical coverage of AC adapter. Does not include the centimeter or so of airflow beneath the adapter.
adapter_covered_height = 25;

//The corner radius of the adapter.
inset_radius = 7 * 1;
inset_width = adapter_width - inset_radius * 2;
inset_length = adapter_length - inset_radius * 2;

outset_radius = 10 * 1;
base_width = adapter_width + outset_radius * 2 - inset_radius * 2;
base_length = adapter_length + outset_radius * 2 - inset_radius * 2;

foot_radius = outset_radius * 1;

floor_height = foot_radius * 2;
stand_height = adapter_covered_height + floor_height;
base_thickness = 5 * 1;

$fa=1 * 1;
$fs=0.5 * 1;

rotate([0, 0, 90])
difference() {

//translate([0,0,foot_radius])
intersection() {
translate([-100, -100, 0])
cube([200, 200, stand_height]);

hull()
 {
//Top edge
translate([inset_width * -0.5 + inset_radius, inset_length * -0.5 + inset_radius, stand_height])
sphere(r=inset_radius);
translate([inset_width * -0.5 + inset_radius, inset_length * +0.5 - inset_radius, stand_height])
sphere(r=inset_radius);
translate([inset_width * +0.5 - inset_radius, inset_length * -0.5 + inset_radius, stand_height])
sphere(r=inset_radius);
translate([inset_width * +0.5 - inset_radius, inset_length * +0.5 - inset_radius, stand_height])
sphere(r=inset_radius);
//Base
translate([base_width * -0.5, base_length * -0.5, 0])
sphere(r=foot_radius);
translate([base_width * -0.5, base_length * +0.5, 0])
sphere(r=foot_radius);
translate([base_width * +0.5, base_length * -0.5, 0])
sphere(r=foot_radius);
translate([base_width * +0.5, base_length * +0.5, 0])
sphere(r=foot_radius);
} //hull
}

//AC adapter
color("blue") {
hull() {
translate([adapter_width * -0.5 + inset_radius, adapter_length * -0.5 + inset_radius, floor_height])
sphere(r=inset_radius);
translate([adapter_width * -0.5 + inset_radius, adapter_length * +0.5 - inset_radius, floor_height])
sphere(r=inset_radius);
translate([adapter_width * +0.5 - inset_radius, adapter_length * -0.5 + inset_radius, floor_height])
sphere(r=inset_radius);
translate([adapter_width * +0.5 - inset_radius, adapter_length * +0.5 - inset_radius, floor_height])
sphere(r=inset_radius);

translate([adapter_width * -0.5 + inset_radius, adapter_length * -0.5 + inset_radius, floor_height + adapter_length])
sphere(r=inset_radius);
translate([adapter_width * -0.5 + inset_radius, adapter_length * +0.5 - inset_radius, floor_height + adapter_length])
sphere(r=inset_radius);
translate([adapter_width * +0.5 - inset_radius, adapter_length * -0.5 + inset_radius, floor_height + adapter_length])
sphere(r=inset_radius);
translate([adapter_width * +0.5 - inset_radius, adapter_length * +0.5 - inset_radius, floor_height + adapter_length])
sphere(r=inset_radius);
} //hull

translate([adapter_width * -0.5 + inset_radius, adapter_length * -1, base_thickness])
cube([adapter_width - inset_radius * 2, adapter_length * 2, adapter_length]);
translate([adapter_width * -2, adapter_length * -0.5 + inset_radius, base_thickness])
cube([adapter_width * 4, adapter_length - inset_radius * 2, adapter_length]);
} //blue

} //difference
