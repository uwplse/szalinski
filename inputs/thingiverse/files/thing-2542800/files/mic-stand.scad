/*

Desktop Microphone Stand
Author: Keegan Neave
Website: http://neave.engineering

Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0

This is designed for a Shure 10A microphone but simply adjust the inner and outer diameters according to the taper of your mic and print.  This should make for a snug fit.

*/

$fn=90;

inner_diamater_bottom = 35.4;
inner_diamater_top = 35;

inner_radius_bottom = inner_diamater_bottom / 2;
inner_radius_top = inner_diamater_top / 2;


difference()
{
    union()
    {
        //  Base structure to cut from
        cylinder(h=4, r1 = inner_radius_bottom + 2, r2= inner_radius_bottom + 2); 
        arc(36/2, 86, 4, 45);
    }
    cylinder(h=4, r1= inner_radius_bottom, r2= inner_radius_bottom);
    rotate([0,0,-2]) arc(inner_radius_bottom + 2, 87, 4, 41);
}

arc(27, 28, 3, 45);
arc(37, 38, 3, 45);
arc(47, 48, 3, 45);
arc(57, 58, 3, 45);
arc(67, 68, 3, 45);
arc(77, 78, 3, 45);

/* 
 * Excerpt from... 
 * 
 * Parametric Encoder Wheel 
 *
 * by Alex Franke (codecreations), March 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
*/
module arc(innerradius, radius, height, degrees ) 
{
    $fn=60;
    
    render() 
    {
            if( degrees > 180 )
            {
                difference()
                {
                  difference()
                    {
                        cylinder( r=radius, h=height );
                        cylinder( r=innerradius*1.0001, h=height );
                    }
                    rotate([0,0,-degrees]) arc( innerradius,radius*1.0001, height*1.0001,  360-degrees) ;                    
                }
            }
            else
            {        
                difference() 
                {    
                    // Outer ring
                    rotate_extrude()
                        translate([innerradius, 0, 0])
                            square([radius - innerradius,height]);
                
                    // Cut half off
                    translate([0,-(radius+1),-.5]) 
                        cube ([radius+1,(radius+1)*2,height+1]);
           
                    // Cover the other half as necessary
                    rotate([0,0,180-degrees])
                    translate([0,-(radius+1),-.5]) 
                        cube ([radius+1,(radius+1)*2,height+1]);
                }
            }
        
    }
}