/*[Variables]*/
height_cloud = 5; // [1:20]

quantity_hook =5; // [1:5]

//offset hook in axis Y
position_hook_offset_y = 4; //

//distance hooks between self
distance_hook = 15; // [5:18]

//length hooks
cube_z = 15; // [9:30]

/*[hidden]*/
size = [0.2 * quantity_hook, 0.2 * quantity_hook, 1];
circle1 = 77.981/2;
circle2 = 57.986/2;
circle3 = 104.974/2;
circle4 = 73.982/2;
cube5_x = 123.917/2;
cube5_y =  42.798/2;
position_hook_y = -position_hook_offset_y * quantity_hook;

cube_xy = 5;

x1 = distance_hook * quantity_hook;

hook1 = [[0,-5,0]];
hook2 = [[-x1,position_hook_y,0], [x1, position_hook_y, 0]];
hook3 = [[-x1,position_hook_y,0], [0, position_hook_y, 0], [x1, position_hook_y, 0]];
hook4 = [[-x1,position_hook_y,0], [-x1/3, position_hook_y, 0], [x1/3, position_hook_y, 0], [x1, position_hook_y, 0]];
hook5 = [[-x1,position_hook_y,0], [-x1/2, position_hook_y, 0], [0, position_hook_y, 0], [x1/2, position_hook_y, 0], [x1, position_hook_y, 0]];

hook = quantity_hook == 1 ? hook1 : quantity_hook == 2 ? hook2 : quantity_hook == 3 ? hook3 : quantity_hook == 4 ? hook4 : quantity_hook == 5 ? hook5 : hook1;
hole1 = [[0, 10, 0]];
hole2 = [[-x1/1.5, 10, height_cloud/2], [x1/1.5, 10, height_cloud/2]];
holes = quantity_hook < 3 ? hole1 : hole2;
difference(){
	scale(v=size){
		union(){
			translate ([-61.001, -11.417, 0]) {
				cylinder(h = height_cloud, r = circle1, center = true, $fn = 100);
			}
			translate ([-46.769, 22.975, 0]) {
				cylinder(h = height_cloud, r = circle2, center = true, $fn = 100);
			}
			translate ([14.831, 25.274, 0]) {
				cylinder(h = height_cloud, r = circle3, center = true, $fn = 100);
			}
			translate ([63.084, -13.512, 0]) {
				cylinder(h = height_cloud, r = circle4, center = true, $fn = 100);
			}
			translate ([-0.162, -29, 0]) {
				cube(size = [123.917, 42.798, height_cloud], center = true);
			}
		}
	}
	for (a = holes){
		union(){
			translate(a){
				 cylinder(h=height_cloud + 20, r=2, $fn=50, center=true);
			}
			translate(a){
				 cylinder(h=height_cloud/2, r1=2, r2 = 6, $fn=50, center=true);
			}
		}
	}
}
$fn = 20;
for(x = hook){
	translate(x){
		minkowski(){
			union(){
				translate ([0,0, (cube_z/2)+(height_cloud/2)]){
					cube(size = [cube_xy, cube_xy, cube_z], center = true);
				}
				difference(){
					translate ([0, 5, (((height_cloud/2)+cube_z)-3.75)]){
						cube(size = [cube_xy, cube_xy, 7.5], center = true);
					}
					translate([0, 6, (((height_cloud/2)+cube_z)-5.75)]){
						rotate([30, 0, 0]){
							#cube(size = [cube_xy+2, 10, 5], center=true);
						}
					}
				}
			}
			rotate([0, 90, 0]){
				cylinder(r = 2, h = 2);
			}
		}
	}
}


