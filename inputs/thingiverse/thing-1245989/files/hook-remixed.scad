// Parametric Desk Hook w/ Hole for Headphone Cable
// fros1y 

// Width of hook
width = 20;

// Thickness of desk
desk_height = 35;

// Height of headphones portion
hook_height = 30;

//Height of the hook of the headphones portion
hook_end_height = 5;

// Thickness of Plastic in Hook
thickness = 5;

// Depth of Hook
depth=40;

// Diameter of Headphone Jack (0 disables)
jack = 10;

// Fillet code borrowed from Vaclav Hula (http://axuv.blogspot.com/2012/05/openscad-helper-funcions-for-better.html)

module fillet(radius, height=100, $fn=16) {                                     
    //this creates negative of fillet,
    //i.e. thing to be substracted from object
    translate([-radius, -radius, -height/2-0.01])
        difference() {
            cube([radius*2, radius*2, height+0.02]);
            cylinder(r=radius, h=height+0.02, $fn=16);
        }
}


module cube_negative_fillet(
        size,
        radius=-1,
        vertical=[3,3,3,3], 
        top=[0,0,0,0],
        bottom=[0,0,0,0],
        $fn=0
    ){

    j=[1,0,1,0];

    for (i=[0:3]) {
        if (radius > -1) {
            rotate([0, 0, 90*i])
                translate([size[1-j[i]]/2, size[j[i]]/2, 0])
                    fillet(radius, size[2], $fn=$fn);
        } else {
            rotate([0, 0, 90*i])
                translate([size[1-j[i]]/2, size[j[i]]/2, 0])
                    fillet(vertical[i], size[2], $fn=$fn);
        }
        rotate([90*i, -90, 0])
            translate([size[2]/2, size[j[i]]/2, 0 ])
                fillet(top[i], size[1-j[i]], $fn=$fn);
        rotate([90*(4-i), 90, 0])
            translate([size[2]/2, size[j[i]]/2, 0])
                fillet(bottom[i], size[1-j[i]], $fn=$fn);
    }
}

module cube_fillet_inside(
         size,
        radius=-1,
        vertical=[3,3,3,3],
        top=[0,0,0,0],
        bottom=[0,0,0,0],
        $fn=0
    ){
    if (radius == 0) {
        cube(size, center=true);
    } else {
        difference() {
            cube(size, center=true);
            cube_negative_fillet(size, radius, vertical, top, bottom, $fn);
        }
    }
}


module cube_fillet(
        size,
        radius=-1,
        vertical=[3,3,3,3],
        top=[0,0,0,0],
        bottom=[0,0,0,0],
        center=false,
        $fn=0 
    ){
    if (center) {
        cube_fillet_inside(size, radius, vertical, top, bottom, $fn);
    } else {
        translate([size[0]/2, size[1]/2, size[2]/2])
            cube_fillet_inside(size, radius, vertical, top, bottom, $fn);
    }
}

module desk_hook(width, desk_height, hook_height, thickness, depth, jack)
{
	difference() {
		cube_fillet([width, depth, thickness + desk_height + thickness + hook_height + thickness]);
		//cube([width, depth, thickness + desk_height + thickness + hook_height + thickness]);

		translate([0, 0, thickness]) {
			cube([width, depth - thickness, hook_height]);
		}

		translate([0, thickness, thickness + hook_height + thickness]) {
			cube([width,depth - thickness, desk_height]);
		}
	
		if(jack > 0)
		{
			translate([width/2, 0, thickness + hook_height /2])
				rotate(90, [1, 0, 0])
				cylinder(r=jack/2, center=true, h=depth*3, $fs=0.05);
		}	
	}

	cube_fillet([width, thickness, hook_end_height + thickness]);
}

desk_hook(width, desk_height, hook_height, thickness, depth, jack);