/*
** Inspired by SexyCyborg https://www.thingiverse.com/thing:2394831

** Remix by: Dave Borghuis
** Email : dave@daveborghuis.nl
** https://www.thingiverse.com/thing:2400932
** dynamic choker_circumference and params name

** Remix by: Sandro kensan
** email : kensan@kensan.it
** https://www.thingiverse.com/thing:2831884
** dynamic choker_height, choker_thickness, magnet_height, magnet_diameter and bug fix
** point feature
*/

/* [Choker size] */
//Choker size in mm (circumference of your neck) 
choker_circumference = 320; 

/* [Advanced options] */
choker_height = 20;
//If you change the params the choker change accordly
choker_thickness = 2;
magnet_height = 17;
magnet_diameter = 4; 

/* [Hidden] */
dia = choker_circumference / PI;
magnetholddia = (magnet_diameter/2+0.5)*8;
//resolution
$fs = 0.1;
$fa = 5;

module dog(height)
{
 translate( [height+choker_thickness-choker_height/15, 0, 0] )   sphere(r = choker_height/4);

     
     translate( [height+choker_height/2.5, 0, 0] )
     rotate( 90, [0, 1, 0])
     cylinder(h = choker_height/2, r1 = choker_height/6.6, r2 = 0.3, center = true);
}

difference() {
    union() { 
        translate([dia/2+choker_thickness, 0, 0])
        scale([0.5, 1, 1])  cylinder(h = choker_height, d = magnetholddia, center = true); //magnet holder
    cylinder(h = choker_height, d = dia+choker_thickness*2, center = true); //outer circle
    for ( i = [1:11] ) {
      rotate( i*360/12, [0, 0, 1])
      dog(dia/2);
     }
    }

    //inner circle
    cylinder(h = choker_height+1, d = dia, center = true); 

    //gap for magnet holder
    translate([dia/2, 0, 0])
    cube([30, 2, choker_height+1], center = true); 

    //holes in magnet holder
    translate([dia/2 + magnetholddia/9+choker_thickness/2 , magnet_diameter/2+0.8+1, choker_height/2-magnet_height/2])
    cylinder(h = magnet_height+2, d = magnet_diameter, center = true);
    translate([dia/2 + magnetholddia/9+choker_thickness/2, -magnet_diameter/2-0.8-1, choker_height/2-magnet_height/2])
    cylinder(h = magnet_height+2, d = magnet_diameter, center = true);
}