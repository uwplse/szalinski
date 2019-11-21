Epaisseur = 3;
Diametre_general = 80;
Trou_clef_Hauteur = 50;
Trou_clef_diametre_1 = 25;
Trou_clef_diametre_2 = 13;
Trou_clef_arrondi = 10;

Vis_espacement=50;
Vis_diametre=4;
Force_vis_conique=60;

difference()
{
    linear_extrude(Epaisseur)
    difference()
    {
        circle(d=Diametre_general,$fn=64);
        offset(-Trou_clef_arrondi,$fn=64)
        offset(Trou_clef_arrondi,$fn=64)
        {
            translate([0,Trou_clef_Hauteur/2-Trou_clef_diametre_1/2,0])
            circle(d=Trou_clef_diametre_1,$fn=64);
            hull()
            {    
                translate([0,-Trou_clef_Hauteur/2+Trou_clef_diametre_2/2,0])
                circle(d=Trou_clef_diametre_2,$fn=64);
                translate([0,Trou_clef_Hauteur/2-Trou_clef_diametre_1/2,0])
                circle(d=Trou_clef_diametre_2,$fn=64);
            }   
        }
    }
    for(i=[-1,1])
    {
    translate([i*Vis_espacement/2,0,0])

    cylinder(d1=Vis_diametre,d2=Vis_diametre+(Vis_diametre*Epaisseur*Force_vis_conique/100),h=Epaisseur,$fn=64);
        
        
    
    }

}

