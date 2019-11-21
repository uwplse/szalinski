//Articulated Ball Joint Fan Mount by John Davis (ei8htohms) 8-24-13
//Polyhole module by nophead

// Which part would you like to make?
part = "All"; // [Base,Clip,Duct,All]

/*[Dimensions of Base]*/
//Ratio of material around screws
Screw_Base_Multiplier = 1.8;
//Ratio of material around central base
Central_Base_Multiplier = 1;
//Height of mount base including sphere
Height = 24;
//Thickness of mount base
Thickness = 2;
//Sphere diameter
Sphere_Diameter = 16;
//How far are the mounting screws from the center?
Screw_Distance = 15;
//The angle of the base connection to the sphere (larger angle means fatter "neck")
Angle=45;

/*[Base Mounting Screw Dimensions]*/
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

/*[Dimensions of Clip]*/
//Space between inside of clip and ball joint
Clip_Clearance=0.3;
//Clip thickness (also determines duct wall thickness)
Clip_Thickness=1;
//Clip height
Clip_Height=8;
//Opening for clip compression
Opening=1.2;
//How far out does the clamp screw extend from the ball
Clamp_Extension=6;
//How far out does the elbow extend from the ball
Mount_Extension=18;

/*[Clamping Screw and Nut Dimensions]*/ 
//Clamping screw diameter
Clamping_Screw_Diameter=2.8;
//Nut width across flats
Nut_Width=4.7;
//Nut height   
Nut_Height=1.6;
//Additional clearance for nut
Nut_Clearance=0.2; 
//Vertical nut correction (to make it align with screw hole when printed)
Nut_Correction=-0.5;

/*[Arm with Duct Dimensions]*/
//Small Sphere Diameter
Small_Sphere_Diameter=12;
//Fan size 
Fan_Size=35;
//Fan screw diameter
Fan_Screw_Diameter=2.8;
//Clearance for fan screw head diameter
Fan_Screw_Head_Diameter=8;
//Duct height
Duct_Height=25;
//Duct scaling - how restrictive is the duct
Duct_Scaling=0.35;
//Duct wall thickness
Duct_Wall=0.52;


/*[Printer Settings]*/
//To control the number facets rendered, fine ~ 0.1 coarse ~1.0. 0.3 is fine for home printers.
$fs = 0.5;


/*[Hidden]*/
//leave $fn disabled, do not change
$fn = 0;
//leave $fa as is, do not change
$fa = 0.01;
//padding to insure manifold, ignore
Padding = 0.01; 

print_part();

module print_part() {
	if (part == "Base") {
		Base();
	} else if (part == "Clip") {
		Clip();
	} else if (part == "Duct") {
		Duct();
	} else {
		Base();
		Clip();
		Duct();
	}
}

module Duct()

//uncomment for assembled view
//translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension,0,Height-Sphere_Diameter/2-Small_Sphere_Diameter/2])

//uncomment for printable view
translate([Fan_Size/2,min(-Sphere_Diameter/2-Clip_Clearance-Clip_Thickness*3-Small_Sphere_Diameter,-Sphere_Diameter/2-Clip_Clearance-Clip_Thickness*3-Fan_Size/2),0])
rotate([0,0,180])

difference(){
	union(){
		translate([0,0,Small_Sphere_Diameter/2])
		sphere(r=Small_Sphere_Diameter/2);
		
		difference(){
			translate([0,0,Small_Sphere_Diameter/2])
			rotate([0,135,0])			
			cylinder(r=sqrt(pow(Small_Sphere_Diameter/2,2)/2),h=sqrt(pow(Small_Sphere_Diameter/2,2)*2));
			translate([0,0,Small_Sphere_Diameter/2])
			rotate([0,135,0])
			translate([0,0,3*sqrt(pow(Small_Sphere_Diameter/2,2)/2)/2])
			rotate_extrude()
			translate([3*sqrt(pow(Small_Sphere_Diameter/2,2)/2)/2,0,0])
			circle(r=3*sqrt(pow(Small_Sphere_Diameter/2,2)/2)/4);
			
			translate([Small_Sphere_Diameter/2,0,-Small_Sphere_Diameter/2])
			cylinder(r=Small_Sphere_Diameter/2,h=Small_Sphere_Diameter/2);
		}
		
		minkowski(){
			translate([Small_Sphere_Diameter/2+Fan_Size/2,0,Thickness/2-0.5])
			cube([Fan_Size-Fan_Size/5,Fan_Size-Fan_Size/5,Thickness-1],center=true);
			cylinder(r=Fan_Size/10,h=1);
		}
		
		difference(){
			translate([Small_Sphere_Diameter/2+Fan_Size/2,0,Thickness-Padding])
			cylinder(r1=Fan_Size/2,r2=Fan_Size/2*Duct_Scaling,h=Duct_Height);
			translate([0,0,Small_Sphere_Diameter/2])
			sphere(r=Small_Sphere_Diameter/2+Clip_Thickness*2);	
		}
		
	}

	translate([Small_Sphere_Diameter/2+Fan_Size/10,-Fan_Size/2+Fan_Size/10,-Padding])
	polyhole(Thickness+Padding*2+Duct_Height,Fan_Screw_Diameter);
	
	translate([Small_Sphere_Diameter/2+Fan_Size/10,Fan_Size/2-Fan_Size/10,-Padding])
	polyhole(Thickness+Padding*2,Fan_Screw_Diameter);
	
	translate([Small_Sphere_Diameter/2+Fan_Size-Fan_Size/10,-Fan_Size/2+Fan_Size/10,-Padding])
	polyhole(Thickness+Padding*2,Fan_Screw_Diameter);
	
	translate([Small_Sphere_Diameter/2+Fan_Size-Fan_Size/10,Fan_Size/2-Fan_Size/10,-Padding])
	polyhole(Thickness+Padding*2,Fan_Screw_Diameter);

//

	translate([Small_Sphere_Diameter/2+Fan_Size/10,-Fan_Size/2+Fan_Size/10,Thickness+Padding])
	cylinder(r=Fan_Screw_Head_Diameter/2, h=Duct_Height);
	
	translate([Small_Sphere_Diameter/2+Fan_Size/10,Fan_Size/2-Fan_Size/10,Thickness+Padding])
	cylinder(r=Fan_Screw_Head_Diameter/2, h=Duct_Height);
	
	translate([Small_Sphere_Diameter/2+Fan_Size-Fan_Size/10,-Fan_Size/2+Fan_Size/10,Thickness+Padding])
	cylinder(r=Fan_Screw_Head_Diameter/2, h=Duct_Height);
	
	translate([Small_Sphere_Diameter/2+Fan_Size-Fan_Size/10,Fan_Size/2-Fan_Size/10,Thickness+Padding])
	cylinder(r=Fan_Screw_Head_Diameter/2, h=Duct_Height);

	difference(){
		union(){
			translate([Small_Sphere_Diameter/2+Fan_Size/2,0,Thickness-Padding])
			cylinder(r1=Fan_Size/2-Duct_Wall,r2=(Fan_Size/2*Duct_Scaling)-Duct_Wall,h=Duct_Height+Padding);
		
			translate([Small_Sphere_Diameter/2+Fan_Size/2,0,-Padding])
			cylinder(r=Fan_Size/2-Duct_Wall,h=Thickness+2*Padding);
		}

		translate([0,0,Small_Sphere_Diameter/2])
		sphere(r=Small_Sphere_Diameter/2+Clip_Thickness*3);		


		translate([Small_Sphere_Diameter/2+Fan_Size/10,-Fan_Size/2+Fan_Size/10,-Padding])
		cylinder(r=Fan_Screw_Head_Diameter/2+Duct_Wall, h=Duct_Height);
	
		translate([Small_Sphere_Diameter/2+Fan_Size/10,Fan_Size/2-Fan_Size/10,-Padding])
		cylinder(r=Fan_Screw_Head_Diameter/2+Duct_Wall, h=Duct_Height);
	
		translate([Small_Sphere_Diameter/2+Fan_Size-Fan_Size/10,-Fan_Size/2+Fan_Size/10,-Padding])
		cylinder(r=Fan_Screw_Head_Diameter/2+Duct_Wall, h=Duct_Height);
	
		translate([Small_Sphere_Diameter/2+Fan_Size-Fan_Size/10,Fan_Size/2-Fan_Size/10,-Padding])
		cylinder(r=Fan_Screw_Head_Diameter/2+Duct_Wall, h=Duct_Height);
	}
}


module Clip(){

//uncomment for assembled view
//translate([0,0,Height-Sphere_Diameter/2-Clip_Height/2])

//uncomment for printable view
translate([-Fan_Size/2,0,0])

difference(){
	union(){
		intersection(){
			translate([0,0,Clip_Height/2])
			sphere(r=Sphere_Diameter/2+Clip_Clearance+Clip_Thickness);			
			cylinder(r=Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Padding,h=Clip_Height);		
		}
		
		translate([0,Opening/2,0])
		cube([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension,Clip_Thickness*3,Clip_Height]);
		
		intersection(){
			translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension,0,Clip_Height/2])
			sphere(r=Small_Sphere_Diameter/2+Clip_Clearance+Clip_Thickness);
			translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension,0,0])
			cylinder(r=Small_Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Padding, h=Clip_Height);
		}
			
		translate([0,-Opening/2-Nut_Height*3,0])
		cube([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension,Nut_Height*3,Clip_Height]);

	}

	translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Clamp_Extension,-Opening/2-2.5*Nut_Height-Nut_Clearance,Clip_Height/2+Nut_Correction])
	rotate([-90,0,0])
	nut();

	translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Clamp_Extension-(Nut_Width/2+Nut_Clearance)/cos(30),-Opening/2-2.5*Nut_Height-Nut_Clearance,Clip_Height/2+Nut_Correction])
	cube([(Nut_Width/2+Nut_Clearance)/cos(30)*2,Nut_Height+2*Nut_Clearance,Nut_Width/2+Nut_Clearance]);

	translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Clamp_Extension,-Opening/2-Nut_Height*3-Padding,Clip_Height/2])
	rotate([-90,0,0])
	cylinder(h= Nut_Height*3+Opening+Clip_Thickness*3+Padding*2, r=Clamping_Screw_Diameter/2);

	translate([0,-Opening/2,-Padding])
	cube([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Padding+Mount_Extension+Small_Sphere_Diameter/2+Clip_Clearance+Clip_Thickness,Opening,Clip_Height+Padding*2]);

	translate([0,0,Clip_Height/2])
	sphere(r=Sphere_Diameter/2+Clip_Clearance);

	translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension,0,Clip_Height/2])
	sphere(r=Small_Sphere_Diameter/2+Clip_Clearance);

	difference(){
		translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension,-Small_Sphere_Diameter/2-Clip_Clearance-Clip_Thickness-Padding,-Padding])
		cube([Small_Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Padding,2*(Small_Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Padding),Clip_Height+2*Padding]);
		translate([Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Mount_Extension,-Small_Sphere_Diameter/2-Clip_Clearance-Clip_Thickness-Padding,Clip_Height/2])
		rotate([-90,0,0])
		cylinder(r=Clip_Height/2,h=2*(Small_Sphere_Diameter/2+Clip_Clearance+Clip_Thickness+Padding));
	}

}
}

module Base(){

Base_Rad=(Height-Sphere_Diameter/2-(Sphere_Diameter/2*cos(Angle))-Thickness)/(1+cos(Angle));

//uncomment for printable view
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
	cylinder(r=(Nut_Width/2+Nut_Clearance)/cos(30),h=Nut_Height+2*Nut_Clearance,$fn=6);
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
