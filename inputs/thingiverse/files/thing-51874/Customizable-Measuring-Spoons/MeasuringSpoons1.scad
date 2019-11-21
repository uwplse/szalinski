include <write/Write.scad>


/////////////////////////////
// Customizer configurations
/////////////////////////////

// preview[view:south, tilt:top diagonal]

// On extrusion printers, nestable type must be printed with support material.
Type=0; // [0:Flat on counter,1:Nestable,2:Sweep,3:Ring coupler]

Units=2; // [0:Milliliters,1:U.S. Ounces,2:U.S. Teaspoons,3:U.S. Tablespoons,4:Imperial Ounces,5:Imperial Teaspoons,6:Imperial Tablespoons]

// How many of the selected units should it hold?
Size=1;

// Optional text
Label="Spoon!";

Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]

// Wall thickness in millimeters
Thickness=3; // [2:5]



/////////////////////////////
// Advanced configurations
/////////////////////////////

TextThickness=1.5*1;		// Raised text height in mm
HandleWidth=15*1;			// Width of the handle in mm
HandleLength=90*1;		// Length of handle in millimetes including rounded ends
TextHeight=6*1;			// Distance from bottom to top of character in mm
HoleDiameter=5*1;			// Diameter of hole in handle in mm



/////////////////////////////
// Calculations
/////////////////////////////

Conversion=[1,29.5735,4.92892,14.7868,28.4131,5.91939,17.7582];	// To convert to mL
Volume=Size*Conversion[Units];
InsideRadius=pow((3 * Volume) / (2 * 3.14), 1/3)*10;
OutsideRadius=InsideRadius+Thickness;
ConeBottomRadius=OutsideRadius*.5;
ConeTopRadius=OutsideRadius*.85;
ConeHeight=OutsideRadius*.5;



/////////////////////////////
// Flat on counter
/////////////////////////////

if (Type==0)
{
rotate (a = [0, 0, 45]) 
{
difference()
{
union()
{
	// Text
	translate([HandleLength/2 - HandleWidth*.75 - 
	  len(Label)*TextHeight*.125*5.5/2,0,Thickness - 0.001 + TextThickness/2])
	  write(Label,t=TextThickness,h=TextHeight,center=true,font=Font);
	
	// Cube in center of handle
	translate([0,0,Thickness/2])
	  cube([HandleLength-HandleWidth, HandleWidth, Thickness], center=true);
	
	// Cylinder at handle end
	translate([HandleLength/2 - HandleWidth/2 + 0.001, 0, Thickness/2])
	  cylinder(h=Thickness, r=HandleWidth/2, center=true);
	
	// Cylinder at bowl end
	translate([0 - (HandleLength/2 - HandleWidth/2 + 0.001), 0, Thickness/2])
	  cylinder(h=Thickness, r=HandleWidth/2, center=true);

	// Cone under bowl
	translate([0 - (HandleLength/2 - HandleWidth/2 + 0.001), 0, ConeHeight/2])
		cylinder(h=ConeHeight, r1=ConeBottomRadius, r2=ConeTopRadius,
			center=true);
	
	difference()
	{
		// Bowl outside
		translate([0 - (HandleLength/2 - HandleWidth/2), 0, OutsideRadius])
		  sphere(r=OutsideRadius, $fn=50);
		
		// Truncating cube
		translate([0 - (HandleLength/2 - HandleWidth/2), 0, OutsideRadius*2.5])
		  cube([OutsideRadius*3, OutsideRadius*3, OutsideRadius*3],
			 center=true);
	
	}
}

// Bowl inside
translate([0 - (HandleLength/2 - HandleWidth/2), 0,
	OutsideRadius+.002])
		sphere(r=InsideRadius, $fn=50);	

// Hole in handle
translate([HandleLength/2 - HandleWidth/2 + 0.002, 0, Thickness/2])
  cylinder(h=Thickness*2, r=HoleDiameter/2, $fn=15, center=true);
}
}
}


/////////////////////////////
// Nestable
/////////////////////////////

if (Type==1)	
{
translate([0,0,OutsideRadius])
{
rotate (a = [180, 0, 45]) 
{
difference()
{
union()
{
	// Text
	rotate (a = [180, 0, 0]) 
	{
		translate([HandleLength/2 - HandleWidth*.75 - 
	  			len(Label)*TextHeight*.125*5.5/2,0,Thickness - 0.001 +
				TextThickness/2 - OutsideRadius])
	  		write(Label,t=TextThickness,h=TextHeight,center=true,font=Font);
	}
	// Cube in center of handle
	translate([0,0,OutsideRadius - Thickness/2])
	  cube([HandleLength-HandleWidth, HandleWidth, Thickness], center=true);
	
	// Cylinder at handle end
	translate([HandleLength/2 - HandleWidth/2 + 0.001, 0, OutsideRadius - Thickness/2])
	  cylinder(h=Thickness, r=HandleWidth/2, center=true);
	
	difference()
	{
		// Bowl outside
		translate([0 - (HandleLength/2 - HandleWidth/2), 0, OutsideRadius])
		  sphere(r=OutsideRadius, $fn=50);
		
		// Truncating cube
		translate([0 - (HandleLength/2 - HandleWidth/2), 0, OutsideRadius*2.5])
		  cube([OutsideRadius*3, OutsideRadius*3, OutsideRadius*3],
			 center=true);
	
	}
}

// Bowl inside
translate([0 - (HandleLength/2 - HandleWidth/2), 0,
	OutsideRadius+.002])
		sphere(r=InsideRadius, $fn=50);	

// Hole in handle
translate([HandleLength/2 - HandleWidth/2 + 0.002, 0, OutsideRadius - Thickness/2])
  cylinder(h=Thickness*2, r=HoleDiameter/2, $fn=15, center=true);
}
}
}
}


/////////////////////////////
// Sweep
/////////////////////////////

if (Type==2)	
{
rotate (a = [0, 0, 45]) 
{
difference()
{
union()
{
	// Text
	translate([HandleLength/2 - HandleWidth*.75 - 
	  len(Label)*TextHeight*.125*5.5/2,0,Thickness - 0.001 + TextThickness/2])
	  write(Label,t=TextThickness,h=TextHeight,center=true,font=Font);
	
	// Cube in center of handle
	translate([0,0,Thickness/2])
	  cube([HandleLength-HandleWidth, HandleWidth, Thickness], center=true);
	
	// Cylinder at handle end
	translate([HandleLength/2 - HandleWidth/2 + 0.001, 0, Thickness/2])
	  cylinder(h=Thickness, r=HandleWidth/2, center=true);
	
	// Cylinder at bowl end
	translate([0 - (HandleLength/2 - HandleWidth/2 + 0.001), 0, Thickness/2])
	  cylinder(h=Thickness, r=HandleWidth/2, center=true);
}

// Hole in handle
translate([HandleLength/2 - HandleWidth/2 + 0.002, 0, Thickness/2])
  cylinder(h=Thickness*2, r=HoleDiameter/2, $fn=15, center=true);
}
}
}


/////////////////////////////
// Ring coupler
/////////////////////////////

if (Type==3)	
{
	difference()
	{
		translate([0,0,13/2])
			cylinder(h=13, r=4, $fn=15, center=true);
	
		translate([0,0,13/2])
			cylinder(h=15, r=1.15, $fn=15, center=true);
	}
}
