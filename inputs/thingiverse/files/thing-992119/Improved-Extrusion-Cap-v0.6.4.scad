// Improved Extrusion End Cap
// Original by jag
// Modified by Bill Gertz (billgertz) on 31 August 2015
// Version 0.6.4
//
// Fixed:
// 0.5     billgertz   Modified code to create double (2n x n) end caps with no, one or two holes
//                     Modified tab height to clarify length as a seperate tab
// 0.6.3   billgertz   Modified and corrected for customizer
// 0.6.4   billgertz   Added work around Customizer bug by renaming [Global] to [General] tab
//
// Improved Extrusion End Cap by billgertz is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
// Based on a work at http://www.thingiverse.com/thing:43756 
// All measurements are in mm
//

/* [General] */
// set to print a double wide cap e.g. 40x80
double_wide_cap="yes";       // [yes,no]

// set holes, but for:
//       double wide (double_wide_cap=true): > 2 generates only two holes
//       single wide (double_wide_cap=false): > 1 generates one hole
//       either: < 0 generates no holes

// number of holes //
holes=0;                     // [0:none,1:one,2:two]

/* [T Slot Base] */
// width of exterior slot at T base (mm)
slot_width=8.35;             // 
// wall thckness of extrusion at T base (mm)
slot_thickness=4.5;          // 

/* [T Slot Crossbar] */
// length of T crossbar (mm)
t_width=19.0;                // 
// depth of crossbar before taper (mm)
t_depth=3.5;                 // 

/* [T Slot Crossbar Taper] */
// most T slot excrusion narrows at top of T crossbar this is modeled with a trapazoid

// bottom of taper use T Width (mm)
trapezoid_bottom_width=19.0; // 
// top of taper (mm)
trapezoid_top_width=9.5;     // 
// taper width (mm)
trapezoid_depth=3.6;         // 

/* [End Cap] */
// extrusion size (mm)
extrusion_size=40;           // [10,15,20,25,30,40,50]
// end cap thickness (mm)
end_cap_thickness=3;         // [2:10]
// corner rounding radius (mm)
corner_rounding=2;           // [2:5]
// hole diameter (mm)
hole_size=7.7;               // 
// length of tabs that fit into each T slot (mm)
tab_height=7;                //  
// trim for good fit (mm)
undersize=0.2;		         // 

if (double_wide_cap == "yes") {
    union() {
        translate([0,-extrusion_size,0])
        
            if (holes > 1) {
                end_cap_with_hole();
            } else {
                end_cap();
            }
            
        if (holes > 0) {
               end_cap_with_hole();
        } else {
               end_cap();
        }
        
        patch();
        
    }
    
} else {
    if (holes > 0) {
        end_cap_with_hole();
    } else {
        end_cap();
    }
}

module end_cap_with_hole() {
    difference() {
        end_cap();
        cylinder(r=hole_size/2, h=end_cap_thickness*4, center=true, $fn=30);
    }   
}

module end_cap() {
    union() {
        
        for (a=[0:3])
            rotate([0,0,90*a])
                translate([0,-extrusion_size/2,0])
                    t_slot();
		
        translate([-extrusion_size/2+corner_rounding, -extrusion_size/2+corner_rounding,0])
            minkowski() {
                cube([extrusion_size-corner_rounding*2,extrusion_size-corner_rounding*2,end_cap_thickness-1]);
                cylinder(r=corner_rounding, h=1, $fn=30);
            }
            
    }
    
}

module t_slot() {
	translate([-slot_width/2+undersize/2,0,0])
		cube([slot_width-undersize, slot_thickness+t_depth, tab_height+end_cap_thickness]);
	translate([-t_width/2+undersize/2,slot_thickness,0])
		cube([t_width-undersize,t_depth-undersize+0.01,tab_height+end_cap_thickness]);
	translate([0,slot_thickness+t_depth-undersize,0])
		linear_extrude(height=tab_height+end_cap_thickness)
			trapezoid(bottom=trapezoid_bottom_width-undersize, top=trapezoid_top_width-undersize, height=trapezoid_depth-undersize);
}


module trapezoid(bottom=10, top=5, height=2) {
	polygon(points=[[-bottom/2,0],[bottom/2,0],[top/2,height],[-top/2,height]]);
}

module patch() {
    translate([-extrusion_size/2,-extrusion_size/2-corner_rounding,0])  // create patch for rounded corners at join
        cube([extrusion_size,corner_rounding*2,end_cap_thickness]);
}
