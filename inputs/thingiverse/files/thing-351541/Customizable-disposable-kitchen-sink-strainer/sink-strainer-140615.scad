// sink strainer
//  ver.20140615 by junnno

// The diameter of the inside
inner_diamter = 66;
// The diameter of the outside of main tube
outer_diameter = 71;
// The diameter of the head flange
head_diameter = 79;

// The height of the main tube including bottom filter
main_cylinder_height = 15;
// The gradient length between the head and the main tube 
gradient_height = 4;
// The height of the head
head_cylinder_height = 1.2;

// The thickness of the bottom filter
filter_height = 2.4;
// The length between the centers of the bottom filter slits
filter_periodic_length = 4;
// The opening area over the bottom filter area
filter_opening_ratio = 0.5;
// The bottom beam width over the filter thickness
filter_beam_aspect_ratio = 2;

// The length between the centers of side filter slits
side_slit_periodic_length = 4;
// The opening area over the side filter area
side_slit_opening_ratio = 0.5;
// The opaque wall height above the side filter
side_slit_top_margin = 2.4;
// The opaque wall height below the side filter
side_slit_bottom_margin = 1.2;

handle_height = 16;
handle_lower_diameter = 10;
handle_upper_diameter = 16;

//echo(version());
//echo(PI);

module test01()
{
	// head
	difference(){
		translate([0,0,main_cylinder_height+gradient_height])
			cylinder(h=head_cylinder_height, r=head_diameter/2);
		translate([0,0,main_cylinder_height+gradient_height-1])
			cylinder(h=head_cylinder_height+2, r=inner_diamter/2);
	}
	// gradient under the head
	difference(){
		translate([0,0,main_cylinder_height])
			cylinder(h=gradient_height, r1=outer_diameter/2, r2=head_diameter/2);
		translate([0,0,main_cylinder_height-1])
			cylinder(h=main_cylinder_height+2, r=inner_diamter/2);
	}
	// main tube with side slit pattern
	slit_angles = floor((inner_diamter*PI/2)/side_slit_periodic_length);
	slit_angle_step = 180/slit_angles;
	difference(){
		cylinder(h=main_cylinder_height, r=outer_diameter/2);
		translate([0,0,-1])
			cylinder(h=main_cylinder_height+2, r=inner_diamter/2);
		translate([0,0,filter_height+side_slit_bottom_margin+(main_cylinder_height-side_slit_top_margin-filter_height-side_slit_bottom_margin)/2])
			for(i=[0 : slit_angle_step : 180]){
				rotate(i,[0,0,1])	
				cube([outer_diameter+1,side_slit_periodic_length*side_slit_opening_ratio,(main_cylinder_height-filter_height-side_slit_bottom_margin-side_slit_top_margin)],center=true);
			}
	}

	// bottom filter pattern
	final_ring = floor((outer_diameter/2)/filter_periodic_length)-1;
	for(i=[0:final_ring]){
		difference(){
			cylinder(h=filter_height, r=(i+1)*filter_periodic_length);
			translate([0,0,-1])
				cylinder(
				 h=filter_height+2,
				 r=(i+filter_opening_ratio)*filter_periodic_length);
		}
	}

	// bottom filter beam
	translate([0,0,filter_height/2]){
		cube([
		 (outer_diameter+inner_diamter)/2,
		 filter_height*filter_beam_aspect_ratio,
		 filter_height],
		 center=true);
		cube([
		 filter_height*filter_beam_aspect_ratio,
		 (outer_diameter+inner_diamter)/2,
		 filter_height],
		 center=true);
	}

	// center handle
	cylinder(r=handle_lower_diameter/2,h=filter_height);
	translate([0,0,filter_height])
		cylinder(r1=handle_lower_diameter/2, r2=handle_upper_diameter/2, h=handle_height);
	
}
test01();