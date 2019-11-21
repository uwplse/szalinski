
Hauteur                         = 100;
Largeur                         = 185;
Profondeur                      = 100;
EpaisseurPlanches               = 5;

NombreSubdivisionsHauteur       = 5;
NombreSubdivisionsLargeur       = 2;
NombreSubdivisionsProfondeur    = 2;

BoiteFermee                     = "oui";//[oui,non]


Fente                           = "oui";//[oui,non]
HauteurFente                    = 10;
LargeurFente                    = 80;
ArrondiCoins                    = 5;

modevision                      = "boite";//[boite,DXF]

SubH = Hauteur/((2*NombreSubdivisionsHauteur)+1);
SubL = (Largeur)/((2*NombreSubdivisionsLargeur)+1);
SubP = Profondeur/((2*NombreSubdivisionsProfondeur)+1);
SubP2 = (Profondeur-EpaisseurPlanches)/((2*NombreSubdivisionsProfondeur)+1);


objet();

module objet()
{
if(modevision=="boite")
{
    boite();
}
if(modevision=="DXF")
{
    DXFF();
}
}
module DXFF()
{
translate([-Largeur/2-EpaisseurPlanches,-Hauteur/2-EpaisseurPlanches])cotesun();
translate([Profondeur/2+EpaisseurPlanches,-Hauteur/2-EpaisseurPlanches])cotesdeux();   
translate([-Largeur/2-EpaisseurPlanches,Hauteur/2+EpaisseurPlanches])cotesun();
translate([Profondeur/2+EpaisseurPlanches,Hauteur/2+EpaisseurPlanches])cotesdeux();
translate([EpaisseurPlanches+Largeur/2,Hauteur+Profondeur/2+EpaisseurPlanches*2]) dessous();
if(BoiteFermee=="oui")
{
translate([-Largeur/2-EpaisseurPlanches,Hauteur+Profondeur/2+EpaisseurPlanches*2]) dessus();  
}
}

module boite()
{
color("red")
linear_extrude(height=EpaisseurPlanches)
dessous();
if(BoiteFermee=="oui")
{
color([1,0,0,1])
translate([0,0,Hauteur-EpaisseurPlanches])
linear_extrude(height=EpaisseurPlanches)
dessus();
}


color("green")
rotate([90,0,0])
translate([0,Hauteur/2,Profondeur/2])
rotate([180,0,0])
linear_extrude(height=EpaisseurPlanches)
cotesun();

color("green")
rotate([90,0,0])
translate([EpaisseurPlanches,Hauteur/2,-Profondeur/2-EpaisseurPlanches])
rotate([0,0,180])
linear_extrude(height=EpaisseurPlanches)
cotesun();

color("blue")
rotate([90,0,90])
translate([0,Hauteur/2,Largeur/2])
linear_extrude(height=EpaisseurPlanches)
cotesdeux();

color("blue")
rotate([90,0,-90])
translate([-EpaisseurPlanches,Hauteur/2,Largeur/2-EpaisseurPlanches])
linear_extrude(height=EpaisseurPlanches)
cotesdeux();
}

module cotesun()
{
    difference()
    {
        union()
        {
            square([Largeur,Hauteur],center=true);
            for(i=[-NombreSubdivisionsHauteur:2:NombreSubdivisionsHauteur])
            {
                translate([Largeur/2,SubH*i,0])
                square([EpaisseurPlanches*2,SubH],center=true);
            }
        }
        for(i=[-NombreSubdivisionsHauteur:2:NombreSubdivisionsHauteur])
        {
            translate([-Largeur/2,SubH*i,0])
            square([EpaisseurPlanches*2,SubH],center=true);
        }
        
        for(i=[-NombreSubdivisionsLargeur+1:2:NombreSubdivisionsLargeur-1])
        {
            translate([EpaisseurPlanches/2,0])
            translate([(((Largeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsLargeur)+1))*i),Hauteur/2])
            square([(Largeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsLargeur)+1),EpaisseurPlanches*2],center=true);
        }
if(BoiteFermee=="oui")
    
        for(i=[-NombreSubdivisionsLargeur+1:2:NombreSubdivisionsLargeur-1])
        {
            translate([EpaisseurPlanches/2,0])
            translate([(((Largeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsLargeur)+1))*i),-Hauteur/2])
            square([(Largeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsLargeur)+1),EpaisseurPlanches*2],center=true);
        }

    }
}






module cotesdeux()
{
difference()
    {
    union()
    {
        square([Profondeur,Hauteur],center=true);
        for(i=[-NombreSubdivisionsHauteur:2:NombreSubdivisionsHauteur])
        {
            translate([Profondeur/2,SubH*i,0])
            square([EpaisseurPlanches*2,SubH],center=true);
        }
 
    }
    for(i=[-NombreSubdivisionsHauteur:2:NombreSubdivisionsHauteur])
    {
        translate([-Profondeur/2,SubH*i,0])
        square([EpaisseurPlanches*2,SubH],center=true);
    }
    for(i=[-NombreSubdivisionsProfondeur+1:2:NombreSubdivisionsProfondeur-1])
    {
        translate([EpaisseurPlanches/2,0])
        translate([(((Profondeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsProfondeur)+1))*i),-Hauteur/2])
        square([(Profondeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsProfondeur)+1),EpaisseurPlanches*2],center=true);
    }
    if(BoiteFermee=="oui")
    {
    for(i=[-NombreSubdivisionsProfondeur+1:2:NombreSubdivisionsProfondeur-1])
    {
        translate([EpaisseurPlanches/2,0])
        translate([(((Profondeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsProfondeur)+1))*i),Hauteur/2])
        square([(Profondeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsProfondeur)+1),EpaisseurPlanches*2],center=true);
    }
}
    
    }
}







module dessous()
{
    tailleX=Largeur-(EpaisseurPlanches);
    tailleY=Profondeur-(EpaisseurPlanches);
    union()
    {
        translate([EpaisseurPlanches/2,EpaisseurPlanches/2])
        square([tailleX,tailleY],center=true);
        for(i=[-NombreSubdivisionsLargeur+1:2:NombreSubdivisionsLargeur-1])
        {
            translate([EpaisseurPlanches/2,0])
            translate([(((Largeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsLargeur)+1))*i),-Profondeur/2+EpaisseurPlanches])
            square([(Largeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsLargeur)+1),EpaisseurPlanches*2],center=true);
        }
        for(i=[-NombreSubdivisionsLargeur+1:2:NombreSubdivisionsLargeur-1])
        {
            translate([EpaisseurPlanches/2,0])
            translate([(((Largeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsLargeur)+1))*i),Profondeur/2])
            square([(Largeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsLargeur)+1),EpaisseurPlanches*2],center=true);
        }
        for(i=[-NombreSubdivisionsProfondeur+1:2:NombreSubdivisionsProfondeur-1])
        {
            translate([Largeur/2,EpaisseurPlanches/2])
            translate([0,i*SubP2])
            square([EpaisseurPlanches*2,SubP2],center=true);
        }
        for(i=[-NombreSubdivisionsProfondeur+1:2:NombreSubdivisionsProfondeur-1])
        {
            translate([-Largeur/2+EpaisseurPlanches,EpaisseurPlanches/2])
            translate([0,i*SubP2])
            square([EpaisseurPlanches*2,SubP2],center=true);
        }
    }
}


module dessus()
{
    tailleX=Largeur-(EpaisseurPlanches);
    tailleY=Profondeur-(EpaisseurPlanches);
    difference()
    {
        union()
        {
            translate([EpaisseurPlanches/2,EpaisseurPlanches/2])
            square([tailleX,tailleY],center=true);
            for(i=[-NombreSubdivisionsLargeur+1:2:NombreSubdivisionsLargeur-1])
            {
                translate([EpaisseurPlanches/2,0])
                translate([(((Largeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsLargeur)+1))*i),-Profondeur/2+EpaisseurPlanches])
                square([(Largeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsLargeur)+1),EpaisseurPlanches*2],center=true);
            }
            for(i=[-NombreSubdivisionsLargeur+1:2:NombreSubdivisionsLargeur-1])
            {
                translate([EpaisseurPlanches/2,0])
                translate([(((Largeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsLargeur)+1))*i),Profondeur/2])
                square([(Largeur-1*EpaisseurPlanches)/((2*NombreSubdivisionsLargeur)+1),EpaisseurPlanches*2],center=true);
            }
            for(i=[-NombreSubdivisionsProfondeur+1:2:NombreSubdivisionsProfondeur-1])
            {
                translate([Largeur/2,EpaisseurPlanches/2])
                translate([0,i*SubP2])
                square([EpaisseurPlanches*2,SubP2],center=true);
            }
            for(i=[-NombreSubdivisionsProfondeur+1:2:NombreSubdivisionsProfondeur-1])
            {
                translate([-Largeur/2+EpaisseurPlanches,EpaisseurPlanches/2])
                translate([0,i*SubP2])
                square([EpaisseurPlanches*2,SubP2],center=true);
            }
        }
        if(Fente=="oui")
        {
        hull()
        {
            translate([LargeurFente/2-ArrondiCoins/2,HauteurFente/2-ArrondiCoins/2])
            circle(r=ArrondiCoins/2);
    
            translate([LargeurFente/2-ArrondiCoins/2,-HauteurFente/2+ArrondiCoins/2])
            circle(r=ArrondiCoins/2);
    
            translate([-LargeurFente/2+ArrondiCoins/2,HauteurFente/2-ArrondiCoins/2])
            circle(r=ArrondiCoins/2);
    
            translate([-LargeurFente/2+ArrondiCoins/2,-HauteurFente/2+ArrondiCoins/2])
            circle(r=ArrondiCoins/2);
        }
    }
        
        
    }
}




