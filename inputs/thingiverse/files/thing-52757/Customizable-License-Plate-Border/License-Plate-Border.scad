include <MCAD/shapes.scad>
use <MCAD/fonts.scad>

//Choose what font you want
thisFont=8bit_polyfont();

x_shift=thisFont[0][0];
y_shift=thisFont[0][1];

// preview[view:south, tilt:top]

//Choose between full size 12in X 6in (311.8) or split (155.9) to fit build platform.
plate=155.9;//[155.9,311.8]

//Change font to fit text in space
font_scale=2;//[1,1.5,2,2.5,3]

//1 goes all the way through, 8 leaves blank
text_depth=3;//[1,2,3,4,5,6,7,8]


//This is the text for the top // Use spaces in front of word to center
top_word="   Hello";

//This is the text for the bottom // Use spaces in front of word to center
bottom_word="   World";


module license_plate_trim();
{
	difference()
	{
		union()
		{
			difference()
			{
				translate([0,0,1])scale([311.8,159.5,6.35])cube(1);
					union()
					{
						linear_extrude(height=10)translate([0,0,-5])polygon(points=[[13.4,13.4],[55,13.4],[60,28.1],[251.8,28.1],[256.1,13.4],[298.4,13.4],[298.4,146.1],[256.1,146.1],[256.1,146.1],[251.1,132.7],[60,132.7],[55,146.1],[13.4,146.1]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12]]);
						translate([66.9,139.4,-1])cylinder(10,4,2);
						translate([66.9,139.4,5])cylinder(5,6,6);
						translate([244.9,139.4,-1])cylinder(10,4,2);
						translate([244.9,139.4,5])cylinder(5,6,6);
						translate([66.9,19.25,-1])cylinder(10,4,2);
						translate([66.9,19.25,5])cylinder(5,6,6);
						translate([244.9,19.25,-1])cylinder(10,4,2);
						translate([244.9,19.25,5])cylinder(5,6,6);
						cube([5,5,10]);
						translate([0,154.5,0])cube([5,5,10]);
						translate([306.8,154.5,0])cube([5,5,10]);
						translate([306.8,0,0])cube([5,5,10]);
						translate([-1,-1,6])cube([55,165,3]);
						translate([257.1,-1,6])cube([55,165,3]);
						translate([60,145,text_depth-2])License_Top_Label();
						translate([60,13,text_depth-2])License_Bottom_Label();
					}
			}
		translate([5,5,1])cylinder(5,5,5);
		translate([5,154.5,1])cylinder(5,5,5);
		translate([306.8,5,1])cylinder(5,5,5);
		translate([306.8,154.5,1])cylinder(5,5,5);
	
		}
translate([plate,-10,0])scale([400,200,20])cube(1);
}
}


module License_Bottom_Label()
	{
	theseIndicies=search(bottom_word,thisFont[2],1,1);
	difference() 
		{
		union() 
			{
				scale([font_scale,font_scale,2])
					{
						for(i=[0:(len(theseIndicies)-1)] ) 
							translate([i*x_shift, -y_shift/2 ,1]) 
						{
							linear_extrude(height=4) polygon(points=thisFont[2][theseIndicies[i]][6][0],paths=thisFont[2][theseIndicies[i]][6][1]);
						}
					}
			}
		}
	}

module License_Top_Label()
	{

	theseIndicies=search(top_word,thisFont[2],1,1);
	difference() 
		{
		union() 
			{
				scale([font_scale,font_scale,2])
					{
						for(i=[0:(len(theseIndicies)-1)] ) 
							translate([ i*x_shift, -y_shift/2 ,1]) 
						{
							linear_extrude(height=4) polygon(points=thisFont[2][theseIndicies[i]][6][0],paths=thisFont[2][theseIndicies[i]][6][1]);

						}
					}
			}
		}
	}
module right_half_license_plate_trim();
{
	difference()
	{
		union()
		{
			translate([-125,-30,1])difference()
			{
				translate([0,0,1])scale([311.8,159.5,6.35])cube(1);
					union()
					{
						linear_extrude(height=10)translate([0,0,-5])polygon(points=[[13.4,13.4],[55,13.4],[60,28.1],[251.8,28.1],[256.1,13.4],[298.4,13.4],[298.4,146.1],[256.1,146.1],[256.1,146.1],[251.1,132.7],[60,132.7],[55,146.1],[13.4,146.1]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12]]);
						translate([66.9,139.4,-1])cylinder(10,4,2);
						translate([66.9,139.4,5])cylinder(5,6,6);
						translate([244.9,139.4,-1])cylinder(10,4,2);
						translate([244.9,139.4,5])cylinder(5,6,6);
						translate([66.9,19.25,-1])cylinder(10,4,2);
						translate([66.9,19.25,5])cylinder(5,6,6);
						translate([244.9,19.25,-1])cylinder(10,4,2);
						translate([244.9,19.25,5])cylinder(5,6,6);
						cube([5,5,10]);
						translate([0,154.5,0])cube([5,5,10]);
						translate([306.8,154.5,0])cube([5,5,10]);
						translate([306.8,0,0])cube([5,5,10]);
						translate([-1,-1,6])cube([55,165,3]);
						translate([257.1,-1,6])cube([55,165,3]);
						translate([60,145,text_depth-2])License_Top_Label();
						translate([60,13,text_depth-2])License_Bottom_Label();
					}
			}
			translate([-125,-30,1])union()
			{
				translate([306.8,5,1])cylinder(5,5,5);
				translate([306.8,154.5,1])cylinder(5,5,5);
				translate([5,5,1])cylinder(5,5,5);
				translate([5,154.5,1])cylinder(5,5,5);
			}
		}
		
	translate([plate-436.9,-40,0])scale([312,200,20])cube(1);
	}
}
