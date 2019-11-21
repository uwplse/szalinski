thickness = 2;
batteries = 5;
brackets = true; // [true, false]

type = "AA"; // [AA,AAA,AAAA,C,D,custom]

custom_diameter = 14; //mm
custom_length = 50; //mm

if (type == "custom") batteryTray(custom_diameter, custom_length);
else if (type == "AA") batteryTray(14,50);
else if (type == "AAA") batteryTray(10,44);
else if (type == "AAAA") batteryTray(8.3,42.5);
else if (type == "C") batteryTray(26,50);
else if (type == "D") batteryTray(34,61);
else batteryTray(14,50);

module batteryTray (diameter, length) {
	difference() {
	cube([diameter*batteries+2*thickness,length+2*thickness,diameter+thickness]);
		translate([thickness,thickness,thickness+diameter/3])
		cube([diameter*batteries,length,diameter*2]);
		if (brackets) {
			rotate ([90,0,0])
			translate([diameter/2+thickness,diameter/2+thickness,-length-thickness])
			for ( i = [0 : batteries-1] ) {
				translate([diameter*i,0,0])
				cylinder (h = length, r=diameter/2, center = false, $fn=100);
			}
		}
	}
}