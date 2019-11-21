// preview[view:north east, tilt:top diagonal]
//This program allows for the production of easily customizable risers for skateboards.
//Created By: Matthew Kelly
//Date:2-18-13




//This section is for Library Callouts
use <MCAD/boxes.scad>
use <utils/build_plate.scad>
use <write/Write.scad> 

//This section askes the user for the information necessary to generate a custom skateboard riser

//Select the the desired truck hole pattern.
Hole_Pattern="Old School";  //[Old School, New School]

//Enter your desired riser width here in inches.
Riser_Width=2.5;

//Enter your desired riser length here in inches.
Riser_Length=3.25;

//Select the desired minimum riser height.
Riser_Height=.5;  //[0.125:1/8", 0.25:1/4", 0.375:3/8", 0.5:1/2", 0.625:5/8", 0.75:3/4", 0.875:7/8", 1:1"]

//Select the desired riser angle.
Riser_Angle=10;  //[0:20]

//Enter your custom text here.  (Not recommended for 0.125" Risers) (Note riser prints upside down)
Custom_Text="RELENTLESS";

//Select Text Font
Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/braille.dxf":Braille, "write/knewave.dxf":Retro]

//Enter Text Height in millimeters.
Text_Height=6;




//This section is for constants.
Hole_Size_Standard=0.219
*1;  //7/32" Diameter
Hole_Width_Old_School=41.28*1;  //1-5/8" 
Hole_Length_Old_School=63.5*1;  //2-1/2"
Hole_Width_New_School=41.28*1;  //1-5/8"
Hole_Length_New_School=53.98*1;  //2-1/8"



//This section carries out simple standard to metric conversions of the inputs where necessary.

Riser_Height_Metric=Riser_Height*25.4;
Hole_Size_Metric=Hole_Size_Standard*25.4;
Truck_Width_Metric=Riser_Width*25.4;
Truck_Length_Metric=Riser_Length*25.4;


//This section carries out calculations for the riser's general geometry.

Board_Side_Length=Truck_Length_Metric/cos(Riser_Angle); //This is the length of the board-side of the riser.
Angled_Thickness=sin(Riser_Angle)*Board_Side_Length;  //This is the thickness of the angles section of the riser.
Angled_Height=Truck_Length_Metric*sin(Riser_Angle);




//This section builds the riser



//for display only, doesn't contribute to final object
build_plate_selector = 2; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);




if (Hole_Pattern == "Old School")
{
translate([0,0, Riser_Height_Metric])

union() 
{

	difference()
	{

		union() 
		{

			difference()
			{
				translate([0,0,0])
				rotate([Riser_Angle,0,0])
				roundedBox([Truck_Width_Metric, Truck_Length_Metric, Angled_Thickness], 10, true);  //Angled Portion
				

			translate([0,0,-50])cube(size = [100,100,100], center = true); //Blank off the angled portion of the riser.
			}

		translate([0,0,-Riser_Height_Metric/2])roundedBox([Truck_Width_Metric, Board_Side_Length, Riser_Height_Metric], 			10, true);  //Add riser height
		}

	rotate([Riser_Angle,0,0])translate([Hole_Width_Old_School/2,Hole_Length_Old_School/2,-100]) cylinder(h = 200, 				r1 = Hole_Size_Metric/2, r2 = Hole_Size_Metric/2, center = false, $fn=100);

	rotate([Riser_Angle,0,0])translate([-Hole_Width_Old_School/2,Hole_Length_Old_School/2,-100]) cylinder(h = 200,				 r1 = Hole_Size_Metric/2, r2 = Hole_Size_Metric/2, center = false, $fn=100);

	rotate([Riser_Angle,0,0])translate([Hole_Width_Old_School/2,-Hole_Length_Old_School/2,-100]) cylinder(h = 200, 				r1 = Hole_Size_Metric/2, r2 = Hole_Size_Metric/2, center = false, $fn=100);

	rotate([Riser_Angle,0,0])translate([-Hole_Width_Old_School/2,-Hole_Length_Old_School/2,-100]) cylinder(h = 200, 				r1 = Hole_Size_Metric/2, r2 =Hole_Size_Metric/2, center = false, $fn=100);
	}
if (Riser_Angle>4)
{
translate([0,Board_Side_Length/2-(cos(180-90-Riser_Angle)*(Angled_Thickness/2)),Riser_Height+(sin(180-90-Riser_Angle)*(Angled_Thickness/2))])
rotate(90-Riser_Angle,[-1,0,0]) // rotate around the x axis
rotate(90,[0,0,0]) // rotate around the y axis
write(Custom_Text,t=1.5,h=Text_Height*1,center=true, font=Font);
}
else 
{
translate([0,Board_Side_Length/2-(cos(180-90-Riser_Angle)*(Angled_Thickness/2)), -Riser_Height_Metric/2])
rotate(90-Riser_Angle,[-1,0,0]) // rotate around the x axis
rotate(90,[0,0,0]) // rotate around the y axis
write(Custom_Text,t=1.5,h=Text_Height*1,center=true, font=Font);
}


}
}
else 
{
translate([0,0, Riser_Height_Metric])

union() 
{

	difference()
	{

		union() 
		{

			difference()
			{
				translate([0,0,0])
				rotate([Riser_Angle,0,0])
				roundedBox([Truck_Width_Metric, Truck_Length_Metric, Angled_Thickness], 10, true);  //Angled Portion
				

			translate([0,0,-50])cube(size = [100,100,100], center = true); //Blank off the angled portion of the riser.
			}

		translate([0,0,-Riser_Height_Metric/2])roundedBox([Truck_Width_Metric, Board_Side_Length, Riser_Height_Metric], 			10, true);  //Add riser height
		}

	rotate([Riser_Angle,0,0])translate([Hole_Width_New_School/2,Hole_Length_New_School/2,-100]) cylinder(h = 200, 				r1 = Hole_Size_Metric/2, r2 = Hole_Size_Metric/2, center = false, $fn=100);

	rotate([Riser_Angle,0,0])translate([-Hole_Width_New_School/2,Hole_Length_New_School/2,-100]) cylinder(h = 200,				 r1 = Hole_Size_Metric/2, r2 = Hole_Size_Metric/2, center = false, $fn=100);

	rotate([Riser_Angle,0,0])translate([Hole_Width_New_School/2,-Hole_Length_New_School/2,-100]) cylinder(h = 200, 				r1 = Hole_Size_Metric/2, r2 = Hole_Size_Metric/2, center = false, $fn=100);

	rotate([Riser_Angle,0,0])translate([-Hole_Width_New_School/2,-Hole_Length_New_School/2,-100]) cylinder(h = 200, 				r1 = Hole_Size_Metric/2, r2 =Hole_Size_Metric/2, center = false, $fn=100);
	}
if (Riser_Angle>3)
{
translate([0,Board_Side_Length/2-(cos(180-90-Riser_Angle)*(Angled_Thickness/2)),Riser_Height_Metric/2])
rotate(90-Riser_Angle,[-1,0,0]) // rotate around the x axis
rotate(90,[0,0,0]) // rotate around the y axis
write(Custom_Text,t=1.5,h=Text_Height*1,center=true, font=Font);
}
else 
{
translate([0,Board_Side_Length/2-(cos(180-90-Riser_Angle)*(Angled_Thickness/2)), -Riser_Height_Metric/2])
rotate(90-Riser_Angle,[-1,0,0]) // rotate around the x axis
rotate(90,[0,0,0]) // rotate around the y axis
write(Custom_Text,t=1.5,h=Text_Height*1,center=true, font=Font);
}


}
}