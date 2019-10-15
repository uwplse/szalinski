//This is a parametric script for generating footplates
//with holes with various number of sides.

// Created by Hamish Trolove - Oct 2018
//www.techmonkeybusiness.com

//FootPlatev9-Thingiverse.scad

//Licensed under a Creative Commons license - attribution
// share alike. CC-BY-SA

//No extra libraries are required and it works under 
//      OpenSCAD 2014 and OpenSCAD 2015.

//Basic Tray Dimensions

//Outer Corner Radius
LrgRad = 4;

//Inner Corner Radius
SmlRad = 3.2;

//Overall Length
Length = 50;

//Overall Width
Width = 18;

//Overall Tray Thickness
Thickness = 4;

//Depth of Tray Recess
TrayDepth = 3;

//Pattern Trimming Margin
PatternTrim = 1;

//Resolution of Curved Tray Edges
OuterCylRes = 64;

//Hole diameter
HoleD = 2;

//Number of Hole Rows
HoleRows = 4;

//Number of Side for the Holes
HoleRes = 6;

//Calculate the Active Width and Length for the Hexagonal Hole Pattern
ActWidth = Width - 4*(LrgRad-SmlRad);  // This allows the rim width clear of holes
ActLength = Length- 4*(LrgRad-SmlRad);

RowCLSpacing = ActWidth/HoleRows;
LenSpacing = 2*RowCLSpacing/sqrt(3);
NosLngth = ActLength/LenSpacing;

//Pattern trimming shape dimensions
TrimWidth = Width - 2*(LrgRad-SmlRad+PatternTrim);
TrimLength = Length - 2*(LrgRad-SmlRad+PatternTrim);
TrimRad = SmlRad - PatternTrim;


difference(){
	
	union()
	{
		cylinder(r=LrgRad,h=Thickness,center=true,$fn=OuterCylRes);
		translate([Length-2*LrgRad,0,0])
			cylinder(r=LrgRad,h=Thickness,center=true,$fn=OuterCylRes);
		translate([Length-2*LrgRad,Width-2*LrgRad,0])
			cylinder(r=LrgRad,h=Thickness,center=true,$fn=OuterCylRes);
		translate([0,Width-2*LrgRad,0])
			cylinder(r=LrgRad,h=Thickness,center=true,$fn=OuterCylRes);
		translate([(Length-2*LrgRad)/2,(Width-2*LrgRad)/2,0])cube([Length-2*LrgRad,Width,Thickness],center=true);
		translate([(Length-2*LrgRad)/2,(Width-2*LrgRad)/2,0])cube([Length,Width-2*LrgRad,Thickness],center=true);
	}

	union()
	{
	
		translate([0,0,Thickness-TrayDepth])cylinder(r=SmlRad,h=Thickness,center=true,$fn=OuterCylRes);
		translate([Length-2*LrgRad,0,Thickness-TrayDepth])
			cylinder(r=SmlRad,h=Thickness,center=true,$fn=OuterCylRes);
		translate([Length-2*LrgRad,Width-2*LrgRad,Thickness-TrayDepth])
			cylinder(r=SmlRad,h=Thickness,center=true,$fn=OuterCylRes);
		translate([0,Width-2*LrgRad,Thickness-TrayDepth])
			cylinder(r=SmlRad,h=Thickness,center=true,$fn=OuterCylRes);
		translate([(Length-2*LrgRad)/2,(Width-2*LrgRad)/2,Thickness-TrayDepth])cube([Length-2*LrgRad,Width-2*(LrgRad-SmlRad),Thickness],center=true);
		translate([(Length-2*LrgRad)/2,(Width-2*LrgRad)/2,Thickness-TrayDepth])cube([Length-2*(LrgRad-SmlRad),Width-2*LrgRad,Thickness],center=true);
	}
    
    intersection()
    {
        //Pattern Trim shape building
        union()
        {
            cylinder(r=TrimRad,h=Thickness*4,center=true,$fn=OuterCylRes);
            translate([TrimLength-2*TrimRad,0,0])
                cylinder(r=TrimRad,h=Thickness*4,center=true,$fn=OuterCylRes);
            translate([TrimLength-2*TrimRad,TrimWidth-2*TrimRad,0])
                cylinder(r=TrimRad,h=Thickness*4,center=true,$fn=OuterCylRes);
            translate([0,TrimWidth-2*TrimRad,0])
                cylinder(r=TrimRad,h=Thickness*4,center=true,$fn=OuterCylRes);
            translate([(TrimLength-2*TrimRad)/2,(TrimWidth-2*TrimRad)/2,0])cube([TrimLength-2*TrimRad,TrimWidth,Thickness*4],center=true);
            translate([(TrimLength-2*TrimRad)/2,(TrimWidth-2*TrimRad)/2,0])cube([TrimLength,TrimWidth-2*TrimRad,Thickness*4],center=true);
        }
        
        
        //Note: Extra row created so the slicing
        // using the pattern trimmer will create partial holes where needed.
        
        translate([-(LrgRad-0.5*LenSpacing),-(LrgRad-0.5*RowCLSpacing),-1]) 
        {
            for(rowA = [0:2:HoleRows])
            {
                for(i=[0:1:NosLngth+2])
                {
                    translate([i*LenSpacing,rowA*RowCLSpacing,0])
                        rotate([0,0,180/HoleRes])cylinder(r = HoleD,h=Thickness*3,center=true,$fn=HoleRes);
                }
            }
            
            for(rowB = [1:2:HoleRows])
            {
                for(i=[0:1:NosLngth+2])
                {
                    translate([LenSpacing*(i-0.5),rowB*RowCLSpacing,0])
                        rotate([0,0,180/HoleRes])cylinder(r = HoleD,h=Thickness*3,center=true,$fn=HoleRes);
                }
            }
        }
    }




}
