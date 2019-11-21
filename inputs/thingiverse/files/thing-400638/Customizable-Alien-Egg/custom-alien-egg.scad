//
//		Customizable Alien Egg
//		Steve Medwin
//		July 2014
//						

$fn=100*1;	// set print resolution

//Age=$t*10;	// uncomment this line in OpenSCAD editor to animate model
			// then comment out the line 'Age=8;' below
			// in OpenSCAD, set View/Animate
			// try FPS=1 and Steps=10 in animation console
			
// select age of egg:
Age=8 ; // [0,1,2,3,4,5,6,7,8,9]
// add flat bottom to help egg stand up?
Flat="yes"; // [yes,no]
// add ribs or segments to embryo?
Ribs="yes"; //  [yes,no]
// include antennae? (suggest at least Age 6)
Antennae="yes";	// [yes,no]
// include shell around embryo?
Shell="yes"; //  [yes,no]

// Parameters
Outer=50*1;
Embryo=5+Age*4;
Inner=Embryo+2;

if (Age>0) {
	make_embryo();
}

if (Shell=="yes") {
	make_shell();
}


module make_embryo(){
	if (Ribs=="yes") {
		scale([0.5,0.5,0.5]) sphere(Embryo); // ribs are actually series of spheres
		translate([0,0,-Embryo*0.71]) scale([0.28,0.28,0.28]) sphere(Embryo);
		translate([0,0,Embryo*0.71]) scale([0.28,0.28,0.28]) sphere(Embryo);
		translate([0,0,-Embryo*0.35]) scale([0.45,0.45,0.45]) sphere(Embryo);
		translate([0,0,Embryo*0.35]) scale([0.45,0.45,0.45]) sphere(Embryo);
	} else {
		scale([0.5,0.5,1.0]) sphere(Embryo);		
	}
	// make the head and eyes
	translate([0,0,Embryo*1.0]) scale([0.15,0.35,0.15]) sphere(Embryo);
	translate([0,Embryo*0.24,Embryo*1.0]) scale([0.15,0.15,0.15]) sphere(Embryo);
	translate([0,-Embryo*0.24,Embryo*1.0]) scale([0.15,0.15,0.15]) sphere(Embryo);
	// if old enough, add antennae
	if (Antennae=="yes") {
		translate([0,-Embryo*0.08,Embryo*1.0]) rotate([15,0,0]) cylinder(h=Embryo*0.6, r1=Age*0.25, r2=Age*0.125, center=false);
		translate([0,Embryo*0.08,Embryo*1.0]) rotate([-15,0,0]) cylinder(h=Embryo*0.6, r1=Age*0.25, r2=Age*0.125, center=false);
		translate([0,-Embryo*0.233,Embryo*1.59]) sphere(Embryo*0.05);
		translate([0,Embryo*0.233,Embryo*1.59]) sphere(Embryo*0.05);
	}
}

module make_shell() {
	difference(){
		scale([0.5,0.5,1.0]) sphere(Outer);
		scale([0.5,0.5,1.0]) sphere(Inner);
		// subtract top viewport
		translate([0,0,10+Age*3])  rotate ([0,0,0]) scale([1,0.25,0.5]) sphere(30+Age*4);
		// subtract side viewports
		translate([0,-36,9])  rotate ([90,0,90]) scale([.4,.5,.25]) sphere(0+Age*7.5);
		translate([0,36,9])  rotate ([90,0,90]) scale([.4,.5,.25]) sphere(0+Age*7.5);
		// subtract bottom viewports
		translate([15,0,-34])  rotate ([0,90,90]) scale([1,.35,1]) sphere(0+Age*3);	
		translate([-15,0,-34])  rotate ([0,90,90]) scale([1,.35,1]) sphere(0+Age*3);
		// make bottom flat for standing up
		if (Flat=="yes") {
			translate([-30,-30,-108.5]) cube(60); 
		}
	}
}