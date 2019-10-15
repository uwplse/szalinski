/*
** Corner part for box
**
** Licence Creative commens : CC-BY
** By : Dave Borghuis
** Email : dave@daveborghuis.nl
** Project page (work in progress) : https://tkkrlab.nl/wiki/Arcade_RetroPie
**  
*/

// preview[view:north, tilt:top]

/* [Corner Bracket] */
//Size of corner block in mm
$size = 20;
//Wall thickness
$wall = 7;
//Hight in mm
$hight = 50; 
//Solid block
$hight = 50; 

/* [Advanced options] */
//Diameter for screw in mm
$screw_diameter = 4;
//thickness of plate in mm (keep wall thickness in mind)
$plate = 2.2; 
//Solid cube (without overhang)
inner_cube = true; // [true:Small,false:Medium]

/* [Hidden] */
//distanse from nearest edge in mm
$screwdistance = 8; 
//Size of overlap in mm
$plateLengt = 20; 
//calculations are done radius, convert diameter to radius.
$screwsize = $screw_diameter/2;

union() {
    //main corner
    difference() {
        cube([$size,$size,$hight]); //outer
        if (inner_cube) translate ([$wall,$wall,$wall]) {
            cube([$size+$plateLengt,$size+$plateLengt,$hight-(2*$wall)]); //inner
        }
        //top and bottom screw
        translate ([$size/2,$size/2,$hight]) rotate ([0,0,90]) cylinder (h = 2*$hight , r=$screwsize, center = true, $fn=100); 
    }

    //Side plates
    difference() {
        //left plate
        translate ([$size,$plate,0]) {
            cube([$plateLengt,$wall-$plate,$hight]) color([255,0,0]); //inner
        }
        //screws
        translate ([$size+$plateLengt/2,$wall,$hight-$screwdistance]) rotate ([90,0,0]) cylinder (h = 2*$wall , r=$screwsize, center = true, $fn=100);
        translate ([$size+$plateLengt/2,$wall,$screwdistance]) rotate ([90,0,0]) cylinder (h = 2*$wall , r=$screwsize, center = true, $fn=100);
    }
    
    difference() {    
        //right plate
        translate ([$plate,$size,0]) {
            cube([$wall-$plate,$plateLengt,$hight]) color([255,0,0]); //inner
        }
        //screws
        translate ([$wall,$size+$plateLengt/2,$hight-$screwdistance]) rotate ([0,90,0]) cylinder (h = 2*$wall , r=$screwsize, center = true, $fn=100);
        translate ([$wall,$size+$plateLengt/2,$screwdistance]) rotate ([0,90,0]) cylinder (h = 2*$wall , r=$screwsize, center = true, $fn=100);
    }
}
