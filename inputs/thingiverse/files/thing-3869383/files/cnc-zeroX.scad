//customisation alfawise c10 - axe X nouvelle pièce pour intégrer la fixation d'un début de course
echo(version=version());

epsilon=0.1;
long_moteur=42;
diam_tete_vis=6;
diam_vis=3.2;
epaisseur_fixation_vis=1;
entraxe_vis=31;
epaisseur_platine=8;
largeur_platine=10;
long_inter=35;
larg_inter=20;
haut_inter=3;
diam_fix_inter=2.7;
pas_fix_inter=5;//un pas depuis le bord, deux pas entre les deux trous et un autre pas jusqu'à l'autre bord
retrait_inter=7;

difference(){
    union(){
        //fixation
        cube([largeur_platine,epaisseur_platine,long_moteur],0);
        //platine support inter
        translate([0,-epaisseur_platine,long_moteur-(long_moteur-entraxe_vis)/2-diam_tete_vis/2-haut_inter]){
            cube([long_inter,larg_inter,haut_inter],0);
        }
        
    }
    union(){
        //2x tete+vis moteur
        union(){
            //tete vis du bas
            translate([epaisseur_fixation_vis,epaisseur_platine/2,(long_moteur-entraxe_vis)/2]){
                rotate([0,90,0]){
                    cylinder(largeur_platine-epaisseur_fixation_vis+epsilon,(diam_tete_vis/2),(diam_tete_vis/2),$fn=32);
                }
            }
            //trou vis du bas
            translate([-epsilon,epaisseur_platine/2,(long_moteur-entraxe_vis)/2]){
                rotate([0,90,0]){
                    cylinder(largeur_platine-epaisseur_fixation_vis+epsilon,(diam_vis/2),(diam_vis/2),$fn=32);
                }
            }
            //tete vis du haut
            translate([epaisseur_fixation_vis,epaisseur_platine/2,long_moteur-(long_moteur-entraxe_vis)/2]){
                rotate([0,90,0]){
                    cylinder(long_moteur+epsilon,(diam_tete_vis/2),(diam_tete_vis/2),$fn=32);
                }
            }
            //trou vis du haut
            translate([-epsilon,epaisseur_platine/2,long_moteur-(long_moteur-entraxe_vis)/2]){
                rotate([0,90,0]){
                    cylinder(largeur_platine-epaisseur_fixation_vis+epsilon,(diam_vis/2),(diam_vis/2),$fn=32);
                }
            }
        }
        //2x vis inter
        union(){
            //coté avant
            translate([long_inter-retrait_inter,pas_fix_inter-epaisseur_platine,long_moteur-(long_moteur-entraxe_vis)/2-diam_tete_vis/2-haut_inter-epsilon]){
                cylinder(haut_inter+2*epsilon,diam_fix_inter/2,diam_fix_inter/2,$fn=32);
            }
            //coté rail
            translate([long_inter-retrait_inter,3*pas_fix_inter-epaisseur_platine,long_moteur-(long_moteur-entraxe_vis)/2-diam_tete_vis/2-haut_inter-epsilon]){
                cylinder(haut_inter+2*epsilon,diam_fix_inter/2,diam_fix_inter/2,$fn=32);
            }
        }
    }
}

