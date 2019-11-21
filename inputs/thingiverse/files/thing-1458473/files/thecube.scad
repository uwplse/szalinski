nbr=6;
taille=0.125;
union()
{
for (i=[1:nbr])
{
        union()
        {

    for (j=[1:nbr])
    {
        union()
        {
        for (k=[1:nbr])
        {
            hull()
            {
            translate([sin(360/nbr*i)*nbr,sin(360/nbr*j)*nbr,sin(360/nbr*k)*nbr])
            cube([taille,taille,taille],center=true);
            
            translate([sin(360/nbr*(i+1))*nbr,sin(360/nbr*(j+1))*nbr,sin(360/nbr*(k+1))*nbr])
            cube([taille,taille,taille],center=true);
            }
        }
    }   
    }    
}
}
}