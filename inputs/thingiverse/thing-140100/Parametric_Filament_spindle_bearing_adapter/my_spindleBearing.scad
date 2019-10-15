/* spindle bearing adapter for Filament spools
	 by Kevin Osborn 
*/
// dimensions in mm
// How far into the spindle you want the hub
Spindle_length = 8;
// The size of your hole
Spindle_diameter = 32;
// Diameter of your axel/threaded rod
Axel_diameter = 8;
// Thickness in mm of the brim
Brim_height = 3;
// Width of the brim outside the spindle
Brim_width =13;//[0:50]
/* [Advanced] */
Layer_height = .254;
skate_recess_height = 10;
inner_wall_thick = Layer_height *3;
/* [Hidden] */
Brim_diameter = Spindle_diameter+Brim_width;
$fn=100;

difference()
{
  union()// the outside hat
   {
   cylinder(Brim_height,Brim_diameter/2,Brim_diameter/2);	
   translate ([0,0,Brim_height]) cylinder (Spindle_length,Spindle_diameter/2,Spindle_diameter/2);//Spindle part
	
   }
   union()
    {
    cylinder(skate_recess_height,11.75,11.75); // skate bearing recess
    translate([0,0,skate_recess_height +inner_wall_thick]) cylinder(Spindle_length+Brim_height,Axel_diameter/2,Axel_diameter/2);
    }

}


