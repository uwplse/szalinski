
part = "first"; // [first:Calibration Cube,second:Text inlay]

// Include dual material settings
use_dual = 1; // [0:No, 1:Yes]

material = "PLA";

manufacturer = "Generic";

color = "XimaB";

// in mm/s
speed = 60;

// height
layer = 0.15;

// Adaptive layers max variation
layer_adj = 0.1;

// type
infill = "gyroid";

// Infill percentage
infill_pct = 20;

// Print time
time = "15m";

// Print tempurature
print_temp = 200;

// Initial printing pemperature
initial_temp = 190;

// Final printing tempurature
final_temp = 185;

// Standby tempurature
standby = 175;

// Bed tempurature
bed_temp = 60;

module stats() {
    translate([5,1,15]) rotate([90,0,0]) rotate([0,0,-90]) linear_extrude(1.1) text("X");
    translate([1,15,5]) rotate([90,0,-90]) linear_extrude(1.1) text("Z");
    translate([5,5,19.4]) linear_extrude(1.1) text("Y");

    layer_suff = layer_adj ? str("±", layer_adj) : "";
    translate([19,1,16]) rotate([90,0,90]) linear_extrude(1.1) text(str(layer,layer_suff), 3);
    translate([19,1,11]) rotate([90,0,90]) linear_extrude(1.1) text(infill, 3);
    translate([19,1,6]) rotate([90,0,90]) linear_extrude(1.1) text(str(infill_pct,"%"), 3);
    translate([19,1,1]) rotate([90,0,90]) linear_extrude(1.1) text(str(speed,"mm/s"), 3);
        
    translate([19,19,16]) rotate([90,0,180]) linear_extrude(1.1) text(str(print_temp, "°"), 3);
    translate([9,19,16]) rotate([90,0,180]) linear_extrude(1.1) text(str(bed_temp, "°"), 3);    
    if (use_dual) {
        translate([19,19,11]) rotate([90,0,180]) linear_extrude(1.1) text(str(initial_temp, "°"), 3);
        translate([19,19,6]) rotate([90,0,180]) linear_extrude(1.1) text(str(final_temp, "°"), 3);
        translate([19,19,1]) rotate([90,0,180]) linear_extrude(1.1) text(str(standby, "°"), 3);
    }

    translate([3,7,1]) rotate([0,180,180]) linear_extrude(1.1) text(manufacturer, 3);
    translate([3,12,1]) rotate([0,180,180]) linear_extrude(1.1) text(material, 3);
    translate([3,17,1]) rotate([0,180,180]) linear_extrude(1.1) text(color, 3);
}

module main() {
    difference() {
        cube(20);
        stats();
    }
}


module dual_color() {
    intersection() {
        cube(20);
        stats();
    }
}


if (part == "second") {
   dual_color();
} else {
   main();
}
