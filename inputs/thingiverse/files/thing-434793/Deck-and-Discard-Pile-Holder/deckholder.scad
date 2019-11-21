/* [Main] */

// What would you like to generate?
part = "both"; // [base:Base Only,top:Top Only,both:Base and Top]

// Number of holders
holder_count = 1;

// Width of cards to be used (mm)
card_width = 64;

// Length of cards to be used (mm)
card_length = 88;

// Height of holder (approx height of deck) (mm)
holder_height = 25;	// Height of holder

/* [Tweaking] */

// How far back the top layer should be (mm)
top_offset = 14;
// How much the cards overhang the ends of the holder (mm)
overhang = 16;
// The angle of the angled supports (degrees)
angle = 8;
// Gap added to card with to give width of holder (mm)
card_gap = 5;
// Thickness of support bars (mm)
bar_thickness = 2;
// Gap to allow top/bottom to clip together (mm)
support_gap = 0.25;
// Gap to allow clips to clip together (mm)
clip_card_gap = 0.25;
// Distance between top and bottom if printing both (mm)
both_gap = 10;


/****************************************
 *
 ****************************************/

// Internal width of holder
holder_width = card_width + card_gap;
// Length of angled support
angled_length = cos(angle) * (card_length - overhang);;
// Height of angled support
angled_height = (tan(angle) * angled_length) + bar_thickness;
// Length of base (for side bars)
base_length = angled_length - top_offset;
// Full length of base
base_full_length = angled_length + bar_thickness;
// Full length of top
top_full_length = angled_length + (bar_thickness * 2);
// Thickness of clips
clip_thickness = bar_thickness * 1.5;
// Offset of angled support from middle (1/6th from 1/2 = 1/3rd!)
offset = (holder_width) / 6;
// Offset for diagonal bars
diag_offset = sin(45) * bar_thickness;

print_part();

/****************************************
 * Generate the selected part
 ****************************************/
module print_part()
{
	if (part == "base")
	{
		bases();
	} else if (part == "top") {
		tops();
	} else if (part == "both") {
		// translate stuff here...
		translate([0, (base_full_length + both_gap) / 2, 0])
			bases();
		translate([0, -(top_full_length + both_gap) / 2, 0])
			tops();
	}
}

/****************************************
 * Generate the correct number of tops
 ****************************************/
module tops()
{
	// Calculate the full width of the tops
	full_width = (holder_width + bar_thickness) * (holder_count) + (bar_thickness * 3);
	// Centre the tops around zero
	translate([full_width/2, -top_full_length/2, 0])
	{
		// Draw each top
		for(i=[1:holder_count])
		{
			translate([-(holder_width + bar_thickness) * (i-1),0,0])
				singleTop();
		}

		// Thicker bars at ends
		translate([-bar_thickness, angled_length, 0])
		{
			cube([bar_thickness, bar_thickness, holder_height + angled_height]);
		}
		translate([-full_width, angled_length, 0])
		{
			cube([bar_thickness, bar_thickness, holder_height + angled_height]);
		}
	}
}

/****************************************
 * Generate a single top holder
 ****************************************/
module singleTop()
{
	// Length of diagonal bar
	diag_length = 
		(
			(offset*2 - bar_thickness)	// Distance between middle of angled support
												// 	and inside edge of side bar
			+ (diag_offset/2) 				// Distance from inside edge of side bar 
												//		to rotation axis of diagional bar
			+ (bar_thickness-diag_offset)	// Distance from rotation axis 
												//		to centre of diagonal bar
		) / sin(45);

	// Move the holder to start at [0,0,0]
	translate([-holder_width/2-(bar_thickness*2),0,0])
	{
		// As the base is mirrored down the middle, do a side at a time
		for (m=[[0,0,0],[1,0,0]])
		{
			mirror(m)
			{
				// Bar at back
				cube([offset, bar_thickness * 2, bar_thickness]);

				// Support at back
				translate([offset-(bar_thickness * 1.5),0,0])
					cube([bar_thickness * 3, bar_thickness, holder_height + bar_thickness]);
				translate([0,0,holder_height])
					cube([offset, bar_thickness, bar_thickness]);

				// Angled Support
				translate([offset-(bar_thickness * 0.5),bar_thickness,0])
					angledSupport();

				// Notches
				translate([offset-(bar_thickness * 1.5), 0, 0])
				{
					for(s=[
								[0, top_offset - bar_thickness, 0],
								[0, top_offset + bar_thickness + support_gap, 0]
							])
					{
						translate(s)
							cube([bar_thickness * 3, bar_thickness - support_gap, bar_thickness]);
					}
				}

				// Bar at front
				translate([0, angled_length, 0])
					cube([holder_width/2 + (bar_thickness * 2), bar_thickness, bar_thickness * 2]);

				// Front support
				translate([holder_width/2 - bar_thickness, angled_length - bar_thickness, 0])
				{
					for(t=[
							[0, 0, 0],
							[bar_thickness*2 + support_gap, 0, 0]
						])
					{
						translate(t)
							cube([bar_thickness - support_gap, bar_thickness * 3, bar_thickness * 2]);
					}

					translate([0, 0, bar_thickness * 1.5])
						cube([bar_thickness * 3, bar_thickness * 3, bar_thickness * 0.5]);

					// Vertical support
					translate([bar_thickness,0,bar_thickness * 1.5])
					{
						cube([bar_thickness, 
								bar_thickness * 3, 
								holder_height + angled_height - (bar_thickness * 1.5)]);
					}
				}

				// Diagonal supports
				translate([holder_width/2, angled_length + bar_thickness - diag_offset, 0])
					rotate([0,0,135])
						cube([bar_thickness,diag_length,bar_thickness]);
			}
		}
	}	
}

/****************************************
 * Generate the correct number of bases
 ****************************************/
module bases()
{
	// Move bases so generated object is in middle of area
	translate([
			((holder_width * holder_count) + (bar_thickness * (holder_count + 1)))/2,
			-base_full_length/2,
			0])
	{
		// Draw each base
		for(i=[1:holder_count])
		{
			translate([-(holder_width + bar_thickness) * (i-1),0,0])
				singleBase();
		}

		// Add the clips - all mirrored/rotated in their own way

		clip();

		translate([0,base_length + (bar_thickness * 2),0])
			mirror([0,1,0])
				clip();	

		translate([-(holder_width + bar_thickness) * (holder_count) - bar_thickness,
						base_length + (bar_thickness * 2) - (clip_thickness * 3),
						0])
			mirror([1,0,0])
				clip();

		translate([-(holder_width + bar_thickness) * (holder_count) - bar_thickness,
						(clip_thickness * 3),
						0])
			rotate([0,0,180])
				clip();

	}
}

/****************************************
 * Generate a single base
 ****************************************/
module singleBase()
{
	// Length of diagonal bar
	diag_length = 
		(
			(offset*2) 						// Distance between middle of angled support
												// 	and inside edge of side bar
			+ (diag_offset/2) 				// Distance from inside edge of side bar 
												//		to rotation axis of diagional bar
			+ (bar_thickness-diag_offset)	// Distance from rotation axis 
												//		to centre of diagonal bar
		) / sin(45);

	// Move so the base is at [0,0,0]
	translate([-holder_width/2-bar_thickness,0,0])
	{
		// As the base is mirrored down the middle, do a side at a time
		for (m=[[0,0,0],[1,0,0]])
		{
			mirror(m)
			{
				// Bar at back
				cube([holder_width/2, bar_thickness, bar_thickness * 2]);
				// Bar at front
				translate([0,base_length,0])
					cube([holder_width/2, bar_thickness, bar_thickness]);
				// Bar at top of back support
				translate([0,0,holder_height + angled_height - bar_thickness])
					cube([offset, bar_thickness, bar_thickness]);		

				// Side bar
				translate([holder_width/2,0,0])
					cube([bar_thickness, base_length + bar_thickness, bar_thickness * 2]);

				// angled Support
				translate([offset-(bar_thickness * 0.5),bar_thickness,0])
					angledSupport();

				// Back support
				translate([offset-(bar_thickness * 1.5),0,0])
					verticalSupport();
				// Front support
				translate([holder_width/2 + bar_thickness,base_length - bar_thickness,0])
					rotate([0,0,90])
						verticalSupport();

				// Diagonal at back
				translate([holder_width/2 + (bar_thickness - diag_offset), 0, 0])
					rotate([0,0,45])
						cube([bar_thickness,diag_length,bar_thickness]);
				// Diagonal at front
				translate([holder_width/2 + bar_thickness, base_length + bar_thickness - diag_offset, 0])
					rotate([0,0,135])
						cube([bar_thickness,diag_length,bar_thickness]);
			}
		}
	}
}

/****************************************
 * Angled support for cards to sit on
 ****************************************/
module angledSupport()
{
	// Calculate the maximum height of holes
	max_hole = floor(
		((angled_length - (bar_thickness * 2)) * tan(angle))
		- bar_thickness);

	difference()
	{
		// The triangle, with a bar of bar_thickness underneath
		polyhedron(points=[ 
			[0,0,0], [bar_thickness,0,0], 
			[0,angled_length,0], [bar_thickness,angled_length,0],
			[0,angled_length,angled_height], [bar_thickness,angled_length,angled_height],
			[0,0,bar_thickness], [bar_thickness,0,bar_thickness] ],
			// ONLY STILL TRIANGLES FOR THINGIVERSE CUSTOMIZER!
			triangles=[
				[0,1,2], [1,3,2],
				[2,3,5], [2,5,4],
				[4,5,6], [5,7,6],
				[0,6,1], [6,7,1],
				[0,2,6], [2,4,6],
				[3,1,7], [5,3,7]
		]);

		// Step through heights of holes and add them
		if(max_hole>0)
		{
			for (v=[bar_thickness+1:bar_thickness+max_hole])
			{
				translate([-0.1, v/tan(angle), bar_thickness])
					cube([bar_thickness + 0.2, 
							min((v+1)/tan(angle), angled_length)
								-(v/tan(angle))
								-bar_thickness,
							(v-bar_thickness)]);
			}
		}
	}
}

/****************************************
 * A single vertical support for the base (with notches on the top)
 ****************************************/
module verticalSupport()
{
	difference() {
		cube([bar_thickness*3,bar_thickness,holder_height + angled_height + bar_thickness]);
		translate([bar_thickness-support_gap,0,holder_height + angled_height]) {
			cube([bar_thickness+(support_gap * 2),bar_thickness,bar_thickness * 1.1]);
		}
	}
}

/****************************************
 * A single clip, to clip multiple bases together
 ****************************************/
module clip()
{
	translate([-bar_thickness,0,0])
		cube([clip_thickness * 2 + bar_thickness, clip_thickness, bar_thickness * 2]);
	translate([clip_thickness + clip_card_gap, clip_thickness, 0])
		cube([clip_thickness - clip_card_gap, clip_thickness - clip_card_gap, bar_thickness * 2]);
}


