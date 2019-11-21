/*      
        Customizable LEGO Technic Beam on Parametric LEGO Technic Beam 
        by "projunk" www.thingiverse.com/thing:203935
        and Even More Customizable Straight Beam for LEGO Technic 
        by "samkass" www.thingiverse.com/thing:1119651
        and Lego Technic: Perpendicular Beam Connector  Customizable
        by "shusy" www.thingiverse.com/thing:2503065
        Modified by Shusy
        September 2017
*/


$fn=40;

eps = 0.05*1;

//Nuber of the holes
NrOfHolesX = 7; 
NrOfHolesY = 3;
Step = 2; // [1:3]
Diameter1 = 4.8;
Diameter2 = 6.1;

Pitch = 8*1;
Radius1 = Diameter1 / 2;
Radius2 = Diameter2 / 2;
Height = 7.8*1;
Depth = 0.8*1;
Width = 7.5*1;
MidThickness = 2*1;
MiniCubeOffset = 1.1*1; 
MiniCubeWidth = Radius1 - MiniCubeOffset;
CrossInnerRadius = 1.5*1;

translate([Pitch*Step,0,0])drawBeam(NrOfHolesX);
translate([0,Pitch*Step,0])rotate([0,0,90])drawBeam(NrOfHolesY);


AngularDrawBeam(Step+1);

module drawBeam(NrOfHoles){
translate([0,-Width/2,0])union(){    
{
	Length = (NrOfHoles - 1) * Pitch;
	Thickness = (Width - 2 * Radius2) / 2;

	difference()
	{
		union()
		{			
			cube([Length, Thickness, Height]);
			translate([0, Width-Thickness,0]) cube([Length, Thickness, Height]);
			translate([0, 0, Height/2-MidThickness/2]) cube([Length, Width, MidThickness]);
			for (i = [1:NrOfHoles])
			{
				translate([(i-1)*Pitch, Width/2,0]) 
				{
					cylinder(r=Width/2, h=Height);
				}
			}
		}

		union()
		{
            for (i = [1:NrOfHoles-1])
			{
				translate([(i-1)*Pitch, Width/2,0]) 
				{
					translate([0,0,-eps]) cylinder(r=Radius2,h=Depth+eps);
					translate([0,0,-eps]) cylinder(r=Radius1,h=Height+2*eps);
					translate([0,0,Height-Depth]) cylinder(r=Radius2,h=Depth+eps);
				}
			}
            translate([(NrOfHoles-1)*Pitch, Width/2,0]) plus();
		}
	}
    
}
}
}

module AngularDrawBeam(NrOfHoles){
rotate([0,0,-45])
   translate([-(NrOfHoles-1)*Pitch*sqrt(2)/2,(NrOfHoles-1)*Pitch*sqrt(2)/2-Width/2,0])
    union(){    
{
	Length = (NrOfHoles - 1) * Pitch*sqrt(2);
	Thickness = (Width - 2 * Radius2) / 2;

	difference()
	{
		union()
		{			
			cube([Length, Thickness, Height]);
			translate([0, Width-Thickness,0]) cube([Length, Thickness, Height]);
			translate([0, 0, Height/2-MidThickness/2]) cube([Length, Width, MidThickness]);
				translate([0, Width/2,0])cylinder(r=Width/2, h=Height);
				translate([Length, Width/2,0])cylinder(r=Width/2, h=Height);
            hull(){
				translate([Pitch, Width/2,0])cylinder(r=Width/2, h=Height);
				translate([Length-Pitch, Width/2,0])cylinder(r=Width/2, h=Height);
            }    

		}

		union()
		{
				translate([0, Width/2,0]) 
				{
					translate([0,0,-eps]) cylinder(r=Radius2,h=Depth+eps);
					translate([0,0,-eps]) cylinder(r=Radius1,h=Height+2*eps);
					translate([0,0,Height-Depth]) cylinder(r=Radius2,h=Depth+eps);
				}
				translate([Length, Width/2,0]) 
				{
					translate([0,0,-eps]) cylinder(r=Radius2,h=Depth+eps);
					translate([0,0,-eps]) cylinder(r=Radius1,h=Height+2*eps);
					translate([0,0,Height-Depth]) cylinder(r=Radius2,h=Depth+eps);
				}
                hull(){
					translate([Pitch,Width/2,-eps]) cylinder(r=Radius2,h=Depth+eps);
					translate([Length-Pitch, Width/2,-eps])cylinder(r=Radius2,h=Depth+eps);
                }
                hull(){
					translate([Pitch,Width/2,-eps]) cylinder(r=Radius1,h=Height+2*eps);
					translate([Length-Pitch, Width/2,-eps])cylinder(r=Radius1,h=Height+2*eps);
                }
                hull(){
					translate([Pitch,Width/2,Height-Depth]) cylinder(r=Radius2,h=Depth+eps);
					translate([Length-Pitch, Width/2,Height-Depth])cylinder(r=Radius2,h=Depth+eps);
                }

		}
	}
}
}
}


module plus() {
Plus_Width = 2.0*1.0;
Overhang = 0.05*1.0;
    union() {
        translate([-Plus_Width/2, -Radius1, -Overhang]) 
            cube([Plus_Width, Radius1*2, Height+Overhang*2]);
        translate([-Radius1, -Plus_Width/2, -Overhang]) 
            cube([Radius1*2, Plus_Width, Height+Overhang*2]);
    }
}


