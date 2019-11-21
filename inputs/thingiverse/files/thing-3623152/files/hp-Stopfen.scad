AnzahlSpalte=4;
AnzahlZeile=4;

//Ab hier bicht mehr aendern!
Breite=15.0;
Laenge=17.5;
Dicke=9;
Verjuengung=2;
re=3; // RundungEcke
rg=2; // RundungGriff
$fn=120;
$fa=2;

module DoIt()
{
    hull()
    {
        translate([-(Laenge-re-Verjuengung)/2,-(Breite-re)/2,re/2]) sphere(re/2);
        translate([+(Laenge-re-Verjuengung)/2,-(Breite-re)/2,re/2]) sphere(re/2);
        translate([-(Laenge-re-Verjuengung)/2,+(Breite-re)/2,re/2]) sphere(re/2);
        translate([+(Laenge-re-Verjuengung)/2,+(Breite-re)/2,re/2]) sphere(re/2);
        translate([-(Laenge-re)/2,-(Breite-re)/2,Dicke-re/2]) sphere(re/2);
        translate([+(Laenge-re)/2,-(Breite-re)/2,Dicke-re/2]) sphere(re/2);
        translate([-(Laenge-re)/2,+(Breite-re)/2,Dicke-re/2]) sphere(re/2);
        translate([+(Laenge-re)/2,+(Breite-re)/2,Dicke-re/2]) sphere(re/2);
    }
    hull()
    {
        translate([-(Laenge-re-Verjuengung)/4,0,Dicke/3]) sphere(rg/2);
        translate([+(Laenge-re-Verjuengung)/4,0,Dicke/3]) sphere(rg/2);
        translate([-(Laenge-re-Verjuengung)/4,0,Dicke+4]) sphere(rg/2);
        translate([+(Laenge-re-Verjuengung)/4,0,Dicke+4]) sphere(rg/2);
    }    
     hull()
    {
        translate([-(Laenge-re-Verjuengung)/4,0,Dicke+4]) sphere(rg/2);
        translate([+(Laenge-re-Verjuengung)/4,0,Dicke+4]) sphere(rg/2);    
        translate([-(Laenge-re-Verjuengung)/4,-0,Dicke+5]) sphere(rg);
        translate([+(Laenge-re-Verjuengung)/4,-0,Dicke+5]) sphere(rg);
    }
}

for (x=[0:AnzahlZeile-1]) for (y=[0:AnzahlSpalte-1]) translate([x*(Laenge+5),y*(Breite+5),0]) DoIt();
