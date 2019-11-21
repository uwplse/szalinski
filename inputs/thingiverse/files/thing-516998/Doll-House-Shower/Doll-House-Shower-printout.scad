///////////////////////////////////////////////////////////////////////////////
/////////////////////////// Doll House Shower //////////////////////////////////
/*/////////////////////////////////////////////////////////////////////////////
date started: 10/22/2014
date finished:
modeler:		
copyright:		N/A
comments:		For Katie's school project
*////////////////////////////////////////////////////////////////////////////////
/////////////////////////// - Paramaters - ////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
//$fn=50;
use <MCAD/boxes.scad>;
// height = 80; // 80mm

// How tall should the shower be in mm? [10:145] All other measurements and dimensions will auto-adjust.
height = 80; // [10:145]


////////////// math //////// - Don't Change - //////////////// math ////////////
width = height/1.6; // 1.6
length = height/(1.6*2); // 3.0
wall = height/10; // 10
corner_rad = height/32; // 2.5mm
///////////////////////////////////////////////////////////////////////////////
//////////////////////////// - Renders - //////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
rotate([-90,0,0])
//rotate([-00,0,0])
{
	shower_box();
	nozzle();
	handle();
	drain();
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////// - Modules - /////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
module shower_box()
{
	difference()
	{
		roundedBox([width, length, height], corner_rad, false);
		translate([0,-wall/2,0]) roundedBox([width-wall, length, height-wall], corner_rad, false);
		translate([0,wall/2,-(height/2)-wall/2]) cylinder(h = wall*2, r=corner_rad*1.6);
		translate([width/2,0,-((height/4)-(wall/4))]) roundedBox([wall*2, (length-wall*1.6), ((height-(wall+wall))/2)], corner_rad, false); // ** (2) // ** (1)
		translate([width/2,0,((height/4)-(wall/4))]) roundedBox([wall*2, (length-wall*1.6), ((height-(wall+wall))/2)], corner_rad, false); // ** (2) // ** (1)
		translate([-width/2,0,-((height/4)-(wall/4))]) roundedBox([wall*2, (length-wall*1.6), ((height-(wall+wall))/2)], corner_rad, false); // ** (2) // ** (1)
		translate([-width/2,0,((height/4)-(wall/4))]) roundedBox([wall*2, (length-wall*1.6), ((height-(wall+wall))/2)], corner_rad, false); // ** (2) // ** (1)
		translate([0,0,height/2]) roundedBox([width-wall*1.6, length-wall*1.6, wall*2], corner_rad, false);
	}
}
///////////////////////////////////////////////////////////////////////////////
module nozzle()
{
	translate([0,0,height/4]) rotate([-45,00,0]) cylinder(h=wall*2, r=corner_rad/1.6);
	translate([0,-(((wall*2)-(wall/4)/sin(90))*sin(45))/2,height/4-(corner_rad*2)]) rotate([-45,00,0]) cylinder(h=wall, r2=corner_rad/1.6, r1=(corner_rad/1.6)*2.5);
}
///////////////////////////////////////////////////////////////////////////////
module handle()
{
	translate([height/15,length/4.8,height/15])
	{
		rotate([-90,0,0])
		{
			cylinder(h=wall/1.6, r=corner_rad/1.6);
			sphere(r = corner_rad);
		}
	}

	translate([-height/15,length/4.8,height/15])
	{
		rotate([-90,0,0])
		{
			cylinder(h=wall/1.6, r=corner_rad/1.6);
			sphere(r = corner_rad);
		}
	}

}
///////////////////////////////////////////////////////////////////////////////
module drain()
{
	for ( i = [1 : 3] )
	{
		translate([0,wall/2,-(height/2)+wall/2.5])
		rotate( [0, 0, i * 360 / 3])
	    cube([corner_rad*4,corner_rad/2,corner_rad/2],center=true);
	}
}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////// - Echos - ///////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
echo(" -- /////////////////////////////////////// --");
echo("$fn //Resolution = ",$fn); //Resolution
//echo(" = ", ); //Description
echo("height = ",height );
echo("corner_rad = ",corner_rad );
echo("width = ",width );
echo("length = ",length );
echo("wall = ",wall," -actually is half this value as the equations in the code divide it by 2 =",wall/2);
//echo("(height-wall*1.6)/corner_rad+5 = ",(height-wall*1.6)/corner_rad+5," ** (1)");
echo("height*0.3985 = ",height*0.3985," ** (2)");
echo("(length-wall*1.6) = ",(length-wall*1.6));
echo("((height-(wall+wall))/2) = ",((height-(wall+wall))/2) );
echo("(-height/(height*0.053125)) = ",(-height/(height*0.053125)) );
echo("((height/4)-(wall/4)) = ",((height/4)-(wall/4)) );
echo("length/29 = ",length/29 );
echo("corner_rad/1.6 = ",corner_rad/1.6 );
echo("-(corner_rad*2) = ",-(corner_rad*2) );
echo("(wall*2)-(wall/2) = ",(wall*2)-(wall/2) );
echo("-(((wall*2)-(wall/4)/sin(90))*sin(45))/2 = ",-(((wall*2)-(wall/4)/sin(90))*sin(45))/2 );
echo("height/4-(corner_rad*2) = ",height/4-(corner_rad*2) );
echo("length/(corner_rad*corner_rad) = ",length/(corner_rad*corner_rad) );
echo("-(height/2)+wall/3.12+.5 = ",-(height/2)+wall/3.12+.5 );
echo("-(height/2)+wall/2.5 = ",-(height/2)+wall/2.5 );
echo(" -- /////////////////////////////////////// --");
echo("clip - ([0,0,0])");
echo("clip - translate([0,0,0]){");
echo("clip - rotate([0,0,0]){");
//echo ("This is ",number,3," and that's it.");
echo(" -- /////////////////////////////////////// --");
///////////////////////////////////////////////////////////////////////////////
////////////////////////////// - Clip_Pad - ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
//	([0,0,0])
//	translate([0,0,0]){
//	rotate([0,0,0]){
//
//  -- Golden Rule of 1.6
//
// roundedBox([width, height, depth], float radius, bool sidesonly);
// EXAMPLE USAGE:
// roundedBox([20, 30, 40], 5, true);
// size is a vector [w, h, d]
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////