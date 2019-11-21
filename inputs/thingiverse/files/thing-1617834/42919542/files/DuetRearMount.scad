// Fan and Duet read board holder for 2020 Kossel

thickness=2.4;
leftMargin=10;
rightMargin=15;
ribThickness=3;
ribHeight=4;
footHeight = 12.5;	// plus 5mm nylock nut + 2.5mm alu sheet = 20mm
footWidth=14;
pcbThick=1.6;
pcbClear=0.1;
pcbWidth=100;
pcbWclear=0.5;
pcbOffset=24;
m3ClearRad=1.6;
m4ClearRad=2.1;
overlap=0.02;

module duetRibs() {
	translate([-pcbThick-ribThickness,-overlap-pcbWclear,thickness-overlap])
		cube([ribThickness,pcbWidth+2*pcbWclear+2*overlap,ribHeight+overlap]);

	translate([0,-overlap-pcbWclear,thickness-overlap])
		cube([ribThickness,6+overlap,ribHeight+overlap]);
	translate([0,pcbWidth+pcbWclear-6,thickness-overlap])
		cube([ribThickness,6+overlap,ribHeight+overlap]);

	translate([-ribThickness-pcbThick,-ribThickness-pcbWclear,thickness-overlap])
		cube([pcbThick+2*ribThickness,ribThickness,ribHeight+overlap]);
	translate([-ribThickness-pcbThick,pcbWidth+pcbWclear,thickness-overlap])
		cube([pcbThick+2*ribThickness,ribThickness,ribHeight+overlap]);
}

module foot() {
	difference() {
		translate([0,0,thickness-overlap]) cube([footHeight,footWidth,12]);
		translate([-overlap,5,thickness+4])
			rotate([0,90,0])
				cylinder(r=m4ClearRad,h=footHeight+2*overlap,$fn=16);
		translate([-overlap,5,thickness+7])
			rotate([0,90,0])
				cylinder(r=m4ClearRad,h=footHeight+2*overlap,$fn=16);
		translate([0,5,thickness+5.5])
			cube([2*(footHeight+overlap),2*m4ClearRad,3],center=true);
	}
}

module supportRib() {
	cube([pcbOffset-pcbThick-pcbClear-overlap,5,ribHeight+overlap]);
}

module fanCutouts() {
	translate([0,0,-overlap])
		difference() {
			union() {
				cylinder(r=19,h=10);
				for(x=[-16,16])
					for(y=[-16,16])
						translate([x,y,-overlap]) cylinder(r=m3ClearRad,h=20,$fn=16);
			}
			translate([0,0,-overlap]) cylinder(r=10,h=10);
			translate([-1,0,-overlap]) cube([9,100,20], center=true);
		}
}

module terminalCutout() {
	cube([8,12,20],center=true);
}

mirror([0,1,0])
difference() {
	union() {
		cube([48,pcbWidth+leftMargin+rightMargin,thickness]);
		translate([pcbOffset,rightMargin,0]) duetRibs();
		foot();
		translate([0,pcbWidth+leftMargin+rightMargin-10+10,0]) mirror([0,1,0]) foot();
		translate([0,10-1,thickness-overlap]) supportRib();
		translate([0,pcbWidth+leftMargin+rightMargin-10-5+1,thickness-overlap])
			supportRib();	
		translate([0,10-overlap,thickness-overlap])
			cube([ribThickness,pcbWidth+leftMargin+rightMargin-20+2*overlap,ribHeight+overlap]);
	}
	translate([25,rightMargin+18,0]) fanCutouts();
	translate([50,40,-overlap]) rotate([0,0,12]) cube([200,200,10]);
	translate([pcbOffset+pcbClear+7,rightMargin+45,0]) terminalCutout();
	translate([pcbOffset+pcbClear+7,rightMargin+77,0]) terminalCutout();
}
