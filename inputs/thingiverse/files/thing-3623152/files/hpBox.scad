//  Unterteil
AnzahlX=8;
AnzahlY=8;
InnenHoehe=26;
WandDicke=4; 
BodenDicke=3;
ar=2; // Rundung
DiffLaenge=0.5;
MagnetD=11; // Magnet Durchmesser
MagnetH=4; // Magnet Hoehe
BoxErzeugen=1; // 0 fuer Deckel,1 fuer Box

//Ab hier bicht mehr aendern!
$fn=120;
$fa=12;
$fs=2; 
InnenBreite=AnzahlX*20.3;
InnenTiefe=AnzahlY*20.3;
DeckelDicke=sqrt(BodenDicke*BodenDicke+BodenDicke*BodenDicke);
Breite=InnenBreite+2*WandDicke;
Tiefe=InnenTiefe+2*WandDicke;
Hoehe=InnenHoehe+BodenDicke+DeckelDicke;
AussenPunkte=
[
    [-Breite/2+ar,-Tiefe/2+ar,-Hoehe/2+ar],
    [-Breite/2+ar,Tiefe/2-ar,-Hoehe/2+ar],
    [Breite/2-ar,Tiefe/2-ar,-Hoehe/2+ar],
    [Breite/2-ar,-Tiefe/2+ar,-Hoehe/2+ar],
 
    [-Breite/2+ar,-Tiefe/2+ar,Hoehe/2-ar],
    [-Breite/2+ar,Tiefe/2-ar,Hoehe/2-ar],
    [Breite/2-ar,Tiefe/2-ar,Hoehe/2-ar],
    [Breite/2-ar,-Tiefe/2+ar,Hoehe/2-ar],
];

module DoItBox() 
{
    echo(Breite=Breite,Tiefe=Tiefe,Hoehe=Hoehe,DeckelDicke=DeckelDicke);
    difference()
    {
        union()
        {
            translate([0,0,Hoehe/2]) color("LightBlue",1.0) 
            hull()
            {
                for(pos=AussenPunkte)
                translate(pos) sphere(r=ar);
            }
            hull()
            {
                translate([Breite/4+8,-Tiefe/2-1,Hoehe/2]) rotate([-90,0,0]) cube([40,15,2],center=true);           
                translate([Breite/4+8,-Tiefe/2,Hoehe/2-1.5]) rotate([-90,0,0]) cube([46,18,0.1],center=true);           
            }
        }
        union()
        {
             translate([0,0,Hoehe/2+BodenDicke]) color("Red",1.0)  cube([InnenBreite,InnenTiefe,Hoehe],center=true);
             translate([0,-Tiefe/2+2.5,Hoehe-14]) color("Red",1.0)  rotate([-90,0,0])   cylinder(h=MagnetH,d=MagnetD,center=true);    // Loch fuer Magnet          
             translate([InnenBreite/2,-WandDicke/2,Hoehe-DeckelDicke/2])  color("Red",1.0)  rotate([ 0,45,0])  cube([BodenDicke,Tiefe,BodenDicke],center=true);
             translate([-InnenBreite/2,-WandDicke/2,Hoehe-DeckelDicke/2]) color("Red",1.0)  rotate([0,45,0]) cube([BodenDicke,Tiefe,BodenDicke],center=true);
             translate([0,-Tiefe/2+WandDicke/2,Hoehe-DeckelDicke/2-0.1])  cube([InnenBreite+DeckelDicke,WandDicke*3,DeckelDicke+0.2],center=true);
             translate([0,Tiefe/2-WandDicke,Hoehe-DeckelDicke/2-0.1]) cube([InnenBreite,WandDicke,DeckelDicke+0.2],center=true);
             translate([Breite/4+8,-Tiefe/2-0.4,Hoehe/2+2]) color("red",1.0) rotate([-90,0,0]) cube([38,15,1.4],center=true); 
             translate([Breite/4+8,-Tiefe/2-2,Hoehe/2+3]) color("red",1.0) rotate([-90,0,0]) cube([32,10,3],center=true); 
             translate([Breite/4+8-11,-Tiefe/2-2,Hoehe/2+8]) color("red",1.0) rotate([-90,45,0]) cube([10,10,3],center=true); 
             translate([Breite/4+8+11,-Tiefe/2-2,Hoehe/2+8]) color("red",1.0) rotate([-90,45,0]) cube([10,10,3],center=true); 
       }
    }
}
 
module DoItDeckel()
{
    echo(Breite=Breite,Tiefe=Tiefe,Hoehe=Hoehe,DeckelDicke=DeckelDicke);
    difference()
    {
        union()
        {
            translate([InnenBreite/2-DiffLaenge/2,0,Hoehe-DeckelDicke/2])  rotate([ 0,45,0]) color("Red",1.0) cube([BodenDicke,Tiefe-WandDicke,BodenDicke],center=true);
            translate([-InnenBreite/2+DiffLaenge/2,0,Hoehe-DeckelDicke/2]) rotate([0,45,0]) color("Red",1.0) cube([BodenDicke,Tiefe-WandDicke,BodenDicke],center=true);
            translate([0,0,Hoehe-DeckelDicke/2]) color("LightBlue",1.0)  cube([Breite-WandDicke-DeckelDicke-DiffLaenge,Tiefe-WandDicke,DeckelDicke],center=true);
            color("LightBlue",1.0)  hull()
            {
                translate([-Breite/2+WandDicke+DiffLaenge/2,-Tiefe/2+WandDicke,Hoehe-DeckelDicke/2+0.127]) sphere(r=ar);
                translate([Breite/2-WandDicke-DiffLaenge/2,-Tiefe/2+WandDicke,Hoehe-DeckelDicke/2+0.127]) sphere(r=ar);
                translate([-Breite/2+WandDicke+DiffLaenge/2,-Tiefe/2-WandDicke/2,Hoehe-DeckelDicke/2+0.127]) sphere(r=ar);
                translate([Breite/2-WandDicke-DiffLaenge/2,-Tiefe/2-WandDicke/2,Hoehe-DeckelDicke/2+0.127]) sphere(r=ar);
            }
            color("LightBlue",1.0)  hull()
            {
                translate([-Breite/2+WandDicke+DiffLaenge/2,-Tiefe/2-WandDicke/2,Hoehe-DeckelDicke/2]) sphere(r=ar);
                translate([Breite/2-WandDicke-DiffLaenge/2,-Tiefe/2-WandDicke/2,Hoehe-DeckelDicke/2]) sphere(r=ar);
                translate([-15,-Tiefe/2-WandDicke/2,Hoehe-5]) sphere(r=ar);
                translate([15,-Tiefe/2-WandDicke/2,Hoehe-5]) sphere(r=ar);
            }
            color("LightBlue",1.0)  hull()
            {
                translate([-15,-Tiefe/2-WandDicke/2,Hoehe-5]) sphere(r=ar);
                translate([15,-Tiefe/2-WandDicke/2,Hoehe-5]) sphere(r=ar);
                translate([-8,-Tiefe/2-WandDicke/2,Hoehe-12-7]) sphere(r=ar);
                translate([8,-Tiefe/2-WandDicke/2,Hoehe-12-7]) sphere(r=ar);
            }
            color("LightBlue",1.0)  hull()
            {
                translate([-8,-Tiefe/2-WandDicke/2,Hoehe-12-7])  sphere(r=ar);
                translate([8,-Tiefe/2-WandDicke/2,Hoehe-12-7]) sphere(r=ar);
                translate([-8,-Tiefe/2-5,Hoehe-12-5-7]) sphere(r=ar);
                translate([8,-Tiefe/2-5,Hoehe-12-5-7]) sphere(r=ar);
            }
        }
        union()
        {
            translate([0,-Tiefe/2-WandDicke/2+1,Hoehe-14]) color("Red",1.0) rotate([-90,0,0]) cylinder(h=MagnetH,d=MagnetD,center=true);   // Loch fuer Magnet         
        }
    }
}
  

if (BoxErzeugen) DoItBox(); else translate([0,0,Hoehe]) rotate([-180,0,0]) DoItDeckel();

