/// ///
/// PIPETTE RACK v1; 2014 02 24 ///
/// by Tom Baden (thingyverse ID: tbaden) ///
/// thomas.baden@uni-tuebingen.de ///
/// tombaden.wordpress.com ///
/// ///

/////////////////////////////////////////////////////////////////////////////////


// CUSTOMIZABLE VARIABLES
1_or_2_sided = 2; // [1,2]
// (will automatically adjust #slots..)
Length = 130; // [50:300]
Height = 180; //[150:220]

Foot_Y = 150; // [100:200]
Foot_X = 15; // [10:30]
// how thick are all the pieces? - multiplyer
Stability = 2; // [1:4]
// (printer precision)
Tolerance = 0.4; // [0.1, 0.2, 0.3, 0.4, 0.5]
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
/// CUSTOMIZER CUTOFF: MODIFY ANYTHING BELOW HERE AT YOUR OWN RISK! ///////////////////
module customizer_cutoff(){};//////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

sep = 20;

X = Length;
Z = Height;
Y = 18;

Wall_Y = 2*Stability;
Wall_Z = 3*Stability;
Wall_X = 4*Stability;


X_hanger = 11;
Y_hanger = 35;

slot_depth = 20;
slot_width = 5;

Foot_length = Foot_X;
Foot_width = Foot_Y;

R_end = 10;
R_end_inner = 6;
R_end_inner_minus = R_end_inner-Tolerance;
connect_width = sqrt(R_end_inner_minus*R_end_inner_minus*2);


Triangle_top = 30;

n_slots = round(X/50);

2_sided = 1_or_2_sided-1;

/////////////////// TOP (A)

module A(){
	cube([X,Wall_Y,Wall_Z], center = true ); // main beam
	translate([-X/2-R_end/2,0,0]){cylinder(r = R_end, h = Wall_Z, center = true );} // ends
	translate([X/2+R_end/2,0,0]){cylinder(r = R_end, h = Wall_Z, center = true );} // ends
	for (i = [1:n_slots]) { // protrusion 
		translate([-X/2+(i-0.5)*X/n_slots,-Y_hanger/2-Wall_Y/2,0]){cube([X_hanger,Y_hanger,Wall_Z], center = true );} // main
		translate([-X/2+(i-0.5)*X/n_slots,-Y_hanger-Wall_Y/2,Wall_Z/2]){rotate([45,0,0]){ cube([X_hanger,sqrt(2*(Wall_Z*Wall_Z)),sqrt(2*(Wall_Z*Wall_Z))], center = true );}} // slope

		if (2_sided == 1) {	
			translate([-X/2+(i-0.5)*X/n_slots,Y_hanger/2+Wall_Y/2,0]){cube([X_hanger,Y_hanger,Wall_Z], center = true );} 
		translate([-X/2+(i-0.5)*X/n_slots,+Y_hanger+Wall_Y/2,Wall_Z/2]){rotate([45,0,0]){ cube([X_hanger,sqrt(2*(Wall_Z*Wall_Z)),sqrt(2*(Wall_Z*Wall_Z))], center = true );}} // slope
		}
	}	
}
module A_sub(){
	translate([-X/2-R_end/2,0,0]){rotate([0,0,45]){
		cylinder($fn = 4, r = R_end_inner, h = Wall_Z, center = true );}} // end-hole
	translate([X/2+R_end/2,0,0]){rotate([0,0,45]){
		cylinder($fn = 4, r = R_end_inner, h = Wall_Z, center = true );}} // end-hole

	for (i = [1:n_slots]) { // slots
		translate([-X/2+(i-0.5)*X/n_slots,slot_depth/2-Y_hanger-Wall_Y/2,Wall_Z/2]){cube([slot_width,slot_depth,Wall_Z*2], center = true );}
		if (2_sided == 1) {
			translate([-X/2+(i-0.5)*X/n_slots,-slot_depth/2+Y_hanger+Wall_Y/2,Wall_Z/2]){cube([slot_width,slot_depth,Wall_Z*2], center = true);	}}
	}

	translate([0,-Y_hanger-Wall_Y*1.5,Wall_Z/2]){cube([X,Wall_Y*2,Wall_Z*2], center = true );} // Cut ends
	translate([0,Y_hanger+Wall_Y*1.5,Wall_Z/2]){cube([X,Wall_Y*2,Wall_Z*2], center = true );} // Cut ends
	translate([0,0,Wall_Z*1.5]){cube([X,(Y_hanger+Wall_Y)*2,Wall_Z], center = true );} // Cut top
}
difference(){A();A_sub();}

/////////////////// SIDE (B)



module B(){
	translate([-X/2-R_end/2-connect_width/2+Wall_X/2,0,-Z/2-Wall_Z/2-sep]){cube([Wall_X,Y,Z], center = true );} // main beam
	translate([-X/2-R_end/2,0,-sep]){rotate([0,0,45]){
		cylinder($fn = 4, r = R_end_inner_minus, h = Wall_Z, center = true );}} // connect_thingy
	translate([-X/2-R_end/2-connect_width/2+Foot_length/2,0,-Z-sep]){cube([Foot_length,Foot_width,Wall_Z], center = true );} // foot
//	translate([-X/2-R_end/2-connect_width/2+Wall_X/2,0,-sep-connect_width/2]){rotate([0,45,0]){cube([Triangle_top,Wall_Y,Triangle_top], center = true );}} // triangle
}
module B_sub(){

}
difference(){B();B_sub();}