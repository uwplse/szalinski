// Parameter
//
$fn=400;

breite=121;
laenge=121;
hoehe=1.2;
schraubloecher=1;

// Halterung für Kapselpackung
//
cube([breite, laenge, hoehe]);

// Kleberand
//
difference()
{
    translate([0,0,-20])
    cube([breite, hoehe, 20]);

    if (schraubloecher == 1)
    {
    translate([breite/4,1.5,-10])
    rotate([90,0,0])
    cylinder(2,4,2);
    
    translate([breite/4*3,1.5,-10])
    rotate([90,0,0])
    cylinder(2,4,2);
    }
}

// Verstärkung unten
//
difference()
{
    translate([breite/2+10,0,0])
    rotate([0,180,0])
    cube([20,laenge,100]);

    translate([breite/2-10,125,-130])
    rotate([0,90,0])
    cylinder(21,laenge/2+90,breite/2+69);
}

