// Flat Box by JoJoNeiL
// Version Francaise
// Last Rev = 21 oct. 2016
// Creative Commons - Attribution - Non-Commercial license.
// http://www.thingiverse.com/jojoneil/about
// www.jojoneil.net



// ---
// --- A PARAMETRER
// ---

// --- PIED
// nombre de facettes (plus le chiffre est élevé plus les cylindres seront lisses)
Smooth =       120; 


// Diamètre externe du pare buée du telescope
CylDia =       140;
// Hauteur du support où le pare buée s'emboite
CylHt =        30; 
// Epaisseur du cylindre
CylThick =      2; 
// Hauteur de butée
StopHt =        3; 
// Epaisseur de butée
StopDia =       3; 
// Hauteur de la boite
BoxHt =         10;
// Epaisseur des tranchées pour insérer les parois
Trench =       2.5; 
// Epaisseur de "murs" autour des tranchées
WallT =           2; 



// --- Couvercle
// Largeur du trou d'alimentation
AlimW =       8.5;
// Hauteur du trou d'alimentation
AlimHt =        4; 
// Hauteur de la boite en plus du trou d'alimentation
RoofHt =        2; 
// Epaisseur du couvercle
RoofTk =       0.9; 


// --- PLEXIGLASS HOLDER
// Epaisseur des chanfreins
HoldersT =      1; 
// Hauteur du mur (en plus de l'épaisseur des chanfreins)
SpWallHt =      10; 


// --- SIDES
// Hauteur des parois
SidesHt =      30; 

// ---
// --- FIN DES PARAMETRES
// ---









// ---
// --- NE PAS TOUCHER
// ---

// Définition de la taille externe de la boite
// BODY CREATION OF 1st PIECE
// (rayon du tube + épaisseur du mur + taille du trou pour les parrois + épaisseur du mur)x2
Body = CylDia+(2*Trench)+(WallT*4); 

// Variable : taille totale en hauteur plafond
// TOTAL HEIGHT OF THE ROOF
HtG = RoofTk+AlimHt+RoofHt+WallT;

roof = CylDia;

// MODULE DE CREATION DE MUR
// WALL CREATION MODULE
// mur(Hauteur, Taile interieure, Taille exterieure) 
module mur(ht, int, ext) {
  difference() {
    translate([-ext/2,-ext/2,0]) cube([ext,ext,ht]);
    translate([-int/2,-int/2,-1]) cube([int,int,ht+2]);
  }
}


// MODULE DE CREATION DE TRIANGLE
// MODULE TO EXTRUDE TRIANGLE
// chanfreinprepa(Largeur triangle, hauteur triangle);
module chanfreinprepa(size,ep){
    translate([0,-size,0]){
        difference(){
            cube([size,size,ep]);
            rotate([0,0,-45]) translate([0,0,-1]) cube([size*2,size*2,ep+2]);
        }
    }
}


// MODULE DE CREATION DE CHANFREIN sur 4 cotés
// chanfrein(taille générale,taille du chanfrein,hauteur chenfrein)
module chanfrein(sizegen,size,ep){
    rotate([0,0,0]) translate([-sizegen/2,sizegen/2,0]) chanfreinprepa(size,ep);
    rotate([0,0,180]) translate([-sizegen/2,sizegen/2,0]) chanfreinprepa(size,ep);
    rotate([0,0,90]) translate([-sizegen/2,sizegen/2,0]) chanfreinprepa(size,ep);
    rotate([0,0,-90]) translate([-sizegen/2,sizegen/2,0]) chanfreinprepa(size,ep);
}


// ---
// ---









// ---
// --- définition de la piece PIED
// --- FOOT PART
// ---
translate([0,0,HtG+SidesHt+SpWallHt+50]){
    difference(){
            union(){
                //Création de la boite principale
                translate([-Body/2,-Body/2,0]) cube([Body,Body,BoxHt]);
                // Cylindre exterieur (pour créer le rebord du cylindre qui s'emboite autour du pare buée)
                translate([0,0,BoxHt]) cylinder(h=CylHt,d=CylDia+(CylThick*2),$fn=Smooth);
                // Cylindre pour créer la butée
                cylinder(h=StopHt,d=CylDia-StopDia,$fn=Smooth);
            }
            // Cylindre intérieur pour créer trou du Ø du pare buée en donnant la hauteur de la butée)
            translate([0,0,StopHt]) cylinder(h=CylHt*2,d=CylDia,$fn=Smooth);
            // Cylindre trou du Ø de la butée
            translate([0,0,-1]) cylinder(h=BoxHt+2,d=CylDia-(StopDia*2),$fn=Smooth);
            // Création d'un trou pour installer les parois (avec une marge qui récupère l'épaisseur des "murs" autour du trou (WallT) entre les trous parois et le Ø du pare buée)
            translate([0,0,-2]) mur(BoxHt, CylDia+(WallT*2), CylDia+(2*Trench)+(WallT*2));
     }
}    
// ---




// ---
// --- Création de support de plaque plexi
// --- PLEXIGLASS HOLDER PART
// ---
translate([0,0,HtG+SidesHt+30]){
        // création d'un mur qui va frotter les 4 parois
        mur(HoldersT+SpWallHt,CylDia,CylDia+(WallT*2));
        // création de 4 triangles pour supporter la plaque
        chanfrein(CylDia+(WallT*2),CylDia/4,HoldersT);
}

// ---






// ---
// --- Création des parois
// --- SIDES PART
// ---
 translate([0,0,HtG+10]){
    rotate(0,180,0){
         // Créations de murs
        difference(){
        mur(SidesHt, Body-((2*Trench)+(WallT*2)),Body-(WallT*2));
        translate([-roof/2+1,-roof/2,-1]) mirror() cube([Trench+(WallT*2)+2,AlimW,AlimHt+1]);
        }
    }
}
// ---

 



// ---
// --- PIECE COUVERCLE
// --- ROOF PIECE
// ---
translate([0,0,0]){
    difference(){
        
        // création de la boite
        translate([-Body/2,-Body/2,0]) cube([Body,Body,HtG]);
        //création du trou central 
        translate([-roof/2,-roof/2,RoofTk]) cube([roof,roof,HtG]);
        // Création des murs pour inserrer les parois
        translate([0,0,RoofTk]) mur(BoxHt, CylDia+(WallT*2), CylDia+(2*Trench)+(WallT*2));
        // Création du trou pour passer l'alimentation
        translate([-roof/2+1,-roof/2,RoofTk]) mirror() cube([Trench+(WallT*2)+2,AlimW,AlimHt]);
    }
}
// ---











