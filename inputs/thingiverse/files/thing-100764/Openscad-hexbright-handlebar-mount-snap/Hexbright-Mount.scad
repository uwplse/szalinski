handlebarDiameter = 32;
fudj = 0.2;
mmIn = 25.4 * 1;
hexlightFlatDistance = 1.25 * mmIn;
handlebarD = handlebarDiameter + 0.8 + fudj; // inner tube is .8mm thick
len = handlebarD + 6;
$fn = 60;

apothem = hexlightFlatDistance/2;
circumradius = apothem/cos(180/6) + fudj;

apothemminor = 34/2;
circumradiusminor = apothemminor/cos(180/6) + fudj;

sagitta = 1 + 0;
chordy = 13 + 0;
cutoutR = (chordy*chordy)/(8*sagitta) + sagitta/2;

addedThickness = 0.42 * 2;

difference() {
	union() {
		hexMount();
		handlebarMount();
	}
	#zipCutouts();
}

module hexMount() {
	difference() {
		outer();
		hexBrightBody();
		cutout();
	}
}

yOffset = -handlebarD/2 - hexlightFlatDistance/2 - 0.5;

module handlebarMount() {
	difference() {
		translate([-(hexlightFlatDistance-2)/2, yOffset - 2, -len/2])
			cube(size=[hexlightFlatDistance-2, handlebarD, len], center=false);
		translate([0,yOffset - 5,0])
			rotate([0,90,0]) cylinder(r=handlebarD/2, h=len, center=true);
		hexBrightBody();
	}
}

module zipCutouts() {
	translate([hexlightFlatDistance/2 - 8,0,0]) zipCutout();
	translate([-(hexlightFlatDistance/2 - 8),0,0]) zipCutout();
}
module zipCutout() {
	translate([0,yOffset - 5,0])
	rotate([0,90,0])
	rotate_extrude()
	translate([handlebarD/2 + 1.25 + 2, 0, 0])
		square(size=[2.5, 6], center=true);
}

module hexBrightBody() {
	// translate([0,0,10]) cube(size=[hexlightFlatDistance, hexlightFlatDistance, hexlightFlatDistance], center=true);
	// translate([0,0,10]) cube(size=[34, 34, 34], center=true);
	difference() {
		intersection() {
			cylinder(r=circumradius, h=len+1, center=true, $fn=6);
			rotate([0,0,360/12]) cylinder(r=circumradiusminor, h=len+2, center=true, $fn=6);
		}
		hexBrightBodyFillet();
	}
}
module hexBrightBodyFillet() {
	intersection() {
		rotate_extrude($fn=60)
			translate([cutoutR + hexlightFlatDistance/2 + fudj - sagitta,0,0])
				circle(r=cutoutR); 
		outer();
	}
}
outerYOff = -2;
module outer() {
	translate([0,outerYOff,0]) cylinder(r=circumradius + addedThickness, h=len, center=true);
	rib(30);
	rib(180-30);
	rib(15);
	rib(180-15);
}

module rib(angle) {
	r = 1.5;
	translate([
		(circumradius+addedThickness-r/2) * cos(angle), 
		(circumradius+addedThickness-r/2) * sin(angle) + outerYOff,
		0
	]) 
		rotate([0,0,angle])
		scale([1,2,1])
		cylinder(r=r, h=len, center=true);
}


module cutout() {
	translate([0, hexlightFlatDistance/3, 0]) 
		cylinder(r=circumradius + addedThickness, h=len+3, center=true, $fn=4);

}