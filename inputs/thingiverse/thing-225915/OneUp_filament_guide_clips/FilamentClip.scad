// Filament guide for OneUp printer from QU-BD
//
// (c) 2014 Laird Popkin

barWidth = 50;
barThick = 5;
thick=2.5;
height = barThick+2*thick;
head = 10;
tubeD = 3;
tubeR = tubeD/2;
width = 10;
snap=1;
$fn=32;

len=barWidth+snap+head;

difference() {
	cube([len, width, height], center=true);
	translate([len/2-head/2,0,0]) cylinder(r=tubeR, h=height+2, center=true);
	translate([-head/2,0,0]) cube([barWidth,barWidth,barThick], center=true);
	translate([-head/2-snap,0,0]) cube([barWidth,barWidth,barThick-2*snap], center=true);
}