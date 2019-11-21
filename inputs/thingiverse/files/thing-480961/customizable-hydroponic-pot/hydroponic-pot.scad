fn = 100;

pot(height=55, top_radius=25, bottom_radius=20, wall_thickness=1.5, ring_top_thickness=2);

module pot(height, top_radius, bottom_radius, wall_thickness, ring_top_thickness, grid_thickness=2.6){
	
	bottom_diameter = bottom_radius * 2;
	
	union(){
		difference(){
			cylinder(h=height, r1=bottom_radius, r2=top_radius, $fn=fn);
			translate([0,0,0]){
				cylinder(h=height, r1=bottom_radius-wall_thickness/2, r2=top_radius-wall_thickness/2, $fn=fn);	
			}	
		}
		intersection(){
			cylinder(h=wall_thickness, r=bottom_radius, $fn=fn);	
			translate([-bottom_radius,-bottom_radius,0])
				grid();
		}
		translate([0,0,height])
			top_ring();
	}
	
	module top_ring(){
		difference(){
			hull(){
				cylinder(h=wall_thickness, r=top_radius+ring_top_thickness/2, $fn=fn);
				
				translate([0,0,-wall_thickness]){
					difference(){
						cylinder(h=1, r=top_radius-wall_thickness/2, $fn=fn);
						cylinder(h=1, r=top_radius-wall_thickness, $fn=fn);
					}
				}
			}
			translate([0,0,-wall_thickness])
				cylinder(h=wall_thickness+wall_thickness, r=top_radius-wall_thickness/2, $fn=fn);
		}
		
	}

	module grid(){
		bars();
		rotate([0,0,90]){
			translate([0,-bottom_diameter,0])
			bars();
		}
	}

	module bars(){
		for ( i = [0 : round(bottom_radius/grid_thickness)] ){
			translate([0,i*(2*grid_thickness),0])
				cube([bottom_radius*2, grid_thickness, wall_thickness]);
		}
	}
}