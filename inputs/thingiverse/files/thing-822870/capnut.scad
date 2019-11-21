
$fn=32*1;

inch = 25.4*1;

// What kind of cavity? Choose 'hex' to capture a nut; choose 'round' to thread the plastic directly onto a rod.
cavity = "round"; // [hex,round]

// Diameter of the cavity (for a round cavity) or size of the nut (for a hex cavity)
inner_size_pick = 6.35; // [2.8448:#4,3.5052:#6,4.1656:#8,4.8260:#10,4.7625:3/16",5.55625:7/32",6.35:1/4",7.9375:5/16",9.525:3/8",11.1125:7/16",12.7:1/2",4:4mm,5:5mm,6:6mm,7:7mm,8:8mm,9:9mm,10:10mm,11:11mm,12:12mm,13:13mm,14:14mm,manual]

// Manual setting for diameter of the cavity (for a round cavity) or size of the nut (for a hex cavity) (mm)
inner_size_manual = 6;

inner_size = inner_size_pick=="manual" ? inner_size_manual : inner_size_pick;

// Outer size of the nut, i.e. the wrench size needed to turn it.
outer_size_pick = 11.1125; // [4.7625:3/16",5.55625:7/32",6.35:1/4",7.9375:5/16",9.525:3/8",11.1125:7/16",12.7:1/2",4:4mm,5:5mm,6:6mm,7:7mm,8:8mm,9:9mm,10:10mm,11:11mm,12:12mm,13:13mm,14:14mm,manual]

// Manual setting for wrench size of the cap nut (mm)
outer_size_manual = 8;

outer_size = outer_size_pick=="manual" ? outer_size_manual : outer_size_pick;

// Depth of the cavity -- for "hex", the thickness of the nut, for "round", the amount of shaft to consume (mm)
depth = 6.5;

edge_rounding = 0.98*1; // shave a little off the hex edges to make it easier to wrench, 1=no rounding, 0.92=almost fully round, 0.98=reasonable

// for hex forms, convert from flats-distance (wrench size) to points-distance (diameter)
id = cavity=="hex" ? 2/sqrt(3)*inner_size : inner_size;
od = 2/sqrt(3)*outer_size;

module form() {

    translate([0,0,depth/2])
        difference() {
            sphere(d=outer_size, center=true, $fn=2*$fn);
            sphere(d=inner_size, center=true);

            translate([0,0,-outer_size/2])
                cube([outer_size+1, outer_size+1, outer_size], center=true);
        }


    difference() {
        intersection() {
            cylinder(d=od, h=depth, $fn=6, center=true);
            cylinder(d=od*edge_rounding, h=depth, $fn=$fn, center=true);
        }
        cylinder(d=id, h=depth+2, $fn=(cavity=="hex"?6:$fn), center=true);
    }

}

if (inner_size <= outer_size-0.5) {
    form();
} else {
    linear_extrude(2) text("Error: inner size > outer size.");
}
