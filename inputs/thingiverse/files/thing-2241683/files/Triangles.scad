height=230;
sides_of_base_polygon=4; //3 will create a triangle based vase, n will create a n based side vase (min:3).
r_base=30;   //radius of circle in which polygon is inscribed
twist= 120;  //Angle witch the base poligon will be twisted along the height.
scale_x=0.5; //Ratio in size between top and bottom of vase, <1 means top is smaller than bot (default:scale_x = scale_y).
scale_y=0.2;
d=100; //Distance of base polygon from z axis (default:0).
base_count = 8;
pillar_mode= 1; //Enable construction of a central pillar, 0 tp disable, 1 to allow.


union() {
 	for (i = [1:base_count]){
		
		linear_extrude(height = height, center = false, convexity = 10, twist = twist, scale=[scale_x,scale_y], $fn=1000)
		if (pillar_mode == 1) {
			translate([d/sqrt(2),d/sqrt(2),0])  //pillar mode
			rotate ([0,0,360/base_count*i])
			translate([d/sqrt(2),d/sqrt(2),0])  //twist around z
			circle(r_base,$fn=sides_of_base_polygon)
			;
		}
		else {
			rotate ([0,0,360/base_count*i])
			translate([d/sqrt(2),d/sqrt(2),0])  //twist around z
			circle(r_base,$fn=sides_of_base_polygon)
			;
		}
	}
	
 }