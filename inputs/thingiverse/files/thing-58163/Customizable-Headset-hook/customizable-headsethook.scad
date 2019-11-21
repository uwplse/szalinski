//Change the following values to your needs.
// Size of your desk. x>0
desk_size = 25;

// Width of your headphone.
cradle_width = 5;

// Thickness of your headphone.
cradle_height = 3;

// Size of the walls of the object. x>0
wall_size = 3;

// Width of the clamp. x>0
clamp_width = 10;

// Depth of the clamp. x>0
clamp_depth = 20;

// Determines tightness of clamp. 0=<x<wall_size
tightinator_offset = .5;

// Preferred relative width of the tightinator. 0 <=x< 1
tightinator_width = .55;

// Preferred relative height/depth of the tightinator. 0 <=x< 1 
tightinator_height = .65;

// Size of the gap around the tightinator (cut-out). 0 <=x<= tightinator_width*12.5 (roughly)
cutout = .9;

// Preferred width of the hook. 0<x
hook_width = 10;

// Place the hook at the left, right, or centre.
hook_position = "centre"; // [left, centre, right]

// STOP! No need to change these values:
left = clamp_width-hook_width;
centre = clamp_width/2-hook_width/2;
right = 1 * 0;

//
// Here be code...
//

// Some voodoo to bypass the customizer
if (hook_position == "centre") {
	thing(centre);
} else if (hook_position == "right") {
	thing(right);
} else {
	thing(left);
}

// This is the proverbial "it". TADA.wav!
module thing(hookpos)
{
    render()
	union() {
		clamp();
		hook(hookpos);
	}
}

// The part that fits on the desk.
module clamp() {
	union(){
	difference() {
		//main body
		cube([desk_size+2*wall_size,clamp_depth+wall_size,clamp_width]);
		translate([desk_size+wall_size+.001,0,0])
		  #clamp_angle();
		translate([wall_size, 0, 0])
		  cube([desk_size,clamp_depth,clamp_width]);
		//cut-out part
		translate([desk_size+wall_size, (1-tightinator_height)/2*(clamp_depth-wall_size), (1-tightinator_width)/2*clamp_width])
	  	  difference() {
			cube([wall_size,clamp_depth*tightinator_height,clamp_width*tightinator_width]);
			translate([0, cutout+.001, cutout])
		  	cube([wall_size,(clamp_depth*tightinator_height)-cutout,(clamp_width*tightinator_width)-2*cutout]);
	      }		
	}
	translate([desk_size,0,0])
	  clamp_angle();
	}
}

// The TIGHTINATOR. Part of the clamp.
module clamp_angle() {
	a = ((1-tightinator_height)/2*(clamp_depth-wall_size))+cutout-.001;
	b = a + ((clamp_depth*tightinator_height)-cutout);
	translate([0,0,(1-tightinator_width)/2*clamp_width+cutout-.001])
	linear_extrude(height=(clamp_width*tightinator_width+.001)-2*cutout+.001) polygon([[wall_size,a],[wall_size,b],[wall_size-tightinator_offset,a]]);
}

// The part your headset hangs on/off.
module hook(hookpos) {
$fn=30;
translate([wall_size/2, clamp_depth+wall_size-0.001, hookpos])
	minkowski(){
		difference() {
			linear_extrude(height=hook_width) polygon([[cradle_height,0],[cradle_height,cradle_width+wall_size/2],[0,cradle_width+wall_size/2],[0,cradle_width+wall_size],[cradle_height+wall_size,cradle_width+wall_size],[desk_size+wall_size,0]]);
			//cylinder(h = hook_width, r = cradle_width+wall_size);
		} 
		cylinder(h = 0.0001, r = wall_size/2);
	}
}
