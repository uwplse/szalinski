/* BIBO 3D Printer filament spool adapter
 * by Paul F Sehorne 07/07/2019
 * aethenelle 10/2/2019
 */

part = "all"; // [washer:washer between spool adapter and stock arm cap,spacer:spacer between adapter and end of spool holder,adapter:spool diameter adapter,all:all]

$fn=32;

// OD of printer's stock spool holder
spindle_diameter=29;

// ID of spool
spool_axle_opening_diameter=52;

spool_width=70;

// fits between the sleeve the near end of the stock shaft
spacer_length=34;  
flange_wall_thickness=3;
washer_thickness=3; 

/* [Advanced] */

adapter_length=-1;

//automatically calculate if less than 0
washer_outer_diameter=-1;

large_flange_length=adapter_length < 0 ? spool_width-(2*washer_thickness) : adapter_length;

washer_od = washer_outer_diameter < 0 ? spool_axle_opening_diameter+12 : washer_outer_diameter;


if (part == "all" || part == "washer") {
    // goes between the filament spool and the stock flange moounted on the back of the printer
    solid_washer();
}
    
if (part == "all" || part == "spacer") {
    //takes up space between the adapter at the spool and the end of the stock shaft
    translate([0,0,part == "all" ? washer_thickness+ large_flange_length : 0]) solid_spacer();  
}

if (part == "all" || part == "adapter") {
    // slides through the filament spool
    translate([0,0,part == "all" ? washer_thickness +large_flange_length : 0]) rotate([0,part == "all" ? 180 : 0,0]) solid_adapter();
}

//******** modules *******************/
module solid_washer() {
    difference() {
        cylinder(h=washer_thickness, d=washer_od,center=false);
        translate([0,0,-0.5]) cylinder(h=washer_thickness+1, d=spindle_diameter);  
    }
}


module solid_spacer() {
    difference() {
        union() {
            //flange
            cylinder(h=4, d=spindle_diameter+6,center=false);
            //flange cylinder
            translate([0,0,4]) cylinder(h=spacer_length-4, d=spindle_diameter+flange_wall_thickness,center=false);
        }
        translate([0,0,-0.5]) cylinder(h=spacer_length+1, d=spindle_diameter);  
    }
}

module solid_adapter() {
    difference() {
        union() {
            //bottom flange plate
            solid_washer();
                
            difference() {
                //sleeve/axle
                translate([0,0,washer_thickness]) cylinder(h=large_flange_length-washer_thickness, d=spool_axle_opening_diameter,center=false);
                   
                translate([0,0,flange_wall_thickness]) cylinder(h=large_flange_length-(2*flange_wall_thickness), d=spool_axle_opening_diameter-flange_wall_thickness,center=false);
                   
            }
        }
        translate([0,0,-0.5]) cylinder(h=large_flange_length+1, d=spindle_diameter);  
    }
}
