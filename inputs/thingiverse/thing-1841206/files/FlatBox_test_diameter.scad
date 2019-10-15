// Flat Box test diameter by JoJoNeiL
// English Version
// Last Rev = 20 oct. 2016
// Creative Commons - Attribution - Non-Commercial license.
// http://www.thingiverse.com/jojoneil/about
// www.jojoneil.net


// ---
// --- TO BE CUSTOMIZED
// ---

// --- FOOT
// number of sides for the cylinder (more sides will make it smooth, but it will increase the rendering time)
Smooth =       120; 


// outside diameter of dewshield / Diamètre externe du pare buée du telescope
CylDia =      140;
// Height of the cylinder / Hauteur du support où le pare buée s'emboite
CylHt =        30; 
// Thickness of the cylinder / Epaisseur du cylindre
CylThick =      2; 
// Height of the stopper / Hauteur de butée
StopHt =        3; 
// Thickness of the stopper / Epaisseur de butée
StopDia =       3; 


// ---
// --- définition de la piece PIED
// --- FOOT PART
// ---

    difference(){
            union(){
                //Création de la boite principale
                // Cylindre exterieur (pour créer le rebord du cylindre qui s'emboite autour du pare buée)
                translate([0,0,0]) cylinder(h=CylHt,d=CylDia+(CylThick*2),$fn=Smooth);
                // Cylindre pour créer la butée
                cylinder(h=StopHt,d=CylDia-StopDia,$fn=Smooth);
            }
            // Cylindre intérieur pour créer trou du Ø du pare buée en donnant la hauteur de la butée)
            translate([0,0,StopHt]) cylinder(h=CylHt*2,d=CylDia,$fn=Smooth);
            // Cylindre trou du Ø de la butée
            translate([0,0,-1]) cylinder(h=CylHt+2,d=CylDia-(StopDia*2),$fn=Smooth);
     }
  
// ---