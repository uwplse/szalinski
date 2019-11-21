/* [Basic Settings] */

// This is the length of the the crayon.
base_length = 120; // [100:5:200]

// This will duplicate multiple models for printing more than one at a time.
quantity_to_print = 2; // [1, 2, 3, 4]

/* [Technical  Settings] */

// This number is multiplied by the Base Length to determine the width of the crayon.  I did this so you can change the length and the crayon will remain proportional.
base_width_factor = 0.275; // [0.1:0.005:0.5]

// This number is multiplied by the Base Length to determine the height of the cookie cutter base.
base_height = 20; // [15:25]

// This number is multiplied by the Base Length to determine the lengh of the crayon tip.  I did this so you can change the length and the crayon will remain proportional.
tip_length_factor = 0.25; // [0.1:0.05:0.5]

// This determines the size of the flat parts of the tip, including the very end and inset of the crayon tip.
tip_width_factor = 0.03; // [0.01:0.005:0.05]

// This is how thick the walls of the print will be.
wall_thickness = 1.5; // [1:0.25:2]

// This is the height of the handle on top of the cookie cutter.
handle_height = 15; // [1:20]

// The buttresses are the curver parts at the base of the handle and underneath the top platform of the cookie cutter.  They supply additional strength so the sides don't snap under pressure.
buttress_radius = 6; // [1:10]

// This will determine the radius of the rounded top of the handle.  I added this for comfort while pressing down.
handle_radius = 2; // [1:0.5:5]

// This is how far in from the edges the top platform will come.  Reminiscent of the paper label that generally wraps a crayon. 
paper_padding = 7; // [5:0.5:10]

// Calcuated Values
width = base_width_factor*base_length;
tip_length = tip_length_factor*base_length;
tip_width = base_length*tip_width_factor;
length = base_length-tip_length;
offset = base_length*0.1;
outer_tip = [
  [0, tip_width],
  [(wall_thickness*2), tip_width],
  [tip_length+(wall_thickness*2),(width/2)-(tip_width/2)],
  [tip_length+(wall_thickness*2),(width/2)+(tip_width/2)+(wall_thickness*2)],
  [(wall_thickness*2), width+(wall_thickness*2)-tip_width],
  [0, width+(wall_thickness*2)-tip_width],
  [0, tip_width]
];
inner_tip = [
  [0, tip_width+wall_thickness],
  [(wall_thickness*2), tip_width+wall_thickness],
  [tip_length+(wall_thickness*2),(width/2)-(tip_width/2)+wall_thickness],
  [tip_length+(wall_thickness*2),(width/2)+(tip_width/2)+wall_thickness],
  [(wall_thickness*2), width+wall_thickness-tip_width],
  [0, width+wall_thickness-tip_width],
  [0, tip_width+wall_thickness]
];
top_z = base_height-wall_thickness;
top_translation = [wall_thickness+paper_padding,0,top_z];
handle_translation = [base_length/2-wall_thickness/2, 0, top_z];
offset = width+(wall_thickness*2)+5;

module base(origin)
  difference () {
    union () {
      cube([length+(wall_thickness*2),width+(wall_thickness*2),base_height]);
      translate([length, 0, 0])
        linear_extrude(height=base_height)
          polygon(outer_tip);
    }
    translate([wall_thickness, wall_thickness, -1])
      cube([length,width,base_height+2]);
    translate([length-wall_thickness, 0, -1])
      linear_extrude(height=base_height+2)
        polygon(inner_tip);
  }

module handle(top_width)
  union () {
    translate(top_translation)
      cube([length-paper_padding*2, top_width, wall_thickness]);
    translate(handle_translation)
      cube([wall_thickness, top_width, handle_height]);
    difference () {
      translate([top_translation[0],0,top_z-buttress_radius])
        cube([length-paper_padding*2,wall_thickness+buttress_radius,wall_thickness+buttress_radius]);
      translate([top_translation[0],wall_thickness+buttress_radius,top_z-buttress_radius])
        rotate([0,90,0])
          cylinder(r=buttress_radius, h=length-paper_padding*2, $fn=50);
    }
    difference () {
      translate([top_translation[0],top_width-wall_thickness-buttress_radius,top_z-buttress_radius])
        cube([length-paper_padding*2,wall_thickness+buttress_radius,wall_thickness+buttress_radius]);
      translate([top_translation[0],top_width-wall_thickness-buttress_radius,top_z-buttress_radius])
        rotate([0,90,0])
          cylinder(r=buttress_radius, h=length-paper_padding*2, $fn=50);
    }
    difference () {
      translate([base_length/2-wall_thickness/2-buttress_radius,0,top_z])
        cube([buttress_radius*2+wall_thickness,top_width,wall_thickness+buttress_radius]);
      translate([base_length/2-wall_thickness/2-buttress_radius,0,top_z+wall_thickness+buttress_radius])
        rotate([270,0,0])
          cylinder(r=buttress_radius, h=top_width, $fn=50);
      translate([base_length/2+wall_thickness/2+buttress_radius,0,top_z+wall_thickness+buttress_radius])
        rotate([270,0,0])
          cylinder(r=buttress_radius, h=top_width, $fn=50);
    }
    hull() {
      translate([handle_translation[0]+wall_thickness/2, handle_translation[1], handle_translation[2]+handle_height])
        sphere(handle_radius, $fn=50); 
      translate([handle_translation[0]+wall_thickness/2, handle_translation[1]+top_width, handle_translation[2]+handle_height])
        sphere(handle_radius, $fn=50); 
    }
  }

module single(origin)
  translate(origin)
    union () {
      base(origin);
      handle(width+wall_thickness*2);
    }

for(i=[0:quantity_to_print-1])
  single([0,i*offset,0]);
