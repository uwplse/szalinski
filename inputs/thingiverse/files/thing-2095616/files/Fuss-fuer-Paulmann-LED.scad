/*


    Ständer für Paulmann-LED

    08.02.2017                  fp
    
*/

// Auflösung anpassen
//
$fn = 400;
//$fn = 10;

// Höhe des Fusses
//
foot_height = 5;

module Rand()
{
    translate([0, 0, 5])
    {
    linear_extrude(3, scale = 1.05)
    {
        offset(2)
        {
            //square(76, center = true);
            circle(39);
        }
    }
}
}

module InnenRand()
{
    translate([0, 0, 5])
    {
    linear_extrude(3, scale = 1.05)
    {
        offset(2)
        {
            //square(76, center = true);
            circle(37);
        }
    }
}
}

module Grundplatte()
{
    translate([0, 0, 0])
    {
        linear_extrude(foot_height)
        circle(39+2);
    }
}

module Saeule()
{
    translate([0, 0, foot_height])
    linear_extrude(height = 13)
    circle(15);
}

module Innensaeule()
{
    translate([0, 0, 0])
    {
        linear_extrude(height = 25)
        circle(13);
    }
}

module Kabelkanal()
{
    translate([0, -2.5, 0])
    {
        rotate([0,0,90])
        linear_extrude(height = 3)
        square([5,90]);
    }
}

translate([0, 0, foot_height-3])
{
    difference()
    {
        union()
        {
            difference()
            {
                Rand();
                InnenRand();
            }

            Grundplatte();
            Saeule();
        }

       Innensaeule();        
       Kabelkanal();
    }
}
