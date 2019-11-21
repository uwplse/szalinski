// Totally insipred by Acarius10 (TV#91035)
// Additional options and rewrite by jeremie.francois@gmail.com / tridimake.com
// Rev. 20181217-081808 permuted set screw radius & width

//Variables

// preview[view:north east, tilt:side]

//The units of your drill bit.
Drill_Bit_Diameter_Units=1; //[1: Millimeter, 2:Inches]

//Diameter of the drill bit.  Only accepts Decimals. No Fractions
Drill_Bit_Diameter=7.65;  // M3tap=3.45, hexbits=7.50

//Drill bit sides (0=round, 4, 6=hex...)
Drill_Bit_Sides= 6;

//Drill bit length: How far do you want the drill bit to go into the handle
Drill_Bit_Length=10;

//Length of the handle
Handle_Length=40;

//Diameter of the handle
Handle_Diameter=24;

//Number of nut traps
Number_of_Nut_Traps=1;

//Diameter of the set screw (width)
Set_Screw_Diameter=3;

//Number of faces of the set screw nut (usually 4 or 6)
Set_Screw_Sides= 4;

//Thickness of the set screw nut
Set_Screw_Nut_Thickness=2.5; 

//Diameter of the set screw nut (side to side for a 4-side nut, else outer diameter for a hex nut)
Set_Screw_Nut_Diameter=5.6;

// Hole for a leech or a bar in the handle
StringHoleDiameter=5;

//The overall resolution of the handle (1 is good, use 2+ for faster previews)
Resolution=2; 

// If you want to embed a magnet: cylindrical diameter
IncludedMagnetDiameter= 5;

// Magnet height
IncludedMagnetHeight= 4.8;

// This is useful to leave a minimum thickness below the magnet
layer_th= 0.4;

//Ignore these variables
db_l= Drill_Bit_Length;
db_r= (Drill_Bit_Diameter * (Drill_Bit_Diameter_Units==1 ? 1.0 : 25.4)) / 2;
ss_r= Set_Screw_Diameter/2;
ss_nt= Set_Screw_Nut_Thickness;
ss_nr= Set_Screw_Nut_Diameter/2;
hl= Handle_Length;
hr= Handle_Diameter/2;
db_dr= 1+0; // wall thickness from set screw nut to drill bit

$fs= Resolution;
$fa= Resolution;
tol=0.01*1;

Drill_Bit_Handle();

module nut(radius, height, sides=6) 
{
  linear_extrude(height=height)
  {
		if(sides==6)
			circle(r=radius,$fn=sides);
		else
			square(radius*2,center=true);
	}
}

module nut_hole()
{
	hull()
		for(dz=[0,ss_nt+10])
			translate([dz,0, db_r + db_dr])
				nut(radius= ss_nr, height= ss_nt, sides= Set_Screw_Sides);
	cylinder(r= ss_r, h= hr+1);
}

module nut_traps()
{
	for(nut_r=[0:360/Number_of_Nut_Traps:359])
	{
		rotate([0,0,nut_r])
			translate([0, 0, ss_nt*2+1])
				rotate([0,90,0])
		{
			nut_hole();
		}
	}
}

module grooves()
{
	//This is the horizontal toric groove on the bottom of the handle
	translate([0,0,ss_nt*2+15])
		rotate_extrude(convexity= 10)
			translate([hr + 7.45, 0, 0])
				circle(r = 10);

	//Vertical grooves in the handle
	for(g=[0,1])
		for (i=[0:3])
			rotate([0,0,g*360/6 + i*360/3])
				translate([0, hr + 2 + g*5.5, ss_nt+17])
					cylinder(h=hl-ss_nt, r= 3 + g*7);
}

module Drill_Bit_Handle()
{
	difference(){
	
		//Main Body of the Drill Bit Handle
		hull()
		{
			// Top
			translate([0,0,hl])
				sphere(hr);
			// Rounded bottom
			translate([0,0,2])
				rotate_extrude(convexity= 10)
					translate([hr-4, 0, 0])
						circle(r=2);
		}

		//Hole for Drill Bit
		translate([0,0,-tol])
			rotate([0,0,Drill_Bit_Sides==6 ? 30 : (Drill_Bit_Sides==4 ? 45 : 0)])
		{
			if(Drill_Bit_Sides<=0)
				cylinder(r=db_r, h= db_l+tol); 
			else
				cylinder(r=db_r, h= db_l+tol, $fn=Drill_Bit_Sides); 
		}
		if(IncludedMagnetDiameter>0 && IncludedMagnetHeight>0)
		{
			translate([0,0,db_l+layer_th])
				cylinder(r=IncludedMagnetDiameter/2,IncludedMagnetHeight);
		}
		

		// Grooves for the Handle
		grooves();
		
		//Nut Traps
		if(Number_of_Nut_Traps>0)
			nut_traps();
		
		if(StringHoleDiameter>0)
		{
			translate([0,0,hl])
				rotate([90,0,0])
					cylinder(r=StringHoleDiameter/2, h=hr*2+2*tol, center=true);
		}
	}
}
