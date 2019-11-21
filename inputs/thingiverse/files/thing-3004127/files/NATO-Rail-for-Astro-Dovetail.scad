// Parametric NATO Rail for Astro Dovetail by Bikecyclist
// https://www.thingiverse.com/thing:3004127
// V1: First release

//CUSTOMIZER VARIABLES

/* [Parameters] */

// (must be >= dovetail height + 9.4)
total_height = 40;

l_dovetail = 30;

//Typical Astro Dovetail: 32.5 mm
w_dovetail = 32.5;

//Typical Astro Dovetail: 10 mm
h_dovetail = 10;

//Typical Astro Dovetail: 60 degrees
angle_dovetail = 60;

//Height of 45 degree chamfer at bottom of dovetail
h_chamfer = 2;

//Rail length is determined by number of slots (total length is 4.65 mm + 10 mm per slot)
n_slots = 6;

//CUSTOMIZER VARIABLES END

/* [Constants] */

// Constant to ensure proper meshing, should normally not be changed
epsilon = 0.01;         

// Constant, should normally not be changed
w_railbase = 15.6;

union ()
{
    dovetail (l_dovetail, w_dovetail, h_dovetail, angle_dovetail);

    hull ()
    {
        cube ([w_dovetail - 2 * h_dovetail / tan (angle_dovetail), l_dovetail, epsilon], center = true);
        
        translate ([0, 0, total_height - 9.4 - h_dovetail])
            cube ([w_railbase, 10 * (n_slots + 1) - 5.35, epsilon], center = true);
    }

    translate ([0, 0, total_height - 9.4 - h_dovetail])
        nato_rail (n_slots);    
}

module dovetail (l, w, h, a = 60)
{
    rotate ([90, 0, 0])
        difference ()
        {
            translate ([0, -h, -l/2])
                linear_extrude (l)
                    polygon 
                        ([
                            [-w/2, 0],
                            [-w/2 + h / tan (a), h],
                            [w/2 - h / tan (a), h],
                            [w/2, 0],
                        ]);
            
            translate ([0, -h + h_chamfer/2 - epsilon, 0])
                difference ()
                {
                    cube ([w + 2 * epsilon, h_chamfer, l + 2 * epsilon], center = true);

                    hull ()
                    {
                        translate ([0, -h_chamfer/2 - epsilon, 0])
                            cube ([w - 2 * h_chamfer - 2* h_chamfer * cos (angle_dovetail), epsilon, l - 2 * h_chamfer], center = true);
                        
                        translate ([0, h_chamfer/2 + epsilon, 0])
                            cube ([w - 2 * h_chamfer * cos (angle_dovetail), epsilon, l], center = true);
                    }
                }
        }
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
    
    rotate ([90, 0, 0])
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