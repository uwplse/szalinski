use <MCAD/involute_gears.scad>
$fn =100;
difference()
{
  color("black")
  rotate(0,[0,0,0])   
	translate([0,0,1])	
	cylinder(r=91.46+10, h=4);

color("white")
  rotate(0,[0,0,1])   
	translate([0,0,0])				//  centro
	gear(  								//  ANILLO
		number_of_teeth=96,
		circular_pitch=336,
		pressure_angle=20,
		clearance = 0.9,
		gear_thickness =6,
		rim_thickness = 6.15,
		rim_width = -5,
		hub_thickness=6.001,
		hub_diameter=80*2,
		bore_diameter=0,
		circles=0
	);
}
color("white")
   rotate(15,[0,0,1]) 
	translate([0,0,0])   		// centro
	gear(									// SOL
		number_of_teeth=12,
		circular_pitch=336,
		pressure_angle=20,
		clearance = 0.5,
		gear_thickness =5,
		rim_thickness = 6.15,
		rim_width = 6,
		hub_thickness=6.15,
		hub_diameter=16,
		bore_diameter=6.15,
		circles=0
	);
color("blue")
    translate([50.4,0,0])		// centro
	gear(									// PLANETA
		number_of_teeth=42,
		circular_pitch=336,
		pressure_angle=20,
		clearance = 0.5,
		gear_thickness =5,
		rim_thickness = 6.15,
		rim_width = 6,
		hub_thickness=6.15,
		hub_diameter=16,
		bore_diameter=6.15,
		circles=0
	);
color("yellow")
    rotate(120,[0,0,1])
    translate([50.4,0,0])
	gear(
		number_of_teeth=42,
		circular_pitch=336,
		pressure_angle=20,
		clearance = 0.5,
		gear_thickness =5,
		rim_thickness = 6.15,
		rim_width = 6,
		hub_thickness=6.15,
		hub_diameter=16,
		bore_diameter=6.15,
		circles=0
	);
color("red")
    rotate(240,[0,0,1])
    translate([50.4,0,0])
	gear(
		number_of_teeth=42,
		circular_pitch=336,
		pressure_angle=20,
		clearance = 0.5,
		gear_thickness =5,
		rim_thickness = 6.15,
		rim_width = 6,
		hub_thickness=6.15,
		hub_diameter=16,
		bore_diameter=6.15,
		circles=0
	);




// circular_pitch=false,
//	   The usual definition is that this is the distance along the pitch circle from one tooth to the same point on the next tooth.
//	   (The pitch circle lies roughly halfway between the tips of the teeth and the valleys between them.)
//	   Standard practice is circular_pitch = pi / diametral_pitch (See the next parameter).
//	   But for murky historical reasons,  the gear() code defines circular_pitch = 180 / diametral_pitch.
//	   As a result, if one desires an actual circular pitch of X, then one must specify X * 180 / pi as this parameter.
//	   Either circular_pitch or diametral_pitch must be specified (but not both) and gear() will compute the other.
//	   In order for a pair of gears to mesh properly, their circular pitches must be equal.
//	   
