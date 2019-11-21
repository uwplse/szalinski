Viscosite=20;//[0:200]
Modificateur_de_taille=0;//[-100:100]
Qualite=128;//[4,8,16,32,64,128,256]
step=100;//[0:200]


rotate([90,0,0])
rotate_extrude($fn=Qualite)
difference()
{
    offset(-Viscosite)
    offset(Viscosite)
    union()
    {
        for(i=[-1,1])
        {
            translate([0,i*20/100*step,0])
            circle(d=20+(i*Modificateur_de_taille/5),$fn=Qualite);
        }
    }
    translate([160,0])
    square(320,center=true);
}
