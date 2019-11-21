/* [General] */
Longueur=10;
Largeur=1;
Nombre_de_branches=1;//[1,2]
Epaisseur=0;//[0:1000]
Complexite=3;//[1,2,3,4,5]
/* [Première branche] */
Redimensionnement_1=50;//[0:100]
Angle_1=30;//[0:90]
Premiere_branche=66;//[0:100]
/* [Deuxième branche] */
Redimensionnement_2=33;//[0:100]
Angle_2=60;//[0:90]
Deuxieme_branche=33;//[0:100]


monobjet();

module monobjet()
{
linear_extrude(1)
offset(-Epaisseur/1000,$fn=16)
offset(Epaisseur/1000*2,$fn=16)
for(i=[1:6])
{
    rotate([0,0,60*i])

toto(it=1,mit=Complexite);
}
}
module toto()
{

    hull()
    {
        circle(d=Largeur,$fn=16);
        translate([0,Longueur,0])   
        circle(d=Largeur*Redimensionnement_1/100,$fn=16);
    }
    if(it<=mit)
    {
        translate([0,Longueur,0])
        scale(Redimensionnement_1/100)
        toto(it=it+1,mit=mit);

        translate([0,Longueur*(Premiere_branche/100),0])
        rotate([0,0,Angle_1])
        scale(Redimensionnement_1/100)
        toto(it=it+1,mit=mit);

        translate([0,Longueur*(Premiere_branche/100),0])
        rotate([0,0,-Angle_1])
        scale(Redimensionnement_1/100)
        toto(it=it+1,mit=mit);

if(Nombre_de_branches==2)
{
    
        translate([0,Longueur*(Deuxieme_branche/100),0])
        rotate([0,0,Angle_2])
        scale(Redimensionnement_2/100)
        toto(it=it+1,mit=mit);

        translate([0,Longueur*(Deuxieme_branche/100),0])
        rotate([0,0,-Angle_2])
        scale(Redimensionnement_2/100)
        toto(it=it+1,mit=mit);


    
}


        
    }
    
}