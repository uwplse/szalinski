////customisation alfawise c10 - axe X nouvelle pièce pour intégrer la fixation d'une fin de course (à l'opposé du moteur
echo(version=version());

epsilon=0.1;
diam_vis=8.2;
diam_roulement=16+epsilon;
diam_fixation=5;
largeur=24.5;
hauteur=16;
longueur=57;
haut_roulement=6+epsilon;
haut_encoche=hauteur-6.3;
haut_vis=hauteur-8.3;
long_encoche=21+2*epsilon;
long_guide=5;
long_vis=longueur-long_encoche-2*long_guide;
haut_inter=haut_encoche+long_encoche;
long_inter=20;
diam_fix_inter=2.5;
pas_fix_inter=5;//un pas depuis le bord, deux pas entre les deux trous et un autre pas jusqu'à l'autre bord
shift_fix_inter=7;
shift_inter=8;

module prism(l, w, h){
    polyhedron(
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}
union(){
    //pièce originale
    difference(){
        //forme de base
        union(){
            cube([largeur,longueur-(largeur/2),hauteur],0);
            translate([(largeur/2),0,0]){
                cylinder(hauteur,(largeur/2),(largeur/2),$fn=32);
            }
        }
        //retraits
        union(){
            //encoche rail
            translate([-epsilon,longueur-(largeur/2)-(long_guide+long_encoche),hauteur-haut_encoche+epsilon]){
                cube([largeur+2*epsilon,long_encoche,haut_encoche],0);
            }
            //trou fixation
            translate([(largeur/2),longueur-(largeur/2)-(long_guide+long_encoche/2),-epsilon]){
                cylinder(hauteur+2*epsilon,diam_fixation/2+epsilon,diam_fixation/2+epsilon,$fn=16);
            }
            //encoche vis
            translate([-epsilon,-(largeur/2),hauteur-haut_vis+epsilon]){
                cube([largeur+2*epsilon,long_vis,haut_vis],0);
            }
            //trou vis
            translate([(largeur/2),0,-epsilon]){
                cylinder(hauteur+2*epsilon,diam_vis/2,diam_vis/2,$fn=32);
            }
            //trou roulement
            translate([(largeur/2),0,haut_vis-haut_roulement]){
                cylinder(hauteur+2*epsilon,diam_roulement/2+epsilon,diam_roulement/2+epsilon,$fn=64);
            }
        }
    }
    //fixation interupteur fin de course
    difference(){
        //platine
        union(){
            translate([largeur-(largeur-diam_roulement)/2,-largeur/2+long_vis-long_inter,0]){
            cube([(largeur-diam_roulement)/2,long_inter,hauteur],0);
        }
        translate([largeur,long_inter-long_guide,0]){
            rotate([90,0,-90]){
                a=[[0,0],[long_inter,0],[long_inter+shift_inter,haut_inter],[shift_inter,haut_inter]];
                linear_extrude((largeur-diam_roulement)/2) polygon(a);
            }
        }}
        //2x trous fixation inter
        union(){
            translate([largeur-(largeur-diam_roulement)/2-epsilon,pas_fix_inter-largeur/2+long_vis-long_inter-shift_inter/2,haut_inter-shift_fix_inter]){
                rotate([0,90,0]){
                    cylinder((largeur-diam_roulement)/2+2*epsilon,diam_fix_inter/2,diam_fix_inter/2,$fn=16);
                }
            }
            translate([largeur-(largeur-diam_roulement)/2-epsilon,3*pas_fix_inter-largeur/2+long_vis-long_inter-shift_inter/2,haut_inter-shift_fix_inter]){
                rotate([0,90,0]){
                    cylinder((largeur-diam_roulement)/2+2*epsilon,diam_fix_inter/2,diam_fix_inter/2,$fn=16);
                }
            }
        }
    }
}