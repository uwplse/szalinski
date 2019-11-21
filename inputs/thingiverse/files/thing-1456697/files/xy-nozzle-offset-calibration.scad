layerHeight = 0.4;
size = 10;
offset = 0.1; //["0.2", "0.1", "0.05"]
draw = "extruder1"; //["extruder1", "extruder2"]

if (draw=="extruder1") {
    union() {
        cube([10,(size)*10-5,layerHeight]);
        for (i=[0:size-1]) {
            translate([0,i*10,layerHeight])
            cube([5,5,layerHeight]);
        }
    }
    translate([-(((size)/2)*10),5,0])
    rotate([0,0,-90])
    union() {
        cube([10,(size)*10-5,layerHeight]);
        for (i=[0:size-1]) {
            translate([0,i*10,layerHeight])
            cube([5,5,layerHeight]);
        }
    }
} else {
    union() {
        for (i=[0:size-1]) {
            translate([5,i*10-(i-size/2)*offset,layerHeight])
            cube([5,5,layerHeight]);
        }
    }
    translate([-((size/2)*10),5,0])
    rotate([0,0,-90])
    union() {
        for (i=[0:size-1]) {
            translate([5,i*10-(i-size/2)*offset,layerHeight])
            cube([5,5,layerHeight]);
        }
    }
    
}