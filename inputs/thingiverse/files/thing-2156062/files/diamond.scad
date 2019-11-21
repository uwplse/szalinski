// Width of the wider part.
width1 = 50;
// Width of the opening.
width2 = 32;
// Distance from the point to the widest part.
height1 = 35;
// Distance from the widest part to the opening.
height2 = 10;
// Number of sides/points.
sides = 9; // [3:15]


module diamond(w, w2, h1, h2) {
    $fn=sides;
    cylinder(d1=0, d2=w, h=h1);
    translate([0, 0, h1]) cylinder(d1=w, d2=w2, h=h2);
}

module dvase(w, w2, h1, h2) {
    difference() {
            diamond(w, w2, h1, h2);
            translate([0, 0, 3]) diamond(w-3, w2-3, h1-3, h2);
            translate([0, 0, h1-.1]) cylinder(d=w2-4, h=h2+1);
    }
}

rotate([180, 0, 0]) dvase(width1, width2, height1, height2);
