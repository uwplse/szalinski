H=100;  //Height of the cactus
CD=35;  //Diameter of the cactus
N=5;  //Number of cactus Stems
A=3;  //Number of arms around the stem
AL=20;  //Length of arms
AD=10;  //Diamter of arms
AA=35;  //Arm angle down from verticle
FL=CD/2;  //Flatness of the stems, must be less than diameter of the cactus
PD=CD+15;  //Pot diameter, must be larger than diameter of the cactus
PH=30;  //Pot height, ensure this is greater than the height of the cactus divided by 5, otherwise adjst the parameters in line 11
PLH=5;  //Pot Lip Height
F=28;  //Used for $fn function

module Cactus  ()  {
	translate([0, 0, H/4])difference  ()  {
		union  ()  {
			for(X=[0: 180/N: 180])rotate([0, 0, X])resize([CD, FL, H])sphere(d=CD, $fn=F);
			for(X=[1: 1: A]){rotate([0, 0, 360/(A+1-X)])translate([0, -CD/2, (H/10)*X])rotate([AA, 0, 0])resize([AD, AD, AL])sphere(d=AD, $fn=F);}
		}
        #translate([0, 0, -H/2-3])cube([CD, CD, CD], center=true);
	}
}

module  Pot  ()  {
	difference  ()  {
		union  ()  {
			translate([0, 0, -PLH/2])cylinder(d=PD, h=PLH, $fn=F, center=true);  //Pot lip
			translate([0, 0, -PH/2])cylinder(d1=PD-10, d2=PD, h=PH, $fn=F, center=true);  //Pot body
		}
		#translate([0, 0, -(PLH-2)/2])cylinder(d=PD-3, h=PLH-2, $fn=F, center=true);  //Cuts out the top of the pot
		Cactus();
	}
}

color("Green")Cactus();
color("Brown")Pot();

