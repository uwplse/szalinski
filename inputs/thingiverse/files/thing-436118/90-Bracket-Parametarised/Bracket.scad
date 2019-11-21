/*
Created by David Taylor as part of a video series
Video are available at http://bit.ly/GineerTube
*/

include <MCAD/boxes.scad>

//How long should the sides be?
Sides_Length=40;//[40:100]

//How wide should it be?
Width=20;//[20:80]

//How thick should it be?
Thickness=6;//[3:20]

//How big should the holes be?
Hole_Radius=3;//[1.5:10]

//What should the corner radius be?
Corner_Radius=2.5;//[0:10]

difference()
{
	union()
	{
		translate([(Sides_Length/2)-(Thickness/2),0,0])
		{
			//cube([Sides_Length,Width,Thickness], center=true);
			roundedBox([Sides_Length,Width,Thickness],Corner_Radius,true);
		}
		translate([0,0,(Sides_Length/2)-(Thickness/2)])
		{
			rotate([0,90,0])
			{
				//cube([Sides_Length,Width,Thickness], center=true);
				roundedBox([Sides_Length,Width,Thickness],Corner_Radius,true);
			}
		}
		translate([((Sides_Length/2)*sqrt(2))/2,0,((Sides_Length/2)*sqrt(2))/2])
		{
			rotate([0,45,0])
			{
				cube([Sides_Length,Width,Thickness], center=true);
			}
		}
		cube([Thickness,Width,Thickness],center=true);
	}
	translate([(Sides_Length/4),0,0])
	{
		cylinder(h=(Thickness*2), r=Hole_Radius, $fn=100, center=true);
	}
	translate([(Sides_Length/4)*3,0,0])
	{
		cylinder(h=(Thickness*2), r=Hole_Radius, $fn=100, center=true);
	}
	rotate([0,-90,0])
	{
		translate([(Sides_Length/4),0,0])
		{
			cylinder(h=(Thickness*2), r=Hole_Radius, $fn=100, center=true);
		}
		translate([(Sides_Length/4)*3,0,0])
		{
			cylinder(h=(Thickness*2), r=Hole_Radius, $fn=100, center=true);
		}
	}
	translate([(Sides_Length/4),0,(Sides_Length/2)+(Thickness/2)+0.1])
	{
		cylinder(h=(Sides_Length), r=(Hole_Radius*2), $fn=100, center=true);
	}
	translate([(Sides_Length/2)+(Thickness/2)+0.1,0,(Sides_Length/4)])
	{
		rotate([0,90,0])
		{
			cylinder(h=(Sides_Length), r=(Hole_Radius*2), $fn=100, center=true);
		}
	}
	translate([(Sides_Length/4)*3,0,(Sides_Length/2)+(Thickness/2)])
	{
		cylinder(h=(Sides_Length), r=(Hole_Radius*2), $fn=100, center=true);
	}
	translate([(Sides_Length/2)+(Thickness/2),0,(Sides_Length/4)*3])
	{
		rotate([0,90,0])
		{
			cylinder(h=(Sides_Length), r=(Hole_Radius*2), $fn=100, center=true);
		}
	}
	translate([(Sides_Length/4)+(Sides_Length/2),0,(Sides_Length/4)+(Sides_Length/2)])
	{
		cube([Sides_Length,(Hole_Radius*4),Sides_Length], center=true);
	}
	translate([(Sides_Length)-sqrt(pow(Sides_Length/8,2)-pow(Thickness/2,2)),0,(Thickness)])
	{
		rotate([0,20,0])
		{
			cube([(Sides_Length/4),Width,Thickness],center=true);
		}
	}
	translate([(Thickness),0,(Sides_Length)-sqrt(pow(Sides_Length/8,2)-pow(Thickness/2,2))])
	{
		rotate([0,-20,0])
		{
			cube([Thickness,Width,(Sides_Length/4)],center=true);
		}
	}
}