$fn=120;
Hoehe=6;
Laenge=20;
Breite=20;
Rand=3;
LochD=4;
LochPos=5;

module DoIt()
{
    difference()
    {
        union()
        {
            cube([Laenge,Breite,Hoehe],false);
            translate([0,0,-Rand]) cube([Rand,Breite,Rand],false);
            translate([0,Breite-Rand,-Rand]) cube([Laenge,Rand,Rand],false);
        }
        union()
        {
            translate([0,0,Hoehe-Rand]) cube([Rand,Breite,Rand],false);
            translate([0,Breite-Rand,Hoehe-Rand]) cube([Laenge,Rand,Rand],false);
            translate([Rand+LochPos,Breite-Rand-LochPos,Hoehe/2]) cylinder(h=Hoehe*2,d=LochD,center=true);
        }
    }
}

translate([30,30,0]) rotate([0,-90,0]) DoIt();
translate([30,-30,0]) rotate([0,-90,0]) DoIt();
translate([-30,-30,0]) rotate([0,-90,0]) DoIt();
translate([-30,30,0]) rotate([0,-90,0]) DoIt();