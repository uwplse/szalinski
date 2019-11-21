point = 0.376065;
hauteur_typo = 23.56;
hauteur_oeil = 1.5;
hauteur_moule = hauteur_typo - hauteur_oeil;
police = "Linux Libertine G";
taille = 36 * point;
largeur = 26 * point;

// Corps du caractère
difference() {
    // Corps principal
    cube([largeur, taille, hauteur_moule]);
    
    // Cran
    translate([-point, 0, 20 * point])
        rotate([0, 90, 0])
            cylinder(h = largeur + 2 * point, r = 1, $fn = 100);

    // Gouttière
    translate([largeur - 15 * point, 18 * point, -point])
        linear_extrude(height = 3 * point, scale = 14/17)
            square([largeur + 10 * point, taille - 20 * point], center = true);

}

// Lettre Q
translate([largeur, 10 * point, hauteur_moule])
    mirror([1, 0, 0])
        linear_extrude(height = hauteur_oeil)
            text("Q", font = police, $fn = 100);