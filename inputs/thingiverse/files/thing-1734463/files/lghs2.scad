Premier_objet = "sphere";//[sphere,cube]
Deuxieme_objet = "cube";//[sphere,cube]
hull()
{
    if(Premier_objet=="cube"){
        cube(center=true);}
    
    if(Premier_objet=="sphere"){
        sphere();}
    
    translate([4,0,0])
    {
        if(Deuxieme_objet=="cube"){
            cube(center=true);}
    
        if(Deuxieme_objet=="sphere"){
            sphere();}
    }
}