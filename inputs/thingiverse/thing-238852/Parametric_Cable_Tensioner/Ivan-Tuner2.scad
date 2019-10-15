/*

Parametric Prosthetic Hand String Tensioner
Based on a part designed by Ivan Owen
Put into parametric format by David Orgeman

Released under the terms of the GNU GPL v3.0 

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

*/


Metric_Table=[ 	["M2", 0.8000, 1.1000, 2.3094], 
				["M25", 1.0250, 1.3750, 2.8868], 
				["M3", 1.2500, 1.6500, 3.1754], 
				["M4", 1.6500, 2.2000, 4.0415], 
				["M5", 2.1000, 2.7500, 4.6188]  ];


//Standard hole sizes for tapping into plastic
//M2T=1.60;
//M25T=2.05;
//M3T=2.5;
//M4T=3.3;
//M5T=4.2;

//Standard hole sizes for metric screws
//M2=2.2;
//M25=2.75;
//M3=3.3;
//M4=4.4;
//M5=5.5;

//Standard nut sizes - flat-to-flat and then as radius
//M2NutW=4.0;
//M25NutW=5.0;
//M3NutW=5.5;
//M4NutW=7.0;
//M5NutW=8.0;
//M2NutR=(M2NutW/cos(30))/2;
//M25NutR=(M25NutW/cos(30))/2;
//M3NutR=(M3NutW/cos(30))/2;
//M4NutR=(M4NutW/cos(30))/2;
//M5NutR=(M5NutW/cos(30))/2;


//PARAMETERS

//size of the tuner drive screws
Tuner_Size="M25";//[ M2, M25, M3, M4, M5 ]

Metric_Index=search([Tuner_Size], Metric_Table)[0];
Tuner_Screw_Radius=Metric_Table[Metric_Index][1];
Block_Screw_Radius=Metric_Table[Metric_Index][2];
Rod_Radius=Metric_Table[Metric_Index][3];

//extra elevation of the tuners and strings above the gauntlet
Extra_Tuner_Height=0.0;

//slightly increase the length of rods and tuner block for springs
Spring_Length_Adjustment=3.0;

//length of the spring covering shell on the back of the tuner
Spring_Shield_Adjustment=19.0;

//functional length of the tuner rods
Rod_Length=18.0;

//extra tuner rod length to tie the strings to.
Extra_Tuner_Length=5.0;

//size of the hole through the tuners for the drive strings
String_Radius=1.0;

//number of tuners - most will want 5, some might want 4
Tuner_Count=5;//[1, 2, 3, 4, 5]

//extra gap in the tuner slots to allow them to slide more readily
Tuner_Fit=0.25;


//0 to print tuners, 1 to omit them
Print_Tuners=0;//[0, 1]

//0 to print the block, 1 to omit it
Print_Block=0;//[0, 1]


//RENDER
if (Print_Block == 0)
	{
	translate([0, 0, 3])
		block();
	}
	

if (Print_Tuners == 0)
	{
	if (Tuner_Count>0)
		{
		for(i=[1:Tuner_Count])
			{
			translate([20-3*Rod_Radius*(Tuner_Count+1)/2 + 3*Rod_Radius*i, 40, 0])
				tuner();
			}
		}
	}


module block()
	{
	rotate(a=[0, 0, -90])
	difference()
		{
		translate([-2.3*Rod_Radius*(Tuner_Count+1)/2, 0, -3])
			cube([4.6*Rod_Radius*(Tuner_Count+1)/2, Rod_Length+3+Spring_Length_Adjustment+Spring_Shield_Adjustment, 3.8*Rod_Radius+Extra_Tuner_Height+3]);
									
		for(i=[1:Tuner_Count])
			{
			translate([-2.4*Rod_Radius*(Tuner_Count+1)/2 + 2.4*Rod_Radius*i, Rod_Length+0.5+Spring_Length_Adjustment, 1.9*Rod_Radius+Extra_Tuner_Height])
				rotate(a=[0, 30, 0])
				rotate(a=[90, 0, 0])
					cylinder(h=Rod_Length+2+Spring_Length_Adjustment, r=Rod_Radius+Tuner_Fit, $fn=6);
			}

		for(i=[1:Tuner_Count])
			{
			translate([-2.4*Rod_Radius*(Tuner_Count+1)/2 + 2.4*Rod_Radius*i, 50, 1.9*Rod_Radius+Extra_Tuner_Height])
				rotate(a=[0, 30, 0])
				rotate(a=[90, 0, 0])
					cylinder(h=100, r=Block_Screw_Radius/cos(30), $fn=6);
			}
		
		translate([-2.3*Rod_Radius*(Tuner_Count+1)/2-0.01, 0, 3.8*Rod_Radius+Extra_Tuner_Height+0.01])
			rotate(a=[-90, 0, 0])
				fillet(r=2.2*Rod_Radius, h=200);
		translate([2.3*Rod_Radius*(Tuner_Count+1)/2+0.01, 0, 3.8*Rod_Radius+Extra_Tuner_Height+0.01])
			rotate(a=[0, 90, 0])
			rotate(a=[-90, 0, 0])
				fillet(r=2.2*Rod_Radius, h=200);

		difference()
			{
			translate([-2.3*Rod_Radius*(Tuner_Count+1)/2+2, Rod_Length+3+Spring_Length_Adjustment, -6])
				cube([4.6*Rod_Radius*(Tuner_Count+1)/2-4, Spring_Shield_Adjustment+2, 3.8*Rod_Radius+Extra_Tuner_Height+6-2]);
			translate([-2.3*Rod_Radius*(Tuner_Count+1)/2+2-0.01, 0, 3.8*Rod_Radius+Extra_Tuner_Height-2+0.01])
				rotate(a=[-90, 0, 0])
					fillet(r=1.6*Rod_Radius, h=200);
			translate([2.3*Rod_Radius*(Tuner_Count+1)/2-2+0.01, 0, 3.8*Rod_Radius+Extra_Tuner_Height-2+0.01])
				rotate(a=[0, 90, 0])
				rotate(a=[-90, 0, 0])
					fillet(r=1.6*Rod_Radius, h=200);
			}

		}	
	}	
	
	
module tuner()
	{
	translate([0, (Rod_Length+Extra_Tuner_Length+Spring_Length_Adjustment)/2, Rod_Radius*cos(30)])
	difference()
		{
		rotate(a=[90, 0, 0])
			cylinder(h=Rod_Length+Extra_Tuner_Length+Spring_Length_Adjustment, r=Rod_Radius, $fn=6);
		translate([0, 1, 0])
			rotate(a=[90, 0, 0])
				cylinder(h=Rod_Length+Spring_Length_Adjustment, r=Tuner_Screw_Radius, $fn=16);
		translate([-String_Radius, -Rod_Length-Spring_Length_Adjustment-Extra_Tuner_Length/2, -10])
//			polyhole(h=20, d=String_Radius*2);
//			cylinder(h=20, r=String_Radius, center=true);
			cube([2*String_Radius, 2*String_Radius, 20]);
		}
	}


	
module fillet(r, h) 
	{
	translate([r/2, r/2, 0])
		difference() 
			{
			cube([r, r, h], center=true);
			translate([r/2, r/2, 0])
				cylinder(h=h+1, r=r, center=true, $fn=40);
			}
	}

	
	
// By nophead
module polyhole(d, h) 
	{
	n=max(round(2*d), 3);
	rotate(v=[0, 0, 180])
		cylinder(h=h, r=(d/2)/cos(180/n), center=true, $fn=n);
	}

