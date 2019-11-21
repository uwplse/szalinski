// Refined Parametric Saddle Clamp
// Original by Shane Graper (sgraber)
// Last Modified by Bill Gertz (billgertz) on 10 December 2015
// Version 0.9.3
// Fillet Modules by Andrew Plumb from the Clothbot Creations GitHub repository 
//     see: https://github.com/clothbot/ClothBotCreations/blob/master/utilities/fillet.scad
//
// This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//
// Version  Author          Change
// -------  -------------   ------------------------------------------------------------------------------------------
//   0.9.2  billgertz       Documentation starts with this revision - sorry for not starting with orginal modification
//   0.9.3  billgertz       Replaced roundedBox module with new simpler Minkowski version
//                          Removed old roundedBox module by Clifford Wolf and Marius Kintel (thanks guys!)
//                          Corrected tab placement to ensure flush with ID (thanks to MobyDisk reporting problem)
//                          Cleaned up resolution on circular objects and nudging on object differences
//                          Tweaked mount hole placement to stay out of way filleting

// Parametric Saddle Clamp

/* [Pipe Saddle] */
// units
pipe_units = "mm";     // [mm,inches] 
// diameter of the pipe to hang
pipe_diameter = 25.4;  // 
// width of the strap (mm)

/* [Strap] */
strap_width = 20;	  // [10:Narrow,20:Typical,30:Wide,40:Wider,50:Widest]
// screw tab extends from the saddle (mm)
strap_tab = 15;		  // [15:Shorter,30:Short,45:Long,60:Longer]
// strap thickness (mm)
strap_thickness = 2;  // [2:Typical,4:Robust,6:Heavy duty]
// screw hole diameter (mm)
hole_diameter = 4;    // [2:15]

/* [Advanced] */
// strap to tab fillet radius (mm)
fillet_radius = 4;    // [2:Slight,4:Typical,6:Full]
// strap chamfer radius
chamfer_radius = 4;   // [2:Slight,4:Typical,6:Full]
// line segments per full circle
resolution = 90;      // [30:Rough,60:Coarse,90:Fine,180:Smooth,360:Insane]

// No need to edit beyond here unless you want to change how the object is rendered

/* [Hidden] */
hole_rad = hole_diameter/2;

inchMetric = 25.4;   // Length of inch in mm
pipe_OD = (pipe_units == "inches") ? pipe_diameter * inchMetric : pipe_diameter;
pipe_rad = pipe_OD/2;
nudge = 0.01;

///////////// Andrew Plumb Clothbot Creation fillet Modules /////////////

module fillet(r=1.0,steps=3,include=true) {
  if(include) for (k=[0:$children-1]) {
	children(k);
  }
  for (i=[0:$children-2] ) {
    for(j=[i+1:$children-1] ) {
	  fillet_two(r=r,steps=steps) {
	    children(i);
	    children(j);
	    intersection() {
		  children(i);
		  children(j);
	    }
	  }
    }
  }
}

module fillet_two(r=1.0,steps=3) {
  for(step=[1:steps]) {
	hull() {
	  render() intersection() {
		children(0);
		offset_3d(r=r*step/steps) children(2);
	  }
	  render() intersection() {
		children(1);
		offset_3d(r=r*(steps-step+1)/steps) children(2);
	  }
	}
  }
}


module offset_3d(r=1.0) {
  for(k=[0:$children-1]) minkowski() {
	children(k);
	sphere(r=r,$fn=resolution/10);
  }
}

///////////// Thanks Andrew Plumb /////////////

// new rounded box using minkowski replaces 22 lines of code with just 4!
// size is a vector [w, h, d]
module roundedBox(size, radius, resolution)
{
    minkowski () {
        cylinder(r=radius, h=size.z/2, center=true, $fn=resolution);
        cube(size=[size.x - radius*2, size.y - radius*2, size.z/2], center=true);
    }
}

///////////// End Object Modules /////////////

difference() {

    //join the pipe and the filleted saddle straps
    union() {
        
        // the pipe
        difference() {
            cylinder(r=pipe_rad+strap_thickness, h=strap_width, center=true, $fn=resolution);
            cylinder(r=pipe_rad, h=strap_width*(1+nudge), center=true, $fn=resolution); // nudge strap width by a bit for full center saddle removal
        }

        // fillet the straps and the saddle together
        fillet(r=fillet_radius, steps=resolution/10) {
            // subtract mount holes to make the tabs
            difference() {
                translate([0, -pipe_rad+strap_thickness/2, 0]) rotate([90, 0, 0]) roundedBox(size=[strap_tab*2+pipe_OD+2*strap_thickness, strap_width, strap_thickness], radius=chamfer_radius, resolution=resolution);
                translate([-pipe_rad-strap_tab/2-fillet_radius/2, -pipe_rad+strap_thickness/2, 0]) rotate([90, 0, 0]) cylinder(r=hole_rad, h=strap_thickness*(1+nudge), center=true, $fn=resolution);
                translate([pipe_rad+strap_tab/2+fillet_radius/2, -pipe_rad+strap_thickness/2, 0]) rotate([90, 0, 0]) cylinder(r=hole_rad, h=strap_thickness*(1+nudge), center=true, $fn=resolution);
            }

            // make the saddle
            translate([0, -pipe_rad/2, 0]) cube(size=[pipe_OD+strap_thickness*2, pipe_rad, strap_width], center=true);
        
        }
   
    }

    // finish bridge by subtracting from middle to seperate straps, nudge strap width and hright by a bit to remove ghost
    translate([0, -pipe_rad/2-strap_thickness+nudge, 0]) cube(size=[pipe_OD, pipe_rad+strap_thickness*2, strap_width*(1+nudge)], center=true);
}