
Diametre_bobine_en_mm = 60 ; 
Largeur_bobine_en_mm = 40 ; 
Epaisseur_de_la_paroi_en_mm = 5 ; 
Facette = 60 ;


$fn=Facette;
exterieur = Diametre_bobine_en_mm / 2 ; 

difference(){

cylinder ( h=Largeur_bobine_en_mm, r=exterieur ); // exterieur 
cylinder ( h=100, r=8 ); // intérieur
translate ([0,0,14.1]) cylinder ( h=100, r=11.45 ); // logement roulement
translate ([0,0,20.1]) cylinder ( h=Largeur_bobine_en_mm + 300, r=exterieur - Epaisseur_de_la_paroi_en_mm ); 
 
}


