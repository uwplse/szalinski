

$fa = .1*1;
$fn = 100*1;


// total heigth
heigth = 75; // [25:100]

// radius of the pump
pumpRadius = 12; // [10:50]

// radius of the bicycle
cycleRadius = 25; // [10:50]

//thickness of the parts
thickness = 1.5; // [1:5]

difference(){
	union(){
		translate([0,cycleRadius+thickness/2,0])
		rotate([0,0,45])
		arcTube(heigth, cycleRadius,cycleRadius+thickness,90);

		translate([0,-pumpRadius-thickness/2,-heigth/6])
		rotate([0,0,180])
		openCyl(2*heigth/3, pumpRadius,pumpRadius+thickness,pumpRadius);

		translate([7,-.5,-heigth/6])
		cylinder(2*heigth/3, r=2, center=true);

		difference(){
			translate([9,-.8,-heigth/6])
			cylinder(2*heigth/3, r=3, center=true);

			translate([12.2,-1.3,-heigth/6])
			cylinder(2*heigth/3, r=3.3, center=true);			
		}
	}

	translate([0,26,32])
	rotate([0,90,-20])
	cylinder(100,0,5);

	translate([0,26,-32])
	rotate([0,90,-20])
	cylinder(100,0,5);
}

/* My primitives */

module arcTube(aHeigh,intRadius, extRadius,c){
	difference(){
		arcCyl(heigth, extRadius, c);
		arcCyl(heigth+1, intRadius, c);
	}
}

module arcCyl(aHeigh,radius,c){
	difference(){
		cylinder(aHeigh,radius,radius, true);

		rotate([0,0,-90-c/2])
		translate([-100,0,0])
		cube([200,200,aHeigh+1],true);

		rotate([0,0,-90+c/2])
		translate([-100,0,0])
		cube([200,200,aHeigh+1],true);
	}
}

module openCyl(aHeigh,intRadius, extRadius, openWidth){
	difference(){
		cylinder(aHeigh,extRadius,extRadius, true);
		cylinder(aHeigh+1,intRadius,intRadius, true);

		rotate([0,0,90])
		translate([100,0,0])
		cube([200,openWidth,aHeigh+1], true);

		translate([0,6*aHeigh/10,0])
		rotate([0,90,0])
		cylinder(100,aHeigh/2,aHeigh/2, true);
	}
}