$fn=60;
//The inside hole size (diameter) of your filament spool in MM
spool_inside_diameter = 31.5; //min/step/max: [0:0.5:100]
//The total height of the spool adapter
total_height=15; //min/step/max: [0:0.5:100]
//The brim width -- how much lip to hold your spool
brim_width=60; //min/step/max: [0:0.5:100]
// the brim height -- how thick to the make the lip
brim_height=6; //min/step/max: [0:0.5:100]
//the size (diameter) of your HDD spindle / bearing -- what you mount the adapter to
spindle_size=25; //min/step/max: [0:0.5:100]

module main_spool() {
    union() {
        cylinder(r=brim_width/2, h=brim_height);
        cylinder(r=spool_inside_diameter/2, h=total_height);
    }
}

module hollow_center() {
    translate([0,0,-.5]) {
        cylinder(r=spindle_size/2, h=total_height+1);
    }
}

difference() {
    main_spool();
    hollow_center();
}
