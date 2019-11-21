from = 3;
to = 20;
thickness = 2;
boxHeight = 35;

module createGauge(radius) {
    $fn = 64;
	length = 40;
	difference() {
		union() {
			translate([-length/2+radius, 0, 0]) cylinder(h=thickness, r=radius);
			translate([-length/2+radius, -radius, 0]) cube([length-radius/2, radius*2, thickness]);
		}
		translate([length/2+radius/2, radius/2, 0]) cylinder(h=thickness, r=radius);
		translate([length/2-radius/2, radius/2, 0]) cube([radius, radius, 3]);
        
		// text
		if(radius <10) translate([-length/2+5, -(radius*1.5)/2, thickness/2]) linear_extrude(height=thickness) text(str(radius), size=radius*1.5);
		else 					 translate([-length/2+5, -(radius*0.75)/2, thickness/2]) linear_extrude(height=thickness) text(str(radius), size=radius*0.75);
	}
}


module createBox() {
    $fn = 64;
	spacing = 0.75;
	
	difference() {
		// huelle
		hull() {
			translate([0, 2, boxHeight/2]) cube([(from)*2+spacing+4, thickness+spacing+4, boxHeight], center=true);
			translate([0, 2+(to-from)*(thickness+2), boxHeight/2]) cube([(to)*2+spacing+4, thickness+spacing+4, boxHeight], center=true);
		}
		
		// aussparungen
		for(i=[0:(to-from)]) {
			translate([0, 2+i*(thickness+2), 22]) cube([(from+i)*2+spacing, thickness+spacing, 40], center=true);
		}
	}
}


// generate gauges
y=0;
for(i=[from:to]) {
    $fn = 64;
	y = i+i*i;
	translate([0, y, 0]) createGauge(i);
	
	//y = -thickness-1+(i)*(1+thickness);
	//translate([0, -5+y, 32]) rotate([90, -90, 0]) createGauge(i);
}


// generate box
translate([-60, 0, 0]) createBox();