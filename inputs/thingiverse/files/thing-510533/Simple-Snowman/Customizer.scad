//Evan Vengen
//Customizer V.1


// BEGIN CUSTOMIZER
//
/* [Snowman Parameters]  */

//choose part(s) to render
render_parts = 4; // [1:all,2:body,3:Print_withHat, 4:Print_NoHat]

//Draft for preview, production for final
Render_Quality = 24;

//Size of Snowman
scalar = 1; // [1:10]

//Hat or no Hat
Yes_No  = 1; //[1:Yes, 2:No]
// END CUSTOMIZER
$fn = Render_Quality;

module split_hat() {
	translate([0,-1,0])
	rotate([-90,0,180])
	difference(){
	snowman();
	translate([-125,0,-5]) cube([250,250,1000]);
	}
	translate([0,1,0])
	rotate([90,0,180])
	difference(){
	snowman();
	translate([-125,-250,-5]) cube([250,250,1000]); 
	
}}
module split_noHat(){
translate([0,-1,0])
	rotate([-90,0,180])
	difference(){
	no_hat();
	translate([-125,0,-5]) cube([250,250,1000]);
	}
	translate([0,1,0])
	rotate([90,0,180])
	difference(){
	no_hat();
	translate([-125,-250,-5]) cube([250,250,1000]);
}}
module no_hat(){
	translate([0,0,-3.00375]){
	difference(){	
	body();
	bottom();}	
	arms();
	}	
}
module bottom(){
	translate([-15,0,0]){
		cube([30,10,3]);}
	translate([-15,-10,0]){
		cube([30,10,3]);}	
}
module snowman(){
	translate([0,0,-3.00375]){
	difference(){	
	body();
	bottom();}	
	arms();
	hat();
}}

module body(){
//Body///////////////////
	color("White")
	{
		translate([0,0,15])
		{
			sphere(15,$fn=100);	
		}
	}
	color("White")
	{
		translate([0,0,37.5])
		{
			sphere(12,$fn=100);
		}
	}
	color("White")
	{
		translate([0,0,55])
		{
			sphere(10,$fn=100);
		}
	}
	color("Black")
	{
		translate([-.5,-12,42])
		{
			cube(3,4,1);
		}
	}
	color("Black")
	{
		translate([-.5,-13,35])
		{
			cube(3,4,1);
		}
	}
	color("Black")
	{
		translate([-.5,-11,29])
		{
			cube(3,4,1);
		}
	}
	
////////////////////////


//Face//////////////////
	color("Black") //Eye
	{
		translate([5,-8,57.5])
		{
			cube(2,3,1);
		}
	}
	color("Black") //Eye
	{
		translate([-6,-9,57.5])
		{
			cube(2,3,1);
		}
	}
	color("Orange") //Nose
	{
		rotate([90,0,0])
		{
			translate([0,55,5])
			{
				cylinder(h=15,r1=3,r2=.1);
			}
		}
	}
	color("Black")
	{
		translate([-7,-8.5,52])
		{
			cube(2,3,1);
		}
	}
	color("Black")
	{
		translate([-4,-10,51])
		{
			cube(2,3,1);
		}
	}
	color("Black"){
		translate([-.625,-10,50])
		{
			cube(2,3,1);
		}
	}
	color("Black")
	{
		translate([3,-10,51])
		{
			cube(2,3,1);
		}
	}
	color("Black")
	{
		translate([6,-7.5,52])
		{
			cube(2,3,1);
		}
	}
}
 module arms(){
	color("Brown")//Arm
	{
		rotate([0,90,0]){
		translate([-40,0,-25])
		{
			cylinder(h=15,r=1);
		}
	}
}	
	color("Brown")//Arm
	{
		rotate([0,90,0]){
		translate([-40,0,10])
		{
			cylinder(h=15,r=1);
		}	
	}
}
}
module hat(){
color("Black"){
	translate([0,0,62])
		{
			cylinder(h=2,r=10);
		}
	
	
		translate([0,0,62])
		{
			cylinder(h=8,r=7);
		}
	}
}
/////////////////////////

scale([scalar,scalar,scalar]){
if(render_parts == 1 && Yes_No == 1){
	snowman();}
if(render_parts == 1 && Yes_No == 2){
	no_hat();}
if(render_parts == 2 && Yes_No == 1){
	snowman();}
if(render_parts == 2 && Yes_No == 2){
	no_hat();}
if(render_parts == 3 && Yes_No == 1){
	split_hat();}
if(render_parts == 3 && Yes_No == 2){
	split_hat();}
if(render_parts == 4 && Yes_No == 1){
	split_noHat();}
if(render_parts == 4 && Yes_No == 2){
	split_noHat();}
}//end scale

