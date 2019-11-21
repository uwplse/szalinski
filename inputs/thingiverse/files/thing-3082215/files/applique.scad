echo(version=version());

epais=3; // epaisseur des parois et support 
gap =10; // hauteur du support
hauteur = 180 ;// hauteur applique
largeur = 140 ;//largeur applique
corps=true;     // pour avoir l'applique
verre=true;     //pour avoir le verre

// rotate_extrude() always rotates the 2D shape 360 degrees
// around the Z axis. Note that the 2D shape must be either
// completely on the positive or negative side of the X axis.
if (corps)  {
color("red")
union () {
    difference () {
    rotate_extrude($fn=80) //parie demi-cyclindrique de l'applique
    union () {
        translate([largeur/2, 0]) //rayon de 70
            square([epais,hauteur]);// epaisseur 3 mm
        translate ([0,gap]) //support d'ampoule à 3cm (gap) du bas
            square ([largeur/2,epais]); //plateau support d'ampoule
        }
    translate ([-largeur/2 - 5,0,-5])  //pour masquer la moitié du cyclindre
        cube([largeur+10,largeur/2+5,hauteur+10]); //cube plus grand de 5 partout
for (h=[gap+10:15:hauteur-10])         // suite de la fonction différence avec les petits trous h= hauteur des trous
    for (a=[10:10:170])     // a = angle des trous
        translate ([0,0,h]) // translation vers le haut
            rotate ([0,90,-a])// rotation angle
                linear_extrude (largeur/2+10) // tige 
                    translate ([0,-2,0]) // pour avoir le centrage sur le milieu de la tige
                        circle (4);     // forme des trous
union () {
    linear_extrude(gap+epais+2)//trou pour fixer le culot sur le plateau support
        translate ([0,-largeur/4-9,0])
            rotate ([0,0,90]) 
                circle (2.2);
    linear_extrude(gap+epais+2)//trou pour fixer le culot sur le plateau support
        translate ([0,-largeur/4+9,0])
            rotate ([0,0,90]) 
                circle (2.2);
} 
};
difference (){
  translate ([-largeur/2-epais,0,0])
    cube ([largeur+2*epais,epais,hauteur])   ; // plateau arrière
  translate ([0,-2,hauteur-10])     // hauteur du trou
    rotate ([0,90,90])// rotation angle
        linear_extrude (10) // tige 
             circle (3);     // forme du trou pour la vis
 // trou pour passage des cables 
    diamcable=8;
    translate ([0,-2,gap+diamcable+epais])     // hauteur du trou
    rotate ([0,90,90])// rotation angle
        linear_extrude (20) // tige 
            circle (diamcable);     // forme du trou
    // trous fixation du culot 
      translate ([0,-2,gap+diamcable+epais+18])     // hauteur du trou
        rotate ([0,90,90])// rotation angle
            linear_extrude (20) // tige 
                    circle (2.2);     // forme des trous
       translate ([0,-2,gap+diamcable+epais+30])     // hauteur du trou
        rotate ([0,90,90])// rotation angle
            linear_extrude (20) // tige 
                    circle (2.2);     // forme des trous
                   
    };
};
};
// rotate_extrude() uses the global $fn/$fa/$fs settings, but
// it's possible to give a different value as parameter.
//color("cyan")
////union () {
//    linear_extrude(gap+epais+2)//trou pour fixer le culot sur le plateau support
//        translate ([0,-largeur/4-9,0])
//            rotate ([0,0,90]) 
//                circle (4.2);
//    linear_extrude(gap+epais+2)//trou pour fixer le culot sur le plateau support
//        translate ([0,-largeur/4+9,0])
//            rotate ([0,0,90]) 
//                circle (4.2);
//}
//
//
//    translate([40, 0, 0])
//        rotate_extrude($fn = 80)
//            text("  J");

// Using a shape that touches the X axis is allowed and produces
// 3D objects that don't have a hole in the center.
color("green") //vitre de protection ampoule

if (verre) {
translate ([200,0,0])
union (){
    difference () {
    rotate_extrude($fn=80) //parie demi-cyclindrique de l'applique
        translate([largeur/2-epais-1, gap+epais+1]) //rayon de 70
            square([epais/2,hauteur-gap-epais-1]);// epaisseur 3 mm
    translate ([-largeur/2 - 5,0,-5])  //pour masquer la moitié du cyclindre
        cube([largeur+10,largeur/2+5,hauteur+10]); //cube plus grand 
    };
    difference (){
      translate ([-largeur/2+epais-0.5,0,gap+epais+1])
    cube ([largeur-2*epais+1,epais/2,hauteur-gap-epais-1])   ; // plateau arrière
      // trou pour passage des cables 
    translate ([0,-2,70])     // hauteur du trou (-2 pour avoir un trou débouchant)
    rotate ([0,90,90])// rotation angle
        linear_extrude (20) // tige 
              circle (30);     // forme du trou pour passage des cables
        // ouvrir sous ce trou
         translate ([-30,-2,0]) 
        cube ([60,10,70]);
        
        };
};
}

// Written in 2015 by Torsten Paul <Torsten.Paul@gmx.de>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
