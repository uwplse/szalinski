// Modified for thingiverse customizer
// by infinigrove Squirrel Master 2016 (http://www.thingiverse.com/infinigrove)
//
// Customizable Coffee Tamper v 1.2
// http://www.thingiverse.com/thing:1309333
//
//originally hacked from http://www.thingiverse.com/thing:708062
//Parametric coffee tamper by owar 4.3.2015

// Tamper detail
tamper_detail = 40; // [40:360]

// Tamper Style
tamper_style = "straight";// ["straight":Straight stem, "taper":Tapered stem]

// Tamper Diameter
tamper_diameter = 53; // [48:0.5:62]

tamper_height = 8; // [4:0.5:18]

holder_diameter = 14; // [6:0.5:28]

holder_height = 33; // [20:80]

top_knob_diameter = 28; // [10:58]

bottom_bevel = 1; // [.7:0.1:1.7]

/* [Hidden] */

	

	difference(){
        union(){
        cylinder(d = tamper_diameter, h = tamper_height, $fn=tamper_detail); // bottom base
            
        if (tamper_style == "straight") cylinder(d = holder_diameter, h = holder_height, $fn=tamper_detail); // center pole
            
        if (tamper_style == "taper") cylinder(d1 = holder_diameter, ,d2 = top_knob_diameter, h = holder_height, $fn=tamper_detail); // center pole   
            
        translate([0,0,holder_height]) sphere(d=top_knob_diameter, $fn=tamper_detail); // knob on top
            
        translate([0,0,tamper_height/2]) sphere(holder_diameter/bottom_bevel, $fn=tamper_detail); // bottom bevel
        
        }
        
		translate([0,0,-holder_diameter*3]) cylinder(h = holder_diameter*3,r = tamper_diameter, $fn=tamper_detail);

	}
		
	
	
