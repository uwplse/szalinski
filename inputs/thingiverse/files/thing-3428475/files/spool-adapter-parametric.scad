//Variablen

//Innendurchmesser Spule (Minimum = 33)
dia = 56;

//Höhe (Minimum = 13)
z = 20;

//Auflösung
$fn = 100;

//------------------------------------------------------------------------------

//Ring aussen
difference ()
{
    cylinder (5, d1 = dia + 20, d2 = dia + 20);
    cylinder (5, d1 = dia + 10, d2 = dia + 10);
}

//Ring innen
difference ()
{
    cylinder (z, d1 = dia, d2 = dia);
    cylinder (z, d1 = dia - 10, d2 = dia - 10);
}

//Gehäuse Kugellager
difference ()
{
    cylinder (z, d1 = 32.2, d2 = 32.2);
    cylinder (z, d1 = 9, d2 = 9);
    cylinder (7, d1 = 22.2, d2 = 22.2);
    translate ([0, 0, 7]) cylinder (6, d1 = 22.2, d2 = 0);
    translate ([0, 0, 15]) cylinder (5, d1 = 22.2, d2 = 22.2);
}

//Verbindungen aussen 0 Grad
translate([dia / 2 + 2.5, 0, 2.5]) cube ([10, 5, 5],true);
rotate ([0,0,180])
{
    translate([dia / 2 + 2.5, 0, 2.5]) cube ([10, 5, 5],true);
}
rotate ([0,0,90])
{
    translate([dia / 2 + 2.5, 0, 2.5]) cube ([10, 5, 5],true);
    rotate ([0,0,180])
    {
        translate([dia / 2 + 2.5, 0, 2.5]) cube ([10, 5, 5],true);
    }
}

//Verbindungen innen 0 Grad
translate([13.5, -2.5, 0]) cube ([dia / 2 -16.5, 5, z]);
rotate ([0,0,180])
{
    translate([13.5, -2.5, 0]) cube ([dia / 2 -16.5, 5, z]);
}
rotate ([0,0,90])
{
    translate([13.5, -2.5, 0]) cube ([dia / 2 -16.5, 5, z]);
    rotate ([0,0,180])
    {
        translate([13.5, -2.5, 0]) cube ([dia / 2 -16.5, 5, z]);
    }
}

//Verbindungen 45 Grad
rotate ([0, 0, 45]) 
{    
    //Verbindungen aussen 45 Grad
    translate([dia / 2 + 2.5, 0, 2.5]) cube ([10, 5, 5],true);
    rotate ([0,0,180])
    {
        translate([dia / 2 + 2.5, 0, 2.5]) cube ([10, 5, 5],true);
    }
    rotate ([0,0,90])
    {
        translate([dia / 2 + 2.5, 0, 2.5]) cube ([10, 5, 5],true);
        rotate ([0,0,180])
        {
            translate([dia / 2 + 2.5, 0, 2.5]) cube ([10, 5, 5],true);
        }
    }

    //Verbindungen innen 45 Grad
    translate([13.5, -2.5, 0]) cube ([dia / 2 -16.5, 5, z]);
    rotate ([0,0,180])
    {
        translate([13.5, -2.5, 0]) cube ([dia / 2 -16.5, 5, z]);
    }
    rotate ([0,0,90])
    {
        translate([13.5, -2.5, 0]) cube ([dia / 2 -16.5, 5, z]);
        rotate ([0,0,180])
        {
            translate([13.5, -2.5, 0]) cube ([dia / 2 -16.5, 5, z]);
        }
    }
}

