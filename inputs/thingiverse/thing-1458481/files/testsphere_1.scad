nbr=16;
taille=2;
taille2=20;
qual=16;
fermetrou=sqrt(0.5)*3;
union()
{
for(i=[0:nbr])
{
union()
    {
        for(j=[0:nbr],a=360/nbr*i,b=360/nbr*j,c=360/nbr*(i+1),d=360/nbr*(j+1))
        {
            hull()
            {
                translate([sin(b)*sin(a)*taille2,sin(b)*cos(a)*taille2,cos(b)*taille2])
                sphere(r=taille*(cos(b/fermetrou)),$fn=qual);
              
                translate([sin(d)*sin(c)*taille2,sin(d)*cos(c)*taille2,cos(d)*taille2])
                sphere(r=taille*(cos(d/fermetrou)),$fn=qual);
            } 
        }
    }

}
}