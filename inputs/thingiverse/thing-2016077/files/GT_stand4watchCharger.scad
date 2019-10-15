// support pour charger la montre

// thickness of the thing 
thickness=1.2;

/* [charger "box"] */
chargerX=36;
chargerY=27.6;
chargerZ=20.48;
chargerTotalY=48.66;

chargerUSBslotY=16;
chargerUSBslotZ=7;

/* [watch U Box] */

watchX=36;
watchY=12;
watchZ=22;

watchUSBholeX=6.82;
watchUSBdistX=5.4;

/* [hidden] */
chargerUSBslotX=thickness + 2;
plateY=chargerTotalY - chargerY;
watchUSBholeZ=watchZ;

base();

module base()
{
	translate([0,0,-((chargerZ + thickness * 2) /2)]) doChargerBox();
	doWatchBraket();
}


module doWatchBraket()
{
	translate([0,(plateY / 2) + (chargerY / 2) -1, -thickness / 2]) 
	union()
	{
		// plate
		cube([chargerX + thickness * 2, plateY, thickness], center=true);
	
		// ubox
		translate([0,0,watchZ / 2]) difference()
		{
			cube([watchX, watchY + thickness * 2, watchZ], center=true);
			translate([0,0,2]) cube([watchX + 2, watchY, watchZ + 2], center=true);
			// hole for usb in the ubox
			translate([-((watchUSBholeX / 2) + ((watchX / 2) - watchUSBholeX) - watchUSBdistX) ,-((watchY / 2) + 1),thickness]) 
				cube([watchUSBholeX, thickness + 2, watchUSBholeZ], center=true);
		}
	}
	
}

module doChargerBox()
{
	difference()
	{
		cube([chargerX + thickness * 2, chargerY, chargerZ + thickness * 2], center=true);
		cube([chargerX, chargerY + 2, chargerZ], center=true);
		
		// hole for usb slot
		translate([((chargerX+thickness) / 2),-2.6,0]) cube([thickness + 2, chargerUSBslotY, chargerUSBslotZ], center=true);
	}
}