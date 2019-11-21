use <./MCAD/shapes.scad>
use <./pins/pins.scad>

//preview[view:north, tilt:top];

//What Shape do you want the Frames to be?
shape="square";//[round, square]

Width_of_Nose_Bridge=25;//[10:40]
lengthBridge=Width_of_Nose_Bridge;

Height_of_Nose_Bridge=7;//[2:12]
widthBridge=Height_of_Nose_Bridge;

//What is the width of your head at eye level?
Overall_Glasses_Width=100;//[50:200] 
lengthFrame=Overall_Glasses_Width-Width_of_Nose_Bridge-20/2;

Height_of_Frame=35;//[20:60]
widthFrame=Height_of_Frame;

//Greater depth means greater rigidity.
Depth_of_Glasses=3;//[1:5]
heightFrame=Depth_of_Glasses;

//Thickness of frame around eyes.
Thickness_of_Frame=5;//[1:10]
thicknessFrame=Thickness_of_Frame;

//What infill do you want
Pattern_Infill_Type=0;//[0:None, 3:Triangles (3 Sides), 4:Squares(4 Sides), 5:Pentagons(5 Sides), 6:Hexagons(6 Sides), 7:Heptagons(7 Sides), 8:Octagons(8 Sides), 9:Nonagons(9 Sides), 10:Decagons(10 Sides), 40: Circles]
patternSides=Pattern_Infill_Type;//If is 0, no pattern

//Radius of an individual pattern element.
Pattern_Radius=5;//[1:25]
patternRadius=Pattern_Radius;

//Change Radius of individual pattern element without changing spacing between their centers.  Can be used to achieve some cool effects and overlapping pattern elements.
Pattern_Radius_Modifier=0;//[0:30]
patternRadiusModifier=Pattern_Radius_Modifier;

//Will be multiplied by .1mm so can achieve finer precision in this thickness, for more detail. (ie. 11=1.1mm, etc)
Pattern_Line_Thickness=11;//[4:100]
patternThickness=Pattern_Line_Thickness*.1;

//Length of the Temple (The ear hook piece)
Temple_Length=125;//[50:250]
straightLength=Temple_Length;

//Please note that for the hook, it is made out of a side of an oval to achieve the curves, so please take this into consideration.
Height_of_Hook_Curve=30;//[15:50]
hookWidth=Height_of_Hook_Curve;

Length_of_Hook_Curve=18;//[18:50]
hookLength=Length_of_Hook_Curve;

//ignore variable values, add +0 so not included
lengthHinge=15+0;//Set Variable
widthHinge=27+0;//Set Variable
$fn=100+0;
lengthHinge=8+2+heightFrame+0;

//BEGIN

rotate([0, 0, 180])
{
	translate([(straightLength/2)+(4)+5, (15/2)+15-10, 0])//Pins
	{
		pintack(h=22+2, r=2, lh=3, lt=1, bh=3, br=4);//Pins
	}
	translate([(straightLength/2)+(4)+15,  (15/2)+15-10, 0])
	{
		pintack(h=22+2, r=2, lh=3, lt=1, bh=3, br=4);//Pins
	}
	
	translate([0, (15/2)+15+10, 0])
	{
		union()//Left Hook
		{
			translate([0, 0, heightFrame/2])
			{
				cube([straightLength, 15, heightFrame], center=true);
			}  
			translate([-(straightLength/2)+(8/2)+2, 0, (10/2)+heightFrame])//Hinge
			{
				difference()
				{
					cube([8, 10, 10], center=true);
					translate([0, 0, 1])
					{
						rotate([90, 0, 0])
						{
							cylinder(r=2.5, h=10+1, center=true);
						}
					}
				}
			}
			translate([(straightLength/2), hookWidth-(15/2), heightFrame/2])
			{
				rotate([0, 0, 90])
				{
					hook(hookWidth, hookLength, 15, heightFrame, center=true);
				}
			}
		}
	}
	translate([0, (15/2)+15-10, 0])
	{
		union()//Right Hook
		{
			translate([0, 0, heightFrame/2])
			{
				cube([straightLength, 15, heightFrame], center=true);
			}  
			translate([(straightLength/2)-(8/2)-2, 0, (10/2)+heightFrame])//Hinge
			{
				difference()
				{
					cube([8, 10, 10], center=true);
					translate([0, 0, 1])
					{
						rotate([90, 0, 0])
						{
							cylinder(r=2.5, h=10+1, center=true);
						}
					}
				}
			}
			translate([-(straightLength/2), hookWidth-(15/2), heightFrame/2])
			{
				rotate([ 180, 0, 90])
				{
					hook(hookWidth, hookLength, 15, heightFrame, center=true);
				}
			}
		}
	}
}
union()//GLASSES
{
	translate([(lengthBridge/2)+(lengthFrame)+(8/2), (widthFrame/2)+(5/2)-(widthHinge/2), heightFrame+(10/2)])
	{
		hinge(8, 5, 10, 2.5);
	}
	translate([-(lengthBridge/2)-(lengthFrame)-(8/2), (widthFrame/2)+(5/2)-(widthHinge/2), heightFrame+(10/2)])
	{
		hinge(8, 5, 10, 2.5);
	}
	
	difference()
	{
		union()//Make Frame and Bridge
		{
			translate([0, 6, heightFrame/2])
			{
			cube([lengthBridge+(lengthFrame), widthBridge, heightFrame], center=true);//Make Bridge, with some excess
			}
			translate([(lengthFrame/2)+(lengthBridge/2), (widthFrame/2), heightFrame/2])//Lens1
			{
				frame(lengthFrame, widthFrame, heightFrame, thicknessFrame, shape);
			}
			translate([-(lengthFrame/2)-(lengthBridge/2), (widthFrame/2), heightFrame/2])//Lens 2 
			{
				frame(lengthFrame, widthFrame, heightFrame, thicknessFrame, shape);
			}
			translate([(lengthBridge/2)+(lengthFrame)+(lengthHinge/2)-(lengthFrame/4), (widthFrame/2), heightFrame/2])
			{
				union()//Hinge Base
				{
					cube([lengthHinge+(lengthFrame/2), widthHinge, heightFrame], center=true);
					
				}
			}
			translate([(-lengthBridge/2)-(lengthFrame)-(lengthHinge/2)+(lengthFrame/4), (widthFrame/2), heightFrame/2])
			{
				union()//Hinge Base
				{
					cube([lengthHinge+(lengthFrame/2), widthHinge, heightFrame], center=true);
				}
			}
		}
		union()//Subtract Lens
		{
			translate([(lengthFrame/2)+(lengthBridge/2), (widthFrame/2), heightFrame/2])//Lens1
			{
				lens(lengthFrame, widthFrame, heightFrame, thicknessFrame, shape, widthBridge);
			}
			translate([-(lengthFrame/2)-(lengthBridge/2), (widthFrame/2), heightFrame/2])//Lens 2
			{
				lens(lengthFrame, widthFrame, heightFrame, thicknessFrame, shape, widthBridge);
			}
		}
	}
	if(patternSides!=0)//Fill Glasses if want
	{
		translate([(lengthFrame/2)+(lengthBridge/2), (widthFrame/2), heightFrame/2])//Lens1
		{
			intersection()
			{
				if(shape=="round")
				{
					oval((lengthFrame/2)-thicknessFrame, (widthFrame/2)-thicknessFrame, thicknessFrame, center=true);
				}
				else if(shape=="square")
				{
					roundedBox(lengthFrame-(thicknessFrame*2), widthFrame-(thicknessFrame*2), heightFrame+.5, 2, center=true);//Subtract Lens
				}
				mesh(lengthFrame, widthFrame, heightFrame, patternRadius, patternRadiusModifier, (patternThickness), patternSides);
			}
		}
		translate([-(lengthFrame/2)-(lengthBridge/2), (widthFrame/2), heightFrame/2])//Lens1
		{
			intersection()
			{
				if(shape=="round")
				{
					oval((lengthFrame/2)-thicknessFrame, (widthFrame/2)-thicknessFrame, thicknessFrame, center=true);
				}
				else if(shape=="square")
				{
					roundedBox(lengthFrame-(thicknessFrame*2), widthFrame-(thicknessFrame*2), heightFrame+.5, 2, center=true);//Subtract Lens
				}
			mesh(lengthFrame, widthFrame, heightFrame, patternRadius, patternRadiusModifier, (patternThickness), patternSides);
			}
		}
	}
}

//MODULES
module frame(lengthFrame, widthFrame, heightFrame, thicknessFrame, shape)//Make outer Frame
{
	if(shape=="square")
	{
			roundedBox(lengthFrame, widthFrame, heightFrame, 2, center=true);//Make Frame
		
	}
	else if(shape=="round")
	{
			ovalTube(heightFrame, lengthFrame/2, widthFrame/2, thicknessFrame, center=true);//Make Frame			
	}
}//End frame

module lens(lengthFrame, widthFrame, heightFrame, thicknessFrame, shape, widthBridge)//Make Lens to be subtracted
{
	if(shape=="square")
	{
			roundedBox(lengthFrame-(thicknessFrame*2), widthFrame-(thicknessFrame*2), heightFrame+.5, 2, center=true);//Subtract Lens
	}
	else if(shape=="round")
	{
			oval((lengthFrame/2)-thicknessFrame, (widthFrame/2)-thicknessFrame, thicknessFrame, center=true);
	}
}//End Lens

module hinge(width, length, height, radius)
{
	difference()
	{
		cube([width, length, height], center=true);
		translate([0, 0, 1])
		{
			rotate([90, 0, 0])
			{
				cylinder(r=radius, h=length+1, center=true);
			}
		}
	}
	translate([0, widthHinge-(length/2)-(length*2), 0])
	{
		difference()
		{
			translate([0, 10/2, 0])
			{
			cube([width, length*2, height], center=true);
			}
		
			rotate([-90, 0, 0])
			{
			pinhole(h=7, r=2, lh=3, lt=1, t=.5, tight=true);
			}
		}
	}
}//End Hinge


//Oval Shape, part of OpenScad Shapes Library, but for some reason not in the MCAD library
module oval(w,h, height, center = false) {
  scale([1, h/w, 1]) cylinder(h=height, r=w, center=center);
}


module mesh(width,length,height,r,rmod,th,sides)//Based on code from Makerbot iPhone case, but slightly modified
{
	
	columns = length/(r*3)+1;
	rows = width/(r*sqrt(3)/2*2);

	translate([-width/2,length/2,0])
		rotate([0,0,-90])
			for(i = [0:rows]){
				
				translate([0,r*sqrt(3)/2*i*2,0])
					for(i = [0:columns]){
						translate([r*i*3,0,0])
							for(i = [0:1]){
								translate([r*1.5*i,r*sqrt(3)/2*i,0])
									difference(){
										if(sides < 5){
											cylinder(h=height, r = r+th+(r*rmod/50), center = true, $fn = sides);
										} else {
											cylinder(h=height, r = r+(r*rmod/50), center = true, $fn = sides);
										}
										cylinder(h=height+1, r = r-th+(r*rmod/50), center = true, $fn = sides);
									}
							}
					}
			}
}

module hook(radius1, radius2, rim, height)
{
	difference()
	{
	oval(radius1, radius2, height, center=true);
		union()
		{
			oval(radius1-rim, radius2-rim, height+1, center=true);
			translate([radius1/2, 0, 0])
			{
				cube([radius1, radius2*2, height+1], center=true);
			}
			translate([0, radius2/2, 0])
			{
				cube([radius1*2, radius2, height+1], center=true);
			}
		}
	}
}