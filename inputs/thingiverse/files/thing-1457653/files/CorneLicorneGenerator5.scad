//           .             
//          /'             
//         //              
//     .  //                         Générateur de cornes de licorne
//     |\//7                        ---------------------------------
//    /' " \                        GNU GPL v3 - Vanlindt Marc v 0.8
//   .   . .
//   | (    \     '._               
//   |  '._  '    '. '              
//   /    \'-'_---. ) )
//  .              :.'
//  |               \
//  | .    .   .     .
//  ' .    |  |      |
//   \^   /_-':     /
//   / | |    '\  .'
//  / /| |     \\  |
//  \ \( )     // /
//   \ | |    // /
//    L! !   // / Monoceros'95
//     [_]  L[_|  R.B.Cleary


/* [Corne] */
Hauteur_de_la_corne=150;// [1:200]
Diametre_d_une_corne=30;// [1:100]
Espacement_entre_les_cornes=5;// [0:100]
Nombre_de_cornes=2;// [1:16]
// Le nombre de rotation ne doit pas obligatoirement être un chiffre rond.
Nombre_de_rotations=1.5;
/* [Qualité] */
Nombre_de_couches=64;// [4:192]
Nombre_de_faces_par_couche=64;// [4:64]
/* [Accroches] */
Nombre_d_accroches=3;// [2:8]
Epaisseur_des_accroches=2;// [1:5]
Largeur_d_une_accroche=10;// [10:30]
Espacement_entre_les_trous=2;// [1:10]
Diametre_des_trous=2;// [1:10]
/* [Multi-matières] */
Double_extrusion=1;// [0,1]
Objet_Visible=0;//[0,1,2,3]




CorneLicorne();

module CorneLicorne()
{
    if((Nombre_de_cornes==2)&&(Double_extrusion==1))
    {
        if(Objet_Visible==0)
        {
            color([1,1,1,1])
            difference()
            {
                union()
                {
                    rotate([0,0,0])
                    UneCorne(boutdessus=1);
                    rotate([0,0,360*Nombre_de_rotations])
                    translate([Espacement_entre_les_cornes+Diametre_d_une_corne/2,0,0])
                    accroches();    
                }
                rotate([0,0,180])
                UneCorne(boutdessus=0);
            }
            color([0.8,0.3,0.3,1])
            union()
            {    
                rotate([0,0,180])
                UneCorne(boutdessus=0);
                rotate([0,0,360*Nombre_de_rotations])
                translate([-Diametre_d_une_corne/2-Espacement_entre_les_cornes,0,0])
                rotate([0,0,180])
                accroches();        
       
            }
        }
        if(Objet_Visible==1)
        {
           color([1,1,1,1])
            difference()
            {
                union()
                {
                    rotate([0,0,0])
                    UneCorne(boutdessus=1);
                    rotate([0,0,360*Nombre_de_rotations])
                    translate([Espacement_entre_les_cornes+Diametre_d_une_corne/2,0,0])
                    accroches();    
                }
                rotate([0,0,180])
                UneCorne(boutdessus=0);
            } 
        }
        if(Objet_Visible==2)
        {
            color([0.8,0.3,0.3,1])
            union()
            {    
                rotate([0,0,180])
                UneCorne(boutdessus=0);
                rotate([0,0,360*Nombre_de_rotations])
                translate([-Diametre_d_une_corne/2-Espacement_entre_les_cornes,0,0])
                rotate([0,0,180])
                accroches();        
            }
          
        }
        if(Objet_Visible==3)
        {
            translate([Diametre_d_une_corne,0,0])
            color([1,1,1,1])
            difference()
            {
                union()
                {
                    rotate([0,0,0])
                    UneCorne(boutdessus=1);
                    rotate([0,0,360*Nombre_de_rotations])
                    translate([Espacement_entre_les_cornes+Diametre_d_une_corne/2,0,0])
                    accroches();    
                }
                rotate([0,0,180])
                UneCorne(boutdessus=0);
            }
            translate([-Diametre_d_une_corne,0,0])

            color([0.8,0.3,0.3,1])
            union()
            {    
                rotate([0,0,180])
                UneCorne(boutdessus=0);
                rotate([0,0,360*Nombre_de_rotations])
                translate([-Diametre_d_une_corne/2-Espacement_entre_les_cornes,0,0])
                rotate([0,0,180])
                accroches();        
       
            }
        }
    }
    else
    {
                union()
        {
            for(i=[0:Nombre_de_cornes-1])
            {
                rotate([0,0,360/Nombre_de_cornes*i])
                UneCorne(boutdessus=1);
            }
            if(Nombre_de_cornes>=2)
            {
                rotate([0,0,360*Nombre_de_rotations])
                for(i=[0:Nombre_d_accroches-1])
                {
                    rotate([0,0,360/Nombre_d_accroches*i])
                    translate([Espacement_entre_les_cornes+Diametre_d_une_corne/2,0,0])
                    accroches();
                }   
            }
            else
            {
                rotate([0,0,360*Nombre_de_rotations])
                translate([Espacement_entre_les_cornes+Diametre_d_une_corne/2,0,0])
                accroches();    
                rotate([0,0,360*Nombre_de_rotations])
                translate([Espacement_entre_les_cornes+Diametre_d_une_corne/2-Diametre_d_une_corne,0,0])
                rotate([0,0,180])
                accroches();
            }
        }

        
    }
}

module UneCorne()
{
    translate([-Espacement_entre_les_cornes/10,0,0])
    rotate([0,0,360*Nombre_de_rotations])
    linear_extrude(height=Hauteur_de_la_corne,scale=0.1,twist=360*Nombre_de_rotations,slices=Nombre_de_couches)
    formebase(diam=Diametre_d_une_corne);
    translate([0,0,Hauteur_de_la_corne])
    
    if(boutdessus==1)
    {
    dessus();
    }
}

module formebase()
{
    translate([Espacement_entre_les_cornes,0,0])
    circle(d=diam,$fn=Nombre_de_faces_par_couche);
}
module accroches()
{
    linear_extrude(height=Epaisseur_des_accroches)
    difference()
    {
        translate([-Largeur_d_une_accroche/2,0,0])
        square([Largeur_d_une_accroche*2,Largeur_d_une_accroche],center=true);
        translate([Largeur_d_une_accroche/4,-Espacement_entre_les_trous,0])
        circle(r=Diametre_des_trous/2,$fn=6);
        translate([Largeur_d_une_accroche/4,Espacement_entre_les_trous,0])
        circle(r=Diametre_des_trous/2,$fn=6);
    }
}
module dessus()
{
    sphere(d=Diametre_d_une_corne/10,$fn=Nombre_de_faces_par_couche);
}
