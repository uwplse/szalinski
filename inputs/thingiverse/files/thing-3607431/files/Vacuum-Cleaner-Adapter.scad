
/* [General] */
// Vacuum cleaner side, interior diameter (male part)
Vacuum_diameter = 39;
// Tool side, exterior diameter (female part)
Tool_diameter = 29;
// Full adapter length
Adapter_length = 60;
// Cone size, in percent
Center_size = 0.1; // [0:0.01:1]
// Adapter thickness
Adapter_thickness = 2;

/* [Hidden] */
$fn=100;
Center_length = Adapter_length * Center_size;
Part_length = (Adapter_length - Center_length) /2;

union() {
difference() {
    cylinder (r=Tool_diameter/2+Adapter_thickness,h=Part_length);
    translate([0, 0, -0.1]) cylinder (r=Tool_diameter/2,h=Part_length+0.2);
}

translate([0, 0, Part_length-0.1]) difference() {
    cylinder (r1=Tool_diameter/2+Adapter_thickness, r2=Vacuum_diameter/2,h=Center_length+0.1);
    translate([0, 0, -0.1]) cylinder (r1=Tool_diameter/2,r2=Vacuum_diameter/2-Adapter_thickness,h=Center_length+0.3);
}


translate([0, 0, Part_length+Center_length-0.1]) difference() {
    cylinder (r=Vacuum_diameter/2,h=Part_length+0.1);
    translate([0, 0, -0.1]) cylinder (r=Vacuum_diameter/2-Adapter_thickness,h=Part_length+0.3);
}
}
