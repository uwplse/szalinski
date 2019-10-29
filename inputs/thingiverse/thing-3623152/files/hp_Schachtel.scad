AnzahlZeile=1;
AnzahlSpalte=1;
Breite=40;
Tiefe=20;
Hoehe=25.0;
Tasche=true;
Stopfen=false;

//Ab hier bicht mehr aendern!
WandDicke=1;
BodenDicke=1;
Hoehe2mm=10.0;
BodenRund=1.5;
HoeheTasche=10;

$fn = 50;

module DoIt()
{
    translate([-Breite/2,-Tiefe/2,0])
    {
        difference()
        {
            hull()
            {
                translate([0,0,BodenRund]) cube([Breite, Tiefe, Hoehe-BodenRund], center=false); 
                translate([BodenRund,BodenRund,BodenRund]) sphere(r=BodenRund);
                translate([BodenRund,Tiefe-BodenRund,BodenRund]) sphere(r=BodenRund);
                translate([Breite-BodenRund,BodenRund, BodenRund]) sphere(r=BodenRund);
                translate([Breite-BodenRund,Tiefe-BodenRund, BodenRund]) sphere(r=BodenRund);
            }
            hull()
            {
                translate([WandDicke,WandDicke,BodenDicke+BodenRund]) cube([Breite-WandDicke*2, Tiefe-WandDicke*2,Hoehe-BodenRund],center=false); 
                translate([BodenRund+WandDicke,BodenRund+WandDicke,BodenRund+BodenDicke]) sphere(r=BodenRund);
                translate([BodenRund+WandDicke,Tiefe-BodenRund-WandDicke,BodenRund+WandDicke]) sphere(r=BodenRund);
                translate([Breite-BodenRund-WandDicke,BodenRund+WandDicke,BodenRund+WandDicke]) sphere(r=BodenRund);
                translate([Breite-BodenRund-WandDicke,Tiefe-BodenRund-WandDicke,BodenRund+WandDicke]) sphere(r=BodenRund);
            }
        }
        if(Tasche)
        {
            difference()
            {
                hull()
                {
                    translate([WandDicke,0,Hoehe-HoeheTasche]) cube([2,Tiefe,HoeheTasche],center=false); 
                    translate([WandDicke,0,Hoehe-HoeheTasche-5]) cube([0.1,Tiefe,5],center=false); 
                }
                union()
                {
                    translate([WandDicke,0,Hoehe-HoeheTasche]) cube([1,Tiefe,HoeheTasche],center=false); 
                    translate([WandDicke,3,Hoehe-HoeheTasche+3]) cube([3,Tiefe-6,HoeheTasche],center=false); 
                    translate([WandDicke,3,Hoehe-2]) rotate([45,0,0]) cube([3,3,3], center=false); 
                    translate([WandDicke,Tiefe-3,Hoehe-2]) rotate([45,0,0]) cube([3,3,3],center=false); 
                }
            }
        }
        if(Stopfen)
        {
            hull()
            {
                translate([Breite/2,Tiefe-WandDicke,Hoehe2mm]) cube(size=[Breite,2,0.5],center=true);
                translate([Breite/2,Tiefe-WandDicke+0.5,Hoehe2mm-5]) cube(size=[Breite,1,0.5],center=true);
                translate([Breite/2,Tiefe-WandDicke+0.5,Hoehe2mm+5]) cube(size=[Breite,1,0.5],center = true);
            }
            hull()
            {
                translate([Breite/2,WandDicke,Hoehe2mm]) cube(size=[Breite,2,0.5], center = true);
                translate([Breite/2,WandDicke-0.5,Hoehe2mm-5]) cube(size=[Breite,1,0.5], center=true);
                translate([Breite/2,WandDicke-0.5,Hoehe2mm+5]) cube(size=[Breite,1,0.5],center = true);
            }
        }
    }   
}


for (x=[0:AnzahlZeile-1]) for (y=[0:AnzahlSpalte-1]) translate([x*(Breite+5),y*(Tiefe+5),0]) DoIt();