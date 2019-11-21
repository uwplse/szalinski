// This one better be as fit as possible
spline_major=35;
spline_minor=27.5;
spline_count=12;
// Belarus 1523.4 spline length 78mm
spline_length=80;

spline2_major=48;
spline2_minor=41.5;
spline2_count=16;
// Belarus 1523.4 spline2 length 30mm, but we need more as handle
spline2_length=60;


// Bearing iD = 25
pilot_diam=25;
pilot_guide_length_percent=20;
pilot_length=15;

// Not really useful for 1523.4
handle_length=0;

total_length = spline2_length+spline_length+handle_length+pilot_length;
echo (concat("Total length: ", total_length));

// 1523.4 clutch mechanism (splines) is about 110mm in length
usable_length = spline2_length+spline_length;
echo (concat("Total spline length: ", usable_length));

// HANDLE
cylinder(r=spline2_major/2, h=handle_length);

// BOTTOM SPLINE
translate([0,0,handle_length+spline2_length])
    spline(spline_major, spline_minor, spline_count, spline_length);
// TOP SPLINE
translate([0,0,handle_length])
    spline(spline2_major, spline2_minor, spline2_count, spline2_length);

// PILOT GENERATION
offset_pilot=handle_length+spline2_length+spline_length;
translate([0,0,offset_pilot])
     cylinder(r=pilot_diam/2, h=pilot_length*(1-pilot_guide_length_percent*0.01));
translate([0,0,offset_pilot+pilot_length*(1-pilot_guide_length_percent*0.01)])
     cylinder(r1=pilot_diam/2, r2=0.9*pilot_diam/2, h=pilot_length*(pilot_guide_length_percent*0.01));  
	

module spline(spline_major=45, spline_minor=40, spline_count=20, spline_length=10){
    spline_depth=(spline_major-spline_minor)/2;
    major_circumference=3.14159*spline_major;
    minor_circumference=3.14159*spline_minor;
    
    spline_bottom_width=minor_circumference/(spline_count*2);
    spline_width=(major_circumference-(spline_bottom_width*spline_count))/spline_count;
    
    union() {
		difference() {
			cylinder(r=spline_major/2, h=spline_length);
			
			for (c=[0:spline_count])
				rotate([0,0,c*360/spline_count])
					translate([spline_minor/2+0.001,0,-0.5])
						linear_extrude(height=spline_length+1)
							polygon(points=[[0,-spline_bottom_width/2],[spline_depth,-spline_width/2],[spline_depth,spline_width/2],[0,spline_bottom_width/2]]);				
		}		
	}
}
