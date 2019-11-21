use<Write.scad>

//Size scaling
scale=10; //general setting
rotation1=69; //rotation of the cam spikes
rotation2=1; //rotation of the flat tops, flat tops have to be replaced with semi-circles at some point
hole=1.6; //size of the hole for the shaft
thickness=5; //z-thickness of cams


//Switch placement
//Show microswitches on/off
show_microswitches=1; 
//how many mm the switches are apart
switch_spacing=11;

//Initial switch placement
switch_x=0; 
switch_y=-29; //Initial switch placement
switch_z=-2.5; //Initial switch placement


//misc
//Steps on the cam
steps=25; 
//how many cams are generated
tracks=4;
//general setting 
radius=2;

//Westminster chime 


//Tracks 1-4, 25 steps
//0=flat,down 1=hill, 2=flat,top 
//type=[0,0,0,0,1,1,1,1,0,0,0,0,1,2,2,2,2,0,0,0,0,0,0,0,0,0];
type=[	[1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0],
		[0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0],
		[0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0],
		[0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0]];




//don't touch
pi=3.14159;
divisor=(steps/360);






//Rounded plate module - faster than minkowski!
//variables with "customizer" in them are only for the Thingiverse customizer and are not essential.
module rounded_plate(size_x,size_y,size_z,facets,rounding_radius)
{
	hull()
	{
		translate([rounding_radius,rounding_radius,0]) cylinder (h=size_z, r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,rounding_radius,0]) cylinder (h=size_z,r=rounding_radius,$fn=facets);
		translate([rounding_radius,size_y-rounding_radius,0]) cylinder (h=size_z,r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,size_y-rounding_radius,0]) cylinder (h=size_z,r=rounding_radius,$fn=facets);
	}
}

module microswitch()
{
	union()
	{
		difference()
		{
			rounded_plate(28,16,10,32,2.5);
			//upper, round hole
			#translate([28-(3.2/2)-1.4,16-(3.2/2)-1.4],0) cylinder(r=3.2/2,h=10,$fn=32);

			//Lower, keyed hole
			difference()
			{
	
				translate([(3.5/2)+1.4,(3.5/2)+1.4],0) cylinder(r=3.5/2,h=11,$fn=32);
				translate([(3.5/2),(3.5/2)+(3.2/2)+1.4,0]) cube([3.5,0.15,10]);
				translate([(3.5/2),(3.5/2)+(3.2/2)+1.4-3.5+0.15,0]) cube([3.5,0.15,10]);
			}
		}


		//cam nipple
		translate([3.2,16,(10-4.2)/2]) cube([3,3/2,4.2]);
		translate([3.2+1.5,16+1.5,(10-4.2)/2]) cylinder(r=3/2,h=4.2,$fn=16);
	}
}


//****************************************+GENERATE CAMS**************************************************
for (s=[0:tracks-1])
{
	translate ([0,0,s*switch_spacing]) rotate([0,0,0])
	{
		for (t=[1:steps])
		{	

			//hill,upwards
			if (type[s][t-1]==1)
			{
				translate([sin(t/divisor)*scale,cos(t/divisor)*scale,0]) 	
				rotate([0,0,-t/divisor-rotation1])
				cylinder(r=radius+(scale/10),$fn=3,h=thickness);
			}


			//flat, top
			else if (type[s][t-1]==2)
			{
				translate([sin(t/divisor)*(scale+1),cos(t/divisor)*(scale+1),0]) 
				rotate([0,0,-t/divisor-rotation2])
				translate ([-radius,-radius/2,0]) cube([radius*2+0.5,radius+0.5,thickness], center=1);
			}
		}

		//Key and shaft hole
		union()
		{
			difference()
			{
				//Inner circle
				cylinder(r=scale+(scale/10),h=thickness);
				//Shaft hole
				cylinder(r=hole,h=thickness+1,$fn=16);
				//Key hole
				translate([0,scale/2,0])cylinder(r=1.5,h=1,$fn=16);
				//Number
				translate([-2,-7,thickness-1]) write(str(s+1),bold=1,h=4,t=2,font="orbitron.dxf"); 
			}
			//Key
			translate([0,scale/2,thickness])cylinder(r=0.7,h=1);
		}
	}
	if (show_microswitches==1)
	{
		translate([switch_x,switch_y,(s*switch_spacing)+switch_z])microswitch();
	}
}