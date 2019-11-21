// Microscopy Hack-Stage
// hackteria.org
//
// by GaudiLabs
// Modified by dusjagr

/* Botes about screw dimensions
Screw_Diameter = 3; //[3:5] 4.6 for Taiwan 3/16x1/2"
Screw_Length = 12; //[8:24] 12 for Taiwan 3/16x1/2"
Nut_Height = 3; // 3.8 for Taiwan 3/16x1/2"
Nut_Width = 6; // 8 for Taiwan 3/16x1/2"
*/

//LABELS FOR CUSTOMIZER

// Adjust parameters here:

Output_Type = "STL"; //[DXF,STL]
Microscope_Width = 80; //[80:200]
Microscope_Depth = 90; //[80:150]
Microscope_Height = 44; //[28:120]

Object_Plate_Depth = 78; //[70:120]
Object_Plate_Width = 70; //[70:110]
Plate_Width=Object_Plate_Width+10;
Object_Hole_Width = 32; //[15:45]
Object_Hole_Depth = 20; //[15:40]

Wheel_Diameter = 22; //[20:50]

/*[Material]*/

Base_Material = 4;	//[3:8]
Plate_Material = 4;	//[2:6]
Screw_Diameter = 3; //
Screw_Length = 12; //
Nut_Height = 3; //
Nut_Width = 6; //

/*[Hidden]*/

Holder_Notch_Width=25;
Holder_Height=20;
Object_Hole_Position = 32;

$fs=0.1;

if(Output_Type=="single")
{
    BackPlate();
}

if(Output_Type=="STL")
{
rotate(90,[0,0,1])
union()
{
BasePlate();

translate([0,-Microscope_Depth/2+Base_Material+1+(Base_Material/2),(20/2)+(Base_Material/2)])
rotate(90,[1,0,0])
BackPlateHolder();


translate([0,-Microscope_Depth/2+1+(Base_Material/2),(Microscope_Height/2)+(Base_Material/2+2)])
rotate(90,[1,0,0])
BackPlate();


translate([0,-(Microscope_Depth-Object_Plate_Depth)/2+Base_Material+1,Holder_Height+Base_Material/2+1+Plate_Material/2+floor(((Microscope_Height-Holder_Height)*1/3)/10)*10+2
])
ObjectPlate();

translate([0,-(Microscope_Depth-Object_Plate_Depth)/2+Base_Material+1+Object_Plate_Depth/2-8,Holder_Height+Base_Material/2+1+Plate_Material/2+floor(((Microscope_Height-Holder_Height)*1/3)/10)*10+10])
Wheel();

 /*
translate([0,(-Microscope_Depth)/2+Base_Material+1+Object_Hole_Position,Base_Material/2])
Cam();
*/
}
}

if(Output_Type=="DXF")
{

projection(cut=true)
BasePlate();

translate([0,-Microscope_Depth/2-Microscope_Height/2-2,0])
projection(cut=true)
BackPlate();

translate([0,Microscope_Depth/2+Holder_Height/2+6,0])
projection(cut=true)
BackPlateHolder();

translate([-Microscope_Width/2-Object_Plate_Width/2-2,0,0])
projection(cut=true)
ObjectPlate();

translate([-Microscope_Width/2-Object_Plate_Width/2-23,Object_Plate_Depth/2+Wheel_Diameter/2+2,0])
projection(cut=true)
Wheel();
    
 translate([-Microscope_Width/2-Object_Plate_Width/2+23,Object_Plate_Depth/2+Wheel_Diameter/2+2,0])
projection(cut=true)
Wheel();

translate([-Microscope_Width/2-Object_Plate_Width/2+0,Object_Plate_Depth/2+Wheel_Diameter/2+2,0])
projection(cut=true)
Wheel();

}


// MODULES ///////////////////////////////


module Cam()
{
projection(cut=true)
union()
{
translate([0,0,15/2])
roundedRect([35, 25, 15], 2);
translate([0,0,15/2+10])
cylinder(h = 10, r1 = 15/2, r2 = 15/2, center = true);

}
}

module Wheel() //modified to have a hole
{
 difference()
{
  cylinder(h = Plate_Material, r1 = Wheel_Diameter/2, r2 = Wheel_Diameter/2, center = true);
    cylinder(h = Plate_Material+2, r1 = Screw_Diameter*0.75/2, r2 = Screw_Diameter*0.75/2, center = true);
  }
}

module ObjectPlate()
color("LightGreen")
{


difference()
{
rounded2Rect([Object_Plate_Width, Object_Plate_Depth, Plate_Material], 5);
translate([0,-Object_Plate_Depth/2+Object_Hole_Position,0])
roundedRect([Object_Hole_Width, Object_Hole_Depth, Plate_Material+2], 3);

translate([0,Object_Plate_Depth/2-8,0])
cylinder(h = Plate_Material+2, r1 = Screw_Diameter*0.75/2, r2 = Screw_Diameter*0.75/2, center = true);

translate([Object_Plate_Width/2,Object_Plate_Depth/2-13,0])
cylinder(h = Plate_Material+2, r1 = 4/2, r2 = 4/2, center = true);

translate([-Object_Plate_Width/2,Object_Plate_Depth/2-13,0])
cylinder(h = Plate_Material+2, r1 = 4/2, r2 = 4/2, center = true);

translate([0,-Object_Plate_Depth/2+(12/2),0])
cube([Screw_Diameter*1.07,Screw_Length,Plate_Material+2],true);

translate([0,-Object_Plate_Depth/2+(12/2),0])
cube([Nut_Width,Nut_Height*1.07,Plate_Material+2],true); // Nut

}

translate([(45/2),-Object_Plate_Depth/2-((Base_Material+1)/2),0])
cube([25,Base_Material+1,Plate_Material],true);

translate([-(45/2),-Object_Plate_Depth/2-((Base_Material+1)/2),0])
cube([25,Base_Material+1,Plate_Material],true);

}



module BackPlateHolder()
{ color("pink") 
difference()
{
union()
{
rounded2Rect([Microscope_Width, Holder_Height, Base_Material], 5);
translate([-(5+(Microscope_Width-80)/8+Holder_Notch_Width/2),-(Holder_Height/2+(Base_Material/2)),0])
cube([Holder_Notch_Width,Base_Material,Base_Material],true);
translate([(5+(Microscope_Width-80)/8+Holder_Notch_Width/2),-(Holder_Height/2+(Base_Material/2)),0])
cube([Holder_Notch_Width,Base_Material,Base_Material],true);
}
union()
{
translate([0,-(20/2)+(12/2),0])
cube([Screw_Diameter*1.07,Screw_Length,Base_Material+2],true);
translate([0,-4,0])
cube([Nut_Width,Nut_Height*1.07,Base_Material+2],true); //dimension of Nut

translate([(45/2),5.5,0])
cylinder(h = Base_Material+2, r1 = Screw_Diameter*0.75/2, r2 = Screw_Diameter*0.75/2, center = true);

translate([-(45/2),5.5,0])
cylinder(h = Base_Material+2, r1 = Screw_Diameter*0.75/2, r2 = Screw_Diameter*0.75/2, center = true);

// Extra Holes

if (((Microscope_Width-Plate_Width)-20)/2>4)
{
translate([-(((Microscope_Width-Plate_Width)-20)/2+Plate_Width)/2,4,0])
cylinder(h = Base_Material, r1 = Screw_Diameter*0.75/2, r2 = Screw_Diameter*0.75/2, center = true);

translate([(((Microscope_Width-Plate_Width)-20)/2+Plate_Width)/2,4,0])
cylinder(h = Base_Material, r1 = Screw_Diameter*0.75/2, r2 = Screw_Diameter*0.75/2, center = true);

translate([-(((Microscope_Width-Plate_Width)-20)/2+Plate_Width)/2,-4,0])
cylinder(h = Base_Material, r1 = Screw_Diameter*1.07/2, r2 = Screw_Diameter*1.07/2, center = true);

translate([(((Microscope_Width-Plate_Width)-20)/2+Plate_Width)/2,-4,0])
cylinder(h = Base_Material, r1 = Screw_Diameter*1.07/2, r2 = Screw_Diameter*1.07/2, center = true);
}

}
}
}



module BackPlate()

{color("LightBlue")
difference()
{
rounded2Rect([Plate_Width, Microscope_Height, Base_Material], 7);

union()
{
translate([0,0,-Base_Material/2])
linear_extrude(height=Base_Material+2)
hull()
{
translate([-45/2,-Microscope_Height/2+6,0])
circle(Screw_Diameter*1.07/2,true);

translate([-45/2,-Microscope_Height/2+6+11,0])
circle(Screw_Diameter*1.07/2,true);

}
}

union()
{
translate([0,0,-Base_Material/2])
linear_extrude(height=Base_Material+2)
hull()
{
translate([45/2,-Microscope_Height/2+6,0])
circle(Screw_Diameter*1.07/2,true);

translate([45/2,-Microscope_Height/2+6+11,0])
circle(Screw_Diameter*1.07/2,true);
}
}

    
    translate([0,-Microscope_Height/2+10,0])
    cylinder(h = Base_Material+2, r1 = 4, r2 = 4, center = true);
    
    translate([0,-Microscope_Height/2+2,0])
    cube([8, 16, Plate_Material+2], true);

for (y=[0:floor((Microscope_Height-Holder_Height-Plate_Material-4)/10)])
{
translate([45/2,-Microscope_Height/2+Holder_Height+Plate_Material/2+1+10*y,0])
cube([25,Plate_Material,Base_Material+2],true);

translate([-45/2,-Microscope_Height/2+Holder_Height+Plate_Material/2+1+10*y,0])
cube([25,Plate_Material,Base_Material+2],true);

translate([0,-Microscope_Height/2+Holder_Height+Plate_Material/2+1+10*y,0])
cylinder(h = Base_Material+2, r1 = Screw_Diameter*1.07/2, r2 = Screw_Diameter*1.07/2, center = true);

    
}

}

}




module BasePlate()
{color("deeppink") 
difference(){
rounded2Rect([Microscope_Width, Microscope_Depth, Base_Material], 5);
translate([(5+(Microscope_Width-80)/8+Holder_Notch_Width/2),-Microscope_Depth/2+Base_Material+1+(Base_Material/2),0])
cube([Holder_Notch_Width,Base_Material,20],true);
translate([-((5+(Microscope_Width-80)/8+Holder_Notch_Width/2)),-Microscope_Depth/2+Base_Material+1+(Base_Material/2),0])
cube([Holder_Notch_Width,Base_Material,20],true);
translate([0,-Microscope_Depth/2+Base_Material+1+(Base_Material/2),0])
cylinder(h = Base_Material+2, r1 = Screw_Diameter*1.07/2, r2 = Screw_Diameter*1.07/2, center = true);

}

}

// size - [x,y,z]
// radius - radius of corners
module rounded2Rect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	translate([0,0,-z/2])
	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius), (-y/2)+(radius), 0])
		square([2*radius,2*radius],true);
	
		translate([(x/2)-(radius), (-y/2)+(radius), 0])
		square([2*radius,2*radius],true);
	
		translate([(-x/2)+(radius), (y/2)-(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (y/2)-(radius), 0])
		circle(r=radius);
	}

}


// size - [x,y,z]
// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	translate([0,0,-z/2])
	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius), (y/2)-(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (y/2)-(radius), 0])
		circle(r=radius);
	}
}

