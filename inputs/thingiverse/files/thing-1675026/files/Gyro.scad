// Boton charro by Magonegro JUL-2016
// Number of rings:
Rings=5;
// Ring width multiple of the nozzle size (mm):
RingWidth=2.4;
// Min Radius (mm):
MINRadius=10;
// Separation between rings (mm typ 0.8):
Separation=0.8;
// Resolution (min.100 facets):
Facets=100;

/* [Hidden] */
// Hidden settings for normal users.
// Height should be calculated so that rings can be holded together.
Height=(MINRadius*2)-RingWidth; // Forces the hole of the inner ring 
MaxRadius=MINRadius+(Rings*RingWidth)+(Rings*Separation);
// These are the keyring dimensions, increase it for a larger one (mm) Values choosen for a standard keyring.
KEYRINGRADIUSOuter=6;
KEYRINGRADIUSInner=3;
KEYRINHeightt=4;

module Ring(Radius,Width)
{
difference()
    {
    sphere(r=Radius+Width,center=true,$fn=Facets);
    sphere(r=Radius,center=true,$fn=Facets);
    }
}

module KeyRing()
{
// Ring designed this way for an easy print, not nice but functional.
difference()
    {
    translate([MaxRadius-1,0,-Height/2])
    difference()
        {
        cylinder(r=KEYRINGRADIUSOuter,h=KEYRINHeightt,$fn=Facets);
        cylinder(r=KEYRINGRADIUSInner,h=KEYRINHeightt,$fn=Facets);

        }
    sphere(r=MaxRadius-RingWidth,center=true,$fn=Facets);
    }
}

// Main
intersection()
{
    union()
    {
        for(i=[0:Rings-1])
        {
            Ring(MINRadius+(i*RingWidth)+(i*Separation),RingWidth);
        }
        KeyRing();
    }
        cylinder(r=MaxRadius*2,h=Height,$fn=Facets,center=true);
}    

// Sanity checks
if(MaxRadius>Height*1.6)
{
    echo("<B>Error: Unstable build. Reduce ring number or increase Min radius</B>");
}
if(Separation>RingWidth/2.6)
{
    echo("<B>Too high separation or too low ringwidth</B>");
}
