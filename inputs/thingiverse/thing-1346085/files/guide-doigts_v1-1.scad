/* ==========================================
//  File: guide-doigts_v1-1.scad
//  
//  Description:
//  Guide doigt parametrique
//
//  Auteur : Willy ALLEGRE  
//  Organisation : REHAB-LAB
//
//  Licence : CC-By-SA
// ==========================================*/


// VARIABLES 

// Longueur du guide-doigts
longueur_gd = 100;
// Largeur du guide-doigts
largeur_gd = 80; 
// Epaisseur du guide-doigts
epaisseur_gd = 3;

// Nombre de lignes contenant des trous
nb_ligne_trous = 5;
// Nombre de colonnes contenant des trous
nb_colonne_trous = 4;

// Hauteur des barres laterales
hauteur_bl = 20;
// Largeur des barres laterales
largeur_bl = 5;

// Distance entre trou et barre laterale droite
distance_trou_bl = 0;
// Distance entre trou et bord superieur
distance_trou_bs = 5;
// Diametre des trous
diametre_trous = 15;
// Distance entre chaque trou
d_entre_trous = 18;

// Definition generale des formes geometriques
$fn = 20;

// FIN VARIABLES 




// DESSIN

// Barre laterale gauche
cube (size = [longueur_gd, largeur_bl, hauteur_bl], center = false);

// Barre laterale droite
translate([0,largeur_gd-largeur_bl,0]){ 
    cube (size = [longueur_gd, largeur_bl, hauteur_bl], center = false);
}

// Guide-doigts avec trous
difference() {
    cube (size = [longueur_gd, largeur_gd, epaisseur_gd], center = false);

    for (l = [0:nb_ligne_trous-1]) {
        for (c = [0:nb_colonne_trous-1]) {
            translate(
                [distance_trou_bs+diametre_trous/2+d_entre_trous*l,
                distance_trou_bl+largeur_bl+diametre_trous/2,
                0]) {             
                sphere (d = diametre_trous);
            }
            translate(
                [distance_trou_bs+diametre_trous/2+d_entre_trous*l,
                distance_trou_bl+largeur_bl+diametre_trous/2+d_entre_trous*c,
                0]) {             
                sphere (d = diametre_trous);
            }
        }
    }
}    


// FIN DESSIN