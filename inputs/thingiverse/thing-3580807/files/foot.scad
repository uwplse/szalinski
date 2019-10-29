// tube inner diameter
inner = 37.6;
// tube outer diameter
outer = 40.7;
// foot height
height = 4;
// innter part height
innerHeight = 10;
// inner part wall thickness
thick = 3;
$fn = 50;

difference () {

    union () {
        cylinder (height, outer/2, outer/2);
        translate ([0,0,height]) cylinder (innerHeight, inner/2, inner/2);
    }

    translate ([0,0,height]) cylinder (innerHeight, inner/2-thick, inner/2-thick);
}
