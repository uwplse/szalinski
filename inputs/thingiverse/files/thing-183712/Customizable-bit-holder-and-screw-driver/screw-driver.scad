//Creates a customisable scredriver bit holder

//Number of bits
bits = 6; //[3:15]
//increase or decrease to fit tolerance for bits
bitf2f = 6.35; 

//radius of the magnet you are going to use
magnetr = 1;

//height of the magnet you are going to use
magneth = 2;

//walls between bits on the side.  If you set it too small it will take the minimal value
walls = 4;

//Radius of the center column
center_rad = 7;

//height of the total thing
height = 40;

//height of handle
height2 = 20;

//more or less bulb at the bottom
heightb = 11;

//-------------------
//maths

bitd = bitf2f / cos(30);  
bitr = bitd/2;

centerr = max(bitr, center_rad);


theta = 360 / bits;

x1 = tan(theta/2) * bitf2f / 2;
x2 = bitr + (walls/2/cos(theta/2));
x = x1 + x2;
outerr = max(
	centerr + bitf2f + (tan(theta/4) * x),
	x / sin(theta/2));

ringr = max(centerr, outerr - (bitf2f/2) - (tan(theta/4) * x));



//-----------------


module bits() {
	translate([0,0,height - 7])cylinder(r = bitr, h = 50, $fn = 6);	
	for (i = [theta/2: theta:360]) {
		rotate([0,0,i])translate([ringr + 0.1, 0 , height2 - 15])rotate([0,0,30])cylinder(r = bitr, h = 50, $fn = 6);	
	}
}

module magnets() {
	translate([0,0,height - 7 - magneth])cylinder(r = magnetr, h = magneth + 1, $fn = 30);	
	for (i = [theta/2: theta:360]) {
		rotate([0,0,i])translate([ringr, 0 , height2 - 15- magneth])cylinder(r = magnetr, h = magneth + 1, $fn = 30);	
	}
}

module body(){
	cylinder(r = centerr, h = height, $fn = 30);	
	
	translate([0, 0, height2])cylinder(r1 = outerr, r2 = 0, h = 20, $fn = bits);

	
	intersection() {
		//rounded bottom
		translate([0, 0, heightb]) {
			intersection() {
	 			sphere(outerr, $fn = 50);
	 			cylinder(r = outerr, h =outerr *2 , center=true, $fn = bits);
			}
			cylinder(r = outerr, h = height, center=false, $fn = bits);
		}	

		//cut top and bottom
		translate ([-250, -250,0])cube([500, 500, height2]);
	}
	

}

difference() {
	body();	
	bits();
	magnets();
}


