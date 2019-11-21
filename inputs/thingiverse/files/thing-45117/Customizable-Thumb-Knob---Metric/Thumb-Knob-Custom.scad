/*
Universal Thumbnut/Socket Knob Design
By: Harrison Fast (2013)

This is a parametric script for a thumb knob which can be used on either a nut, hex head cap screw, or socket head cap screw.
Options include:
unit of measure (metric, imperial)
thread size []
pocket type (Constant_Wall_Thickness, Solid, Circular)
knob diameter
number of rosettes (fingers/cutouts)
size and position of rosette
wall thickness
top wall thickness

Should work in the Thingiverse Customizer

*/

//****Variables - To be Set****\\
//CUSTOMIZER VARIABLES

//What's This Knob For?
Knob_Type=3;//[1:Nut,2:Hex Head Screw,3:Socket Head Screw]

//What Size Nut or Screw? 
Thread_Size=6; //[0:M1.6,1:M2,2:M2.5,3:M3,4:M4,5:M5,6:M6,7:M8,8:M10,9:M12,10:M14,11:M16,12:M20]

//What Kind of Pocket Do You Want?
Knob_Fill=1;//[1:Constant Wall Thickness,2:Solid,3:Circular Cut-Out]

//How Big Should The Knob Be?
Knob_Diameter = 40;
knob_r = Knob_Diameter/2;

//How Thick Should the Grip Be? (Overall Height)
Knob_Thickness=15;
knob_t=Knob_Thickness*1;

//How Thick Should The Walls Be?
Wall_Thickness=3;

//How Many Prongs Should It Have?
Number_of_Rosettes=6; //[1:16]

//How Big Should The Finger Dents Be?
Rosette_Radius=6; 

//How Far Should The Finger Dents be From The Knob Circumference? (This lets you use larger radii by moving the center of the cut-out cylinder away from the center of the knob)
Rosette_Offset = 3;

//How Big Should the Bevel Be?
Chamfer_Size=1;
r_cham = Chamfer_Size*1; //Too lazy to change the proper names to Chamfer_Size

//How Much Clearance Do You Want? 0 probably won't work.
Clearance=.25; //[0:.125:1];

//CUSTOMIZER VARIABLES END


//$fa=6;


echo(knob_t);
knob_hex(); //main function call


//****MODULES***\\

module hex_trude(hex_width,hex_height) //makes a hexagonal prism at hex_width
	{	
		s = hex_width/1.732;
		l_x=s/2;
		l_y=.866*s;
		a_1 = [ [s,0],[l_x,-l_y],[-l_x,-l_y],[-s,0],[-l_x,l_y],[l_x,l_y]];
		b=[0:5];
		linear_extrude (height = hex_height) polygon(a_1,b);
	}


module pocket(hex_width,hex_height)
{	
	if(Knob_Fill==1){
		difference() {
			 translate([0,0,Wall_Thickness]) {cylinder(h=hex_height, r=knob_r-Wall_Thickness);} //wall offset
				for(i=[0:Number_of_Rosettes-1]) {
					rotate([0,0,360*i/Number_of_Rosettes]) 
						translate([knob_r+Rosette_Offset,0,0]) {
							cylinder(h = Wall_Thickness+hex_height, r = Rosette_Radius+Wall_Thickness); } //wall offset rosette
								}
	}//endif
					}

	else if(Knob_Fill==2){
	}//endif

	else if(Knob_Fill==3) {
		translate([0,0,Wall_Thickness]) {
			cylinder(h=hex_height,r=knob_r-Wall_Thickness-Rosette_Radius+Rosette_Offset);
						}
	}//endif
			
} //end module pocket()



module knobby_base_parts(knob_r, knob_h, rA, rB)
{
	difference()
	{
		cylinder(h=knob_h,r1=knob_r-rA,r2=knob_r-rB);
		for(i=[0:Number_of_Rosettes]){
			rotate(360*i/Number_of_Rosettes,[0,0,1]) translate([knob_r+Rosette_Offset,0,-0.05])
				cylinder(h=knob_h+.1,r1=Rosette_Radius+rA,r2=Rosette_Radius+rB);
		} //end if
	} //end difference
} //end knobby_base_parts



module knobby_base(hex_width,hex_height,r_cham)
{
	difference(){
			union() {
				knobby_base_parts(knob_r,r_cham,r_cham,0);
				if(hex_height<Wall_Thickness){
					union() {
						translate([0,0,r_cham]) knobby_base_parts(knob_r,Wall_Thickness-2*r_cham,0,0); 
						translate([0,0,Wall_Thickness]) knobby_base_parts(knob_r, r_cham,0,r_cham);}}

				else {translate([0,0,r_cham]) knobby_base_parts(knob_r,hex_height-2*r_cham,0,0);
					union() {
						translate([0,0,r_cham]) knobby_base_parts(knob_r,hex_height-2*r_cham,0,0); 
						translate([0,0,hex_height-r_cham]) knobby_base_parts(knob_r, r_cham,0,r_cham); }}
				} //end union
			pocket(hex_width,hex_height+1);
					} //end difference
} //end knobby_base


module make_knob(hex_width,hex_height,r_cham)
{
	if(Knob_Type==1){
	difference(){
			union(){
			rotate(0,[0,0,1]) {
			difference(){
				knobby_base(hex_width,knob_t,r_cham);
				translate([0,0,Wall_Thickness])hex_trude(hex_width+.25,hex_height+1+knob_t);
				}}
			translate([0,0,Wall_Thickness]) {
				difference() {
					hex_trude(hex_width+Wall_Thickness*2,hex_height);
					hex_trude(hex_width+.25,hex_height+.1);}
					}}
		translate([0,0,-.1]) cylinder(h=Wall_Thickness+hex_height+.2, r = Thread_Size/2+.25);
	 } 	//end Difference
	} //end if

	else if(Knob_Type==2) {
	difference() {
		union() {
			knobby_base(hex_width,knob_t,r_cham);
			cylinder(h=hex_height+Wall_Thickness, r=hex_width/2+Wall_Thickness);
			} //end union
		translate([0,0,-.05]) hex_trude(hex_width+.25,hex_height);
		translate([0,0,-.5]) cylinder(h=hex_height+Wall_Thickness+1+knob_t, r=thread_d[Thread_Size]/2+.125);
		}//end difference
	}//end if
			

	else if(Knob_Type==3) {
	difference(){
		union() {
			knobby_base(hex_width,knob_t,r_cham);
			cylinder(h=hex_height+Wall_Thickness, r=hex_width/2+Wall_Thickness);
		}//end union
			translate([0,0,-.05]) cylinder(h=hex_height+Knob_Thickness, r=hex_height/2+.125);
			translate([0,0,-.05]) cylinder(h=hex_height, r=hex_width/2);
	} //end difference
		} //end if
} //end module make_knob_hex


module knob_hex(){
	if (Knob_Type==1 || 2){
		make_knob(hex_w_table[Thread_Size],hex_h_table[Thread_Size],r_cham);
		}//end if
	else if (Knob_Type==3){
		make_knob(shcs_d_table[Thread_Size],thread_d[Thread_Size],r_cham);
} //end_if
} //end knob_hex

//****END KNOB BUILDING****\\

//****LOOKUP TABLES****\\

//----Lookup----\\

//----Thread Outer Diameter----\\\\
thread_d=[1.6,2,2.5,3,4,5,6,8,10,12,14,16,20,24];

//----Hex Width----\\
hex_w_table=[3.2,4,5,5.5,7,8,10,13,16,18,21,24,30,36];

//----Hex Height----\\
hex_h_table=[1.3,1.6,2,2.4,3.2,4.7,5.2,6.8,8.4,10.8,12.8,14.8,18,21.5];

//----Hex Head Height----\\
hex_head_height=[1.3,2,2.1,2.1,2.9,3.5,4.1,5.4,6.5,7.6,8.8,10,12.5,15];

//----SHCS Diameter----\\
shcs_d_table=[2.5,3.8,4.2,5.5,7,8.5,10,13,16,18,21,24,27,30];
//----SHCS Height = Thread Size!---\\

