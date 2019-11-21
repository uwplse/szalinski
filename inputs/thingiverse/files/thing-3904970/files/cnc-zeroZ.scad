//customisation alfawise c10 - axe Z (colonne) remplacement du support fraise/laser par une pièce proposant l'emplacement interrupteur
echo(version=version());

epsilon=0.1;
support_long=85;
support_larg=64;
support_haut=34.5;
support_meplat=17;
pas_fix_inter=5;//un pas depuis le bord, deux pas entre les deux trous et un autre pas jusqu'à l'autre bord
diam_fix_inter=2.7;
shift_inter=7;
diam_fraise=45;
decal_fraise_x=support_long-(diam_fraise/2)-4.5;
decal_fraise_y=9.4+(diam_fraise/2);
decal_fraise_z=support_haut-32.6;
larg_laser=33.8;
decal_laser_x=support_long-10-larg_laser;
decal_laser_y=(support_larg-larg_laser-1)/2;
decal_laser_z=support_haut-32.6;
diam_arret=42.5;
largeur_bride=3;
shift_bride=57;
ecrou_larg=7.8;
ecrou_epai=3.5;
ecrou_prof=10;
ecrou_decal=10;
diam_vis_serrage=4.5;
long_vis_serrage=40;
decal_y_vis_serrage=(9.4/2);
decal_x_vis_serrage=shift_bride-long_vis_serrage+largeur_bride+10;
diam_tete_vis_serrage=2*diam_vis_serrage;
epai_tete_vis_serrage=10;
diam_rondelle=15;
epai_rondelle=2;
diam_renfort=20;
entraxe_glissiere=37.85;
//diam_glissiere=8;
diam_roulement_glissiere=15.15;
diam_vis_fix_moteur=2.5;
entraxe_vis_fix_moteur=16;
diam_trou_moteur=11.5;
decal_axes_vertical=12;
larg_inter=7;
long_inter=21.5;
haut_inter=20;//augmenté pour la place du fil
epai_tete_vis_inter=2.5;
larg_tete_vis_inter=5;
long_vis_inter=20+epai_tete_vis_inter;
diam_vis_inter=3;
decal_inter_y=3;
decal_inter_x=26;
shift_vis_inter=decal_inter_y+2+larg_inter;
pas_fix_inter=5;//un pas depuis le bord, deux pas entre les deux trous et un autre pas jusqu'à l'autre bord
diam_fil_inter=6.5;

module prism(l, w, h){
    polyhedron(
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}
difference(){
    //bloc complet
    union(){
        difference(){
            difference(){
                //support non percé
                difference(){
                        //forme principale
                        cube([support_long,support_larg,support_haut],0);
                    //2 méplats
                    union(){
                        translate([support_long+epsilon,support_larg-support_meplat,-epsilon]){
                            rotate([0,-90,0]){
                                prism(support_haut+2*epsilon,support_meplat+epsilon,support_meplat+epsilon);
                            }
                        }
                        translate([support_long+epsilon,support_meplat,support_haut+epsilon]){
                            rotate([180,90,0]){
                                prism(support_haut+2*epsilon,support_meplat+epsilon,support_meplat+epsilon);
                            }
                        }
                    }
                }
                //trou outil fraise/laser
                union(){
                    //fraise
                    translate([decal_fraise_x,decal_fraise_y,decal_fraise_z]){
                        cylinder(support_haut,(diam_fraise/2)+epsilon,(diam_fraise/2)+epsilon,$fn=128);
                    }
                    //laser
                    translate([decal_laser_x,decal_laser_y,decal_laser_z]){
                        cube([larg_laser,larg_laser,support_haut],0);
                    }
                    //arrêt
                    translate([decal_fraise_x,decal_fraise_y,-epsilon]){
                        cylinder(support_haut,(diam_arret/2)+epsilon,(diam_arret/2)+epsilon,$fn=128);
                    }
                }
            }
            //serrage outil
            union(){
                //fente bride
                translate([shift_bride,-epsilon,-epsilon]){
                    cube([largeur_bride,decal_fraise_y,support_haut+2*epsilon],0);
                }
                //emplacement écrou
                translate([shift_bride-ecrou_decal,-epsilon,(support_haut-ecrou_larg)/2]){
                    cube([ecrou_epai,ecrou_prof,ecrou_larg],0);
                }
                //trou vis
                union(){
                    //vis
                    translate([decal_x_vis_serrage,decal_y_vis_serrage,support_haut/2]){
                        rotate([0,90,0]){
                            cylinder(long_vis_serrage,diam_vis_serrage/2,diam_vis_serrage/2,$fn=16);
                        }
                    }
                    //tete
                    translate([decal_x_vis_serrage+long_vis_serrage-epsilon,decal_y_vis_serrage,support_haut/2]){
                        rotate([0,90,0]){
                            cylinder(epai_tete_vis_serrage,diam_tete_vis_serrage/2,diam_tete_vis_serrage/2,$fn=16);
                        }
                    }
                    //rondelle
                    translate([decal_x_vis_serrage+long_vis_serrage-epsilon,decal_y_vis_serrage,support_haut/2]){
                        rotate([0,90,0]){
                            cylinder(epai_rondelle,diam_rondelle/2,diam_rondelle/2,$fn=16);
                        }
                    }
                }
            }
        }
        //renfort serrage
        difference(){
            translate([shift_bride+largeur_bride,decal_y_vis_serrage,support_haut/2]){
                rotate([0,90,0]){
                    cylinder(decal_x_vis_serrage+long_vis_serrage-(shift_bride+largeur_bride)-epsilon,diam_renfort/2,diam_renfort/2,$fn=16);
                }
            }
            union(){
                //vis
                translate([decal_x_vis_serrage,decal_y_vis_serrage,support_haut/2]){
                    rotate([0,90,0]){
                        cylinder(long_vis_serrage,diam_vis_serrage/2,diam_vis_serrage/2,$fn=16);
                    }
                }
                //fraise
                translate([decal_fraise_x,decal_fraise_y,decal_fraise_z]){
                    cylinder(support_haut,(diam_fraise/2)+epsilon,(diam_fraise/2)+epsilon,$fn=128);
                }
            }
        }
    }
    union(){
        //coulisse et axe moteur
        union(){
            //coulisses
            translate([decal_axes_vertical,(entraxe_glissiere+support_larg)/2,-epsilon]){
                cylinder(support_haut+2*epsilon,(diam_roulement_glissiere/2)+epsilon,(diam_roulement_glissiere/2)+epsilon,$fn=128);
            }
            translate([decal_axes_vertical,(entraxe_glissiere+support_larg)/2-entraxe_glissiere,-epsilon]){
                cylinder(support_haut+2*epsilon,(diam_roulement_glissiere/2)+epsilon,(diam_roulement_glissiere/2)+epsilon,$fn=128);
            }
            //axe moteur
            translate([decal_axes_vertical,support_larg/2,-epsilon]){
                cylinder(support_haut+2*epsilon,(diam_trou_moteur/2)+epsilon,(diam_trou_moteur/2)+epsilon,$fn=128);
            }
            //vis fixation moteur
            translate([decal_axes_vertical-(entraxe_vis_fix_moteur/2),support_larg/2,-epsilon]){
                cylinder(support_haut+2*epsilon,(diam_vis_fix_moteur/2)+epsilon,(diam_vis_fix_moteur/2)+epsilon,$fn=128);
            }
            translate([decal_axes_vertical+(entraxe_vis_fix_moteur/2),support_larg/2,-epsilon]){
                cylinder(support_haut+2*epsilon,(diam_vis_fix_moteur/2)+epsilon,(diam_vis_fix_moteur/2)+epsilon,$fn=128);
            }
            translate([decal_axes_vertical,support_larg/2+(entraxe_vis_fix_moteur/2),-epsilon]){
                cylinder(support_haut+2*epsilon,(diam_vis_fix_moteur/2)+epsilon,(diam_vis_fix_moteur/2)+epsilon,$fn=128);
            }
            translate([decal_axes_vertical,support_larg/2-(entraxe_vis_fix_moteur/2),-epsilon]){
                cylinder(support_haut+2*epsilon,(diam_vis_fix_moteur/2)+epsilon,(diam_vis_fix_moteur/2)+epsilon,$fn=128);
            }
        }
        //emplacement interrupteur
        union(){
            //emplacement inter
            translate([decal_inter_x,support_larg-(decal_inter_y+larg_inter),support_haut-haut_inter+epsilon]){
                cube([long_inter,larg_inter,haut_inter],0);
            }
            //encoche vis 1
            translate([decal_inter_x+pas_fix_inter-(diam_vis_inter/2),support_larg-shift_vis_inter,support_haut-shift_vis_inter+epsilon+2]){
                cube([diam_vis_inter,long_vis_inter,shift_vis_inter],0);
            }
            //encoche vis 2
            translate([decal_inter_x+pas_fix_inter*3-(diam_vis_inter/2),support_larg-shift_vis_inter,support_haut-shift_vis_inter+epsilon+2]){
                cube([diam_vis_inter,long_vis_inter,shift_vis_inter],0);
            }
            //encoche tête de vis 1
            translate([decal_inter_x+pas_fix_inter-(larg_tete_vis_inter/2),support_larg-shift_vis_inter-epai_tete_vis_inter,support_haut-shift_vis_inter+epsilon+2]){
                cube([larg_tete_vis_inter,epai_tete_vis_inter,shift_vis_inter+epai_tete_vis_inter/2],0);
            }
            //encoche tête de vis 2
            translate([decal_inter_x+pas_fix_inter*3-(larg_tete_vis_inter/2),support_larg-shift_vis_inter-epai_tete_vis_inter,support_haut-shift_vis_inter+epsilon+2]){
                cube([larg_tete_vis_inter,epai_tete_vis_inter,shift_vis_inter+epai_tete_vis_inter/2],0);
            }
            //trou fil inter
            translate([decal_inter_x+(long_inter/2),support_larg+epsilon,support_haut-haut_inter+epsilon+(diam_fil_inter/2)]){
                rotate([90,0,0]){
                    cylinder(decal_inter_y+2*epsilon,(diam_fil_inter/2)+epsilon,(diam_fil_inter/2)+epsilon,$fn=8);
                }
            }
        }
    }
}