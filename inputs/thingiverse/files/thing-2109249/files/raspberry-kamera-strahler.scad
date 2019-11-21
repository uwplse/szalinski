/*


    Halterung für Raspi-Kamera in Strahlergehäuse

    14.02.2017  Initial version
    17.12.2017  Variante für kleines Gehäuse
    18.12.2017  Anpassungen und Optimierungen (Dicke, Tiefe)
    
    
*/

// Auflösung anpassen
//
$fn = 400;
$fn = 10;

// Welches Modell?
//
zoom=false;

// Materialstärke
//
dicke = 6;

// Parameter für großes Gehäuse
//
x_size=81;
y_size=62.5;
tiefe = 25;
skala=2;

// Parameter für kleines Gehäuse
//
/*
x_size=59.5;
y_size=40.5;
tiefe = 5;
skala=2;
*/

module Huelse()
{
    linear_extrude(tiefe, scale = skala, center = true)
    {
        offset(0)
        {
            translate([-x_size/2, -y_size/2, 0])
            square([x_size, y_size], 0);
        }
    }
}

module Innenhuelse()
{
    linear_extrude(tiefe, scale = skala, center = true)
    {
        offset(0)
        {
            translate([(-x_size+dicke)/2, (-y_size+dicke)/2, 0])
            square([x_size-dicke, y_size-dicke], 0);
        }
    }
}

hoehe=-tiefe/2-2;

module Box()
{
    translate([-(x_size)/2, -(y_size)/2, hoehe])
    linear_extrude(2)
    {
        offset(0)
        {
            square([x_size, y_size], 0);
        }
    }
}

module Innenbox()
{
    if (!zoom)
    {
        translate([-(12)/2, -10, hoehe])
        linear_extrude(3)
        {
            offset(0)
            {
                square([12, 18], 0);
            }
        }
    }
}

module Zoomloch()
{
    if (zoom)
    {
     translate([-14/2, -1, hoehe])
    
     linear_extrude(3)
     {
         square([14,14]);
     }

     // Linsenbalken
     //
     translate([-23/2, 3.5, hoehe])
    
     linear_extrude(3)
     {
         square([23,5.5]);
     }
    }
}
module Steckerleiste()
{
    // Unteres Loch für die Steckerleiste
    //
    if (zoom)
    {
     translate([-23/2, -10, hoehe])
    
     linear_extrude(3)
     {
         square([23,7]);
     }
    }
}

module Schraubloecher()
{
    // Untere
    //
    if (!zoom)
    {
        translate([-21/2, -6, hoehe])
    
        linear_extrude(3)
        {
            circle(1);
        }

        translate([+21/2, -6, hoehe])
    
        linear_extrude(3)
        {
            circle(1);
        }
    }
    else
    {
        translate([-21/2, -1, hoehe])
    
        linear_extrude(3)
        {
            circle(1);
        }

        translate([+21/2, -1, hoehe])
    
        linear_extrude(3)
        {
            circle(1);
        }
    }
        
    // Obere
    //
    if (!zoom)
    {
        translate([-21/2, 7, hoehe])
        linear_extrude(3)
        {
            circle(1);
        }
    }
    else
    {
        translate([-21/2, 13, hoehe])
        linear_extrude(3)
        {
            circle(1);
        }
    }

    if (!zoom)
    {
        translate([+21/2, 7, hoehe])
        linear_extrude(3)
        {
            circle(1);
        }
    }
    else
    {
        translate([+21/2, 13, hoehe])
        linear_extrude(3)
        {
            circle(1);
        }
    }
}

difference()
{
    Huelse();
    Innenhuelse();
}

difference()
{
    Box();
    
    Schraubloecher();
    
    Zoomloch();
    Steckerleiste();
    
    Innenbox();
}
