//hole spacing for outer standoff feet (side length of the desired square)
outer_hole_spacing = 30;
//diameter of outer standoff feet
outer_foot_diameter = 6;
//diameter of hole in outer standoff feet (better to print with smaller hole, and drill out to precise diameter)
outer_hole_diameter = 2;
//total height of outer standoffs (ie, very bottom of outer standoff to very top of outer standoff)
outer_foot_height = 2.5;

//hole spacing for inner standoff feet (side length of the desired square) - can be ignored if no inner standoff is needed
inner_hole_spacing = 20.5;
//diameter of inner standoff feet - can be ignored if no inner standoff is needed
inner_foot_diameter = 6;
//diameter of hole in inner standoff feet (better to print with smaller hole, and drill out to precise diameter)
inner_hole_diameter = 2;
//total height of outer standoffs - if no inner standoff is needed, set this to zero
inner_foot_height = 5;
//angle of inner standoff from outer standoff - typically set to 0 (inner are in line with outer), or 45 (inner are turned 45 degrees to outer)
inner_angle = 0;

//thickness of the arms and base - this is included in the foot height (so a 4mm foot height, with a 1mm base, will result in 3mm of clearance) Set to zero if only want to print washers
base_plate_thickness = 1.5;

//optional hole in center of body for weight savings - set to zero, if no center hole desired
center_hole_diameter = 8;

//radius of fillet between arms
arm_fillet_radius = 8;
//number of faces used in creating the fillet between arms - larger = finer, but much slower to generate and render (5-10 usually gives good results)
arm_fillet_steps = 10;

module configurable_square_standoff() {
    $fn=40;
    
    difference() {
        union() {
            //inner and outer feet
            feet(outer_hole_spacing, outer_foot_diameter, outer_foot_height, outer_hole_diameter, 0);
            feet(inner_hole_spacing, inner_foot_diameter, inner_foot_height, inner_hole_diameter, inner_angle);

            //arms (if any)
            if (base_plate_thickness > 0) {
                fillet(r=arm_fillet_radius, steps=arm_fillet_steps) {
                    arm(outer_hole_spacing, outer_foot_diameter, outer_foot_height, outer_hole_diameter, 0, base_plate_thickness);
                    arm(outer_hole_spacing, outer_foot_diameter, outer_foot_height, outer_hole_diameter, 90, base_plate_thickness);
                    arm(inner_hole_spacing, inner_foot_diameter, inner_foot_height, inner_hole_diameter, inner_angle, base_plate_thickness);
                    arm(inner_hole_spacing, inner_foot_diameter, inner_foot_height, inner_hole_diameter, inner_angle + 90, base_plate_thickness);
                }
            }        
        }
        
        //holes through feet
        foot_holes(outer_hole_spacing, outer_foot_diameter, outer_foot_height, outer_hole_diameter, 0);
        foot_holes(inner_hole_spacing, inner_foot_diameter, inner_foot_height, inner_hole_diameter, inner_angle);
        
        //center hole
        tcyl(0, 0, center_hole_diameter, base_plate_thickness);
    }
}

module feet(side_len, foot_dia, foot_ht, hole_dia, angle) {
    t = side_len/2;
    rotate([0, 0, angle]) {
        union() {
            //standoff feet
            tcyl(-t, -t, foot_dia, foot_ht);
            tcyl(-t, t, foot_dia, foot_ht);
            tcyl(t, -t, foot_dia, foot_ht);
            tcyl(t, t, foot_dia, foot_ht);
        }
    }
}

module foot_holes(side_len, foot_dia, foot_ht, hole_dia, angle) {
    t = side_len/2;
    rotate([0, 0, angle]) {
        union() {
            //standoff feet
            tcyl(-t, -t, hole_dia, foot_ht);
            tcyl(-t, t, hole_dia, foot_ht);
            tcyl(t, -t, hole_dia, foot_ht);
            tcyl(t, t, hole_dia, foot_ht);
        }
    }
}

module arm(side_len, foot_dia, foot_ht, hole_dia, angle, base_ht) {
    t = side_len/2;
    rotate([0, 0, angle]) {
        hull() {
            tcyl(-t, -t, foot_dia, base_ht);
            tcyl(t, t, foot_dia, base_ht);
        }
    }
}

module tcyl(x, y, dia, ht) {
    translate([x, y, 0]) {
        cylinder(d=dia, h=ht);
    }
}

//this is the awesome ClothBotCreations fillet utility, distributed under the GNU General Public License
// see: https://github.com/clothbot/ClothBotCreations/blob/master/utilities/fillet.scad
// vvvvvvv start of ClothBotCreations fillet utililty vvvvvvv

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
	sphere(r=r,$fn=8);
  }
}
// ^^^^^^^ start of ClothBotCreations fillet utililty ^^^^^^^

configurable_square_standoff();