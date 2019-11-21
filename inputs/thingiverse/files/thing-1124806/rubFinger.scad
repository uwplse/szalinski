
diametreDoigt=20;
longeurDoigt=50;

// ignore variable values
$fn=20+0;
diametreBille=4+0;

epaisseurFond=3+0;
epaisseurParoi=2+0;
ecartParoi=0.5+0;

diametreExterne=diametreDoigt+epaisseurParoi*3+ecartParoi;
hauteurExterne=longeurDoigt+epaisseurFond;

nbBilleH=hauteurExterne/(diametreBille*2);
nbBilleR=(3.14159*diametreExterne)/(diametreBille);
offsetBille=diametreBille/2;

module coqueExterne(){
        union(){
            cylinder(r=diametreExterne, h=hauteurExterne);
                                      
            pas=hauteurExterne/(nbBilleH+1);
            for(i=[0:1:nbBilleR]){
                coodX=diametreExterne*cos(i*360/nbBilleR);
                coodY=diametreExterne*sin(i*360/nbBilleR);
                for(j=[0:1:nbBilleH]){                 
                   translate ([coodX,coodY,j*pas+offsetBille+diametreBille/2])sphere (diametreBille/2,$fn=6);
                    
                }
            }
        }
}

module empreinteInterne(){
    diametreMin=diametreDoigt+epaisseurParoi;
    cylinder(r1=diametreExterne-epaisseurParoi,r2=diametreMin,h=hauteurExterne/3);
    translate([0,0,2*hauteurExterne/3]){
        cylinder(r2=diametreExterne-epaisseurParoi,r1=diametreMin,h=hauteurExterne/3);
            }
    cylinder(r=diametreMin, h=hauteurExterne+0.1);
}

module doigt(){
    translate([0,0,epaisseurFond+0.2]){
        cylinder(r=diametreDoigt, h=longeurDoigt);
    }
}

module conge(diametre){
    taille=(diametreDoigt+epaisseurParoi)-diametre/2;
    difference(){        
       
    rotate_extrude ()square  (diametreDoigt+epaisseurParoi*2);
        rotate_extrude () translate([diametreDoigt+diametre,0,0])circle (diametre);

    }
}
union(){
    difference(){
        coqueExterne();
        translate([0,0,-0.1]){
             scale([1.05,1.05,1.1]){
                 empreinteInterne();
             }
         }
    }

    difference(){
        difference(){
            empreinteInterne();
            doigt();
        }
        diametreConge=diametreDoigt/2;
        translate([0,0,longeurDoigt+epaisseurFond-diametreConge-0.2])conge(diametreConge);
    }
}
//translate([0,0,longeurDoigt+epaisseurFond-4])conge(5);