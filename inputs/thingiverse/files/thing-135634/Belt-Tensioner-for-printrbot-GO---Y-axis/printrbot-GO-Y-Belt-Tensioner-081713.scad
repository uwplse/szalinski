//Printrbot GO Y-axis Belt Tensioner by John Davis 8-17-13
//Polyhole module by nophead


// Which part would you like to make?
part = "All"; // [Wedge: Belt Grip Wedge,Tensioner,Mount, All]

/*[Belt Type]*/
//Standard or GT2
Belt_Type="GT2"; //[Standard,GT2]

/*[Mount Dimensions]*/
//Height of mount
Mount_Height=11;
//Width of mount (parallel with belt)
Mount_Width=18;
//Thickness at mounting holes
Mount_Thickness=2.6;
//Distance between mounting holes
Mount_Separation=18.8;
//Mount screw holes
Mount_Hole_Diameter=3.6;
//Distance between adjusting bolts
Adjusting_Separation=14.8;
//Material supporting nut
Nut_Support=3;

/*[Adjusting Bolt and Trapped Nut Dimensions]*/
//Adjusting screw holes
Adjusting_Hole_Diameter=3.2;
//Nut width across flats
Nut_Width=5.5;
//Nut height   
Nut_Height=2.4;
//Additional clearance for nut
Clearance=0.2; 

/*[Printer Settings]*/
//To control the number facets rendered, fine ~ 0.1 coarse ~1.0. 0.3 is fine for home printers.
$fs = 0.3;

/*[Hidden]*/
//leave $fn disabled, do not change
$fn = 0;
//leave $fa as is, do not change
$fa = 0.01;
//padding to insure manifold, ignore
Padding = 0.01; 

Belt0_Min_Thickness=1.2;
Belt0_Max_Thickness=2.4;
Belt0_Teeth_Spacing=5;
Belt0_Tooth_Width=2.3;
Belt0_Height=6.3;
Shift0=0.15;

Belt1_Min_Thickness=0.9;
Belt1_Max_Thickness=1.6;
Belt1_Teeth_Spacing=2;
Belt1_Tooth_Width=1.3;
Belt1_Height=6.1;
Shift1=0.2;

/****************/


print_part();

module print_part() {
	if (part == "Wedge") {
		Belt_Grip_Wedge();
	} else if (part == "Tensioner") {
		Tensioner();
	} else if (part == "Mount") {
		Mount();
	} else {
		Belt_Grip_Wedge();
		Tensioner();
		Mount();
	}
}

module Belt_Grip_Wedge(){
//Belt grip wedge	
if(Belt_Type=="GT2"){
	
	//uncomment for exploded view
	//translate([-(Belt1_Height+3)/2,13.5,Mount_Height/2])
	//rotate([0,90,0])
	
	//uncomment for printing
	translate([10,10,0])
	
	difference(){	
		linear_extrude(height=Belt1_Height+3)
		polygon(points=[[-Belt1_Max_Thickness/2-1,-(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2],[-Belt1_Max_Thickness/2-1.5,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2],[Belt1_Max_Thickness/2+1.5,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2],[Belt1_Max_Thickness/2+1,-(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2]]);
		
		//channel for belt
		difference(){
			translate([Shift1,0,(Belt1_Height+4.5)/2+1.5])
			cube([Belt1_Max_Thickness,4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2*Padding,Belt1_Height+3+Padding],center=true);
			translate([-Belt1_Max_Thickness/2+Belt1_Min_Thickness+Shift1,-2*Belt1_Teeth_Spacing+Belt1_Tooth_Width/2,1.5])
			cube([Belt1_Max_Thickness-Belt1_Min_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Height+1.5+Padding]);
			translate([-Belt1_Max_Thickness/2+Belt1_Min_Thickness+Shift1,-1*Belt1_Teeth_Spacing+Belt1_Tooth_Width/2,1.5])
			cube([Belt1_Max_Thickness-Belt1_Min_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Height+1.5+Padding]);
			translate([-Belt1_Max_Thickness/2+Belt1_Min_Thickness+Shift1,Belt1_Tooth_Width/2,1.5])
			cube([Belt1_Max_Thickness-Belt1_Min_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Height+1.5+Padding]);
			translate([-Belt1_Max_Thickness/2+Belt1_Min_Thickness+Shift1,1*Belt1_Teeth_Spacing+Belt1_Tooth_Width/2,1.5])
			cube([Belt1_Max_Thickness-Belt1_Min_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Height+1.5+Padding]);
		}

		//bevel for channel opening
		translate([Shift1,0,Belt1_Height+3])
		rotate([90,45,0])
		cube([2,2,4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2*Padding], center=true);
	}
}

if(Belt_Type=="Standard"){
	
	//uncomment for exploded view
	//translate([-(Belt0_Height+3)/2,20,Mount_Height/2])
	//rotate([0,90,0])

	//uncomment for printing
	translate([10,12,0])	

	difference(){	
		linear_extrude(height=Belt0_Height+3)
		polygon(points=[[-Belt0_Max_Thickness/2-1,-(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2],[-Belt0_Max_Thickness/2-1.5,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2],[Belt0_Max_Thickness/2+1.5,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2],[Belt0_Max_Thickness/2+1,-(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2]]);
		
		//channel for belt
		difference(){
			translate([Shift0,0,(Belt0_Height+4.5)/2+1.5])
			cube([Belt0_Max_Thickness,3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2*Padding,Belt0_Height+3+Padding],center=true);
			translate([-Belt0_Max_Thickness/2+Belt0_Min_Thickness+Shift0,-3*Belt0_Teeth_Spacing/2+Belt0_Tooth_Width/2,1.5])
			cube([Belt0_Max_Thickness-Belt0_Min_Thickness,Belt0_Teeth_Spacing-Belt0_Tooth_Width,Belt0_Height+1.5+Padding]);
			translate([-Belt0_Max_Thickness/2+Belt0_Min_Thickness+Shift0,-Belt0_Teeth_Spacing/2+Belt0_Tooth_Width/2,1.5])
			cube([Belt0_Max_Thickness-Belt0_Min_Thickness,Belt0_Teeth_Spacing-Belt0_Tooth_Width,Belt0_Height+1.5+Padding]);
			translate([-Belt0_Max_Thickness/2+Belt0_Min_Thickness+Shift0,Belt0_Teeth_Spacing/2+Belt0_Tooth_Width/2,1.5])
			cube([Belt0_Max_Thickness-Belt0_Min_Thickness,Belt0_Teeth_Spacing-Belt0_Tooth_Width,Belt0_Height+1.5+Padding]);

		}

		//bevel for channel opening
		translate([Shift0,0,Belt0_Height+3])
		rotate([90,45,0])
		cube([2.4,2.4,3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2*Padding], center=true);
	}
}
}

module Tensioner(){
//Tensioner
if(Belt_Type=="GT2"){

	//uncomment for printing, leave commented for exploded view
	translate([0,0,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2)/2])
	rotate([90,0,0])
	
	difference(){
		hull(){
		translate([-Adjusting_Separation/2,0,Mount_Height/2])
		rotate([-90,0,0])
		cylinder(r=Mount_Height/2, h=4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2, center=true);
		translate([Adjusting_Separation/2,0,Mount_Height/2])
		rotate([-90,0,0])
		cylinder(r=Mount_Height/2, h=4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2, center=true);
		}
		
		//slot for wedge
		translate([(Belt1_Height+3.4)/2,1.2,Mount_Height/2])
		rotate([0,-90,0])
		linear_extrude(height=Belt1_Height+3.4)
		polygon(points=[[-Belt1_Max_Thickness/2-1.2,-(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2-0.2],[-Belt1_Max_Thickness/2-1.7,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2+0.2],[Belt1_Max_Thickness/2+1.7,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2+0.2],[Belt1_Max_Thickness/2+1.2,-(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2-0.2]]);

		//slot for belt
		translate([0,0,Mount_Height/2])
		cube([Belt1_Height+1,4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2+2*Padding,Belt1_Max_Thickness+1], center=true); 

		//hole for adjusting bolt #1
		translate([-Adjusting_Separation/2,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2+2*Padding)/2,Mount_Height/2])
		rotate([90,0,0])
		polyhole(Adjusting_Hole_Diameter,4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2+2*Padding);
	
		//hole for adjusting bolt #2
		translate([Adjusting_Separation/2,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2+2*Padding)/2,Mount_Height/2])
		rotate([90,0,0])
		polyhole(Adjusting_Hole_Diameter,4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2+2*Padding);
	}
}

if(Belt_Type=="Standard"){
	
	//uncomment for printing, leave commented for exploded view
	translate([0,0,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2)/2])
	rotate([90,0,0])

	difference(){
		hull(){
		translate([-Adjusting_Separation/2,0,Mount_Height/2])
		rotate([-90,0,0])
		cylinder(r=Mount_Height/2, h=3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2, center=true);
		translate([Adjusting_Separation/2,0,Mount_Height/2])
		rotate([-90,0,0])
		cylinder(r=Mount_Height/2, h=3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2, center=true);
		}
		
		//slot for wedge
		translate([(Belt0_Height+3.4)/2,1.2,Mount_Height/2])
		rotate([0,-90,0])
		linear_extrude(height=Belt0_Height+3.4)
		polygon(points=[[-Belt0_Max_Thickness/2-1.2,-(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2-0.2],[-Belt0_Max_Thickness/2-1.7,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2+0.2],[Belt0_Max_Thickness/2+1.7,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2+0.2],[Belt0_Max_Thickness/2+1.2,-(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2-0.2]]);

		//slot for belt
		translate([0,0,Mount_Height/2])
		cube([Belt0_Height+2,3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2+2*Padding,Belt0_Max_Thickness+1], center=true); 

		//hole for adjusting bolt #1
		translate([-Adjusting_Separation/2,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2+2*Padding)/2,Mount_Height/2])
		rotate([90,0,0])
		polyhole(Adjusting_Hole_Diameter,3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2+2*Padding);
	
		//hole for adjusting bolt #2
		translate([Adjusting_Separation/2,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2+2*Padding)/2,Mount_Height/2])
		rotate([90,0,0])
		polyhole(Adjusting_Hole_Diameter,3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2+2*Padding);
	}
}
}

module Mount(){

//uncomment for printing
translate([-8,8,(Mount_Separation+2*Mount_Hole_Diameter)/2])
rotate([0,-90,-90])

//uncomment for exploded view
//translate([0,30,0])

//Mount

	difference(){
		translate([0,0,Mount_Height/2])
		cube([Mount_Separation+2*Mount_Hole_Diameter,Mount_Width, Mount_Height], center=true);

		//trapped nut #1
		union(){
			translate([-Adjusting_Separation/2,-Mount_Width/2+Nut_Support,Mount_Height/2])
			rotate([-90,0,0])
			nut();
			translate([-Adjusting_Separation/2,-Mount_Width/2+Nut_Support,Mount_Height/2-Nut_Width/2-Clearance])
			cube([(Nut_Width/2+Clearance)/cos(30),Nut_Height,Nut_Width+2*Clearance]);
		}

		//trapped nut #2
		union(){
			translate([Adjusting_Separation/2,,-Mount_Width/2+Nut_Support,Mount_Height/2])
			rotate([-90,0,0])
			nut();
			translate([Adjusting_Separation/2,-Mount_Width/2+Nut_Support,Mount_Height/2-Nut_Width/2-Clearance])
			cube([(Nut_Width/2+Clearance)/cos(30),Nut_Height,Nut_Width+2*Clearance]);
		}

if(Belt_Type=="GT2"){		
		//slot for belt
		translate([0,0,Mount_Height/2])
		cube([Belt1_Height+1,Mount_Width+2*Padding,Belt1_Max_Thickness+1], center=true); 
}

if(Belt_Type=="Standard"){		
		//slot for belt
		translate([0,0,Mount_Height/2])
		cube([Belt0_Height+2,Mount_Width+2*Padding,Belt0_Max_Thickness+1], center=true); 
}
		
		
		//mounting hole #1
		translate([-Mount_Separation/2,Mount_Width/2-Mount_Hole_Diameter,-Padding])
		cylinder(r=Mount_Hole_Diameter/2,h=Mount_Height+2*Padding);
		translate([-Mount_Separation/2,Mount_Width/2-Mount_Hole_Diameter,Mount_Thickness])
		cylinder(r=4.5,h=Mount_Height-Mount_Thickness+2*Padding);
		
		//mounting hole #2
		translate([Mount_Separation/2,Mount_Width/2-Mount_Hole_Diameter,-Padding])
		cylinder(r=Mount_Hole_Diameter/2,h=Mount_Height+2*Padding);
		translate([Mount_Separation/2,Mount_Width/2-Mount_Hole_Diameter,Mount_Thickness])
		cylinder(r=4.5,h=Mount_Height-Mount_Thickness+2*Padding);
			
		//hole for adjusting bolt #1
		translate([-Adjusting_Separation/2,-Mount_Width/2-Padding,Mount_Height/2])
		rotate([-90,0,0])
		cylinder(r=Adjusting_Hole_Diameter/2,h=Mount_Width+Padding*2);
		//hole for adjusting bolt #2
		translate([Adjusting_Separation/2,-Mount_Width/2-Padding,Mount_Height/2])
		rotate([-90,0,0])
		cylinder(r=Adjusting_Hole_Diameter/2,h=Mount_Width+Padding*2);
	
		//cut away
		hull(){
			translate([-Mount_Separation/2-Mount_Hole_Diameter-Padding,Mount_Width/2,Mount_Height])
			rotate([0,90,0])
			cylinder(r=Mount_Height-Mount_Thickness, h=Mount_Separation+2*Mount_Hole_Diameter+2*Padding);
			translate([-Mount_Separation/2-Mount_Hole_Diameter-Padding,-Mount_Width/2+Nut_Support+Nut_Height+Mount_Height-Mount_Thickness+1,Mount_Height])
			rotate([0,90,0])
			cylinder(r=Mount_Height-Mount_Thickness, h=Mount_Separation+2*Mount_Hole_Diameter+2*Padding);
		}

if(Belt_Type=="GT2"){
		//channel for belt
		difference(){
			translate([0,-Mount_Width/2-Padding,-Belt1_Max_Thickness/4])
			rotate([-90,0,0])
			linear_extrude(height=Mount_Width+2*Padding)
		polygon(points=[[-Belt1_Height/2-Belt1_Max_Thickness,0],[-Belt1_Height/2,-Belt1_Max_Thickness],[Belt1_Height/2,-Belt1_Max_Thickness],[Belt1_Height/2+Belt1_Max_Thickness,0]]);
			translate([-Belt1_Height/2-Belt1_Max_Thickness,Mount_Width/2-Belt1_Teeth_Spacing+Belt1_Tooth_Width,3*Belt1_Min_Thickness/4])
			cube([Belt1_Height+2*Belt1_Max_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Max_Thickness-Belt1_Min_Thickness+Padding]);
			translate([-Belt1_Height/2-Belt1_Max_Thickness,Mount_Width/2-2*Belt1_Teeth_Spacing+Belt1_Tooth_Width,3*Belt1_Min_Thickness/4])
			cube([Belt1_Height+2*Belt1_Max_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Max_Thickness-Belt1_Min_Thickness+Padding]);
			translate([-Belt1_Height/2-Belt1_Max_Thickness,Mount_Width/2-3*Belt1_Teeth_Spacing+Belt1_Tooth_Width,3*Belt1_Min_Thickness/4])
			cube([Belt1_Height+2*Belt1_Max_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Max_Thickness-Belt1_Min_Thickness+Padding]);
			translate([-Belt1_Height/2-Belt1_Max_Thickness,Mount_Width/2-4*Belt1_Teeth_Spacing+Belt1_Tooth_Width,3*Belt1_Min_Thickness/4])
			cube([Belt1_Height+2*Belt1_Max_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Max_Thickness-Belt1_Min_Thickness+Padding]);
			translate([-Belt1_Height/2-Belt1_Max_Thickness,Mount_Width/2-5*Belt1_Teeth_Spacing+Belt1_Tooth_Width,3*Belt1_Min_Thickness/4])
			cube([Belt1_Height+2*Belt1_Max_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Max_Thickness-Belt1_Min_Thickness+Padding]);
			translate([-Belt1_Height/2-Belt1_Max_Thickness,Mount_Width/2-6*Belt1_Teeth_Spacing+Belt1_Tooth_Width,3*Belt1_Min_Thickness/4])
			cube([Belt1_Height+2*Belt1_Max_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Max_Thickness-Belt1_Min_Thickness+Padding]);
			translate([-Belt1_Height/2-Belt1_Max_Thickness,Mount_Width/2-7*Belt1_Teeth_Spacing+Belt1_Tooth_Width,3*Belt1_Min_Thickness/4])
			cube([Belt1_Height+2*Belt1_Max_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Max_Thickness-Belt1_Min_Thickness+Padding]);
			translate([-Belt1_Height/2-Belt1_Max_Thickness,Mount_Width/2-8*Belt1_Teeth_Spacing+Belt1_Tooth_Width,3*Belt1_Min_Thickness/4])
			cube([Belt1_Height+2*Belt1_Max_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Max_Thickness-Belt1_Min_Thickness+Padding]);
			translate([-Belt1_Height/2-Belt1_Max_Thickness,Mount_Width/2-9*Belt1_Teeth_Spacing+Belt1_Tooth_Width,3*Belt1_Min_Thickness/4])
			cube([Belt1_Height+2*Belt1_Max_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Max_Thickness-Belt1_Min_Thickness+Padding]);			

		}
}

if(Belt_Type=="Standard"){
		//channel for belt
		difference(){
			translate([0,-Mount_Width/2-Padding,-Belt0_Max_Thickness/4])
			rotate([-90,0,0])
			linear_extrude(height=Mount_Width+2*Padding)
		polygon(points=[[-Belt0_Height/2-Belt0_Max_Thickness,0],[-Belt0_Height/2,-Belt0_Max_Thickness],[Belt0_Height/2,-Belt0_Max_Thickness],[Belt0_Height/2+Belt0_Max_Thickness,0]]);
			translate([-Belt0_Height/2-Belt0_Max_Thickness,Mount_Width/2-Belt0_Teeth_Spacing+Belt0_Tooth_Width,3*Belt0_Min_Thickness/4])
			cube([Belt0_Height+2*Belt0_Max_Thickness,Belt0_Teeth_Spacing-Belt0_Tooth_Width,Belt0_Max_Thickness-Belt0_Min_Thickness+Padding]);
			translate([-Belt0_Height/2-Belt0_Max_Thickness,Mount_Width/2-2*Belt0_Teeth_Spacing+Belt0_Tooth_Width,3*Belt0_Min_Thickness/4])
			cube([Belt0_Height+2*Belt0_Max_Thickness,Belt0_Teeth_Spacing-Belt0_Tooth_Width,Belt0_Max_Thickness-Belt0_Min_Thickness+Padding]);
			translate([-Belt0_Height/2-Belt0_Max_Thickness,Mount_Width/2-3*Belt0_Teeth_Spacing+Belt0_Tooth_Width,3*Belt0_Min_Thickness/4])
			cube([Belt0_Height+2*Belt0_Max_Thickness,Belt0_Teeth_Spacing-Belt0_Tooth_Width,Belt0_Max_Thickness-Belt0_Min_Thickness+Padding]);
			translate([-Belt0_Height/2-Belt0_Max_Thickness,Mount_Width/2-4*Belt0_Teeth_Spacing+Belt0_Tooth_Width,3*Belt0_Min_Thickness/4])
			cube([Belt0_Height+2*Belt0_Max_Thickness,Belt0_Teeth_Spacing-Belt0_Tooth_Width,Belt0_Max_Thickness-Belt0_Min_Thickness+Padding]);
		}
}
	}			
}
/****************/

module nut(){
	cylinder(r=(Nut_Width/2+Clearance)/cos(30),h=Nut_Height,$fn=6);
}


module polyhole(d,h) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}


