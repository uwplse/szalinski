// BEGIN CUSTOMIZER

/* [Snowman Parameters] */

// Draft for preview, production for final
Render_Quality = 24;    // [24:Draft,60:Production]
// Ornamental = 1 adds a hook on the back to tie a string to
ornamental = 0;         // [0:Default,1:Ornamental]
// END CUSTOMIZER


$fn = Render_Quality;
/*
difference(){
	rotate([90,0,90])wholeSnowman();
	color("white")translate([30,0,-25])cube([100,100,50], center = true);
}
difference() {
	rotate([-90,0,-90])translate([80,0,10])wholeSnowman();
	color("white")translate([30,-70,-25])cube([120,120,50], center = true);
}
*/
if(ornamental == 1){
	rotate([8,0,180])union(){
		wholeSnowman();
		hook();
	}
}else{
	rotate([8,0,270])wholeSnowman();
}


module wholeSnowman(){
difference(){
	union(){
		difference(){
			union(){
				color("white")sphere(r = 20, center = true);
				color("white")translate([0,0,24])sphere(r=17,center=true);
				color("white")translate([0,0,48])sphere(r=15,center=true);

//-------------ARMS----------------------------------------

				color("brown")rotate(a = 270,[0,-20,0]) translate([40,0,22]) cube([32,2,2], center = true);
				color("brown")rotate(a = 270,[0,20,0]) translate([-40,0,22]) cube([32,2,2], center = true);

				color("brown")translate([39.9,0,36])cube([10,2,2],center=true);
				color("brown")translate([-39.9,0,36])cube([10,2,2],center=true);

//-------------NOSE----------------------------------------

				color("orange")rotate(a=270,[-90,0,0]) translate([0,-48,18]) cylinder (h=7,r1=1,r2=.1, center = true);

//-------------TOPHAT--------------------------------------

				color("black")rotate([0,10,0])translate([-8,0,61])cylinder(h=1,r=10,center=true);
				color("black")rotate([0,10,0])translate([-8,0,61])cylinder(h=30,r=6,center=true);

//-------------MOUTH---------------------------------------

			color("black")translate([-6,13.1,45])cube([1.1,1.1,1.1],center=true);
			color("black")translate([6,13.1,45])cube([1.1,1.1,1.1],center=true);
			color("black")translate([-4.2,13.7,44])cube([1.1,1.1,1.1],center=true);
			color("black")translate([4.2,13.7,44])cube([1.1,1.1,1.1],center=true);
			color("black")translate([-2,14,43.3])cube([1.1,1.1,1.1],center=true);
			color("black")translate([2,14,43.3])cube([1.1,1.1,1.1],center=true);
			color("black")translate([0,14,43.1])cube([1.1,1.1,1.1],center=true);
		}


//-------------EYE-SOCKETS---------------------------------

		color("white")translate([-6,13,52]) sphere(r = 4, center = true);
		color("white")translate([6,13,52]) sphere(r = 4, center = true);



//-------------BASE(SoSnowmanDoesntFallOver)----------------

		color("white")translate([0,0,-20])cube([50,50,10],center=true);

//-------------EYE-PUPILS----------------------------------
		color("black")translate([-6,11,52]) cube([4,6,4], center = true);
		color("black")translate([6,11,52]) cube([4,6,4], center = true);

}
//----LOLZ-MUCH-SNOWBOARD-SUCH-SWAG------------------------
		color("blue")translate([0,0,-16])cube([60,29,5],center=true); //main board
		color("blue")rotate([90,0,0])translate([-30,-11,0])cylinder(h=29,r=7.5,center=true);//curved edge
		color("blue")rotate([90,0,0])translate([30,-11,0])cylinder(h=29,r=7.5,center=true);//more curved edge
		}

//take out part of cylinder at ends of snowboard to make it look better
//the following is in a difference thingy

color("blue")translate([-25,0,-10])cube([10,30,7],center=true);
color("blue")translate([-32,0,-7])cube([16,30,8],center=true);
color("blue")rotate([90,0,0])translate([-30,-11,0])cylinder(h=30,r=2.5,center=true);

color("blue")translate([25,0,-10])cube([10,30,7],center=true);
color("blue")translate([32,0,-7])cube([16,30,8],center=true);
color("blue")rotate([90,0,0])translate([30,-11,0])cylinder(h=30,r=2.5,center=true);

}
}

module hook(){
	difference(){
		color("white")translate([0,-14,55])rotate([0,90,0])cylinder(h = 2,r = 2.5,center=true);
		color("white")translate([0,-14,55])rotate([0,90,0])cylinder(h = 2.5,r = 1,center=true);
	}
}