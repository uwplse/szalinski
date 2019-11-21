

epaisseur_debordement = 0.1;
pas_de_vis=0.5;
rayon=1.5;
precision=20;
precision_cylindre=40;
hauteur=20;
nb_tour=hauteur/pas_de_vis;
hauteur_tete_de_vis=1.65;
diametre_tete_de_vis=5.6;
type_entrainement="cruciforme";//[cruciforme,plat]
longueur_entrainement=1;
largeur_entrainement=0.2;

function norme(v) = sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]);
function minus(v1,v2) = [v2[0]-v1[0],v2[1]-v1[1],v2[2]-v1[2]];
// en y puis en z
function trouve_rotation(v) = [acos(v[2]/norme(v)),
    (v[1]>=0) ? acos(v[0]/(norme(v)*sin(acos(v[2]/norme(v))))) :
               -acos(v[0]/(norme(v)*sin(acos(v[2]/norme(v)))))]; 
module rotate2(r) {
    rotate([0,0,r[1]]) rotate([0,r[0]]) children([0]);
}

//////////////////////////////////////////////////////////////////////////////////////

module mini3D_aux(v) {
    rotate2(trouve_rotation(v))cylinder(r=epaisseur_debordement,h=norme(v),$fn=precision_cylindre);
}
module mini3D(v1,v2) {
   translate(v1) mini3D_aux(minus(v1,v2));
}

module spirale() {
    for (i=[0:precision*nb_tour-1]) {
    mini3D([rayon*cos(i*360/precision),rayon*sin(i*360/precision),i*pas_de_vis/precision],
      [rayon*cos((i+1)*360/precision),rayon*sin((i+1)*360/precision),(i+1)*pas_de_vis/precision]);
        }
}

module empreinte() {
    if (type_entrainement == "cruciforme") 
        union() {
            cube([longueur_entrainement,largeur_entrainement,2],center=true);
            cube([largeur_entrainement,longueur_entrainement,2],center=true);
        };
}
module vis() {
    difference() {
        union() {
            spirale();
            cylinder(r=rayon,h=hauteur,$fn=precision_cylindre);
            translate([0,0,hauteur])
                cylinder(r1=rayon,r2=diametre_tete_de_vis/2,h=hauteur_tete_de_vis,
                    $fn=precision_cylindre);   
                };
        translate([0,0,hauteur+hauteur_tete_de_vis]) empreinte();}
}

vis();