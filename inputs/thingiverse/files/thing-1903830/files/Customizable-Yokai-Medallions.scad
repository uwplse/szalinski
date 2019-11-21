
/* [Style] */

// Symbol of yokai, just one character.
symbole = "!";

// Hollow face, harder to print.
hole = 0; //[0,1]

/* [Code] */

// ligne 1.
ligne_1 = [1,1,0,1];

// ligne 2. (type)
ligne_2 = [0,1,1,0];

// ligne 3.
ligne_3 = [1,0,0,0];

// ligne 4.
ligne_4 = [0,1,0,1];

/* [Hidden] */

code = [ligne_1, ligne_2, ligne_3, ligne_4];

$fn = 100;

module face() {
    
    module cartouche_f(hole) {

        module cartouche() {
            face_rayon = 18.7-0.2;
            face_depth = 0.5;
            cartouche_height = 7.2;
            cartouche_start = 14.3-0.2;
            cartouche_height2 = cartouche_height+cartouche_start;
            cartouche_width = 6.46503+0.2;
            difference() {
                circle(r = face_rayon);
                difference() {
                    union() {
                        polygon([[-cartouche_width,-cartouche_height2],[cartouche_width,-cartouche_height2],[0,0]]);
                        polygon([[cartouche_width,cartouche_height2],[-cartouche_width,cartouche_height2],[0,0]]);
                    }
                    square(size = cartouche_start*2, center = true);
                }
            }
        }
        
        if( !hole ) {
            difference() {
                offset(r = 0.2) cartouche();
                offset(r = -0.2) cartouche();
            }
        } else offset(r = 0.2) cartouche();
    }

    cartouche_f(hole);
        
    module holes_face() {
        module hole_face() {
            translate([0,20.1,0])
            circle(r = 0.5, center = true);
        }
    
        for (a =[30:30:170])
            rotate(a, [0, 0, 1])
            hole_face();
    
        for (a =[210:30:340])
            rotate(a, [0, 0, 1])
            hole_face();
    }

    holes_face();
    
    module arrow_face() {
        offset(r = 0.2)
		polygon([[-2.5,43/2-5.2],[2.5,43/2-5.2],[0,43/2-1.6]]);
    }

    arrow_face();

    module symbole_face() {
        rotate(180, [0, 1, 0])
		translate([0, -20.3])
   		text(symbole, font = "Liberation Sans:style=Bold", size=5, halign="center");
    }

    symbole_face();
 }
 
module part3() {
    module part2() {
        module part1() {
            difference() {
                circle(r = 43/2-1.6, center = true);
                translate([7.5, 0])
                square([19+1.6*2, 43], center = true);
            }
        }
        union(){
            difference() {
                offset(r = 1.6) part1();
                part1();
            }
            difference() {
                difference() {
                    circle(r = 17.2, center = true);
                    offset(r = -1.6) circle(r = 17.2, center = true);
                }
                translate([7.5, 0])
                square([19, 43], center = true);
            }
            intersection() {
                circle(r = 43/2, center = true);
                translate([-43/4-2, 0])
                square([43/2, 18.6], center = true);
            }
        } 
    }
    difference() {
        linear_extrude(height = 1.5)
        part2();
        translate([-43/4, 0, 1])
        linear_extrude(height = 1.5)
        offset(r = 0.2)
        square([15-0.4, 16.6-0.4], center = true);
    }
}

translate([0, 0, 4.3-1.5])
part3();

module make_code(code) {
    for (y = [0:3])
        for (x = [0:3])
            if (code[y][x] == 1) {
                translate([x*15.4/4-0.2+0.4, -y*5.76667+12.8, 0.15]) {
                    cube([15.4/4-0.8, 2, 1]);
                    rotate(90, [0, 1, 0])
                    translate([-1, 1, 0])
                    cylinder(r = 1, h = 15.4/4-0.8);
                }
            }
}

color("grey")
union(){
    difference() {
        union(){
            difference() {
                cylinder(r = 43/2, h = 2.8);
                linear_extrude(height = 1, center = true)
                face();
            }
            translate([0, 0, 4.3-1.5])
            part3();
        }
        translate([7.5, 0, 2.3])
        linear_extrude(height = 1)
        square([15.4, 43], center = true);
    }
    translate([0, 0, 2])
    make_code(code);
}
        
 