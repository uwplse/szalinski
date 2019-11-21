// Configurable adapter to join two rectangles, or even tubes 
// if you get the settings just right.
//
// (c) 2013 William Winder <wwinder.unh@gmail.com>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

// helper module for drawing rectangles with rounded borders
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

/* [General] */
// Wall thickness in MM
wall_thickness = 2.5;

// circle resolution
circle_resolution=20;
$fn=circle_resolution;

// Height of connector between the two adapters.
middle_tube_h = 20;
// Resolution of interpolation between the two adapters. I saw errors if this was larger 20.
middle_tube_steps = 20;

/* [Bottom adapter] */
// Configure whether the bottom measurements will fit "inside" another rectangle or "outside"
bottom_dimensions = "outside"; // [inside, outside]

// Width
bottom_adapter_w = 31;
// Length
bottom_adapter_l = 51.5;
// Height
bottom_adapter_h = 11;
// Radius - inner or outer depending on "bottom_dimensions" setting
bottom_adapter_radius = 0;

/* [Top adapter] */
// Configure whether the top measurements will fit "inside" another rectangle or "outside"
top_dimensions = "inside"; // [inside, outside]

// Width
top_adapter_w = 31;
// Length
top_adapter_l = 45;
// Height
top_adapter_h = 11;
// Radius - inner or outer depending on "top_dimensions" setting
top_adapter_radius = 6;


/* [Hidden] */

// Internal use for sizing middle tube. Do not modify.
bottom_calc_radius = min(bottom_adapter_w, bottom_adapter_l) * 0.1;
top_calc_radius = min(top_adapter_w, top_adapter_l) * 0.1;

t_offset = (top_dimensions == "inside") ? 0 : wall_thickness * 2;
t_ri =     (top_dimensions == "inside") ? top_adapter_radius : top_calc_radius;
t_ro =     (top_dimensions == "inside") ? top_calc_radius : top_adapter_radius;

b_offset = (bottom_dimensions == "inside") ? 0 : wall_thickness * 2;
b_ri =     (bottom_dimensions == "inside") ? bottom_adapter_radius : bottom_calc_radius;
b_ro =     (bottom_dimensions == "inside") ? bottom_calc_radius : bottom_adapter_radius;

// Bottom.
if (bottom_dimensions == "inside") {
	fit_inside_tube(
		[bottom_adapter_w, bottom_adapter_l, bottom_adapter_h],
		wall_thickness, bottom_adapter_radius);
} else {
	fit_outside_tube(
		[bottom_adapter_w, bottom_adapter_l, bottom_adapter_h],
		wall_thickness, bottom_adapter_radius);
}

// Middle.
translate([0, 0, bottom_adapter_h])
square_funnel(
	middle_tube_steps, wall_thickness, middle_tube_h,
	[bottom_adapter_w + wall_thickness*2, bottom_adapter_l + b_offset], b_ri, b_ro,
	[top_adapter_w + t_offset, top_adapter_l + t_offset], t_ri, t_ro);

// Top.
translate([0, 0, middle_tube_h + bottom_adapter_h])
if (top_dimensions == "inside") {
	fit_inside_tube(
		[top_adapter_w, top_adapter_l, top_adapter_h],
		wall_thickness, top_adapter_radius);
} else {
	fit_outside_tube(
		[top_adapter_w, top_adapter_l, top_adapter_h],
		wall_thickness, top_adapter_radius);
}

module square_funnel(steps, thickness, height, s_dim, s_oRadius, s_iRadius, e_dim, e_oRadius, e_iRadius)
{
	// Calculate steps.
	extrude_length = height / steps;
	w_s = (e_dim[0] - s_dim[0]) / steps;
	l_s = (e_dim[1] - s_dim[1]) / steps;
	ir_s = (e_iRadius - s_iRadius) / steps;
	or_s = (e_oRadius - s_oRadius) / steps;

	// Starting stuff
	w = s_dim[0];
	l = s_dim[1];
	ir = s_iRadius;
	or = s_oRadius;

	union()
	{
		for (i=[0:steps])
		{
			translate([0,0,i*extrude_length])
			linear_extrude(
				height = extrude_length, 
				center = true)
			difference() {
				rounded_square(
					[w + (w_s*i), l + (l_s*i)],
					[or + (or_s*i),or + (or_s*i),or + (or_s*i),or + (or_s*i)],
					true);
				rounded_square(
					[w + (w_s*i) - (thickness*2), l + (l_s*i) - (thickness*2)],
					[ir + (ir_s*i),ir + (ir_s*i),ir + (ir_s*i),ir + (ir_s*i)],
					true);
			}
		}
	}
}

// Tube with measurements to fit around something.
module fit_outside_tube(dim, thickness, radius) {
	w = dim[0];
	l = dim[1];
	h = dim[2];
	or = min(w, l) * 0.1;
	ir = radius;

	linear_extrude(height = h)

	difference() {
		rounded_square([w + thickness*2, l+thickness*2], [or,or,or,or], true);
		rounded_square([w, l], [ir,ir,ir,ir], true);
	}
}

// Tube with measurements to fit inside something.
module fit_inside_tube(dim, thickness, radius) {
	w = dim[0];
	l = dim[1];
	h = dim[2];
	or = radius;
	ir = min(w, l) * 0.1;
	linear_extrude(height = h)

	difference() {
		rounded_square([w , l], [or,or,or,or], true);
		rounded_square([w - thickness*2, l - thickness*2], [ir,ir,ir,ir], true);
	}
}



module rounded_square(dim, corners=[10,10,10,10], center=false){
  w=dim[0];
  h=dim[1];

  if (center){
    translate([-w/2, -h/2])
    rounded_square_(dim, corners=corners);
  }else{
    rounded_square_(dim, corners=corners);
  }
}

module rounded_square_(dim, corners, center=false){
  w=dim[0];
  h=dim[1];
  render(){
    difference(){
      square([w,h]);

      if (corners[0])
        square([corners[0], corners[0]]);

      if (corners[1])
        translate([w-corners[1],0])
        square([corners[1], corners[1]]);

      if (corners[2])
        translate([0,h-corners[2]])
        square([corners[2], corners[2]]);

      if (corners[3])
        translate([w-corners[3], h-corners[3]])
        square([corners[3], corners[3]]);
    }

    if (corners[0])
      translate([corners[0], corners[0]])
      intersection(){
        circle(r=corners[0]);
        translate([-corners[0], -corners[0]])
        square([corners[0], corners[0]]);
      }

    if (corners[1])
      translate([w-corners[1], corners[1]])
      intersection(){
        circle(r=corners[1]);
        translate([0, -corners[1]])
        square([corners[1], corners[1]]);
      }

    if (corners[2])
      translate([corners[2], h-corners[2]])
      intersection(){
        circle(r=corners[2]);
        translate([-corners[2], 0])
        square([corners[2], corners[2]]);
      }

    if (corners[3])
      translate([w-corners[3], h-corners[3]])
      intersection(){
        circle(r=corners[3]);
        square([corners[3], corners[3]]);
      }
  }
}
