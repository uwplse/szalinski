diameter = 59;
height = 31;
thickness = 1.5;

$fn = 360;


linear_extrude(height = height+thickness){
	difference(){
		circle(r = (diameter/2)+thickness);
		circle(r = diameter/2);
	}
}