//Basic Mounted By Joint Clamp by John Davis 8-10-13
//Polyhole module by nophead

// Which part would you like to make?
part = "All"; // [Mount,Clip, All]

/*[Dimensions of Mount Base]*/
//Ratio of material around screws
Screw_Base_Multiplier = 1.8;
//Ratio of material around central base
Central_Base_Multiplier = 1;
//Height of mount base including sphere
Height = 33;
//Thickness of mount base
Thickness = 2;
//Sphere diameter
Sphere_Diameter = 20;
//How far are the mounting screws from the center?
Screw_Distance = 15;
//The angle of the base connection to the sphere
Angle=45;

/*[Dimensions of Clip]*/
//Space between inside of clip and ball joint
Clip_Clearance=0.1;
//Clip thickness
Clip_Thickness=0.84;
//Clip height
Clip_Height=8;
//Opening
Opening=1;
//How far out does the clamp extend from the ball
Clamp_Extension=2.5;
//How far out does the mount extend from the ball
Mount_Extension=10.5;

/*[Mounting Screw Dimensions]*/
//Screw shaft diameter
Screw_Shaft_Diameter = 2.5; 
//Screw head diameter
Screw_Head_Diameter = 4.3;
//Length of screw hole 
Screw_Length = Thickness;
//Screw head thickness or depth of head recesss for countersunk 
Screw_Head_Height = 0.3;
//Countersunk (1) or flat head (0)? 
Countersink = 1; //[0,1]

/*[Clamping Screw and Nut Dimensions]*/ 
//Clamping screw diameter
Clamping_Screw_Diameter=2.6;
//Nut width across flats
Nut_Width=4.8;
//Nut height   
Nut_Height=1.5;
//Additional clearance for nut
Clearance=0.2; 

/*[Printer Settings]*/
//To control the number facets rendered, fine ~ 0.1 coarse ~1.0. 0.3 is fine for home printers.
$fs = 0.2;


/*[Hidden]*/
//leave $fn disabled, do not change
$fn = 0;
//leave $fa as is, do not change
$fa = 0.01;
//padding to insure manifold, ignore
Padding = 0.01; 

print_part();

module print_part() {
	if (part == "Mount") {
		Mount();
	} else if (part == "Clip") {
		Clip();
	} else {
		Mount();
		Clip();
	}
}

//Clip


module Clip(){

//uncomment for assembled view
//translate([0,0,Height-Sphere_Diameter/2-Clip_Height/2])

difference(){
	union(){
		intersection(){
			translate([0,0,Clip_Height/2])
			sphere(r=Sphere_Diameter/2+Clip_Clearance+Clip_Thickness);			
			cylinder(r=Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Padding,h=Clip_Height);		
		}
		
		translate([0,Opening/2,0])
		cube([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Clamp_Extension,Clip_Thickness,Clip_Height]);
			
		translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Clamp_Extension,Opening/2,Clip_Height/2])
		rotate([-90,0,0])
		cylinder(r=Clip_Height/2, h=Clip_Thickness);
					
		translate([0,-Opening/2-Nut_Height*2,0])
		cube([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension,Nut_Height*2,Clip_Height]);

		translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension,-Opening/2-Nut_Height*2,Clip_Height/2])
		rotate([-90,0,0])
		cylinder(r=Clip_Height/2, h=Nut_Height*2);
	}

	translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Clamp_Extension,-Opening/2-Nut_Height*2-Padding,Clip_Height/2])
	rotate([-90,0,0])
	cylinder(h= Nut_Height*2+Opening+Clip_Thickness+Padding*2, r=Clamping_Screw_Diameter/2);

	translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Clamp_Extension,-Opening/2-1.5*Nut_Height,Clip_Height/2])
	rotate([-90,0,0])
	nut();
	
	translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Clamp_Extension-(Nut_Width/2+Clearance)/cos(30),-Opening/2-1.5*Nut_Height,Clip_Height/2])
	cube([(Nut_Width/2+Clearance)/cos(30)*2,Nut_Height+Clearance,Nut_Width/2+Clearance]);
	
	translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension,-Opening/2-Nut_Height*2-Padding,Clip_Height/2])
	rotate([-90,0,0])
	cylinder(h= Nut_Height*2+Padding*2,r=Clamping_Screw_Diameter/2);

	translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension,-Opening/2-1.5*Nut_Height,Clip_Height/2])
	rotate([-90,0,0])
	nut();

	translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension-(Nut_Width/2+Clearance)/cos(30),-Opening/2-1.5*Nut_Height,Clip_Height/2])
	cube([(Nut_Width/2+Clearance)/cos(30)*2,Nut_Height+Clearance,Nut_Width/2+Clearance]);

	translate([0,-Opening/2,-Padding])
	cube([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Padding+Clamp_Extension+Clip_Height/2,Opening,Clip_Height+Padding*2]);

	translate([0,0,Clip_Height/2])
	sphere(r=Sphere_Diameter/2+Clip_Clearance);

}
}

module Mount(){

Base_Rad=(Height-Sphere_Diameter/2-(Sphere_Diameter/2*cos(Angle))-Thickness)/(1+cos(Angle));

//uncomment for printing
translate([0,(Sphere_Diameter/2*sin(Angle)+sin(Angle)*Base_Rad)*Central_Base_Multiplier*2,0])

//Base with ball pivot
union(){
	//ball for clip
	translate([0,0,Height-Sphere_Diameter/2])
	sphere(r=Sphere_Diameter/2);
	
	//post for ball
	difference(){
		translate([0,0,Thickness-Padding])
		cylinder(r1=Sphere_Diameter/2*sin(Angle)+sin(Angle)*Base_Rad, r2=Sphere_Diameter/2*sin(Angle), h=Height-Sphere_Diameter/2-(Sphere_Diameter/2*cos(Angle))-Thickness+Padding*2);
		rotate_extrude()
		translate([Sphere_Diameter/2*sin(Angle)+sin(Angle)*Base_Rad,Base_Rad+Thickness+Padding,0])
		//rotate([90,0,0])
		circle(r=Base_Rad+Padding);
	}
	
	//base
	difference(){
		hull(){
			translate([Screw_Distance,0,0])
			cylinder(r=Screw_Head_Diameter/2*Screw_Base_Multiplier,h=Thickness);
			cylinder(r=(Sphere_Diameter/2*sin(Angle)+sin(Angle)*Base_Rad)*Central_Base_Multiplier,h=Thickness);
			translate([-Screw_Distance,0,0])
			cylinder(r=Screw_Head_Diameter/2*Screw_Base_Multiplier,h=Thickness);
		}
		
		//screws
		translate([-Screw_Distance,0,Thickness])
		rotate([180,0,0])
		screw_hole(Thickness);
		translate([Screw_Distance,0,Thickness])
		rotate([180,0,0])
		screw_hole(Thickness);
	}
}	
}

module nut(){
	cylinder(r=(Nut_Width/2+Clearance)/cos(30),h=Nut_Height+Clearance,$fn=6);
}

module screw_hole(L){
 	translate([0,0,-Padding])
	union() {
   	polyhole(L+Padding*2, Screw_Shaft_Diameter);
      polyhole(Screw_Head_Height, Screw_Head_Diameter);
		if (Countersink == 1) 
			{translate([0,0,Screw_Head_Height-Padding])
			polycone(Screw_Head_Diameter/2-Screw_Shaft_Diameter/2+Padding, Screw_Head_Diameter, Screw_Shaft_Diameter);
			}
    }
};

module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

module polycone(h, d1, d2) {
    n = max(round(2 * d1),3);
    rotate([0,0,0])
        cylinder(h = h, r1 = (d1 / 2) / cos (180 / n), r2 = (d2 / 2) / cos (180 / n),$fn = n);
}
