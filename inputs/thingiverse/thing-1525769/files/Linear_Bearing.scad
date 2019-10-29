// Open SCAD model of any linear bearing

/* [General Dimensions] */

internal_diameter =  8.0;  // Internal diameter
external_diameter = 15.0;  // External diameter
length     = 24.0;  // Length

/* [Retainer Rings] */

retainer_rings_depth   = 0.7;  // Retainer ring depth
retainer_rings_width     =  1.1;  // Retainer ring width
retainer_rings_offset     = 17.5;  // Retainer ring offset

/* [Inner Grooves] */

groove_depth = 1.6;  // Groove depth
groove_width = 1.2;    // Groove width
groove_count = 12;    // Groove count

/* [Hidden] */

$fn = 50;

module groove(d1, d2, w) {
	difference() {
		cylinder(r=d1/2+1, h=w, center=true);
		cylinder(r=d2/2  , h=w, center=true);
	}
}

module lb(internal_diameter=8, external_diameter=15, retainer_rings_depth=0.7, length=24, retainer_ringroove_widthidth=1.1, retainer_rings_offset=17.5) {
    chamf = retainer_rings_depth;
    RR_d = external_diameter - retainer_rings_depth;
	difference() {
		hull() {
			cylinder(r=external_diameter/2, h=length-chamf, center=true);
			cylinder(r=RR_d/2, h=length     , center=true);
		}
		cylinder(r=internal_diameter/2, h=length+2    , center=true);
        cylinder(r = internal_diameter/ 2, h=length+20, $fn=50, center=true);
		translate([0, 0, retainer_rings_offset/2-retainer_rings_width/2]) groove(external_diameter, RR_d, retainer_rings_width);
		translate([0, 0,-retainer_rings_offset/2+retainer_rings_width/2]) groove(external_diameter, RR_d, retainer_rings_width);
        
        for (i = [0:groove_count]) assign( grooveAngle=(i+1)*360/groove_count) {
            rotate(90-grooveAngle) translate([0,-(groove_width/2),-((length+retainer_rings_width)/2)])
            cube(size=[(internal_diameter/2)+groove_depth, groove_width, length+retainer_rings_width], center=false);
        }

    
	}
    
}

translate([0,0,length/2]) lb(internal_diameter, external_diameter, retainer_rings_depth, length, retainer_ringroove_widthidth, retainer_rings_offset);