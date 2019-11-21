// Universal filament filter 
// originally from FreeCAD and CreativeTools
// - http://www.thingiverse.com/thing:492067
// Brilliant design.
// Here remade in Openscad. Changed slot to 45 degree angle so works better with 3mm filament
// Also add external clip to hold on a spool.

// preview[view:south east, tilt:top diagonal]

/* [ Filter] */
// Height of the Filter (mm).
Filter_height = 30; //[10:1:80]
// Width of the Filter (mm).
Filter_width = 20; //[12:1:60]
// 5mm good. Smaller if Bowden tube jams.
Exit_hole_diameter = 5; // [4:10]
//The filament keeper hole size. Make slightly larger than real filament.(3.1)
filament_diameter = 3.1; // [1.0:0.05:4.0]
// How much thinner is the slot than the filament keeper hole.
slot_factor = 6; // [2:thinner,4:thin,6:normal,8:slight]


/* [Clip] */
// Add Clip to Filter?
Add_clip = "yes"; // [yes,no]
// Minimum should be longer than 3x filament dia.
Min_Clip_length = 15;

/* [Visualize] */
// Show the filter cut in half for clarity.
Show_Xsection = "no"; // [yes,no]


/* [Hidden] */
buffer = 1.2; // roundness of caps top and bottom
wall = 1.2;   // wall thickness
// Round or Flat Base. Print both with no support.
Base_style = "Flat"; // [Round,Flat]

inner_height = Filter_height - 2*wall - Filter_height/4;
height = Filter_height - 2*buffer;
clip_length = min(Min_Clip_length, height);

//$fa=1.5; // changing these two instead of $fn led to crashes in f6 CGAL.
//$fs=0.5;
$fn=80;
Delta = 0.1; // adj for safe CGAL(F6) overlaps

module filter() {
	translate([0,0,buffer]) { // push it up to >0
		difference() { //Subtract Outside from inside, hole, slot, Xsection.
			// Outside
			union() {
				cylinder(h=height, d=Filter_width);
				// Caps
				if (Base_style == "Round") { // rounded base
					resize(newsize=[0,0,buffer*2]) 
						sphere(d=Filter_width);
				} else { // flat base (easy printing)
					translate([0,0,-buffer])       
						cylinder(h=buffer+Delta, d=Filter_width);
				}
				// top cap
				translate([0,0,height])
				resize(newsize=[0,0,buffer*2])
					sphere(d=Filter_width);
			}
			
			// Inside
			union() {
				inner = Filter_width - 2*wall;
				y_offset = height-inner_height;
				// inner
				translate([0,0,y_offset/2])
					cylinder(h=inner_height, d=inner);
				// caps
				cylinder(h=y_offset/2+Delta/2, d1=Exit_hole_diameter-Delta, d2=inner );
				translate([0,0,height-y_offset/2-Delta/2])
					cylinder(h=y_offset/2+Delta/2, d1=inner, d2=Exit_hole_diameter-Delta );
			}
			
			// hole
			translate([0,0,-3])
				cylinder(h=Filter_height+6, d=Exit_hole_diameter );
				
			// slot for filament capture
			translate([0,0,Filter_height-Filter_width/2])
			rotate([-45,0,0]) // tilt it at 45 degrees.
			rotate([90,90,0]) {
				slot_thick = filament_diameter-filament_diameter/slot_factor;
				// filament hole
				cylinder(h=Filter_width*1.4141/2+Delta,d=filament_diameter+Delta);
				// the slot
				translate([-Filter_width/3,-slot_thick/2,0])
					cube([Filter_width/3, slot_thick, Filter_width*1.4141/2]);
			}
			
			// Visualise Cross_section
			if (Show_Xsection == "yes") {
				sz = max(Filter_height, Filter_width) + 2*Delta;
				translate([0,-sz/2,-buffer-Delta]) {
					cube([sz/2,sz,sz]);
				}
			}
		}
	}
}


module clip() {
	shift = (Base_style == "Round") ? buffer : 0;//(Filter_height-clip_length)/2;
	translate([0,0,shift])
	difference() {
		hull() {
			// support cylinder
			translate([Filter_width/2.9,0,0])
				cylinder(h=clip_length, d =Filter_width/2);
			// cable cylinder
			translate([Filter_width/1.5,0,0])
				cylinder(h=clip_length, d=max(Filter_width/5,6));
		}
		// inner volume
		inner = Filter_width - 2*wall;
		translate([0,0,-shift-Delta/2])
			cylinder(h=height, d=inner+Delta);
		// hole
		translate([Filter_width/1.5,0,-Delta/2]) {
			cylinder(h=clip_length+Delta*2, d =filament_diameter+Delta*2);
			hull() {
				translate([-0.2+Delta,-0.5,0])
					cylinder(h=clip_length+Delta*2, d =filament_diameter);
				translate([-3.2*filament_diameter+Delta,-8*filament_diameter,0])
					cylinder(h=clip_length+Delta*2, d =filament_diameter);
			}
		}
	}
}


// The Object
union() {
	filter();
	if (Add_clip == "yes") {
		clip();
	}
}
