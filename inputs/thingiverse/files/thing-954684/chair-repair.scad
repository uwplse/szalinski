//Bumper height
height=20;

//Wall
wall=3;

//Ground
ground_thickness=4;

//chair thickness
chair_thickness=17.2;

//chair width
chair_width=43.2;


/*hidden*/
$fn=50;

difference() {
        
//aussen
	hull() {
	cylinder(h=height,d=chair_thickness+wall*2);
		translate([chair_width-chair_thickness,0,0]) 
			cylinder(h=height,d=chair_thickness+wall*2);
	}


//innen
	hull() {
	translate([0,0,ground_thickness]) 
	cylinder(h=height,d=chair_thickness);
		translate([chair_width-chair_thickness,0,ground_thickness]) 
			cylinder(h=height,d=chair_thickness);


	}
			cylinder(h=height,d=2);
			translate([chair_width-chair_thickness,0,0]) 
				cylinder(h=height,d=2);






}