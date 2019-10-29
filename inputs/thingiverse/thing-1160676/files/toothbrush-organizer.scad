// Number of Chargers
chargers = 1; // [0:10]

// Number or Toothpaste Holders
toothpastes = 1; // [0:10]

// Inner Diameter of Toothpaste Holders
toothpaste_d = 27; // [24:36]

// Number of Brush Head Holders
brushes = 2; // [0:10]

// Number of Interdental Brush Holders
interdentals = 2; // [0:10]

module ovoid() {
	scale([1,1.32,1])
cylinder(h=10, r=23.5, center=false);
	translate([0,-6,0]) scale([1,1.1,1]) cylinder(h=10, r=22.8, center=false);
	translate([0,-3,0]) scale([1,1.21,1]) cylinder(h=10, r=23.3, center=false);
	translate([0,3.5,0]) scale([1,1.21,1]) cylinder(h=10, r=23.3, center=false);
	translate([0,6.5,0]) scale([1,1.1,1]) cylinder(h=10, r=22.8, center=false);
}

module charger_holder() {
   translate([3,-33.5,-2]) cube([56,69,2]);
	difference() {
		translate([0,3,-2]) scale([1.2, 1.2, 1]) ovoid();
		ovoid();
	   translate([-16,23,0]) cube([32,10,23]);
	   translate([-25,35.5,-2.5]) cube([50,10,15]);
	   translate([-3,30,-2.5]) cube([6,10,25]);
	}
}

module toothpaste_holder() {
	difference() {
		translate([0,0,-0.01]) cylinder(r=(toothpaste_d+3)/2, h=15);
		translate([0,0,-0.5]) cylinder(r=toothpaste_d/2, h=16);
	}
}

module brush_holder() {
	difference() {
		translate([0,0,-0.01]) cylinder(r=3.25,h=15);
 		translate([2.5,-5,-0.5]) cube([10,10,16]);
 		translate([-12.5,-5,-0.5]) cube([10,10,16]);
 		translate([4.75,-2.5,-0.5]) rotate([0,0,45]) cube([5,5,16]);
	}
}

module interdental_holder() {
	difference() {
		translate([0,0,-0.01]) cylinder(r=4.5, h=15);
		translate([0,0,-0.5]) cylinder(r=3, h=16);
	}
}

module plate(length) {
	translate([30,-33.5,-2]) cube([length,69,2]);
}

$fn=50;

if (chargers > 0)
	for (i = [0:chargers-1])
		translate([62*i,0,0]) charger_holder();

center_width = max(5+toothpastes*(toothpaste_d+8), brushes*20);
interdental_width = ceil(interdentals/2) * 20;

translate([(chargers-1)*62,0,0]) {
	plate(center_width+interdental_width);

	if (toothpastes > 0)
		for (i = [0:toothpastes-1])
			translate([50+(toothpaste_d+8)*i,15,0]) toothpaste_holder();

	if (brushes > 0)
		for (i = [0:brushes-1])
			translate([40+20*i,-20,0]) brush_holder();

	if (interdentals > 0) {
		translate([center_width+40,0,0]) {
			for (i = [0:ceil(interdentals/2)-1]) {
				translate([i*20,15,0]) interdental_holder();
				if ((i < ceil(interdentals/2)-1) || 
					 (interdentals % 2 == 0))
					translate([i*20,-15,0]) interdental_holder();
			}
		}
	}
}
