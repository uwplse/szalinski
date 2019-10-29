// L'equipe Braille Rap
// piece parametrable
// couvre buse d'imprimante 3D
// hauteur de la buse
//par Arezki Gasteau
//Licence CCO -1.0

$hauteurCyl = 13;
// nombre de pan de la buse
$panVide = 6;
// taille (taille de cle plate pour devisser la tete de la buse)
$taillePan = 6;
// diametre du couvre buse pour que le plastique ne casse pas en fonction de la taille de la buse
$diametreCyl = 2.1378618*$taillePan;
// hauteur du vide a laisser pour que la buse ne touche pas le couvre buse
$hauteurVide = 10;
// epaisseur du support du pointeau
$decaleVide =[0,0,3];
// diametre des trous optionnels de fixation a la tete
$diametreFixeVide=1;
// diametre du trou pour le pointeau (clou)
diametrePointeau=2;


difference() {        
        cylinder(h=$hauteurCyl, r=$diametreCyl/2, center=false, $fn=50);
        translate($decaleVide){
        cylinder(h=$hauteurVide, r=$taillePan/2, center=false, $fn=$panVide);
            }
        cylinder(h=$hauteurCyl-$hauteurVide, r=$diametrePointeau/2, center=false, $fn=50);
        translate([0,0,($hauteurCyl-2)]) {
            rotate([90,0,0]){
        cylinder(h=$diametreCyl, r=$diametreFixeVide/2, center=true, $fn=50);    
            }
}
}


//echo(version=version());
// Written by Arezki Gasteau
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.