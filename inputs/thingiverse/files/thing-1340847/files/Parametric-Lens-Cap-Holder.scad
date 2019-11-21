//CUSTOMIZER VARIABLES

//Facet number
definition = 100; // [0:400]

//Height of the lens cap holder
baseheight = 6.5;

//Amount of plastic around the lens cap
basewidth = 6;

//Width of the hole in the base of the lens cap holder
basehole = 50;

//Width of your lens cap
capwidth = 58;

//Width to be added to the bottom of the lens cap hole, creates an angle (useful for making sure the cap holds)
captilt = 1.5;

//Height of the cutout for the lens cap
capheight = 4;

//tolerance setting for the lens cap hole (1-2mm should be enough for most printers)
captolerance = 1;

//Gap between the strap holder and the base of the cap holder
beltlength = 10;

//Width of your camera's neck strap
beltwidth = 42;

//Height of the strap holder
beltheight = 4;

//Thickness of the strap holder
beltthickness = 4;

$fn = definition;

difference(){

	cylinder(baseheight,basewidth+capwidth/2,basewidth+capwidth/2);

	translate([0,0,baseheight-capheight])cylinder(capheight+0.01,capwidth/2+captolerance/2+captilt,capwidth/2+captolerance/2);

	translate([0,0,-0.5])cylinder(baseheight-capheight+1,basehole/2,basehole/2);

};

difference(){
	
	intersection(){
		
		cylinder(beltheight,beltlength+basewidth+capwidth/2+beltthickness,beltlength+basewidth+capwidth/2+beltthickness);
		
		translate([-beltwidth/2,-(beltlength*2+basewidth*2+capwidth+beltthickness*2+5)/2,-0.5])cube([beltwidth,beltlength*2+basewidth*2+capwidth+beltthickness*2+5,beltheight+1]);
		
	};
	
	translate([0,0,baseheight-capheight])cylinder(capheight+0.01,capwidth/2+captolerance/2+captilt,capwidth/2+captolerance/2);

	translate([0,0,-0.5])cylinder(baseheight-capheight+1,basehole/2,basehole/2);
	
	translate([0,0,-0.5])cylinder(beltheight+1,beltlength+basewidth+capwidth/2,beltlength+basewidth+capwidth/2);
	
};

difference(){
	
	intersection(){
		
		cylinder(beltheight,beltlength+basewidth+capwidth/2+beltthickness,beltlength+basewidth+capwidth/2+beltthickness);
		
		translate([-(beltwidth/2+beltthickness),-(beltlength*2+basewidth*2+capwidth+beltthickness*2+5)/2,-0.5])cube([beltwidth+beltthickness*2,beltlength*2+basewidth*2+capwidth+beltthickness*2+5,beltheight+1]);
		
	};
	
	translate([-beltwidth/2,-(beltlength*2+basewidth*2+capwidth+beltthickness*2+5)/2,-0.5])cube([beltwidth,beltlength*2+basewidth*2+capwidth+beltthickness*2+5,beltheight+1]);
	
	translate([0,0,baseheight-capheight])cylinder(capheight+0.01,capwidth/2+captolerance/2+captilt,capwidth/2+captolerance/2);

	translate([0,0,-0.5])cylinder(baseheight-capheight+1,basehole/2,basehole/2);
	
};