
// click & clamp

pipe_diameter=50;
pipe_radius=pipe_diameter/2;

clamp_thickness=4;

clamp_radius=pipe_radius+clamp_thickness;

screw_diameter=4;
screw_radius=screw_diameter/2;

screw_head_diameter=7;
screw_head_radius=screw_head_diameter/2;


clamp_height=12;
opening_angle=110;

difference(){
	linear_extrude(height=clamp_height){
		difference(){
			union(){
				translate([-clamp_radius,-clamp_radius-clamp_thickness,0])
					square([2*clamp_radius,clamp_radius+clamp_thickness]);
				circle(r=clamp_radius);
			}
			circle(r=pipe_radius);
			polygon(points=[	[0,0],
								[clamp_radius*cos((180-opening_angle)/2),clamp_radius*sin((180-opening_angle)/2)],
								[clamp_radius*cos((180-opening_angle)/2),clamp_radius],
								[clamp_radius*cos(90+opening_angle/2),clamp_radius],
								[clamp_radius*cos(90+opening_angle/2),clamp_radius*sin(90+opening_angle/2)]],
					path=[0,1,2,3,4]);
		}
		rotate([0,0,(180-opening_angle)/2]) translate([pipe_radius+1/2*clamp_thickness,0,0]) circle(r=clamp_thickness/2);
		rotate([0,0,90+opening_angle/2]) translate([pipe_radius+1/2*clamp_thickness,0,0]) circle(r=clamp_thickness/2);
	}
translate([0,0,clamp_height/2]) rotate([90,0,0]) cylinder(r=screw_radius,h=clamp_radius*2);
translate([0,0,clamp_height/2]) rotate([90,0,0]) cylinder(r=screw_head_radius,h=clamp_radius);
}


