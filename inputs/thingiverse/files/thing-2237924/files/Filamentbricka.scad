// Filament make
make_text_box = "Hatchbox";
// Filament type
filament_text_box = "PLA";
// Filament variant
variant_text_box = "Fluorescent";
// Filament color
color_text_box = "Black";
// Filament extrusion temp
temp_text_box = "195";
// Bed temp
bedtemp_text_box = "50";

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

$fn = 90*1;
fontsize = 4*1;
linedist = 4.5*1;

linear_extrude(height=2) {
    difference() {
        minkowski() {
            square([40,25]);
            circle(1);
        }
        translate([3,3])
        circle(d=4);
    }
}
linear_extrude(height=1) {
    difference() {
        minkowski() {
            square([50,25]);
            circle(1);
        }
        translate([3,3])
        circle(d=4);
    }
}

translate([0,-2,2])
linear_extrude(height=0.4) {
    translate([0,5*linedist]) text(make_text_box, size=fontsize);
    translate([0,4*linedist]) text(filament_text_box, size=fontsize);
    translate([0,3*linedist]) text(variant_text_box, size=fontsize);
    translate([0,2*linedist]) text(color_text_box, size=fontsize);
    translate([8,1*linedist]) text(str("T=", temp_text_box, " B=", bedtemp_text_box), size=fontsize);
}