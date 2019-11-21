hand= "left";	//left, right
height = 3;		//thickness of splint

//Measure strait distances. Just take a plastic ruler and measure. Have a fun:)

//palm sided hand 
front_1 = 35;
front_2 = 26;
front_3 = 65;
front_4 = 37;

//pinkie sided hand
side_1 = 15;
side_2 = 25;
side_3 = 33;

module splint(){

top_length = (side_1 * PI) / 4 + front_1 - side_1 / 2;
middle_length = (side_2 * PI) / 4 + front_1 * 1.5;
bottom_length = (side_3 * PI) / 4 + front_4 - (side_3 / 2);

	
	union(){
		difference(){
			cube([ middle_length, front_3, height]);
			translate([ middle_length, 0, -1]) linear_extrude(height + 2) scale([1, 1.8, 0]) circle(r = middle_length - bottom_length);
		}
		translate([ -middle_length, 0, 0]) cube([ middle_length, front_3, height]);
		translate([ 0, front_3, 0]) cube([ top_length, front_2, height]);
		translate([ -middle_length, front_3, 0]) cube([ middle_length, front_2, height]);

		radius = front_2 / 4;
		linear_extrude(height)
		difference(){
			translate([ top_length, front_3, 0]) polygon([[0,0],[radius,0],[0,radius]]);
			translate([ top_length  + radius, front_3 + radius, 0]) circle(radius);
		}
	}
}

if(hand == "left"){
	rotate([0,180,0]) splint();
}
else splint();


