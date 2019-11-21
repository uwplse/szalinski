//inclusion of the write.scad in the Makerbot Customizer
//The directory "write" has to include Write.scad and the dxf-files,
//also the write-directory has to be in the same directory as this file

use <write/Write.scad> //customizer's location
//resolution faces
$fn = 1*50; 

//Symbols

// Number, letter or special character
symbol_1="1";
symbol_2="2";
symbol_3="3";
symbol_4="4";
symbol_5="5";
symbol_6="6";
symbol_7="7";
symbol_8="8";
symbol_9="9";
symbol_10="0";


//Opening position
//The position you want your ring to unlock

opening_position = 1; //[1:Symbol 1,2:Symbol 2,3:Symbol 3,4:Symbol 4,5:Symbol 5,6:Symbol 6,7:Symbol 7,8:Symbol 8,9:Symbol 9,0:Symbol 10]


//Font specifications

font_type = "Letters.dxf"; //[Letters.dxf:Letters,BlackRose.dxf:BlackRose,orbitron.dxf:Orbitron]

//Symbols outside or inside

font_position = 0; //[0:Imprinted,1:Elevated]

//Symbol height in mm

// [mm]
font_height = 6;

//Symbol depth in mm

// [mm]
font_depth = 0.3;

//Geometrical variables (don't touch!)

diameter_in = 1*24.2;
diameter_out = 1*34;
diameter_channel = 1*30;
channel_width = 1*6;

radius_out = diameter_out/2;
radius_in = diameter_in/2;
channel_height = diameter_channel/2 - radius_in;
ring_height = 1*5;
edge = radius_out*tan(18);


module RingCreator()
{
	difference()
	{
		//Polygon
		for(r=[0:10])
		{	
			rotate([0,0,r*36])
			{
				linear_extrude(height = ring_height, convexity = 10, center = true) 
				{		
					polygon(points=[[0,0],[radius_out,edge],[radius_out,-edge]], paths=[[0,1,2]]);
				}
			}
	
		}


		//Cylindrical hole and unlock-gap
		union()
		{
			//Hole
			union()
			{
				cylinder(h=ring_height+1,r=radius_in,center=true);
				//This is for the planned second revision
				//translate([0,0,ring_height/4])cylinder(h=ring_height/2,r=channel_height+radius_in,center=true);
			}

			//Gap
			intersection()
			{
				rotate([0,0,-36*opening_position])translate([radius_out,0,0])cube([radius_out,channel_width,ring_height],center=true);	
				cylinder(h=ring_height+1,r=channel_height+radius_in,center=true);		
			}
		}
	}
}

module OutsideTextCreator()
{
//Textposition
font_tx = radius_out;
font_ty = -font_height/2; 
font_tz = font_height/3.33;

//symbol1
rot_1 = -1*36;
rotate([0,90,rot_1])translate([-font_tz,font_ty,font_tx])
write(symbol_1,h=font_height,t=font_depth,font=font_type);

//symbol2
rot_2 = -2*36;
rotate([0,90,rot_2])translate([-font_tz,font_ty,font_tx])
write(symbol_2,h=font_height,t=font_depth,font=font_type);

//symbol3
rot_3 = -3*36;
rotate([0,90,rot_3])translate([-font_tz,font_ty,font_tx])
write(symbol_3,h=font_height,t=font_depth,font=font_type);

//symbol4
rot_4 = -4*36;
rotate([0,90,rot_4])translate([-font_tz,font_ty,font_tx])
write(symbol_4,h=font_height,t=font_depth,font=font_type);

//symbol5
rot_5 = -5*36;
rotate([0,90,rot_5])translate([-font_tz,font_ty,font_tx])
write(symbol_5,h=font_height,t=font_depth,font=font_type);

//symbol6
rot_6 = -6*36;
rotate([0,90,rot_6])translate([-font_tz,font_ty,font_tx])
write(symbol_6,h=font_height,t=font_depth,font=font_type);

//symbol7
rot_7 = -7*36;
rotate([0,90,rot_7])translate([-font_tz,font_ty,font_tx])
write(symbol_7,h=font_height,t=font_depth,font=font_type);

//symbol8
rot_8 = -8*36;
rotate([0,90,rot_8])translate([-font_tz,font_ty,font_tx])
write(symbol_8,h=font_height,t=font_depth,font=font_type);

//symbol9
rot_9 = -9*36;
rotate([0,90,rot_9])translate([-font_tz,font_ty,font_tx])
write(symbol_9,h=font_height,t=font_depth,font=font_type);

//symbol10
rot_10 = -10*36;
rotate([0,90,rot_10])translate([-font_tz,font_ty,font_tx])
write(symbol_10,h=font_height,t=font_depth,font=font_type);
}

module InsideTextCreator()
{
//Textposition
font_tx = radius_out-font_depth;
font_ty = -font_height/2; 
font_tz = font_height/3.33;

//symbol1
rot_1 = -1*36;
rotate([0,90,rot_1])translate([-font_tz,font_ty,font_tx])
write(symbol_1,h=font_height,t=font_depth+1,font=font_type);

//symbol2
rot_2 = -2*36;
rotate([0,90,rot_2])translate([-font_tz,font_ty,font_tx])
write(symbol_2,h=font_height,t=font_depth+1,font=font_type);

//symbol3
rot_3 = -3*36;
rotate([0,90,rot_3])translate([-font_tz,font_ty,font_tx])
write(symbol_3,h=font_height,t=font_depth+1,font=font_type);

//symbol4
rot_4 = -4*36;
rotate([0,90,rot_4])translate([-font_tz,font_ty,font_tx])
write(symbol_4,h=font_height,t=font_depth+1,font=font_type);

//symbol5
rot_5 = -5*36;
rotate([0,90,rot_5])translate([-font_tz,font_ty,font_tx])
write(symbol_5,h=font_height,t=font_depth+1,font=font_type);
//symbol6
rot_6 = -6*36;
rotate([0,90,rot_6])translate([-font_tz,font_ty,font_tx])
write(symbol_6,h=font_height,t=font_depth+1,font=font_type);

//symbol7
rot_7 = -7*36;
rotate([0,90,rot_7])translate([-font_tz,font_ty,font_tx])
write(symbol_7,h=font_height,t=font_depth+1,font=font_type);

//symbol8
rot_8 = -8*36;
rotate([0,90,rot_8])translate([-font_tz,font_ty,font_tx])
write(symbol_8,h=font_height,t=font_depth+1,font=font_type);

//symbol9
rot_9 = -9*36;
rotate([0,90,rot_9])translate([-font_tz,font_ty,font_tx])
write(symbol_9,h=font_height,t=font_depth+1,font=font_type);

//symbol10
rot_10 = -10*36;
rotate([0,90,rot_10])translate([-font_tz,font_ty,font_tx])
write(symbol_10,h=font_height,t=font_depth+1,font=font_type);
}


if(font_position == 1)
{
	union()
	{
		RingCreator();
		OutsideTextCreator();
	}

}

else
{
	difference()
	{
		RingCreator();
		InsideTextCreator();
	}
}




