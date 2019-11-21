// This is my first fully parametric openSCAD object. i'm very proud of it. figured most of it out on a flight to SFO and finished the rest here at the Opal Hotel in SF. Thank you to The New Hobbyist for helping me cleanup the openSCAD code and make it look better in the Customizer 

// It is a flower vase for converting 3d printing filament spools to hold a bunch of flowers and provide water for them. Use Cylinder_Height, Exterior_Radius and Wall_Thickness to define the radius of the tube and the thickness of the walls, or use the Thingiverse Customizer. 

// This has not been tested yet - if anyone wants to print one for me i'd appreciate it. 

Cylinder_Height = 100; // height of cylinder
Exterior_Radius = 15; // exterior radius
Wall_Thickness = 2; //wall thickness & lip height
Lip_Radius = Exterior_Radius+Wall_Thickness; // ext lip radius

module vase(){
	difference(){
		exterior();
		color("red") interior();
	}
}

module interior() {
	union() {
		cylinder(h = Cylinder_Height+10, r = Exterior_Radius-Wall_Thickness, center = true);
		translate([0,0,-Cylinder_Height/2]) sphere(r= Exterior_Radius-Wall_Thickness);
	}
}

module exterior() {
	union() {
		cylinder(h = Cylinder_Height, r = Exterior_Radius, center = true);
		color("blue") translate([0,0,+Cylinder_Height/2]) cylinder(h = Wall_Thickness, r = Lip_Radius, center = true);
		translate([0,0,-Cylinder_Height/2]) sphere(r= Exterior_Radius);
	}
}

vase();