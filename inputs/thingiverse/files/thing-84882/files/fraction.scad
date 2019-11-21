use <write/Write.scad> 

// Which one would you like to see?
part = "fraction"; // [fraction:Fraction,plate:Plate]

//Diameter of the disk
diameter = 60;

//Thickness of the disk
thickness = 10;

//clearance
tol=1;

//number of parts
parts=3;

//Smoothness (large numers -> long rendering!)
fine = 50;		// [50:200]

print_part();

module print_part() {
	if (part == "fraction") {
		sectorWithFraction();
	} else if (part == "plate") {
		plateWithFraction();
	} else {
		echo ("ERROR: part not found");
	}
}

module sector(d,t,tol) {
	difference(){
		cylinder(h=t,r=d/2,center=true,$fn=fine);
		union() {
			rotate([0,0,180/parts]) translate([(d+2)/2-tol/2,0,0]) cube(size=[d+2,d+2,t+2], center=true);
			rotate([0,0,-180/parts]) translate([-(d+2)/2+tol/2,0,0]) cube(size=[d+2,d+2,t+2], center=true);
		}
	}
}

module sectorStackable() {
	intersection() {
		union() {
			translate([0,0,-thickness*4/5]) sector(diameter-3, thickness, tol+3);
			hull() {
				translate([0,0,thickness*1/5]) sector(diameter-3, thickness, tol+3);
				translate([0,0,thickness*0.5]) sector(diameter, thickness, tol);
			}
		}
		difference() {
			translate([0,0,thickness*0.05]) sector(diameter, thickness*1.1, tol);
			translate([0,0,thickness]) sector(diameter-2, thickness, tol+2);
		}
	}
}

module fraction() {
	translate([-0.4,-diameter/2.6+8*diameter/60,thickness/2]) write(str(1),t=2*thickness/10,h=diameter*7/60,center=true);
	translate([0.1,-diameter/2.6+7*diameter/60,thickness/2]) write("_",t=2*thickness/10,h=diameter*7/60,center=true);
	translate([0.1,-diameter/2.6-2*diameter/60,thickness/2]) write(str(parts),t=2*thickness/10,h=diameter*7/60,center=true);
}

module sectorWithFraction() {
	difference() {
		sectorStackable();
		fraction();
	}
}


innerR = (diameter-2)/2;
outerR = diameter*0.55;

module plate() {
	union() {
		difference() {
			cylinder(h=thickness*0.2,r=outerR,center=true,$fn=fine);
			translate([0,0,thickness*0.1]) cylinder(h=thickness*0.2,r=innerR,center=true,$fn=fine);
		}
		intersection(){
			translate([0,diameter/4,0]) cube(size = [1,diameter/2,thickness*0.2], center = true);
			rotate([0,0,180]) sector(diameter*2, thickness*0.4, tol);
		}
		for (i = [0:parts-1]) {
			rotate([0,0,360*i/parts]) translate([0,outerR-(outerR-innerR)/2+1,thickness*0.1]) cube(size = [2,outerR-innerR+2,thickness*0.4], center = true);
		}
	}
}

module plateFraction() {
	translate([0.1,-diameter/2.8+8*diameter/60,thickness*0.05]) write(str(parts),t=2*thickness/10,h=diameter*7/60,center=true);
	translate([0.1,-diameter/2.8+7*diameter/60,thickness*0.05]) write("_",t=2*thickness/10,h=diameter*7/60,center=true);
	translate([0.1,-diameter/2.8-2*diameter/60,thickness*0.05]) write(str(parts),t=2*thickness/10,h=diameter*7/60,center=true);
}

module plateWithFraction() {
	difference() {
		plate();
		plateFraction();
	}
}



