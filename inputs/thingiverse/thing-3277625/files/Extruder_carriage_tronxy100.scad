
//translate([90+carriage_width/2,40,0])rotate([180,0,180])import("i3_tensioner_2.STL", convexity = 5);

$fn = 30;

belt_screw_holes_size = 4.5;
//M6 = 5.4 taps with just a screw and a manual champfer lower if using a propper tap
//M5 = 4.3
//M4 = 3.4
carriage_width = 57;
carriage_heigth = 80;
carriage_thickness = 8;

lb_spacing_x = 18;
lb_spacing_y = 24;
bearings_spacing = 51.5-8;

module main_body(x,y,z){
	translate([x,y,z]){

		difference(){
			union(){
				//backplate
				cube([carriage_width,carriage_heigth, carriage_thickness]);
				translate([52,0,0])cylinder(d = 10, h = carriage_thickness);

				//extruder mount
				translate([carriage_width/2 - 32/2, 4 + lb_spacing_y/2, carriage_thickness]){
					cube([32, 5.5, 15]);

				}

				translate([carriage_width/2 - 34/2, 4 + lb_spacing_y/2 + 5.5/2, carriage_thickness]){
					cylinder(d = 10, h = 15, $fn = 20);
					translate([34,0,0])cylinder(d = 10, h = 15, $fn = 20);
			
				}

			}

			//top bearing holes
			translate([carriage_width/2 - lb_spacing_x/2, 7, 0])cylinder(d = 4.2, h = carriage_thickness);
			translate([carriage_width/2 + lb_spacing_x/2, 7, 0])cylinder(d = 4.2, h = carriage_thickness);
			translate([carriage_width/2 - lb_spacing_x/2, 7 + lb_spacing_y, 0])cylinder(d = 4.2, h = carriage_thickness);
			translate([carriage_width/2 + lb_spacing_x/2, 7 + lb_spacing_y, 0])cylinder(d = 4.2, h = carriage_thickness);
			//bottom bearing holes
			translate([carriage_width/2 - lb_spacing_x/2, 7 + bearings_spacing, 0])cylinder(d = 4.2, h = carriage_thickness);
			translate([carriage_width/2 + lb_spacing_x/2, 7 + bearings_spacing, 0])cylinder(d = 4.2, h = carriage_thickness);
			translate([carriage_width/2 - lb_spacing_x/2, 7 + lb_spacing_y + bearings_spacing, 0])cylinder(d = 4.2, h = carriage_thickness);
			translate([carriage_width/2 + lb_spacing_x/2, 7 + lb_spacing_y + bearings_spacing, 0])cylinder(d = 4.2, h = carriage_thickness);
			//belt tensioner holes
			translate([carriage_width/2 - 20, 7 + lb_spacing_y/2 + bearings_spacing - 4 -10, 0])cylinder(d = belt_screw_holes_size, h = carriage_thickness);
			translate([carriage_width/2 + 20, 7 + lb_spacing_y/2 + bearings_spacing - 4 -10, 0])cylinder(d = belt_screw_holes_size, h = carriage_thickness);
			//limit switch holes
			translate([52,0,0])cylinder(d = 2.5, h = carriage_thickness);
			translate([52,9,0])cylinder(d = 2.5, h = carriage_thickness);

			//extruder mount hole
			translate([carriage_width/2, 4 + lb_spacing_y/2 - 5, carriage_thickness + 15])rotate([-90,0,0]){
				cylinder(d = 12.1, h = 20);
			}
			//extruder holes nuts
			translate([carriage_width/2 - 34/2, 4 + lb_spacing_y/2 + 5.5/2, carriage_thickness + 15 - 3-1]){
				cylinder(d = 6.2, h = 3, $fn = 6);
				translate([34,0,0])cylinder(d = 6.2, h = 3, $fn = 6);
			}
			//extruder through holes
			translate([carriage_width/2 - 34/2, 4 + lb_spacing_y/2 + 5.5/2, 0]){
				cylinder(d = 3.2, h = 50, $fn = 20);
				translate([34,0,0])cylinder(d = 3.2, h = 50, $fn = 20);
			
			}
			//round corners
			translate([8,8,0])rotate([0,0,180])difference(){
				cube([16,16,carriage_thickness]);
				union(){
					cylinder(r = 8, h = carriage_thickness);
				}
			}
			translate([carriage_width-8,carriage_heigth-8,0])difference(){
				cube([16,16,carriage_thickness]);
				union(){
					cylinder(r = 8, h = carriage_thickness);
				}
			}
			translate([8,carriage_heigth-8,0])rotate([0,0,90])difference(){
				cube([16,16,carriage_thickness]);
				union(){
					cylinder(r = 8, h = carriage_thickness);
				}
			}

		}

		//extruder cooling fan mount

		translate([0,22,carriage_thickness+7]){
			rotate([0,90,0])difference(){
				union(){
					translate([0,-7/2,0])cube([8,7,4]);
					translate([0,-7/2+32,0])cube([8,7,4]);
					hull(){
						cylinder(d = 7, h = 4);
						//translate([-32,32,0])cylinder(d = 7, h = 4);
					}
					hull(){
						translate([0,32,0])cylinder(d = 7, h = 4);
						//translate([-32,0,0])cylinder(d = 7, h = 4);
					}
				}
				cylinder(d = 3.5, h = 4);
				translate([-32,32,0])cylinder(d = 3.5, h = 4);
				translate([0,32,0])cylinder(d = 3.5, h = 4);
				translate([-32,0,0])cylinder(d = 3.5, h = 4);


			}



		}
	}
}

module clamp(x,y,z){
	translate([x,y,z]){
		difference(){
			union(){
				//fan mounts
				translate([3,0,0])cube([28, 5.5, 28]);
				translate([23,0,0])cube([8,40,4]);
				translate([3,0,0])cube([8,20,4]);
				translate([34/2-19,10,0,])hull(){
					cylinder(d = 8, h = 4);
					translate([40,40,0])cylinder(d = 8, h = 4);
				}
				//clamp mounts
				translate([0, 5.5/2, 18]){
					cylinder(d = 10, h = 10, $fn = 20);
					translate([34,0,0])cylinder(d = 10, h = 10, $fn = 20);
			
				}
				
			}
			//main hole
			translate([34/2, -1, 28])rotate([-90,0,0]){
				cylinder(d = 12.1, h = 20);
			}
			//mounting holes
			translate([0, 5.5/2, 10]){
				cylinder(d = 3.2, h = 50, $fn = 20);
				translate([34,0,0])cylinder(d = 3.2, h = 50, $fn = 20);
			
			}
			translate([0,10,0]){
				//fan holes
				translate([34/2-19, 0, 0]){
					cylinder(d = 2.2, h = 5, $fn = 20);
					translate([40,40,0])cylinder(d = 2.2, h = 5, $fn = 20);
				
				}
			}

		}
	}
}

main_body(50,0,0);
clamp(0,0,0);