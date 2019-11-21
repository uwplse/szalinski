/* [Nominal Extrusion Dimensions] */

// Nominal width of the extrusion (i.e. 3030 = 30mm)
extrusion_width=30;

// Nominal width of the outer slot
slot_width=8.0;

// Nominal depth / height of the outer slot
slot_height=2.0;

// Nominal width of the t-slot channel at the top of the channel
tslot_top_width=16.5;

// Nominal height of the square portion of the t-slot channel
tslot_cube_height=3.5;

// Nominal height of the trapezoid portion of the t-slot channel
tslot_trap_height=3.5;

/* [End Cap Dimensions] */

// The amount of "margin" or gap around the tabs of the endcap (0.0 - need a hammer; 0.2 - snug; 0.5 - very loose)
undersize=0.2; // [0.0:0.05:0.5]

// Thickness of the cover / endcap
cover_thickness=3.0;

// Corner rounding diameter (in mm)
corner_rounding=2.0;

// Hole size (0 for no hole, otherwize specify exact desired diameter)
hole_size=7.3;

// Overall height of the tabs / inserts
tab_height=7;

/* [Hidden] */

// Nominal width of the t-slot channel at the bottom of the channel
tslot_bottom_width=tslot_top_width-tslot_trap_height*2;  // Because the angle of the trapezoid sides needs to be at 45 degrees, the triangle on each side is an isocolese triangle. Therefore the width of the top of the trapezoid is the bottom width - 2 times the height of the trapezoid


difference() {
	union() {
        
        // CREATE 4 SIDES OF COVER INSERTS
		for (a=[0:3])
			rotate([0,0,90*a])
				translate([0,-extrusion_width/2,0])
					t_slot();
		
        // CREATE COVER BASE WITH ROUNDED CORNERS
		translate([-extrusion_width/2+corner_rounding, -extrusion_width/2+corner_rounding,0])
			minkowski() {
				cube([extrusion_width-corner_rounding*2,extrusion_width-corner_rounding*2,cover_thickness-1]);
				cylinder(r=corner_rounding, h=1, $fn=16);
			}
	}
    
    // CREATE HOLE IN COVER
	cylinder(r=hole_size/2, h=cover_thickness*4, center=true);
}

module t_slot() {
    
    // CREATE SLOT
	translate([-slot_width/2+undersize,0,0])
		cube([slot_width-undersize*2, slot_height+undersize, tab_height+cover_thickness]);
    
    if (tslot_cube_height == 0) {
        
        // CREATE T-SLOT CHANNEL (TRAPEZOID SECTION)
        translate([0,slot_height+undersize,0])
            linear_extrude(height=tab_height+cover_thickness)
                trapezoid(bottom=tslot_top_width-undersize*2, top=tslot_bottom_width-undersize*2, height=tslot_trap_height-undersize*2);
        
    }
    
    else {
        
        // CREATE T-SLOT CHANNEL (CUBE SECTION)
        translate([-tslot_top_width/2+undersize,slot_height+undersize,0])
            cube([tslot_top_width-undersize*2,tslot_cube_height-undersize,tab_height+cover_thickness]);
        
        // CREATE T-SLOT CHANNEL (TRAPEZOID SECTION)
        translate([0,slot_height+tslot_cube_height,0])
            linear_extrude(height=tab_height+cover_thickness)
                trapezoid(bottom=tslot_top_width-undersize*2, top=tslot_bottom_width-undersize*2, height=tslot_trap_height-undersize);
    }
}


module trapezoid(bottom=10, top=5, height=2)
{
	polygon(points=[[-bottom/2,0],[bottom/2,0],[top/2,height],[-top/2,height]]);
}