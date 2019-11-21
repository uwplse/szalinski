use <utils/build_plate.scad>
//use <Write.scad>

//preview[view:east,tilt:top]

Pattern_Shape = 8;  //[3:Triangle (3-sided),4:Square (4-sided),5:Pentagon (5-sided),6:Hexagon (6-sided),7:Heptagon (7-sided),8:Octogon (8-sided),9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),30:Circle (30-sided)]



//in degrees:
Pattern_Angle =45;		//[0:180]

//in mm:
Pattern_Radius = 15; //[4:40]

//in mm:
Pattern_Thickness = 1; //[1:10]

//% of Radius
Pattern_Overlap = 40; //[0:100]

//Only used for visualisation
Build_Plate_Selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic]



module elongate() {
  for (i = [0 : $children-1])
    scale([1 , 1, case_thickness/4]) child(i); }

build_plate(Build_Plate_Selector);


/*Non customizer variables*/



$fn = 20;

iphone4_length = 115.15;
iphone4_width = 58.55;
iphone4_rad = 8.77;
iphone4_thickness = 9.34;
iphone4_rimheight = 6.4;
base_thickness = 1;
base_rim_thick = 2;
cam_ctr_width = 6.15;

iphone4_innerrad = iphone4_rad-0.5;
iphone4_rimrad = iphone4_rad+0.3;
rad_length = iphone4_length-(2*iphone4_rad);
rad_width = iphone4_width-(2*iphone4_rad);
rad_offsetl = 0.5*rad_length;
rad_offsetw = 0.5*rad_width;
case_thickness = iphone4_thickness+2;
button_basewall_thick = 2;
rad_buttoncut = (0.5*case_thickness)-button_basewall_thick;
tb_buttoncut_offset = (0.5*iphone4_width)-12.04;
sidecut_topctr = (0.5*115.15)-12.17;
sidecut_botctr = (0.5*115.15)-34.92;
sidecut_ctrwidth = sidecut_topctr-sidecut_botctr;
patt_mult = 1.5;



echo (rad_offsetw,tb_buttoncut_offset);






//--------------------------------------

difference (){  //for main top bottom and side button cuts


difference () {

elongate () {

	union() {
		//corner cylinders
		translate ([rad_offsetl,rad_offsetw,2])
		rotate_extrude (){
	
			translate([0,-2,0])
		 	square ([iphone4_rad,4]);

			translate([iphone4_rad,0,0])
			circle(r = 2);}

		translate ([rad_offsetl,-rad_offsetw,2])
		rotate_extrude (){
	
			translate([0,-2,0])
		 	square ([iphone4_rad,4]);

			translate([iphone4_rad,0,0])
		 	circle(r = 2);}

		translate ([-rad_offsetl,-rad_offsetw,2])
		rotate_extrude (){

			translate([0,-2,0])
		 	square ([iphone4_rad,4]);

			translate([iphone4_rad,0,0])
		 	circle(r = 2);}

		translate ([-rad_offsetl,rad_offsetw,2])
		rotate_extrude (){

			translate([0,-2,0])
 			square ([iphone4_rad,4]);

			translate([iphone4_rad,0,0])
 			circle(r = 2);}

	//center cube fill
	translate([0,0,2])
	cube ([rad_length,rad_width,4], center=true);


	// edges

	rotate ([90,0,90])
	translate ([rad_offsetw,2,0]){
		linear_extrude (height=rad_length, center=true){
			translate([0,-2,0])
 			square ([iphone4_rad,4]);

			translate([iphone4_rad,0,0])
 			circle(r = 2);}}

	rotate ([90,0,270])
	translate ([rad_offsetw,2,0]){
		linear_extrude (height=rad_length, center=true){
			translate([0,-2,0])
 			square ([iphone4_rad,4]);

			translate([iphone4_rad,0,0])
 			circle(r = 2);}}

	rotate ([90,0,180])
	translate ([rad_offsetl,2,0]){
		linear_extrude (height=rad_width, center=true){
			translate([0,-2,0])
 			square ([iphone4_rad,4]);

			translate([iphone4_rad,0,0])
 			circle(r = 2);}}

	rotate ([90,0,0])
	translate ([rad_offsetl,2,0]){
		linear_extrude (height=rad_width, center=true){
			translate([0,-2,0])
 			square ([iphone4_rad,4]);

			translate([iphone4_rad,0,0])
 			circle(r = 2);}}

	} //end union base flat form
	} //end elongation and main body block


//------------------------------------------



//main cut through

union() {

	//corner cylinders
		translate ([rad_offsetl,rad_offsetw,-5])
		 	cylinder (r=iphone4_innerrad, h=20);

		translate ([rad_offsetl,-rad_offsetw,-5])
		 	cylinder (r=iphone4_innerrad, h=20);

		translate ([-rad_offsetl,-rad_offsetw,-5])
		 	cylinder (r=iphone4_innerrad, h=20);

		translate ([-rad_offsetl,rad_offsetw,-5])
		 	cylinder (r=iphone4_innerrad, h=20);

	//center cube fill
		translate([0,0,5]){
			cube ([rad_length+(2*iphone4_innerrad),rad_width,20], center=true);	
			cube ([rad_length,rad_width+(2*iphone4_innerrad),20], center=true);}


	//rim cut

	//corner cylinders
		translate ([rad_offsetl,rad_offsetw,case_thickness/2])
		 	cylinder (r=iphone4_rimrad, h=iphone4_rimheight, center=true);

		translate ([rad_offsetl,-rad_offsetw,case_thickness/2])
		 	cylinder (r=iphone4_rimrad, h=iphone4_rimheight, center=true);

		translate ([-rad_offsetl,-rad_offsetw,case_thickness/2])
		 	cylinder (r=iphone4_rimrad, h=iphone4_rimheight, center=true);

		translate ([-rad_offsetl,rad_offsetw,case_thickness/2])
		 	cylinder (r=iphone4_rimrad, h=iphone4_rimheight, center=true);

	//center cube fill
		translate([0,0,case_thickness/2]){
			cube ([rad_length+(2*iphone4_rimrad),rad_width,iphone4_rimheight], center=true);
			cube ([rad_length,rad_width+(2*iphone4_rimrad),iphone4_rimheight], center=true);}

	} //end main cut through union

} // end difference on main cut

//-----------------------------------------

// top + bottom button cut

difference () {

	union () {
	
		translate ([0,tb_buttoncut_offset,case_thickness/2])
		rotate([0,90,0])
		cylinder (r=rad_buttoncut, h=iphone4_length+10,center=true);

		translate ([0,-tb_buttoncut_offset,case_thickness/2])
		rotate([0,90,0])
		cylinder (r=rad_buttoncut, h=iphone4_length+10,center=true);

		translate ([0,0,case_thickness/2])
		cube([iphone4_length+10,2*tb_buttoncut_offset,2*rad_buttoncut],center=true);

		translate ([-0.5*iphone4_length-5,-tb_buttoncut_offset-2*rad_buttoncut,(0.5*case_thickness)+button_basewall_thick])
		cube([iphone4_length+10,(2*tb_buttoncut_offset)+(4*rad_buttoncut),20-((0.5*case_thickness)+button_basewall_thick)]);

		translate ([-0.5*iphone4_length-5,-tb_buttoncut_offset-rad_buttoncut,00.5*case_thickness])
		cube([iphone4_length+10,2*tb_buttoncut_offset+(2*rad_buttoncut),button_basewall_thick]);}



	translate ([0,-tb_buttoncut_offset-(2*rad_buttoncut),(case_thickness/2)+button_basewall_thick])
	rotate([0,90,0])
	cylinder (r=rad_buttoncut, h=iphone4_length+12,center=true);

	translate ([0,tb_buttoncut_offset+(2*rad_buttoncut),(case_thickness/2)	+button_basewall_thick])
	rotate([0,90,0])
	cylinder (r=rad_buttoncut, h=iphone4_length+12,center=true);

}

//-----------------------------------------

// side cut

difference () {

	union () {
	
		translate ([-sidecut_topctr,0,case_thickness/2])
		rotate([0,90,270])
		cylinder (r=rad_buttoncut, h=(0.5*iphone4_width)+5);

		translate ([-sidecut_botctr,0,case_thickness/2])
		rotate([0,90,270])
		cylinder (r=rad_buttoncut, h=(0.5*iphone4_width)+5);

		translate ([-sidecut_topctr,-((0.5*iphone4_width)+5),(0.5*case_thickness)-rad_buttoncut])
		cube([sidecut_ctrwidth,(0.5*iphone4_width)+5,2*rad_buttoncut]);

		translate ([-sidecut_topctr-rad_buttoncut,-((0.5*iphone4_width)+5),(0.5*case_thickness)])
		cube([sidecut_ctrwidth+(2*rad_buttoncut),(0.5*iphone4_width)+5,button_basewall_thick]);

		translate ([-sidecut_topctr-(2*rad_buttoncut),-((0.5*iphone4_width)+5),(0.5*case_thickness)+button_basewall_thick])
		cube([sidecut_ctrwidth+(4*rad_buttoncut),(0.5*iphone4_width)+5,20-((0.5*case_thickness)+button_basewall_thick)]);}



		translate ([-sidecut_topctr-(2*rad_buttoncut),0,(case_thickness/2)+button_basewall_thick])
		rotate([0,90,270])
		cylinder (r=rad_buttoncut, h=(0.5*iphone4_width)+6);

		translate ([-sidecut_botctr+(2*rad_buttoncut),0,(case_thickness/2)+button_basewall_thick])
		rotate([0,90,270])
		cylinder (r=rad_buttoncut, h=(0.5*iphone4_width)+6);}

}  // end top bottom side button cuts difference

//-----------------------------------------

// Base rim

difference () {

union () {

	//corner cylinders
		translate ([rad_offsetl,rad_offsetw,0])
		 	cylinder (r=iphone4_rad, h=base_thickness);

		translate ([rad_offsetl,-rad_offsetw,0])
		 	cylinder (r=iphone4_rad, h=base_thickness);

		translate ([-rad_offsetl,-rad_offsetw,0])
		 	cylinder (r=iphone4_rad, h=base_thickness);

		translate ([-rad_offsetl,rad_offsetw,0])
		 	cylinder (r=iphone4_rad, h=base_thickness);

	//center cube fill
		translate ([0,0,base_thickness/2]){
			cube ([rad_length+(2*iphone4_rad),rad_width,base_thickness], center=true);	
			cube ([rad_length,rad_width+(2*iphone4_rad),base_thickness], center=true);}}

union () {

	//corner cylinders
		translate ([rad_offsetl,rad_offsetw,-1])
		 	cylinder (r=iphone4_rad-base_rim_thick, h=base_thickness+2);

		translate ([rad_offsetl,-rad_offsetw,-1])
		 	cylinder (r=iphone4_rad-base_rim_thick, h=base_thickness+2);

		translate ([-rad_offsetl,-rad_offsetw,-1])
		 	cylinder (r=iphone4_rad-base_rim_thick, h=base_thickness+2);

		translate ([-rad_offsetl,rad_offsetw,-1])
		 	cylinder (r=iphone4_rad-base_rim_thick, h=base_thickness+2);

	//center cube fill
		translate ([0,0,base_thickness/2]){
			cube ([rad_length-(2*base_rim_thick)+(2*iphone4_rad),rad_width,base_thickness+2], center=true);	
			cube ([rad_length,rad_width-2*(base_rim_thick)+(2*iphone4_rad),base_thickness+2], center=true);}}

} // end base rim


//-----------------------------------------

// Camera rim

difference () {

union () {
		translate ([-rad_offsetl,rad_offsetw,0])
		 	cylinder (r=iphone4_rad, h=base_thickness);

		translate ([-rad_offsetl,rad_offsetw-cam_ctr_width,0])
		 	cylinder (r=iphone4_rad, h=base_thickness);

		translate ([-rad_offsetl-iphone4_rad,rad_offsetw-cam_ctr_width,0])
		 	cube ([2*iphone4_rad,cam_ctr_width,base_thickness]);}

union () {
		translate ([-rad_offsetl,rad_offsetw,-1])
		 	cylinder (r=iphone4_rad-base_rim_thick, h=base_thickness+2);

		translate ([-rad_offsetl,rad_offsetw-cam_ctr_width,-1])
		 	cylinder (r=iphone4_rad-base_rim_thick, h=base_thickness+2);

		translate ([-rad_offsetl-iphone4_rad+base_rim_thick,rad_offsetw-cam_ctr_width,-1])
		 	cube ([2*(iphone4_rad-base_rim_thick),cam_ctr_width,base_thickness+2]);}

}  // end of camera rim difference



//-----------------------------------------


// start of pattern details



overlap=Pattern_Overlap*Pattern_Radius*0.01;
imax=(ceil((iphone4_length/2)/(patt_mult*Pattern_Radius-overlap)));
jmax=(ceil((iphone4_width/2)/(patt_mult*Pattern_Radius-overlap)));
echo (overlap);
echo ("imax=",imax);
echo ("jmax=",jmax);

a=ceil (0.03);
echo (a);



intersection() {  // intersection with block below

difference () {		

for(i = [(-imax):(imax)], j = [-jmax:jmax]) {

    		translate([i*(patt_mult*Pattern_Radius-overlap),j*(patt_mult*Pattern_Radius-overlap),0.5])
			rotate([0,0,Pattern_Angle])
  
			difference() { 

			circle(r=Pattern_Radius+(0.5*Pattern_Thickness), center = true, $fn = Pattern_Shape);
			translate ([0,0,-1])
			linear_extrude (h=3) {circle(r=Pattern_Radius-(0.5*Pattern_Thickness), center = true, $fn = Pattern_Shape);}
}


/*
		translate ([(0.5*rad_length)+iphone4_rad-base_rim_thick-Text_size-Text_position,0,base_thickness/2]){
			cube ([Text_size*2,rad_width+(2*iphone4_rad),base_thickness], center=true);//	

} */

}   // end pattern details


/*	translate ([((0.5*rad_length)+iphone4_rad-base_rim_thick-Text_size)-Text_position,0,0])
	rotate ([0,180,90])
		write(Custom_text,t=base_thickness+2,h=Text_size,font=Font_Style,center=true);	

*/
}
//-----------------------------------------

// pattern intersection block

difference () {

union () {

	//corner cylinders
		translate ([rad_offsetl,rad_offsetw,-1])
		 	cylinder (r=iphone4_rad-base_rim_thick, h=base_thickness+2);

		translate ([rad_offsetl,-rad_offsetw,-1])
		 	cylinder (r=iphone4_rad-base_rim_thick, h=base_thickness+2);

		translate ([-rad_offsetl,-rad_offsetw,-1])
		 	cylinder (r=iphone4_rad-base_rim_thick, h=base_thickness+2);

		translate ([-rad_offsetl,rad_offsetw,-1])
		 	cylinder (r=iphone4_rad-base_rim_thick, h=base_thickness+2);

	//center cube fill
		translate ([0,0,base_thickness/2]){
			cube ([rad_length-(2*base_rim_thick)+(2*iphone4_rad),rad_width,base_thickness+2], center=true);	
			cube ([rad_length,rad_width-2*(base_rim_thick)+(2*iphone4_rad),base_thickness+2], center=true);}}





union () {
		translate ([-rad_offsetl,rad_offsetw,-2])
		 	cylinder (r=iphone4_rad, h=base_thickness+4);

		translate ([-rad_offsetl,rad_offsetw-cam_ctr_width,-2])
		 	cylinder (r=iphone4_rad, h=base_thickness+4);

		translate ([-rad_offsetl-iphone4_rad,rad_offsetw-cam_ctr_width,0])
		 	cube ([2*iphone4_rad,cam_ctr_width,base_thickness+4]);}




} // end pattern intersection block



}

//-----------------------------------------





