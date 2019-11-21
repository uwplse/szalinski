//////////////////////////////////////////////
// Start of User Configurable Parameters
//////////////////////////////////////////////

/**
top_hook_radius: [Mili Meters] This is the inner radius of the top S Hook
**/
top_hook_radius = 20;

/**
bottom_hook_radius: [Mili Meters] This is the inner radius of the bottom S Hook
**/
bottom_hook_radius = 10.5;

/**
width: [mili meters] This is the width of the S Hook body (in Y direction)
**/
width = 6.0;

/**
thickness: [Milli Meters] This is the thickness of the S Hook (in Z direction)
**/
// The thickness of the piece
thickness = 12.0;

/**
length: [mili meters] This is the length of the joiner between hook ends (in X direction)
**/
length = 60.0;

/**
start_angle: [DEGREES] This adjusts where the opening in the S Hook starts
**/
start_angle = 45;

/**
end_angle: [DEGREES] This adjusts where the opening of the S Hook ends.
	Normally end_angle will be ~-90 degrees. This is so the transition from top to bottom hook
	is smooth. If you want the opening to be somewhere else than adjust this value.
**/
end_angle = -89; // 


//////////////////////////////////////////////
// End of User Configurable Parameters
//////////////////////////////////////////////

/**
The union formed in this method is used to cut the hook opening in the circle
**/
module cutOpening(start, end, radius) {
	union() {
		for(angle=[start:end]) {
			//echo("remove angle: ", angle);
			rotate([0,0,angle]) {
				translate([0,0,-thickness/2-0.01]) {
					cube([radius,4,thickness+0.04]);
				}
			}
		}
	}
}

/**
This method forms one half of the S Hook
**/
module hook(hookWidth, hookThickness, hookInnerRadius) {
	radius = hookInnerRadius + hookWidth; 
	
	start = floor(start_angle);
	end = floor(end_angle);
	
	openingStart = min(start, end);
	openingEnd = max(start, end);
	
	echo("Opening Start Angle=", openingStart, " openingEnd= ", openingEnd);
	
	difference() {
		cylinder( h = thickness, r = radius, center = true);	
    	cylinder( h = thickness, r = hookInnerRadius, center = true);
		
		cutOpening(start, end, radius);
	}
}

union() {
	translate(v = [-length,0,0]) {
    	hook(width, thickness, top_hook_radius);
	}
	translate(v = [-length/2,-1*(top_hook_radius+(width/2)),0]) {
		cube([length,width,thickness],true);
	}
	
    translate(v = [0,-1*(top_hook_radius+(width)+bottom_hook_radius),0]) {
        rotate([0, 0, 180]) {
	    	hook(width, thickness, bottom_hook_radius);
		}
    }
}