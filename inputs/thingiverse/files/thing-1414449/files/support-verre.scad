

diametre_bas=50;
diametre_haut=80;
hauteur=100;
epaisseur=4;

hauteur_main=120;
largeur_main=25;
rayon_raccordement=10;
longueur_appui=20;
largeur_anse=50;

//epaisseur_mini=0.1;
precision=30;
$fn=precision;

function distance(v1,v2)=sqrt((v2[0]-v1[0])*(v2[0]-v1[0])+(v2[1]-v1[1])*(v2[1]-v1[1]));
function new_atan(v1,v2) = (v2[0]>=v1[0]) ? 
    90-atan((v2[1]-v1[1])/(v2[0]-v1[0])) : -90-atan((v2[1]-v1[1])/(v2[0]-v1[0]));
    
coeff_dir=(2*hauteur)/(diametre_haut-diametre_bas);
theta=atan(coeff_dir);
haut=hauteur_main-rayon_raccordement*(1-cos(theta));
x_zero=epaisseur+(diametre_bas/2)+(haut/coeff_dir);
x_un=x_zero+rayon_raccordement*sin(theta);
x_deux=x_zero+largeur_main+rayon_raccordement;
largeur_arc_to_arc=largeur_main-rayon_raccordement*(1+sin(theta));

/*
module mini3D(v1,v2){
    translate([v1[0],0,v1[1]]) rotate([0,new_atan(v1,v2),0])
            cylinder(r=epaisseur_mini,h=distance(v1,v2));
}
*/
/*
module anse_aux_2() {
    union(){
        translate([0,-(largeur_anse-epaisseur)/2,-epaisseur/2]) 
            cylinder(r=epaisseur/2,h=epaisseur);
        cube([epaisseur,largeur_anse-epaisseur,epaisseur],center=true);
        translate([0,(largeur_anse-epaisseur)/2,-epaisseur/2]) 
            cylinder(r=epaisseur/2,h=epaisseur);
    }
}
*/

module mini3D(v1,v2){
    dis=distance(v1,v2);
    translate([v1[0],0,v1[1]]) rotate([0,new_atan(v1,v2),0])
        union(){
            translate([0,-(largeur_anse-epaisseur)/2,0]) 
                cylinder(r=epaisseur/2,h=dis);
            translate([0,0,distance(v1,v2)/2])
                cube([epaisseur,largeur_anse-epaisseur,dis],center=true);
            translate([0,(largeur_anse-epaisseur)/2,0]) 
                cylinder(r=epaisseur/2,h=dis);
    }
}

module arc_de_cercle_aux(x_centre,y_centre,rayon,theta_1,theta_2,prec,i){
    if (i<prec)
        union(){
        mini3D([x_centre+rayon*cos(theta_1+i*(theta_2-theta_1)/prec),
                y_centre+rayon*sin(theta_1+i*(theta_2-theta_1)/prec)],
               [x_centre+rayon*cos(theta_1+(i+1)*(theta_2-theta_1)/prec),
                y_centre+rayon*sin(theta_1+(i+1)*(theta_2-theta_1)/prec)]);
        arc_de_cercle_aux(x_centre,y_centre,rayon,theta_1,theta_2,prec,i+1);
            };
 }
module arc_de_cercle(x_centre,y_centre,rayon,theta_1,theta_2,prec){  
     arc_de_cercle_aux(x_centre,y_centre,rayon,theta_1,theta_2,prec,0);}
/////////////////////////////////////////////////////////////////////////////////////
     
module support_aux() {
    cylinder(h=hauteur,d1=diametre_bas,d2=diametre_haut);
}

module support() {
    
    difference(){
        minkowski(){support_aux();sphere(epaisseur);};
        support_aux();
        translate ([0,0,hauteur+epaisseur/2]) 
            cube([diametre_haut+2*epaisseur,diametre_haut+2*epaisseur,epaisseur],
                        center=true);} 
}

/////////////////////////////////////////////////////////////////////////////////////

module raccord() {    
    coeff_dir=(2*hauteur)/(diametre_haut-diametre_bas);
    theta=atan(coeff_dir);
    haut=hauteur_main-rayon_raccordement*(1-cos(theta));
    mini3D([epaisseur+diametre_bas/2,0],[epaisseur+(diametre_bas/2)+(haut/coeff_dir),haut]);  
}
module rayon_raccord_1() {
    arc_de_cercle(x_zero+rayon_raccordement*sin(theta),hauteur_main-rayon_raccordement,         rayon_raccordement,90,90+theta,precision);
}
module tranche_main() {
    mini3D([x_un,hauteur_main],[x_un+largeur_arc_to_arc,hauteur_main]);
}
module rayon_raccord_2() {
    arc_de_cercle(x_zero+largeur_main-rayon_raccordement,hauteur_main-rayon_raccordement,
        rayon_raccordement,0,90,precision);
}
module hauteur_anse() {
    mini3D([x_zero+largeur_main,hauteur_main-rayon_raccordement],
        [x_zero+largeur_main,rayon_raccordement-epaisseur/2]);
}
module rayon_raccord_3() {
    arc_de_cercle(x_deux,rayon_raccordement-epaisseur/2,rayon_raccordement,180,270,precision);
}
module appui() {
   mini3D([x_deux,-epaisseur/2],[x_deux+longueur_appui,-epaisseur/2]);
}
module anse_aux() {
    raccord();
    rayon_raccord_1();
    tranche_main();
    rayon_raccord_2();
    hauteur_anse();
    rayon_raccord_3();
    appui();
}
module anse() {
    //minkowski(){anse_aux();cube([epaisseur,largeur_anse,epaisseur],center=true);};
    anse_aux();
}
/////////////////////////////////////////////////////////////////////////////////////

module support_de_verre(){
    support();
    translate([-epaisseur/2,0,0])anse();
}
/////////////////////////////////////////////////////////////////////////////////////


support_de_verre();
