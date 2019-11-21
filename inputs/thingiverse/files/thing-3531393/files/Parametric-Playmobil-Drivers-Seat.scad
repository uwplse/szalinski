// Parametric Playmobil Driver's Seat
// For use with your 3D printed vehicles (or anything else that become a toy if a driver's seat is added)
// https://www.thingiverse.com/thing:3531393
// by Bikecyclist
// https://www.thingiverse.com/Bikecyclist

// Rendinger mode: which components to render, in which arragement
rendering = 0;  // [0:Assembled, 1:Seat Unit Disassembled, 2:Seat Unit For Printing, 3: Steering Wheel for Printing, 4: Seat Unit Locking Block for Printing, 5: Seat Unit Main Block for Printing]

// Centering aid
centering_aid = 1; // [1: Seat had recess in underside to serve as centering aid, 2: No centering aid]

// Width of the seat
w_seat = 26;

// Length of the seat
l_seat = 21;

// Height of the seat
h_seat = 5;

// Height of the foot of the dashboard (ensures the figure's feet fit under the dashboard)
h_foot = 14.5;

// Length (approximate thickness) of the seat back
l_back = 5;

// Height of the seat back
h_back0 = 27;

// Heightwise position of the steering wheel
h_wheel = 22;

// Lengthwise position of the steering wheel
l_wheel = 16;

// Diameter of the steering wheel rim
d_wheel = 32;

// Diameter of the steering wheel hub
d_hub = 7;

// Thickness of the steering wheel rim
th_wheel = 3.5;

// Number of the steering wheel spokes (3 recommended, must be > 1 for cutout to work)
n_spokes = 3;

// Reduction of wheel bottom cutout (to facilitate placing of figure) to allow for spoke thickness (in degrees)
a_cutout_displacement = 16;

// Angle of wheel cutout to facilitate placing of figure (104 degrees recommended for 3 spokes)
a_cutout = 360 / n_spokes - a_cutout_displacement;

// Thickness of the steering wheel spokes
th_spokes = 3.5;

// Angle of the steering wheel shaft
a_shaft = 15;

// Diameter of the steering wheel shaft
d_shaft = 3;

// Length of the steering wheel shaft
l_shaft = 12;

// Tolerance of the steering wheel shaft
tol_shaft = 0.75; // 0.5

// Greatest diameter of the streeing wheel bearing
d_bearing = 6;

// Length of the steering wheel bearing
l_bearing = 4;

h_back = h_back0 - l_back/2;

// Angle of the seat back
a_seat_back = -10;

// Height of the bottom plate
h_plate = 3;

// Lengthwise extension of the dashboard
l_dash = 8.5;

// Height of the dashboard
h_dash = 26;

// Nominal leg length of figure (measure in seating position, soles of the feet to back of the figure)
l_leg_nom = 36.5;

// Tolerance for leg length (to ensure easy placement of driver figure)
tol_leg = 1;

l_leg = l_leg_nom + tol_leg;

// Nominal length of screw (tip to bottom surface of head)
l_screw = 20;

// Heightwise displacement of screw
hd_screw = -4.5;

// Lengthwise displacement of screw
ld_screw = -15;

// Maximum length for the purpose of cutting (anything greater than the entire thing is fine)
l_max = 100;

// Maximum height for the purpose of cutting (anything greater than the entire thing is fine)
h_max = 100;

// Number of facets
$fn = 32;

// Small distance to ensure proper meshing
eps = 0.01;

if (rendering == 0)
{
    cutaway (0, 0)
    seat_unit ();
    
    cutaway (0, 1)
    seat_unit ();
    
    place_steering_wheel ()
    steering_wheel ();
} 
else if (rendering == 1)
{
    cutaway (20, 0)
    seat_unit ();
    
    cutaway (20, 1)
    seat_unit ();
    
    place_steering_wheel ()
    steering_wheel ();
} 
else if (rendering == 2)
{
    translate ([h_back/2, 0, w_seat/2])
    rotate ([0, -90, 0])
    cutaway (0, 0)
    seat_unit ();
    
    translate ([h_back, 0, w_seat/2])
    rotate ([0, 90, 0])
    cutaway (0, 1)
    seat_unit ();
    
    translate ([0, 0, th_wheel/2 * sin (60)])
    steering_wheel ();
}
else if (rendering == 3)
{
    translate ([0, 0, th_wheel/2 * sin (60)])
    steering_wheel ();
}
else if (rendering == 4)
{
    translate ([h_back/2, 0, w_seat/2])
    rotate ([0, -90, 0])
    cutaway (0, 0)
    seat_unit ();
}
else if (rendering == 5)
{
    translate ([-h_back, 0, w_seat/2])
    rotate ([0, 90, 0])
    cutaway (0, 1)
    seat_unit ();   
}

module seat_unit ()
{
    difference ()
    {
        union ()
        {
            difference ()
            {
                seat ();
                if (centering_aid == 1)
                centering_aid ();
            }
        
            hull ()
            {
                place_steering_wheel ()
                wheel_mounting ();
                
                
                translate ([0, -(l_leg - l_seat) - l_seat/2 - l_dash/2, h_wheel + hd_screw])
                ccube ([w_seat, l_dash, h_seat + h_dash  - h_wheel - hd_screw]);
            }
            
            translate ([0, ld_screw , hd_screw])
            place_steering_wheel ()
            intersection ()
            {
                hull ()
                {
                    rotate ([90, 0, 90])
                    m3hole (l_screw, -a_shaft, 2);
                }
                
                cube ([w_seat, 10, 10], center = true);
            }
        }
        
        translate ([0, ld_screw , hd_screw])
        place_steering_wheel ()
        rotate ([90, 0, 90])
        m3hole (l_screw, -a_shaft, 1);
        
        place_steering_wheel ()
        steering_wheel (tol_shaft);
        
        
        x = (l_leg - l_seat) + l_seat/2;
        translate ([0, -(l_leg - l_seat) - l_seat/2 + x/2 + eps, h_seat + eps])
        ccube ([w_seat + 2 * eps, x, h_foot]);
    }
}

module centering_aid ()
{
    translate ([0, 0, -h_seat])
    hull ()
    {
        cube ([4 * h_seat, 4 * h_seat, eps], center = true);
        
        translate ([0, 0, h_seat])
        cube ([eps, eps, eps], center = true);
    }
}

module seat ()
{
    // Seat
    ccube ([w_seat, l_seat, h_seat]);

    // Seat back
    hull ()
    {
        // Seat back bottom
        translate ([0, l_seat/2 + l_back/2, 0])
        ccube ([w_seat, l_back, h_seat]);
        
        // Reclined Seat back
        translate ([0, l_seat/2 + l_back/2, h_seat])
        rotate ([a_seat_back, 0, 0])
        {
            ccube ([w_seat, l_back, h_back]);
            
            translate ([0, 0, h_back])
            rotate ([0, 90, 0])
            cylinder (d = l_back, h = w_seat, center = true);
        }
    }

    // Floor plate
    translate ([0, l_seat/2 + l_back/2 - l_leg/2, -h_plate])
    ccube ([w_seat, l_leg + l_back, h_plate]);

    // Dashboard plate
    translate ([0, -(l_leg - l_seat) - l_seat/2 - l_dash/2, -h_plate])
    ccube ([w_seat, l_dash, h_seat + h_dash + h_plate]);

}

module place_steering_wheel ()
{
    translate ([0, -l_wheel, h_seat + h_wheel])
    rotate ([90 + a_shaft, 0, 0])
    children ();
}

module steering_wheel (tol = 0)
{
    rotate ([0, 0, 360/(2 * n_spokes)])
    {
        rotate ([0, 0, 90 - 360/(2 * n_spokes)])
        difference ()
        {
            rotate_extrude ()
            translate ([d_wheel/2 - th_wheel/2, 0])
            circle (d = th_wheel, $fn = 6);
            
            translate ([0, 0, -th_wheel/2 - eps])
            linear_extrude (th_wheel + 2 * eps)
            polygon ([[0, 0],  [-d_wheel, -d_wheel * tan(a_cutout/2)], [-d_wheel, d_wheel * tan(a_cutout/2)]]);
        }
        
        for (i = [0:n_spokes - 1])
            rotate ([0, 0, 360/n_spokes * i])
            rotate ([90, 0, 0])
            cylinder (h = d_wheel/2 - th_wheel/2, d = th_spokes, $fn = 6);
        
        translate ([0, 0, -th_wheel/2 * sin (60)])
        cylinder (h = th_wheel * sin (60), d = d_hub + tol, $fn = 32);
        
        cylinder (h = l_shaft + tol, d = d_shaft + tol, $fn = 32);
        
        translate ([0, 0, l_bearing + d_bearing/2])
        for (i = [0, 1])
            mirror ([0, 0, i])
            cylinder (h = d_bearing/2, d2 = d_shaft + tol, d1 = d_bearing + tol);
    }
}

module wheel_mounting ()
{
    translate ([0, 0, l_bearing])
    ccube ([w_seat, 2 * (h_dash - h_wheel), -l_wheel - l_bearing + l_leg - l_seat/2]);
}

module ccube (dim)
{
    translate ([0, 0, dim [2]/2])
    cube (dim, center = true);
}

module cutaway (d = 0, partno = 0)
{
    translate ([partno==0?-d:d, 0, 0])
        if (partno == 0)
            intersection ()
            {
                children ();
                
                cutbody ();
            }
        else
            difference ()
            {
                children ();
                
                cutbody ();
            }
}

module cutbody ()
{
    translate ([-w_seat, -l_max - l_wheel, h_wheel + hd_screw + eps])
    cube ([w_seat + 2 * eps, l_max, h_max]);
}

module cutdup (d = 0, part = 0)
{
    if (part != 2)
        translate ([-d, 0, 0])
        intersection ()
        {
            children ();
            
            translate ([-1000, 0, 0])
            cube ([2000, 2000, 2000], center = true);
        }

    if (part != 1)
        translate ([d, 0, 0])
        difference ()
        {
            children ();
            
            translate ([-1000, 0, 0])
            cube ([2000, 2000, 2000], center = true);
        }
}

module m3hole (l_screw, angle = 0, tol = 0)
{
    l_head = 2;
    d_head = (5.5 + tol)/2;
    d_screw = (3.5 + tol)/2;
    l_nut = 2.4;
    size_nut = 5.5 + tol;
    n_excess = 5;
    
    rotate ([0, 0, angle])
    translate([0, 0, 0])
    
    union ()
    {
        //Hole for Screw
        union ()
        {
            translate([0, 0, -(l_screw - l_nut)/2])
            difference ()
            {
                //Screw Head
                translate([0, 0, - n_excess * l_head])
                    cylinder (h = n_excess * l_head, r1 = d_head, r2 = d_head);
                
                //Ridges to hold Screw in Place
                translate([0, 0, -l_head/2])
                    union ()                
                    {
                        for (i=[1,-1])
                        {
                            translate([0, i * d_head, -l_head/2 - 0.25])
                                rotate ([0, 90, 0])
                                    cylinder (2 * d_screw, 0.25, 0.25, center = true);
                        }
                    }

            }
            
            //Screw Cylinder
            cylinder (h = l_screw - l_nut + 0.1, r1 = d_screw, r2 = d_screw, center = true);
        }

        translate([0, 0, (l_screw - l_nut)/2])
        difference ()
        {
            //Hole for Nuts
                linear_extrude (n_excess * l_nut)
                    circle ((size_nut / sqrt (3)), $fn = 6);
            
            //Ridges to hold Nut in Place
            union ()
            {
                for (i=[1,-1])
                {
                    translate([0, i * d_head, 0.25 + l_nut])
                        rotate ([0, 90, 0])
                            cylinder (2 * d_head, 0.25, 0.25, center = true);
                }
            }
        }
    }
}