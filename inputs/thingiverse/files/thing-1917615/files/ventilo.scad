Diametre_base = 160;
Hauteur_base =4;
Diametre_cylindre_central=30;
Hauteur_cylindre_central=30;
Diametre_trou_cylindre_central=17;
Nbr_faces_trou_cylindre_central=8;
Longueur_pale=110;
Arrondi_pale=6;
Epaisseur_pale=3;
Hauteur_pale=10;
Hauteur_helice=20;
Decallage_helice=15;
Longueur_helice=25;
Nombre_de_pale=11;
Surelevage_pale=4;

objet_final();


module objet_final()
{
    difference()
    {
    union()
    {
        base();
        cylindre_central();
        translate([0,0,Surelevage_pale])
        for(i=[1:Nombre_de_pale])
        {
            rotate([0,0,360/Nombre_de_pale*i])
            pale();
        }
    }
    translate([0,0,Hauteur_base])
    cylinder(d=Diametre_trou_cylindre_central,h=Hauteur_cylindre_central+1,$fn=Nbr_faces_trou_cylindre_central);
}
}
module pale()
{
    translate([0,Epaisseur_pale/2,0])
    rotate([90,0,0])
    linear_extrude(Epaisseur_pale)
    union()
    {
        hull()
        {
            square([1,Hauteur_pale]);
            translate([Longueur_pale-Arrondi_pale/2,Arrondi_pale/2])
            circle(d=Arrondi_pale,$fn=64);
            translate([Longueur_pale-Arrondi_pale/2,Hauteur_pale-Arrondi_pale/2])
            circle(d=Arrondi_pale,$fn=64);    
        }
        hull()
        {
            translate([Longueur_pale-Arrondi_pale/2,Hauteur_pale-Arrondi_pale/2])
            circle(d=Arrondi_pale,$fn=64);    
            translate([Longueur_pale-Arrondi_pale/2-Decallage_helice,Hauteur_helice-Arrondi_pale/2])
            circle(d=Arrondi_pale,$fn=64);    
            translate([Longueur_pale-Arrondi_pale/2-Decallage_helice-Longueur_helice,Hauteur_helice-Arrondi_pale/2])
            circle(d=Arrondi_pale,$fn=64);    
            translate([Longueur_pale-Arrondi_pale/2-Decallage_helice*2-Longueur_helice,Hauteur_pale-Arrondi_pale/2])
            circle(d=Arrondi_pale,$fn=64);    
        }
    }
}

module cylindre_central()
{
    difference()
    {
        cylinder(d=Diametre_cylindre_central,h=Hauteur_cylindre_central,$fn=64);
        cylinder(d=Diametre_trou_cylindre_central,h=Hauteur_cylindre_central+1,$fn=Nbr_faces_trou_cylindre_central);
    }
}
module base()
{
    cylinder(d=Diametre_base,h=Hauteur_base,$fn=64);
}