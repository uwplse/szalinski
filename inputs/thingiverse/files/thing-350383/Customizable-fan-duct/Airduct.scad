//CUSTOMIZER VARIABLES

// The inner diameter of the duct
cowl_Innerdiameter = 85; // [10:100]
// The thickness of the duct
cowl_Thickness = 4; // [1:20]
// The inside curvature of the duct 
cowl_Inner_Curvature = 500; // [100:10000]
// The outside curvature of the duct 
cowl_Outer_Curvature = 150; // [100:10000]
// The height of the duct
cowl_Height = 48; // [10:250]

// Thickness of the support beams
support_Thickness = 3; // [1:10]
// The radius of the support cone
support_Radius = 17; // [2:30]
// The vertical location of the support in the duct
support_Location = 0; // [-50:50]

// Connection length
connection_Length = 40; // [10:100]

//	This section is creates the build plates for scale
//	for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//	when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//	when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//CUSTOMIZER VARIABLES END

//	This is just a Build Plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

$fs=1; 
$fa=1;

module shape(inner_Curvature,outer_Curvature,thickness,height) {
	rotate([90,0,0]) {	
		difference() {
			intersection() {
				translate([inner_Curvature-thickness/2,0,0]) {
					circle(inner_Curvature);
				}
				translate([-outer_Curvature+thickness/2,0,0]) {
					circle(outer_Curvature);
				}
			}
			translate([-50,height/2,0]) {
					square([100,100]);
			}
			translate([-50,-100-height/2,0]) {
					square([100,100]);
			}
			
		}
	}
}

module cowl(inner_Curvature,outer_Curvature,thickness,innerDiameter,height) {
	rotate_extrude() {
		translate([(innerDiameter/2)+(thickness/2),0,0]) {
				
					shape(inner_Curvature,outer_Curvature,thickness,height);
					
				
			
		}
	}
}

module support(radius,thickness,size) {
	difference() {	
		union() {
			translate([0,0,-thickness]) {
				scale([1,1,3]) {
					rotate([90,0,0]) {
						cylinder(r=thickness/2,h=size,center = true, $fn=30);
					}
					rotate([0,90,0]) {
						cylinder(r=thickness/2,h=size,center = true, $fn=30);
					}
				}
			}
			scale([1,1,1.3]) {
				sphere(r=radius);
			}
		}
		translate([0,0,(thickness/2)+250.1]) {
			cube([1000,1000,500],center = true);
		}
	}
}

module housing(cowl_Innerdiameter,cowl_Thickness,cowl_Inner_Curvature,cowl_Outer_Curvature,cowl_Height,support_Thickness,support_Radius,support_Location){

	union(){
		cowl(cowl_Inner_Curvature, cowl_Outer_Curvature, cowl_Thickness, cowl_Innerdiameter, cowl_Height);
		translate([0,0,support_Location]) {
			support(support_Radius,support_Thickness,cowl_Innerdiameter+cowl_Thickness);
		}
		connection(cowl_Innerdiameter,connection_Length);
	}
}

module connection(position,length) {
	translate([0,-position/2,0]) {	
		rotate([90,0,0]) {
			union() {
				cylinder(r1=7,r2=4,h=length);
				translate([0,0,length]) {
					sphere(r=7);
				}
			}
		}
	}
}


*shape(600,500,5);
*cowl(500,600,5,50,50);
*support(12,3,25);

housing(cowl_Innerdiameter,cowl_Thickness,cowl_Inner_Curvature,cowl_Outer_Curvature,cowl_Height,support_Thickness,support_Radius,support_Location);
