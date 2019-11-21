Hauteur=90;
Largeur=40;
Arrondi=5;

rotate_extrude()
difference()
{
    offset(-Arrondi) 
    offset(Arrondi*2)
    union()
    {
        hull()
        {
            translate([0,Hauteur-Arrondi])
            circle(d=Arrondi,$fn=16);

            translate([0,Largeur+Arrondi])
            circle(d=Largeur-Arrondi,$fn=16);
        }
    
        translate([0,Arrondi,0])
        square([Largeur-Arrondi,Arrondi],center=true);

        translate([0,Arrondi,0])
        square([Largeur-Arrondi,Arrondi],center=true);

        translate([0,Hauteur/4+Arrondi,0])
        square([Arrondi,Hauteur/2],center=true);
    }
    
    translate([0,-Hauteur])
    square([Hauteur,Hauteur*3]);
}