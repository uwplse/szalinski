/*


    Ständer für Paulmann-LED

    08.02.2017                  fp
    09.02.2017                  Neue Version mit niedrigerer Lampe, Beautify
    
*/

// Auflösung anpassen
//
$fn = 400;
//$fn = 10;

// Höhe des Fusses
//
foot_height = 13; // war 13

foot_width=39;

led_width=13;
led_height=13;
kabel_width=5;
kabel_height=3;

module Rand()
{
    translate([0, 0, foot_height])
    {
    linear_extrude(3, scale = 1.05)
    {
        offset(2)
        {
            circle(foot_width);
        }
    }
}
}

module InnenRand()
{
    translate([0, 0, foot_height])
    {
    linear_extrude(3, scale = 1.05)
    {
        offset(2)
        {
            circle(foot_width-2);
        }
    }
}
}

module Grundplatte()
{
    translate([0, 0, 0])
    {
        linear_extrude(foot_height)
        circle(foot_width+2);
    }
}

module Saeule()
{
    translate([0, 0, 0])
    linear_extrude(height = led_height)
    circle(led_width+2);
}

module Innensaeule()
{
    translate([0, 0, 0])
    {
        linear_extrude(height = led_height)
        circle(led_width);
    }
}

module Kabelkanal()
{
    translate([0, -kabel_width/2, 0])
    {
        rotate([0,0,90])
        linear_extrude(height = kabel_height)
        square([kabel_width,90]);
    }
}

translate([0, 0, 0])
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
