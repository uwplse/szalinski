// top mount filament stand
// 2016oct17,ls v0.0.1 initial version, http://www.thingiverse.com/thing:1835048

// as I happen to have some 6mm alu pipe lying here, and these bearing too, this is a match:
// bearing = [6, 10, 3];				// inner, outer, height
// above line is my preferred way to specify bearing dimensions.
// substituted for customiser against nexts lines:

bearing_inner_diameter = 6;				// [1:0.5:12]
bearing_outer_diameter = 10;				// [3:0.1:22]
bearing_depth = 3;					// [1:0.5:12]

// added to bearing_outer_diameter, bearing_depth and rod for a fit. Purpose is to allow entering actual dimension..
slack       = 0.5;					// [0:0.1:1]

// diameter of supporting rod. Slack will be added.
rod         = 7;					// [2:0.1:10]

// distance of the two rods.
rod_spacing = 47;					// [30:80]

// holes will be 20% larger for fit.
screws      = 3;					// [2:0.1:6]

// strength where it's thinnest
wall        = 2.5;					// [0.5:0.1:4]

// or breached axle end
capped      = 1;					// [0:breached, 1:capped]

little      = 0+0.01;					// improve preview, avoid gaps
holes       = screws*1.2;				// screws diameter 15% increased
thread_d    = rod+slack;

// bearing_d   = bearing[1]+slack;			// outer diameter
// bearing_h   = bearing[2]+slack;			// height
// bearing_rim = (bearing[1]-bearing[0])/3;
bearing_d   = bearing_outer_diameter+slack;		// outer diameter
bearing_h   = bearing_depth+slack;			// height
bearing_rim = (bearing_outer_diameter-bearing_inner_diameter)/3;

thread_r    = thread_d/2;
bearing_r   = bearing_d/2;
bracket     = 2*wall + holes;
height      = 2*wall + bearing_d + thread_r;
spacing     =   wall + bearing_r + thread_r;
width_upper = 2*wall + max(bearing_d, thread_d);
depth       = max(bearing_h+wall, holes+2*wall);
width_lower = width_upper + 2*bracket;
plate_spacing = 0+5;
$fn         = 0+50;

complete_set();

module complete_set()  {
   for (x=[-1, 1])
   translate([0, x*(height+2*plate_spacing+rod+wall)/2, 0])
   half_a_set();
}

module half_a_set()  {
   top_bracket();
   translate([0, -plate_spacing, 0])
   bottom_bracket();
}


module top_bracket()  {
   for (x=[-1, 1])
   translate([x*rod_spacing/2, 0, 0])
   half_top_bracket();
   translate([-(rod_spacing+little/2-width_lower)/2, 0, 0])
   cube([rod_spacing+little-width_lower, wall, depth]);

}

module bottom_bracket()  {
   for (x=[-1, 1])
   translate([x*rod_spacing/2, 0, 0])
   half_bottom_bracket();
   translate([-(rod_spacing+little/2-width_lower)/2, -wall, 0])
   cube([rod_spacing+little-width_lower, wall, depth]);
}


// bracket, top piece
module half_top_bracket()  {
   difference()  {
      translate([-width_lower/2, 0, 0])
      cube([width_lower, height, depth]);					// bracket base block

      difference()  {								// stencil for rounded outer shape around bearings
         translate([-width_upper/2-little, spacing, -little/2])
         cube([width_upper+2*little, width_upper/2+little/2, depth+little]);
   
         translate([0, spacing, -little/2])
         cylinder(depth+little, r=width_upper/2);
      }

      translate([0, 0, -little/2])						// rod seats
      cylinder(depth+little, r=thread_r);

      translate([0, spacing, capped*(wall+little)/2-little/2])			// capped or breached axle ends
      cylinder(depth+little, r=bearing_r-bearing_rim);

      translate([0, spacing, depth-bearing_h])					// recess for bearings
      cylinder(bearing_h+little/2, r=bearing_r);

      translate([-width_lower/2-little/2, wall, -little/2])			// cut away one side
      cube([bracket, height+little/2-wall, depth+little]);

      translate([bearing_r+wall, wall, -little/2])				// cut away other side
      cube([bracket+little/2, height+little/2-wall, depth+little]);

      for (hole = [-2, 2])
      translate([ (bracket-width_lower)/hole, -little/2, depth/2])
      rotate([270, 0, 0])
      cylinder(wall+little, d=holes);						// bores for screws
   }
}


// bracket counterpiece
module half_bottom_bracket()  {
   difference()  {
      union()  {								// base structure
         translate([-width_lower/2, -wall, 0])
         cube([width_lower, wall, depth]);
         cylinder(depth, r=thread_r+wall);
      }

      translate([0, 0, -little/2])
      cylinder(depth+little, r=thread_r);					// rod seats

      translate([-thread_r-wall, 0, -little/2])
      cube([thread_d+2*wall, thread_r+wall, depth+little]);			// remove upper half of rod seat

      for (hole = [-2, 2])
      translate([ (bracket-width_lower)/hole, little/2, depth/2])
      rotate([90, 0, 0])
      cylinder(wall+little, d=holes);						// bores for screws
   }
}
