//preview[view:south, tilt:top]
//units in mm

/* [Simple] */
//Choose a standard configuration or custom
Standard_Size=80;// [Custom,36,38,40,52,60,80,92,120,127,140,150]

/* [Custom Grille] */
//Width of Grille
Grille_Width=80;//Edge to Edge
//Diameter of Bolt Holes
Bolt_Diameter=4.5;
//Center to Center Width of Bolt Holes
Bolt_Hole_Width=71.5;

/* [Global] */
//Thickness of grille
Grille_Height=4;
//Edge Width
Edge_Width=2;
//Number of vanes
Vanes=4;//[3:20]
//Width of vanes
Vane_Width=2;
//Number of rings
Rings=2;//[1:20]
//Width of rings
Ring_Width=2;
//Hollow Center Support
Hollow="yes"; //[yes,no]

/* [Hidden] */
//Standard Configurations
if(Standard_Size==36)FanGrille(36,29.5,3.5);
else if(Standard_Size==38)FanGrille(38,30,3.5);
else if(Standard_Size==40)FanGrille(40,32,3.5);
else if(Standard_Size==52)FanGrille(52,42,3.7);
else if(Standard_Size==60)FanGrille(60,50,4.3);
else if(Standard_Size==80)FanGrille(80,71.5,4.3);
else if(Standard_Size==92)FanGrille(92,82.5,4.3);
else if(Standard_Size==120)FanGrille(120,104.8,4.3);
else if(Standard_Size==127)FanGrille(127,113.3,4.3);
else if(Standard_Size==140)FanGrille(140,124.5,4.3);
else if(Standard_Size==150)FanGrille(150,135,4.5);
else FanGrille(Grille_Width,Bolt_Hole_Width,Bolt_Diameter);

module FanGrille(Grille_Width,Bolt_Hole_Width,Bolt_Diameter)
{
//Thickness of vanes
Vane_and_Ring_Thickness=Grille_Height*.75;
//Diameter of center support
Grille_Center_Diameter=Grille_Width*.25;
//Outside Corner Radius's of fan Grille
Outside_Radius=Grille_Width/30;
//Inside Corner Radius's of fan Grille
Inside_Radius=Grille_Width/4;
//Angle Between Vanes
Vane_Angle=360/Vanes;
//Spacing Between Rings
Ring_Spacing=((Grille_Width/2-Edge_Width)/sin(45)-(Inside_Radius/sin(45)-Inside_Radius)-Grille_Center_Diameter/2-Rings*Ring_Width)/(Rings+1);
//Determine where to start first vane
Odd_or_Even= Vanes%2==0 && Vanes%4==0 ? 1 : 2;

	intersection()
	{
		union()
		{
			translate([0,0,Grille_Height/2]) difference() //Main Profile
				{
					minkowski()
					{
			 			cube([Grille_Width-Outside_Radius*2,Grille_Width-Outside_Radius*2,Grille_Height/2],center=true);
			 			cylinder(r=Outside_Radius,h=Grille_Height/2,center=true,$fn=100);
					}
					minkowski()
					{
			 			cube([Grille_Width-(Edge_Width+Inside_Radius)*2,Grille_Width-(Edge_Width+Inside_Radius)*2,Grille_Height],center=true);
			 			cylinder(r=Inside_Radius,h=Grille_Height,center=true,$fn=100);
					}
					//Mounting Holes
					for (i=[-1:2:1])
					{
						for (j=[-1:2:1])
						{
							translate([i*Bolt_Hole_Width/2,j*Bolt_Hole_Width/2,0])
							cylinder(r=Bolt_Diameter/2,h=Grille_Height*2,center=true,$fn=100);
						}
					}
				}
			//Inner Support
			if(Hollow=="yes")
			{
				difference()
				{
					cylinder(h=Vane_and_Ring_Thickness,r=Grille_Center_Diameter/2,$fn=100);
					translate([0,0,-1])
					cylinder(h=Vane_and_Ring_Thickness+2,r=Grille_Center_Diameter/2-Ring_Width*2,$fn=100);
				}
			}
			else
			{
				cylinder(h=Vane_and_Ring_Thickness,r=Grille_Center_Diameter/2,$fn=100);
			}
			//Vanes
			for(k=[0:1:Vanes-1])
			{
				rotate([0,0,k*Vane_Angle+(45*Odd_or_Even)]) translate([Grille_Center_Diameter/2,-Vane_Width/2,0])
				cube([(Grille_Width/2-Edge_Width)/sin(45)-(Inside_Radius/sin(45)-Inside_Radius)-Grille_Center_Diameter/2,Vane_Width,Vane_and_Ring_Thickness]);
			}
			//Rings
			for(l=[1:1:Rings])
				{
					difference()
					{
						cylinder(h=Vane_and_Ring_Thickness,r=Grille_Center_Diameter/2+(l*Ring_Spacing)+Ring_Width*l,$fn=100);
						translate([0,0,-1]) cylinder(h=Vane_and_Ring_Thickness+2,r=Grille_Center_Diameter/2+(l*Ring_Spacing)+Ring_Width*(l-1),$fn=100);
					}
				}
		}
		translate([0,0,Grille_Height/2])
		cube([Grille_Width,Grille_Width,Grille_Height],center=true);
	}
}