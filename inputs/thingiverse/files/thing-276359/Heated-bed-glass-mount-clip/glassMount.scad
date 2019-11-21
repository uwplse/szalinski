/* [HeatedBed] */

hotBedThickness = 2.5;
hotBedSizeX = 214; 
hotBedSizeY = 214; 
hotBedMountPointX = 2.5;
hotBedMountPointY = 2.5;
hotBedMountPointDiameter = 3.7;

/* [Glass] */

glassThickness = 4;
glassSizeX = 200;
glassSizeY = 200; 

/* [Mount] */

mountTopThickness = 2;
mountBorderThickness = 2;
mountGlassBorderThickness = 4;
mountSize = 15;


/* [Hidden] */

hotBedBoltLength = 20;

// Calculations
hotBedMountPoints = [[hotBedMountPointX,hotBedMountPointY,0],
							[hotBedMountPointX,hotBedSizeY-hotBedMountPointY,0],
							[hotBedSizeX-hotBedMountPointX,hotBedSizeY-hotBedMountPointY,0],
							[hotBedSizeX-hotBedMountPointX,hotBedMountPointY,0]];

// Hot Bed
module HotBed(){
	difference() {
		color("OrangeRed", 1) 
			cube([hotBedSizeX, hotBedSizeY, hotBedThickness]);
		HotBedBolts();
/*
		for (i = hotBedMountPoints)
		{
			translate(i) 
				cylinder(h=hotBedThickness,r=hotBedMountPointDiameter/2, $fn=10);
		}
*/
	}
}

module HotBedBolts(){
	for (i = hotBedMountPoints)
	{
		translate(i+[0,0,-5]) 
			cylinder(h=hotBedThickness+glassThickness+10,r=hotBedMountPointDiameter/2, $fn=20);
	}
}

module Glass() {
	glassPosition = [(hotBedSizeX-glassSizeX)/2,(hotBedSizeY-glassSizeY)/2,hotBedThickness];
	color("Azure",0.7) 
		translate(glassPosition) cube([glassSizeX, glassSizeY, glassThickness]);
}

module GlassMount() {
	mountTotalHeight=hotBedThickness/2+glassThickness+mountTopThickness;
	mountPosition=[-mountBorderThickness,-mountBorderThickness,hotBedThickness/2];
	intersection() {
	difference(){
		translate(mountPosition) 
			color("Blue")
				cube([mountSize+mountBorderThickness,mountSize+mountBorderThickness,mountTotalHeight]);	
		HotBed();
		HotBedBolts();
		Glass();
		// Substract top piece
	//	translate([mountGlassBorderThickness,mountGlassBorderThickness,mountTopThickness]) Glass();
		// Triangle
	}
		translate(mountPosition)cylinder(h=mountTotalHeight,r=mountSize+mountBorderThickness,$fn=100);
	}
}
 
//HotBed();
//HotBedBolts();
//Glass();
//GlassMount();

module GlassMountPair() {
	translate([0,0,glassThickness + hotBedThickness + mountTopThickness])
	mirror([0,0,90]){
		GlassMount();
		translate([-10-mountBorderThickness, 0, 0]) mirror() GlassMount();
	}
}

GlassMountPair();
translate([0, -10-mountBorderThickness, 0]) mirror([0,1,0]) GlassMountPair();