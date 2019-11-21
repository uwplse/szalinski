/**
    David Tre (https://github.com/DavidTre07/)
    02/2016

    Parametric Dice

    Licence: Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)
    http://creativecommons.org/licenses/by-nc-sa/3.0/
*/

// - Size of the dice - Taille du dé
size=15;//[11:1:30]
// - Size of the angles - Taille des angles
angles=3;//[0:1:6]

/* [Hidden] */
artefact=0.05;

module dice_empty() {
    minkowski() {
        //Total of internal_size and angles must be equal to size
        //internal_size=3*size/4;
        //angles=size/4;
        internal_size=(8-angles)*size/8;
        external_size=angles*size/8;
        cube([internal_size,internal_size,internal_size]);
        translate([external_size/2,external_size/2,external_size/2]) sphere(d=external_size,$fn=100);
    }
}

module hole(hsize=1) { //weight calculation with hole_width and hole_height and number of holes
    //[1]=1 hole * 6 * 2 =12 or [6]=6 holes * 2 * 1 =12
    hole_width=[4,3,2,3,2.4,2];
    hole_height=[3,2,2,1,1,1];
    cylinder(d=hole_width[hsize-1],h=hole_height[hsize-1],$fn=100);
}

difference() {
    dice_empty();
    rotate ([180, 0, 0]) //1
        translate([size/2,-size/2,-size-artefact])
            translate([0,0,0]) hole(1);
    rotate ([0, 0, 0]) //6
        translate([size/3,size/4,-artefact]) {
            translate ([0,0,0])          hole(6);
            translate([0,size/4,0])      hole(6);
            translate([0,size/2,0])      hole(6);
            translate([size/3,0,0])      hole(6);
            translate([size/3,size/4,0]) hole(6);
            translate([size/3,size/2,0]) hole(6);
        }
    rotate ([90, 0, 180]) //2
        translate([-size/3,size/3,-artefact]) {
            translate([0,size/3,0])  hole(2);
            translate([-size/3,0,0]) hole(2);
        }
    rotate ([90, 0, 0]) //5
        translate([size/3,size/3,-size-artefact]) {
            translate([0,0,0])           hole(5);
            translate([0,size/3,0])      hole(5);
            translate([size/3,0,0])      hole(5);
            translate([size/3,size/3,0]) hole(5);
            translate([size/6,size/6,0]) hole(5);
        }
    rotate ([0, 90, 180]) //3
        translate([-size/3,-size/3,-size-artefact]) {
            translate([0,0,0])             hole(3);
            translate([-size/3,-size/3,0]) hole(3);
            translate([-size/6,-size/6,0]) hole(3);
        }
    rotate ([0, 90, 0]) //4
        translate([-size/3,size/3,-artefact]) {
            translate([0,0,0])            hole(4);
            translate([-size/3,size/3,0]) hole(4);
            translate([-size/3,0,0])      hole(4);
            translate([0,size/3,0])       hole(4);
        }
}
