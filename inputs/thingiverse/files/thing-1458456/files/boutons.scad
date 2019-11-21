// Générateurs de boutons
// Par Vanlindt Marc (www.vanlindt.be)
/* [Variables générales] */

// Choix du type de bouton
TypeDeBouton="lissé";//[forme,lissé]


// Exprimé en mm.
HauteurDuBouton=3;

// Exprimé en mm.
RayonDuBouton=20;

// Nombre de faces au boutons :
Forme=5;

/* [Rebord] */
// Rebord
Rebord="true";//[true,false]

// Epaisseur du rebord (en mm)
EpaisseurDuRebord=2;

// Hauteur du rebord (en mm)
HauteurDuRebord=2;

/* [Trous] */
// Nombre de trous 
NombreDeTrous=5;

// Distance d'un trou par rapport au centre (en mm)
DistanceTrou=5;

// Diamètre d'un trou (en mm)
DiametreTrou=2;

// Rotation des trous
RotationsDesTrous=0;//[0:360]

/* [Lissage] */
QualiteDuLissage=2;//[1:4]


bouton();



module bouton()
{
if (TypeDeBouton=="forme")
{    
    difference()
    {
	if (Rebord=="true")
	{
            difference()
            {
                union()
		{
                    cylinder(r=RayonDuBouton,h=HauteurDuBouton,center=true,$fn=Forme);
                    difference()
                    {
                        cylinder(r=RayonDuBouton,h=HauteurDuBouton+HauteurDuRebord,center=true,$fn=Forme);
			cylinder(r=RayonDuBouton-EpaisseurDuRebord,h=HauteurDuBouton+HauteurDuRebord*2,center=true,$fn=Forme);
                    }
		}
                rotate([0,0,RotationsDesTrous])
                for (i=[1:NombreDeTrous])	
                {
                    rotate([0,0,i*360/NombreDeTrous])
                    translate([DistanceTrou,0,0])
                    cylinder(r=DiametreTrou/2,h=HauteurDuBouton*20,$fn=16,center=true);
                }
            }
        }
       	if (Rebord=="false")
	{
            difference()
            {
                cylinder(r=RayonDuBouton,h=HauteurDuBouton,center=true,$fn=Forme);
                rotate([0,0,RotationsDesTrous])
                for (i=[1:NombreDeTrous])	
                {
                    rotate([0,0,i*360/NombreDeTrous])
                    translate([DistanceTrou,0,0])
                    cylinder(r=DiametreTrou/2,h=HauteurDuBouton*20,$fn=16,center=true);
                }
            }
        }
        translate([0,0,-HauteurDuBouton])
        cube([RayonDuBouton*2,RayonDuBouton*2,HauteurDuBouton],center=true);
    }
}
if (TypeDeBouton=="lissé")
{    
    difference()
    {
	if (Rebord=="true")
	{
            difference()
            {
                translate([0,0,HauteurDuRebord/2])
                hull()
                {
                for (i=[1:Forme])
                {
                    rotate([0,0,i*360/Forme])
                    translate([RayonDuBouton,0,0])
                    sphere(r=HauteurDuBouton/2+HauteurDuRebord/2,$fn=8*QualiteDuLissage);
                }
                }
                
                rotate([0,0,RotationsDesTrous])
                for (i=[1:NombreDeTrous])	
                {
                    rotate([0,0,i*360/NombreDeTrous])
                    translate([DistanceTrou,0,0])
                    cylinder(r=DiametreTrou/2,h=HauteurDuBouton*20,$fn=8*QualiteDuLissage,center=true);
                }
                translate([0,0,HauteurDuBouton/2+HauteurDuRebord])
               hull()
                {
                    for (i=[1:Forme])
                    {
                        rotate([0,0,i*360/Forme])
                        translate([RayonDuBouton-EpaisseurDuRebord,0,0])
                        sphere(r=HauteurDuRebord,$fn=8*QualiteDuLissage);
                
                    }
                }
            }            
            
        }  
       	if (Rebord=="false")
	{
            difference()
            {
                hull()
                {
                for (i=[1:Forme])
                {
                    rotate([0,0,i*360/Forme])
                    translate([RayonDuBouton,0,0])
                    sphere(r=HauteurDuBouton/2,$fn=8*QualiteDuLissage);
                }
                }
                
                rotate([0,0,RotationsDesTrous])
                for (i=[1:NombreDeTrous])	
                {
                    rotate([0,0,i*360/NombreDeTrous])
                    translate([DistanceTrou,0,0])
                    cylinder(r=DiametreTrou/2,h=HauteurDuBouton*20,$fn=8*QualiteDuLissage,center=true);
                }
            }
        }

    }

}

}