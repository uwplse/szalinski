//customisation alfawise c10 - axe Y (plateau) nouvelle pièce pour intégrer la fixation d'une fin ou début de course
echo(version=version());

epsilon=0.1;
larg_rail=20;
longueur=35;
hauteur=28;//penser à retirer la hauteur de l'interrupteur+vis qui doit passer sous le plateau
haut_fixation=3;
long_encoche=12;
haut_encoche=15;
larg_axe=8;
diam_fixation=5;
haut_fix_inter=4;
trapeze_min=5.3;
trapeze_max=7.3;
haut_trapeze=3;
pas_fix_inter=5;//un pas depuis le bord, deux pas entre les deux trous et un autre pas jusqu'à l'autre bord
diam_fix_inter=2.7;
shift_inter=7;
long_fixation=longueur-4*pas_fix_inter;

module prism(l, w, h){
    polyhedron(
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}

difference(){
    //pièce de base
    union(){
        //fixation sur rail
        cube([longueur,larg_rail,haut_fixation],0);
        //connexion verticale
        translate([long_fixation,0,0]){
            cube([longueur-long_fixation,larg_axe,hauteur],0);
        }
        //platine inter
        translate([long_fixation,0,hauteur-haut_fix_inter]){
            cube([longueur-long_fixation,larg_rail,haut_fix_inter],0);
        }
        //(trapèze) encoche d'alignement dans le rail (attention, coordonnées négatives, bien vérifier en imprimant)
        union(){
            translate([long_fixation,(trapeze_max-trapeze_min)/2+(larg_rail+trapeze_min)/2,0]){
                prism(longueur-long_fixation,-(trapeze_max-trapeze_min)/2,-haut_trapeze);
            }
            translate([long_fixation,(larg_rail-trapeze_min)/2,-haut_trapeze]){
                cube([longueur-long_fixation,trapeze_min,haut_trapeze],0);
            }
            translate([longueur,(larg_rail-trapeze_min)/2-(trapeze_max-trapeze_min)/2,0]){
                rotate([0,0,180]){
                    prism(longueur-long_fixation,-(trapeze_max-trapeze_min)/2,-haut_trapeze);
                }
            }
        }
    }
    //retraits
    union(){
        //vis fixation
        translate([long_fixation/2,larg_rail/2,-epsilon]){
            cylinder(haut_fixation+2*epsilon,(diam_fixation/2)+epsilon,(diam_fixation/2)+epsilon,$fn=32);
        }
        //2x vis inter
        translate([longueur-pas_fix_inter,larg_rail-shift_inter,hauteur-haut_fix_inter-epsilon]){
            cylinder(haut_fix_inter+2*epsilon,(diam_fix_inter/2)+epsilon,(diam_fix_inter/2)+epsilon,$fn=32);
        }
        translate([longueur-3*pas_fix_inter,larg_rail-shift_inter,hauteur-haut_fix_inter-epsilon]){
            cylinder(haut_fix_inter+2*epsilon,(diam_fix_inter/2)+epsilon,(diam_fix_inter/2)+epsilon,$fn=32);
        }
        //encoche
        translate([longueur-long_encoche,-epsilon,-haut_trapeze-epsilon]){
            cube([long_encoche+epsilon,larg_rail+2*epsilon,haut_encoche+haut_trapeze+epsilon],0);
        }
    }
}
