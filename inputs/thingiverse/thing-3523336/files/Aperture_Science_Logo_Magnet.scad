$fn = 50;


logo_radius = 25;
logo_thickness = 5;

magnet_diameter = 6.2;
magnet_thickness = 2.5;

ratio = 0.6;

difference() {
	union() {
		translate ([0, 0, logo_thickness/2]) aperture_logo(logo_radius, logo_thickness);

		support_thickness = logo_thickness/2;
		support_center_rho = (logo_radius + logo_radius*ratio) / 2;
		support_width = (logo_radius - logo_radius*ratio) / 3;
		support_outer_radius = support_center_rho + support_width/2;
		support_inner_radius = support_center_rho - support_width/2;
		translate([0, 0, support_thickness/2])
			difference() {
				cylinder(h = support_thickness, r = support_outer_radius, center = true);
				union() {
					translate([0, 0, -0.02]) cylinder(h = support_thickness+0.4, r = support_inner_radius, center = true);
				}
			}
	}

	for (r = [0:180:315]) {
		rotate(r) {
			xy_m = (logo_radius + logo_radius*ratio/2) / 2;
			translate([xy_m, xy_m-4, -0.01]) cylinder(h = magnet_thickness, d = magnet_diameter, center=false);
		}
	}

};


module aperture_logo(radius, thickness)
{
	beam_thickness = 0.07 * radius;
	ratio = 0.6;
	beam_x_dist = ratio*radius * cos(360/16) - beam_thickness/2;

	rotate (12.5)
		difference(){
			cylinder(h = thickness, r = radius, center = true);

			union() {
				rotate(22.5)
					translate([0, 0, -0.01]) cylinder(h = thickness+0.04, r = ratio*radius, $fn = 8, center = true);
				for (r = [0:45:315]){
					rotate(r){
						translate([beam_x_dist, ratio*radius, 0])
							cube([beam_thickness, radius, thickness+0.04], center = true);
					}
				}
			}
		};
}


// check for collisions
max_magnet_diameter = (logo_radius - logo_radius*ratio) * 0.9;
if(magnet_diameter >= max_magnet_diameter) {
	echo("<h2><font color='red'> <b>WARNING</b>: magnet diameter is to large</font></h2>");
}
if(magnet_thickness >= logo_thickness*0.9) {
	echo("<h3><font color='red'> <b>WARNING</b>: magnet thickness is to large</font></h3>");
}