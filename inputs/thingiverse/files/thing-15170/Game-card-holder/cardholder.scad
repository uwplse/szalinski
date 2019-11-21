//Settlers game card holder
// 1 to 1 copy of previous blender version but with parameters for changeing dimention

//Constants
card_x = 54; //original 54
card_y = 80; //original 80
card_space = 2; //original 2
wall_thickness = 2; //original 2
plate_height = 2; //original 2
wall_height = 12; //original 12
shortwall_cut = card_x/(card_y/card_x);
shortwall = (card_x-shortwall_cut)/2+wall_thickness+card_space/2;

//Connecting piece
//the "female" part is 21mm at the biggest point and 12.5mm at the smallest and 10mm deep
//the "male" part is  19.8mm at the biggest point and 10.46mm at smallest and 11.4mm long
//the odd numbers are because i used a manualy freehand modifed box with no real grid snapping, and some random scaling
female_con_x = 10;
female_con_y1 = 21;
female_con_y2 = 12.5;
male_con_x = 11.4;
male_con_y1 = 19.8;
male_con_y2 = 10.46;
angle = atan( ((female_con_y1-female_con_y2)/2) / female_con_x ); // same for both


union() {

	difference() {
		//Base plate
		cube(size = [card_x+card_space+wall_thickness*2, card_y+card_space+wall_thickness*2,plate_height], center = true);
		//Round Cut
		// was made with a cylinder with radius=32 scaled in x and y by 0.8, resulting in R=25.6 and that is aprox card_x
		translate([0,card_y/1.27,-card_x/4])
		cylinder(card_x/2, card_x/2, card_x/2, $fa=2);
		translate([0,-card_y/1.27,-card_x/4])
		cylinder(card_x/2, card_x/2, card_x/2, $fa=2);
		
		//female con
		translate( [ (card_x/2) - female_con_x + card_space/2 + wall_thickness +0.01 , -female_con_y1/2, -plate_height ] ) //0.01 is for overlapping
		difference() {
			cube(size = [female_con_x, female_con_y1, plate_height*2], center = false);
			translate( [ 0,female_con_y1,-1 ] )
			rotate([0, 0, -angle])
			cube(female_con_x*2);
			translate( [ 0,0,-1 ] )
			rotate([0, 0, angle-90])
			cube(female_con_x*2);
		}

	}

	//male con
	translate( [ -(card_x/2) - card_space/2 - wall_thickness - male_con_x, -male_con_y1/2, -plate_height/2 ] ) 
	difference() {
		cube(size = [male_con_x, male_con_y1, plate_height], center = false);
		translate( [ 0,male_con_y1,-1 ] )
		rotate([0, 0, -angle])
		cube(male_con_x*2);
		translate( [ 0,0,-1 ] )
		rotate([0, 0, angle-90])
		cube(male_con_x*2);
	}

	//Cards for reference
	//%cube(size = [card_x,card_y,9], center = true);
	//%cube(size = [card_y,card_x,9], center = true);
	
	//%cube(size= [shortwall_cut, 100,20], center = true);
	
	// Long wall 1 of 4
	translate([  (card_x+card_space+wall_thickness*2)/2 , (card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
	rotate([0,0,180])
	cube(size = [wall_thickness,(card_y-card_x)/2+wall_thickness+card_space/2,wall_height] ,center = false);
	
	// Long wall 2 of 4
	translate([  -(card_x+card_space+wall_thickness*2)/2 +wall_thickness , (card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
	rotate([0,0,180])
	cube(size = [wall_thickness,(card_y-card_x)/2+wall_thickness+card_space/2,wall_height] ,center = false);
	
	// Long wall 3 of 4
	translate([  (card_x+card_space+wall_thickness*2)/2 -wall_thickness, -(card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
	rotate([0,0,0])
	cube(size = [wall_thickness,(card_y-card_x)/2+wall_thickness+card_space/2,wall_height] ,center = false);
	
	// Long wall 4 of 4
	translate([  -(card_x+card_space+wall_thickness*2)/2 , -(card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
	rotate([0,0,0])
	cube(size = [wall_thickness,(card_y-card_x)/2+wall_thickness+card_space/2,wall_height] ,center = false);
	
	//Shortwall 1 of 4
	//the cut to make the space between the walls was originaly 37mm
	translate([  -(card_x+card_space+wall_thickness*2)/2  , (card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
	rotate([0,0,270])
	cube(size = [wall_thickness, shortwall , wall_height] ,center = false);
	
	//Shortwall 2 of 4
	//the cut to make the space between the walls was originaly 37mm
	translate([  (card_x+card_space+wall_thickness*2)/2 , -(card_y+card_space+wall_thickness*2)/2 ,plate_height/2])
	rotate([0,0,90])
	cube(size = [wall_thickness, shortwall , wall_height] ,center = false);
	
	//Shortwall 3 of 4
	//the cut to make the space between the walls was originaly 37mm
	translate([  -(card_x+card_space+wall_thickness*2)/2 , -(card_y+card_space+wall_thickness*2)/2 +wall_thickness ,plate_height/2])
	rotate([0,0,270])
	cube(size = [wall_thickness, shortwall , wall_height] ,center = false);
	
	//Shortwall 4 of 4
	//the cut to make the space between the walls was originaly 37mm
	translate([  (card_x+card_space+wall_thickness*2)/2 , (card_y+card_space+wall_thickness*2)/2 -wall_thickness ,plate_height/2])
	rotate([0,0,90])
	cube(size = [wall_thickness, shortwall , wall_height] ,center = false);
	

}