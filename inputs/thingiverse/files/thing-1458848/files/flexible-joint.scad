height = 30;
radius = 5;
lenght = 30;
middle_width = 5;
module extrudedCircle(){
	linear_extrude(height=height){
		circle(radius);
	}
}

extrudedCircle();

translate([lenght,0,0]){
	extrudedCircle();
}

translate([0,-middle_width/2,0]){
	linear_extrude(height=height){
		square([lenght,middle_width],0);
	}
}