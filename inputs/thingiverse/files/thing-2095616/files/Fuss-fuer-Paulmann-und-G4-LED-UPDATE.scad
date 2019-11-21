/*


    Ständer für Paulmann-LED

    08.02.2017  fp
    09.02.2017  Niedrigere Lampe, Beautify
    10.02.2017  G4-Update
    
*/

// Auflösung anpassen
//
$fn = 400;
//$fn = 10;

// Parameter
//

// Fuß
//
foot_height = 18; // 13 = Paulmann, 18 für G4
foot_width=39;   // 39 = Cellular Lamp

// LED-Fassung
//
led_width=8;    // 13 für Paulmann, 8 für G4
led_height=18;  // 20 für Paulmann, 20 für G4

// G4???
//
g4 = true;
g4_fassung=8;

// Kabelkanal
//
kabel_width=5;
kabel_height=3;

module G4_Fassung()
{
    if (g4 == true)
    {
        difference()
        {
            translate([0, 0, led_height-g4_fassung])
            {
                linear_extrude(3)
                {
                    circle(led_width);
                }
            }
        
            translate([0, -3, led_height-g4_fassung])
            {
                linear_extrude(3)
                {
                    circle(1);
                }
            }

            translate([0, +3, led_height-g4_fassung])
            {
                linear_extrude(3)
                {
                    circle(1);
                }
            }
        }
    }
}

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
    
    G4_Fassung();
}
