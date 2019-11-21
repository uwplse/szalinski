// Which one would you like to see?
part = "first"; // [first:Box Only,second:Divider Only]




box_length = 96; //box length
box_width = 73; //box width
box_height = 47; //box height

//wall thickness in mm
box_thickness = 3; //box wall thickness

//corner rounded radius in mm
box_rounded_corner = 1; //rounded corner radius

//extra space on each side for divider slots
tolerance = 0.2; //extra space on divider slots

//extra space on the stacking rim (bottom)
rim_tolerance = 0.4; //extra space on the rim

//shortens the divider height in mm
div_height_tolerance = 2;


div_length = box_width - (2 * box_thickness) - (2 * tolerance);
div_height = box_height - box_thickness - div_height_tolerance; //divider height
div_thickness = 2; //divider thickness

//the number of sections, not the number of dividers 
number_of_slots = 9;

//Enable stacking?
stacking = true; // [true,false]

//Cut circles in the box ends?
cut_ends = true; // [true,false]

//Cut circles in the divider ends?
div_cut_ends = "top"; // [top,bottom,both]

stack_rim_thickness = (box_thickness < 3) ? box_thickness / 2 : 1.2; //either half the wall thickness or 1.2
	
//the lower rim groove is 0.4mm deeper than this. do not exceed your wall thickness!
upper_rim_height = 1.3;
lower_rim_height = upper_rim_height + 0.4;





//divider();
//build_box();

print_part();


module print_part()
 {
    if (part == "first") build_box();
    if (part == "second") divider();
 }

module lower_rim()
{
	translate([0,0,0])
		difference()
		{
			translate([0,0,lower_rim_height/2-.01])
			cube([box_length - ((box_thickness - stack_rim_thickness) * 2) + rim_tolerance * 2,box_width - (box_thickness - stack_rim_thickness) * 2 + rim_tolerance*2 ,lower_rim_height], center = true);
			roundedRect([box_length - ((box_thickness - stack_rim_thickness) * 2) - rim_tolerance * 4 - stack_rim_thickness * 2,box_width - (box_thickness - stack_rim_thickness) * 2 - rim_tolerance*4 - stack_rim_thickness * 2,lower_rim_height+.1], box_rounded_corner, $fn=50);
		}


}
module upper_rim()
{
	translate([0,0,box_height])
		roundedRect([box_length - (box_thickness - stack_rim_thickness) * 2,box_width -  (box_thickness - stack_rim_thickness) * 2,upper_rim_height], box_rounded_corner, $fn=50);
}

module main_cube()
{
	difference()
	{
		union()
		{
			roundedRect([box_length, box_width, box_height], box_rounded_corner, $fn=50);
			if(stacking) upper_rim();
		}
	
		if(stacking) lower_rim();
	}
		
	
	
}

module build_box ()
{
	slot_thickness = div_thickness + (tolerance * 2);
	slot_spacing = ((box_length - (box_thickness * 2)) - ((number_of_slots - 1) * slot_thickness)) / number_of_slots;
	$fn = 50;
	stack_rim_thickness = (box_thickness < 3) ? box_thickness / 2 : 1.5;
		
	difference() {

		
		main_cube();
		

		translate ([0,0,box_thickness+box_height/2]) 
			cube ([box_length - (2 * box_thickness), box_width - (2 * box_thickness), box_height], center = true);
		if (cut_ends)
		{
			hull()
			{
				translate([0,0,box_height])
					rotate(a=[0,90,0])
						scale(v=[box_height,(box_width - (box_thickness * 2))*.8,1])
							cylinder (h = box_length+2, r = .5, $fn = 50, center = true);
				translate([0,0,box_height+50])
					rotate(a=[0,90,0])
						scale(v=[box_height,(box_width - (box_thickness * 2))*.8,1])
							cylinder (h = box_length+2, r = .5, $fn = 50, center = true);
			}
		}
		
		if (number_of_slots > 1)
		{
			translate([-((number_of_slots-2) * (slot_thickness + slot_spacing))/2,0,box_height])
				for ( i = [0 : number_of_slots-2] )
				{
					translate([i * (slot_thickness + slot_spacing),0,0])
					cube ([slot_thickness, box_width - box_thickness, (box_height - box_thickness)], center = true); 
				}
		}
	}

}

module divider ()
{
	tab_length = (box_thickness / 2) - tolerance;
	tab_width = div_thickness;
	tab_height = ((box_height - box_thickness) / 2) - (box_height - box_thickness - div_height);
	
	translate([0,0,(div_height / 2) + box_thickness + div_height_tolerance])
	difference() {
	
		union() {
			cube ([div_thickness, div_length, div_height], center = true);
				translate([-div_thickness / 2, div_length / 2, (div_height / 2) - tab_height])	
					cube ([tab_width, tab_length, tab_height ]);
			mirror ([0,1,0])
				translate([-div_thickness / 2, div_length / 2, (div_height / 2) - tab_height])	
					cube ([tab_width, tab_length, tab_height ]);
			}
		
		if ((div_cut_ends == "top") || (div_cut_ends == "both"))
		translate([0,0,div_height / 2 ])
			rotate(a=[0,90,0])
				scale(v=[div_height * 0.7,(div_length * 0.6),1])
					cylinder (h = div_thickness+2, r = .5, $fn = 50, center = true);

	if ((div_cut_ends == "bottom") || (div_cut_ends == "both"))
		translate([0,0,-div_height / 2 ])
			rotate(a=[0,90,0])
				scale(v=[div_height * 0.7,(div_length * 0.6),1])
					cylinder (h = div_thickness+2, r = .5, $fn = 50, center = true);
		}

	}

module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius), (y/2)-(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (y/2)-(radius), 0])
		circle(r=radius);
	}
}
