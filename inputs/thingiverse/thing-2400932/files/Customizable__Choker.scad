/*
** Inspired by SexyCyborg https://www.thingiverse.com/thing:2394831
**
** Licence Creative commens : CC-BY
** By : Dave Borghuis
** Email : dave@daveborghuis.nl
**  
*/

/* [Choker] */
//Choker size in mm (= of your neck) 
choker_circumference = 320; 
choker_Font="write/orbitron.dxf"; //[write/orbitron.dxf:Arbitron , BlackRose.dfx:BlackRose , write/knewave.dfx:Knewave, write/Letters.dfx:Letters]
//User uppercase only, Leave empty for no text on choker
choker_text = "SEXYCYBORG";
/* [Advanced options] */
choker_height = 20;
//Keep this very thing to keep it flexable
choker_thickness = 3;
magnet_height = 17;
magnet_diameter = 4; 

/* [Hidden] */
dia = choker_circumference / PI;
magnetholddia = dia*.25; 

//resolution
$fs = 0.1;
$fa = 5;

use <write/Write.scad>;

difference() {
    union() { 
        translate([dia/2, 0, 0])
        scale([0.5, 1, 1])  cylinder(h = choker_height, d = magnetholddia, center = true); //magnet holder
        cylinder(h = choker_height, d = dia+choker_thickness, center = true); //outer circle
        writecylinder(choker_text,[0,0,0],radius=(dia+choker_thickness)/2 ,h=choker_height*.8, east=-90, font=choker_Font ,center=true);
    }

    //inner circle
    cylinder(h = choker_height+1, d = dia, center = true); 

    //gap for magnet holder
    translate([dia/2, 0, 0])
    cube([30, 2, choker_height], center = true); 

    //holes in magnet holder
    translate([dia/2 + 3 , 3.8, choker_height-magnet_height])
    cylinder(h = magnet_height, d = magnet_diameter, center = true);
    translate([dia/2 + 3, -3.8, choker_height-magnet_height])
    cylinder(h = magnet_height, d = magnet_diameter, center = true);
}