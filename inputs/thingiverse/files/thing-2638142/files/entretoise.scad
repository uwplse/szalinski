$fn=120; // résolution 

diam_buse=0.4;          // penser à la compenstion http://reprap.org/wiki/ArcCompensation si vous êtes sur mettre 0
                        // laisser 0 ou reneigner le diametre de la buse
entraxe=100;            // entraxe des vis en mm
diam_vis=12;            // diametre des vis en mm   
epaisseur_z=2;          // epaisseur de la piece en mm
epaisseur_bord=5;       // epaisseur des bords en mm




linear_extrude(epaisseur_z){ // "épaississement" de la piece par rapport à l'epaisseur_z
difference(){
hull(){
translate ([entraxe/2,0,0 ])     circle (d=diam_vis +(epaisseur_bord*2), center = true);   // diam_vis exentré + epaisseur_bord en X
translate ([-entraxe/2,0,0 ])    circle (d=diam_vis +(epaisseur_bord*2), center = true);  // diam_vis exentré + epaisseur_bord  en -X
      }
hull(){
translate ([entraxe/2,0,0 ])    circle (d=diam_vis+(diam_buse/2), center = true); // diametre des vis en mm exentré en X
translate ([-entraxe/2,0,0 ])    circle (d=diam_vis+(diam_buse/2), center = true); // diametre des vis en mm exentré en -X
      }
            }
                           }