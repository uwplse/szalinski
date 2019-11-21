// NATO Rail for Binoculars
//
// V1.0 First Version on Thingiverse
// https://www.thingiverse.com/thing:3027974
// Created by https://www.thingiverse.com/Bikecyclist

// Diameter of Connection Piece
d_connect = 21.5;

//Height of NATO Rail Bottom above Connection Piece Circumference
h_connect = 5;

// Diameter of Screw Head
d_head = 15;

// Diameter of Screw Body
d_screw = 6;

// Thickness of Wall between Screw Head and Binocular
wall = 5;

// Number of Slots in the NATO Rail - determines Rail Length
n_slots = 3;

// Bottom Width of NATO Rail (no need to change this)
w1 = 15.6;

// Number of Facets in a Circle (no need to change this, normally)
$fn = 256;

th_connect = 5 + wall;

// Parameter to ensure proper meshing (no need to change this, normally)
epsilon = 0.01;

rotate ([90, 0, 0])
union ()
{
    rotate ([0, 0, 90])
        translate ([-(h_connect + d_connect/2), 0, 0])
            difference ()
            {
                hull ()
                {
                    cylinder (d = d_connect, h = th_connect);
                    
                    translate ([h_connect + d_connect/2, 0, th_connect/2])
                        cube ([epsilon, w1, th_connect], center = true);
                }
                
                translate ([0, 0, -epsilon])
                    cylinder (d = d_screw, h = th_connect + 2 * epsilon);
                
                translate ([0, 0, wall + epsilon])
                    cylinder (d = d_head, h = th_connect - wall + epsilon);
            }


    translate ([0, 0, (n_slots * 10 + 10 - 5.35)/2])
        nato_rail (n_slots);
}

module nato_rail (n = 5)
{
    
    ws = 5.35;

    h0 = 5;
    h1 = 3.53;
    h2 = 5.87;
    h3 = 3;

    w0 = 20;
    w1 = 15.6;
    
    l = 10 * (n + 1) - ws;
    
   
    rotate ([0, 0, 0])
    translate ([0, -h0, -l/2])
    rail(h0, h1, l, w0, w1);
    
    
    module rail(h0, h1, l, w0, w1)
    {
        difference ()
        {
            union ()
            {
                railbase(h0, h1, l, w0, w1);                
                translate ([0, h0 + h1, 0])
                railprism (l);
            };
            union ()
            {
                for (i = [1:1:n]) {
                    translate ([0, h0 + h1, 10 * i - ws])
                    railslot(ws);
                }
            };
        };
    };


    module railbase (h0, h1, l, w0, w1)
    {
        translate ([0, h0 + h1 / 2, l/2])
        cube ([w1, h1, l], center = true);
    }
    
    module basefillet (h0, l, w1)
    {
    difference() {
            translate ([w1 / 2, h0, 0])
            cube ([1.5, 1.5, l]);
            translate ([w1 / 2 + 1.5, h0 + 1.5, l / 2])
            cylinder (l+1, 1.5, 1.5, $fn=64, center = true);
        }
    }
    
    module railprism (l)
    {
        linear_extrude (height = l, convexity = 10)
        polygon (points = [[7.8, 0], [10.6, 2.8], [10.6, 3.34], [8.07, 5.87], [-8.07, 5.87], [-10.6, 3.34], [-10.6, 2.8], [-7.8, 0]], convexity = 10);
    }
    
    module railslot (l)
    {
        linear_extrude (height = l, convexity = 10)
        polygon (points = [[11, 6], [11, 2.65], [10.4, 2.6], [10.4, 2.87], [-10.4, 2.87], [-10.4, 2.6], [-11, 2.65], [-11, 6]], convexity = 10);
    }
}