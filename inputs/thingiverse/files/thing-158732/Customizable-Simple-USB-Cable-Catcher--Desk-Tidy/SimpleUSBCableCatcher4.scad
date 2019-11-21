// How thick your desk is.
deskh = 18.5; // 
//How wide you want the cable catcher to be
fullWidth = 160;
//How deep (ensure it fits between your desk and the wall!)
depth = 8;
//The gap between usb cable slots
slotGap=20;
//The diameter of the slot to hold the usb cable 
slotDiameter = 5;
//How far to recess the slot.
slotRecess=2;
//Thickness of the tabs which hold the USB catcher to the desk
tabHeight = 3.5;  
// Tab width
tabWidth = 20;
//Tab length
tabLength = 25;
module cableCatcher() {
difference()
{
	cube([fullWidth, depth, deskh+2*tabHeight]);
		for (z = [tabWidth+(slotGap/2) : slotGap : fullWidth-(tabWidth+(slotGap/2))] ) 
		{
   			  translate([z, slotRecess,-5]) cylinder(r=slotDiameter/2.0, h=40);
    		}
}
 translate([0,-tabLength,0]) 	cube([tabWidth, tabLength,tabHeight]);
 translate([0,-tabLength,deskh+tabHeight]) cube([tabWidth, tabLength, tabHeight]);
 translate([fullWidth-tabWidth,-tabLength,0]) 	cube([tabWidth, tabLength, tabHeight]);
 translate([fullWidth-tabWidth,-tabLength,deskh+tabHeight]) cube([tabWidth, tabLength, tabHeight]);
}
cableCatcher();
