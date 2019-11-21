
//lengh between holes
longueur = 140;
//width
largeur = 16;
//thickness
epaisseur = 2;

//don't touch this
rayon1 = largeur/2;
rayontrou = 3;
rayondecoupe = rayon1-2;
decalage = largeur+10;

difference(){
            union(){
                    cube ([largeur,longueur/2,epaisseur]);
                    translate([rayon1,0,0]) cylinder (epaisseur,rayon1,rayon1,center=false, $fn= 100);
                    translate ([rayon1,longueur/2,0]) cylinder (epaisseur,rayondecoupe,rayondecoupe-2,center=false, $fn= 8);}
            translate([rayon1,0,-1]) cylinder (epaisseur,rayontrou,rayontrou,center=false, $fn= 100); 
            translate([rayon1,0,epaisseur-1.9]) cylinder (2,rayontrou-1,rayontrou+1,center=false, $fn = 100);}
difference(){
    
            union(){    
                    translate ([decalage,0,0]) cube ([largeur,longueur/2,epaisseur]);
                    translate([rayon1+decalage,0,0]) cylinder (epaisseur,rayon1,rayon1,center=false, $fn= 100);}
            
            translate([rayon1+decalage,0,-1]) cylinder (epaisseur,rayontrou,rayontrou,center=false, $fn= 100);
            translate([rayon1+decalage,0,epaisseur-1.9]) cylinder (2,rayontrou-1,rayontrou+1,center=false, $fn= 100);
             translate ([rayon1+decalage,longueur/2,-0.1]) cylinder (epaisseur+1,rayondecoupe,rayondecoupe-2,center=false, $fn = 8);       
            }
