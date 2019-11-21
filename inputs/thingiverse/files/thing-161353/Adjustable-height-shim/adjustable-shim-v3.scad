// Width of cross-section
width = 30;
// Length - bolt will need to be this long. 52=2" 39=1.5 26=1"
length = 39;
// Minimum height - by tightening bolt, can increase up to about 125% of this value
min_height = 12;
// Attachment screw holes (to secure wedge to work)
attachment_holes = 2; // [0,2,4]
// Attachment screw head type (mushroom=pan head)
attachment_head_type = "bugle"; // [bugle,mushroom]

/* [Advanced] */
// Slot width (should fit flat to flat dimension of hex nut) - 8.2mm for #6 (US), 7.4mm for M4
slot_width = 8.25;
// Slot depth - must accommodate greater of bolt head height and nut height. May need to be greater for steeper gradient
slot_depth = 2.75;
// Ratio of slot height to minimum height
slot_height_ratio = 0.8;
// Bolt width
bolt_width = 4.2;
// Bolt slot height as ratio of slot height
bolt_slot_height_ratio = 0.7;
// Ratio of center hole width to overall
center_hole_ratio_w = 0.65;
// Ratio of center hole length to overall
center_hole_ratio_l = 0.42;
// Number on build plate
number_on_plate = 1; // [1,2]
// Arrangement of multiple pieces on build plate
multiple_arrangement = "sidebyside"; // [sidebyside,endtoend]
// Attachment hole screw shaft width; 3.8 for #8, 4.8 for #10
attachment_shaft_width = 3.8;
// Attachment hole taper height for bugle head
attachment_taper_height = 4;
// Attachment hole taper top diameter; #8 woodcraft screws use 8.2, common wood screws closer to 9.0, #10 9.8
attachment_taper_top_diameter = 9.0;

/* [Hidden] */
hypotenuse = sqrt(length*length + min_height*min_height);

adjustable_shim();

if (number_on_plate > 1)
{
  if (multiple_arrangement == "sidebyside")
  {
	translate([-2,-hypotenuse,0]) rotate([0,0,180]) adjustable_shim();
  }
  if (multiple_arrangement == "endtoend")
  {
	translate([width,-2.05*hypotenuse,0]) rotate([0,0,180]) adjustable_shim();
  }
}

// Produce a single shim, printing with hypotenuse down
module adjustable_shim()
{
  assign( angle = atan(min_height/length), slot_height = min_height * slot_height_ratio ) render( convexity = 5 )
  {
    rotate([180-angle,0,0])
    difference()
    {
	  // Basic rectangle
	  cube(size=[width,length,min_height], center=false);
	  // Subtract half to make wedge
     rotate([angle,0,0]) cube(size=[width,hypotenuse,min_height], center=false);
	  // Subtract larger slot from end
	  translate([(width-slot_width)/2,length-slot_depth,min_height*(1.0-slot_height_ratio)/2]) cube(size=[slot_width, slot_depth, slot_height], center=false);
	  // Subtract bolt (via) slot
	  translate([(width-bolt_width)/2,0,(min_height-bolt_slot_height_ratio * slot_height)/2]) cube(size=[bolt_width, length, bolt_slot_height_ratio * slot_height], center=false);
	  // Create center hole so we can secure fasteners through this
	  translate([(1-center_hole_ratio_w)*width/2,(1-center_hole_ratio_l)*length/2,0]) cube(size=[width*center_hole_ratio_w, length*center_hole_ratio_l, min_height], center=false);
	  // Optional attachment screw holes
	  attachment_screws();
    }
  }
}

// Generate 2 or 4 attachment screw holes
module attachment_screws()
{
  if (attachment_holes >= 2) assign( margin_side = width * (1.0 - center_hole_ratio_w), margin_end = length * (1.0 - center_hole_ratio_l) )
  {
	 translate( [margin_side / 2, length - margin_end / 4, 0 ] ) attachment_hole();
	 translate( [width - margin_side / 2, length - margin_end / 4, 0 ] ) attachment_hole();
	 if (attachment_holes >= 4)
    {
	 	// At the thin end, mushroom heads will be on a slant
		 translate( [margin_side / 2, margin_end / 2, 0] ) attachment_hole();
		 translate( [width - margin_side / 2, margin_end / 2, 0] ) attachment_hole();
    }
  }
}

// Generate a single untranslated attachment hole
module attachment_hole()
{
  if (attachment_head_type == "bugle")
  {
	attachment_hole_bugle();
  }
  if (attachment_head_type == "mushroom")
  {
	attachment_hole_mushroom();
  }
}

// Taper head (bugle) attachment hole
module attachment_hole_bugle()
{
  union()
  {
   attachment_hole_mushroom();
	cylinder( r1 = attachment_shaft_width / 2, r2 = attachment_taper_top_diameter / 2, h = attachment_taper_height, $fn = 72 );
  }
}

// Pan head (mushroom) attachment hole
module attachment_hole_mushroom()
{
  union()
  {
    cylinder( h = min_height, r = attachment_shaft_width / 2, center = false, $fn = 72 );
    translate([0,0,attachment_taper_height]) cylinder(h = min_height, r = attachment_taper_top_diameter / 2, center = false, $fn = 72 );
  }
}
