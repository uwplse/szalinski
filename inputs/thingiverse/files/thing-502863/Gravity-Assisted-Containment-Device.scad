/* Input Parameters */

volume=250; /* The target volume of the container. */

conversion=1; // [1:Milliliters (mL),29.5735:Fluid Ounces (fl oz),236.5882:Cups (c)]

sides=12; /* The number of sides to use for the polygon based cylinder. */

// (mm)
thickness=1; /* The thickness of the walls and bottom of the container. */

shape=1; // [1:Tall,0:Wide]

// calculations
ratio=0.6180+shape;
volume_mm3=volume*conversion*1000; // convert ml input into mm3 for calculations
internal_radius=pow(volume_mm3/(sin(180/sides)*cos(180/sides)*sides*ratio*2),1/3);
internal_height=internal_radius*ratio*2;
external_radius=internal_radius+thickness;
external_height=internal_height+thickness;

// statistics
echo("Required XY",external_radius*2);
echo("Required Z",external_height);

// rendering
$fn=sides;
translate([0,0,external_height]){
	rotate([0,180,0]){
		difference(){
			cylinder(r=external_radius,h=external_height);
			translate([0,0,-0.1]){
				cylinder(r=internal_radius,h=internal_height+0.1);
			}
		}
	}
}
