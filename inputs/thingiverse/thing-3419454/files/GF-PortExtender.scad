
/* Glowforge port extender v1
 * Designed by Techyg
 *
 * Purpose: Extend the back 4" port on the glowforge and allow for 
 * an easier time making the connection.  
 * If using the default settings below, you will have an additional 12mm extension
 * There is also a recess (lip) that your connector is meant to sit on to help secure it
 *
 * Print with a semi flex filament, such as Sainsmart TPU. 
 * It is designed to be stretched over the exhaust port and should be very snug. 
 * 
 */ 

//Settings for thickness and diameter below.
//All measurements are milimeters
//Only change if you know what you're doing

$fn=100;
port_od = 95.5; //glowforge outer diameter of exhaust port measured around 97 mm. Minus 1.5mm for tight tolerance
port_depth = 12.5; //length of the port on the GF 
extender_depth = port_depth + 12;
extender_thickness = 4; //thickness of the extender 
extender_od = port_od + extender_thickness;
extender_connect_lip_depth = 10; //where we want the connection to start (measured from bottom)
extender_connect_lip_length = 6; //length of the lip
extender_connect_recess = extender_od-1; //recess of lip


difference()
{
    cylinder(r=extender_od/2, h=extender_depth); //build outer diameter of extender
    cylinder(r=port_od/2, h=extender_depth+1); //subtract inner diameter of extender
    translate([0,0,extender_connect_lip_depth])
    difference() //subtract the "lip"
    {
        cylinder(r=105/2, h=extender_connect_lip_length); //outside lip 
        cylinder(r=extender_connect_recess/2, h=extender_connect_lip_length); //inside lip 
    }
}
