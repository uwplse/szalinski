// Laminar Flow Pond Pump Hose Splitter Adapter
// This will take a pond pump and split the output into multiple hoses.
// The unique part of this item is it creates laminar flow streams before the splitting occurs over smooth transitions into the smaller sized hoses. This should reduce water flow drop.

// Created by Mike Creuzer Feb 2013 thingiverse@creuzer.com
// Using Customizable Honeycomb Pencil Holder by IWorkInPixels http://www.thingiverse.com/thing:41703

// Tubing
// Tubing Outer Diameter
TubingOD = 6;
//Tubing Inner Diameter
TubingID  = 4;

// Create the base 
// Diameter of the pump outlet
PumpHousingHole = 19;
// Height (Base height to clear the pump housing; may be adjusted by rounded top)
height = 40; 
// How thick the walls will be
WallThickness = 2; // Even numbers of your printer's print thread width would give good results.

//Laminar Flow Generator
// Honeycomb Radius (hexes from center to outside of holder)
honeycomb_radius = 2; //[2:5]

// Floor Thickness
floor_thickness = 0; //[0:5]
// The value that the honeycomb_radius is a fudge factor to allow for good wall thicknesses on the outside of the honeycomb mesh. this may need to be replaced with a true cylindar
HexMath = PumpHousingHole * .5 / (3 * honeycomb_radius);

// Inner Smoothing for the output end.
smooth = 180; // Number of facets of rounding cylinder 360 is smooth but slow rendering



Base();
translate([0,0,height]) ReducerCone (3);
// Print Support Beam
linear_extrude(height=height + PumpHousingHole + 3){hexagon(HexMath*1.2);} // base




module ReducerCone (count)
{
	difference()
	{
	
		for ( i = [1 : count] )
		{
			// Outer Cones
			rotate(a= i * 360 / count) hull()
			{
				cylinder(r=PumpHousingHole * .5, h=.01);
		 		translate([0, (PumpHousingHole - TubingOD) * .5 , PumpHousingHole + TubingOD])  cylinder(r=(TubingOD + WallThickness) * .5, h=.01);
			}
			// tube sockets OD
			rotate(a= i * 360 / count) translate([0, (PumpHousingHole - TubingOD) * .5 , PumpHousingHole + TubingOD])  cylinder(r=(TubingOD + WallThickness) * .5, h=TubingOD);
		}
	
		for ( i = [1 : count] )
		{
			// Inner  Cones
			rotate(a= i * 360 / count) hull()
			{
				cylinder(r=(PumpHousingHole - WallThickness) * .5, h=.01);
			 	translate([0, (PumpHousingHole - TubingOD) * .5 , PumpHousingHole + TubingOD])  cylinder(r=TubingID * .5, h=.01, $fn=smooth);
			}
			//Tube sockets ID
			rotate(a= i * 360 / count) translate([0, (PumpHousingHole - TubingOD) * .5 , PumpHousingHole + TubingOD])  cylinder(r=(TubingOD) * .5, h=TubingOD, $fn=smooth);

		}
	}
}


module Base()
{
	difference()
	{
		cylinder(r=PumpHousingHole * .5, h=height);
		translate([0,0,height - (height * .25)]) cylinder(r1=(PumpHousingHole - WallThickness) * .40, r2=(PumpHousingHole - WallThickness) * .5, h=height * .25);
	
		pencil_holder(honeycomb_radius, HexMath, height*2, height*2);
	}
	pencil_holder(honeycomb_radius, HexMath, height, floor_thickness);
}



module hexagon(radius){
	circle(r=radius,$fn=6);
}

module cell(radius, height, floor_thickness){
	difference(){
		linear_extrude(height=height){hexagon(radius*1.2);} // base
		translate([0,0,floor_thickness]) linear_extrude(height=height){hexagon(radius*1.1);} // hole
	}
}

module translate_to_hex(x_coord, y_coord, hex_width){
	x = x_coord*hex_width*1.75;
	y = (2*y_coord*hex_width)+(x_coord*hex_width);
	translate([x, y, 0]){
		child(0);
	}
}

module rounded_cap(radius, hex_width, height){
	difference(){
		translate([0,0,height]) cylinder(r=3*hex_width*radius,h=height *.75,center=true);
		translate([0,0,height/1.5]) scale([1,1,1/radius]) sphere(r=3*hex_width*radius,center=true);
	}
}


// This code section is by IWorkInPixels from http://www.thingiverse.com/thing:41703
module pencil_holder(radius, hex_width, height, floor_thickness){
	difference(){
		union(){
			for(x = [-radius:radius]){
				for(y = [-radius:radius]){
					assign(z=0-x-y){
						if(max(abs(x),abs(y),abs(z))<=radius){
							translate_to_hex(x, y, hex_width) cell(hex_width, height, floor_thickness);
						}
					}
				}
			}
		}
		rounded_cap(radius, hex_width, height);
	}
}

