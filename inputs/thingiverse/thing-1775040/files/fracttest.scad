/*
Test fractal pour pas changer 😛
v0.1
*/


//points=[[0,0],[5,0],[5,5],[10,5],[10,0],[15,0],[20,0]];
//points=[[0,0],[2,2],[4,0],[6,-2],[8,0]];
//points=[[0,0],[10,0],[10,10],[0,10],[0,20],[10,20],[20,20],[30,20],[30,10],[20,10],[20,0],[30,0]];
//points=[[0,0],[20,0],[cos(-60)*20,-sin(-60)*20],[20+cos(60)*20,-sin(-60)*20],[20,0],[40,0]];
//points=[[0,0],[10,0],[10,10],[20,10],[20,0],[20,-10],[30,-10],[30,0],[40,0]];
//points=[[0,0],[20,0],[cos(-60)*20*3,-sin(-60)*20],[cos(-60)*20*2,-sin(-60)*20*2],[cos(-60)*20*3,-sin(-60)*20*3],[cos(-60)*20*5,-sin(-60)*20*3],[cos(-60)*20*6,-sin(-60)*20*2],[cos(-60)*20*5,-sin(-60)*20],[cos(-60)*20*6,0],[cos(-60)*20*8,0]];
//points=[[],[],[],[],[],[],[],[],[],[],[],[],[],[]];
points=[[0,0],[10,0],[cos(60)*30,sin(60)*10],[20,0],[30,0]];
max_iter=3;

// La variable "longueur" est égal à l'hypoténuse entre le premier point et le dernier point.
// Il y a actuellement un problème lorsque lorsque le Y du dernier point n'est pas à 0
longueur=sqrt((points[len(points)-1][0]-points[0][0])*(points[len(points)-1][0]-points[0][0])+(points[len(points)-1][1]-points[0][1])*(points[len(points)-1][0]-points[0][0]));


//toto(it=1,mit=1);
//translate([40,0,0])toto(it=1,mit=2);
//translate([80,0,0])toto(it=1,mit=3);
toto(it=1,mit=max_iter);



module toto()
{
    if(it==mit)
    {
        for(i=[0:len(points)-2])
        {
            hull()
            {
                translate([points[i][0],points[i][1],0])        // Ici se crééent les vecteurs réunissan
                sphere();                                       // les différents points.
                translate([points[i+1][0],points[i+1][1],0])    // Ils ne s'affichent que si la dernière 
                sphere();                                       // itération est atteinte.
            }
        }
    }
    if(it<=mit)
    {
        for(i=[0:len(points)-2])
        {
            // Longueur2 se calcule à chaque fois et est la longueur entre le point utilisé et le point suivant.
            longueur2=sqrt(((points[i+1][0]-points[i][0])*(points[i+1][0]-points[i][0]))+((points[i+1][1]-points[i][1])*(points[i+1][1]-points[i][1])));
            // ang sert à calculer l'angle existant entre les deux points utilisés
            ang=atan2(points[i+1][1]-points[i][1],points[i+1][0]-points[i][0]);
            // On place l'objet là où il doit être
            translate([points[i][0],points[i][1],0])
            // On change sa taille pour que la taille de l'objet soit égale à la taille du vecteur
            scale([longueur2/longueur,longueur2/longueur,longueur2/longueur])
            // Et on effectue une rotation pour que l'objet rejoigne bien le point suivant
            rotate([0,0,ang])
            // On appelle l'objet en agumentation son itération
            toto(it=it+1,mit=mit);
        }
    }
}