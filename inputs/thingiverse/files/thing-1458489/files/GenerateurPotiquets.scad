// Nombre de divisions
nbr =32;

// Taille des barreaux
ta=0.5;

// Rayon de l'objet
ta2=20;

// Qualité des barreaux
qual=8;

// Nombre de barraux de décalage.
decal=10;

// Hauteur de la forme
hauteur=60;

//Cylindre du dessus
cyldessus=0;//[0,1]

union()
{
for(i=[1:nbr],a=(360/nbr*i),b=(360/nbr*(i+decal)),c=(360/nbr*(i-decal)))
{
    union()
    {
    hull()
    {
    rotate([0,0,a])
    translate([ta2,0,0])
    sphere(r=ta,$fn=qual);
    
    rotate([0,0,b])
    translate([ta2,0,hauteur])
    sphere(r=ta,$fn=qual);
    }

    hull()
    {
    rotate([0,0,a])
    translate([ta2,0,0])
    sphere(r=ta,$fn=qual);
    
    rotate([0,0,c])
    translate([ta2,0,hauteur])
    sphere(r=ta,$fn=qual);
    }
}
    
}
cylinder(r=ta2+(ta*2),$fn=nbr,center=true,h=ta*2);


if(cyldessus==1)
{
difference()
{
translate([0,0,hauteur])
cylinder(r=ta2+(ta*2),$fn=nbr,center=true,h=ta*2);

translate([0,0,hauteur])
cylinder(r=ta2-(ta),$fn=nbr,center=true,h=ta*4);

}
}

}
