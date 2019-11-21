$fn = 128;

// Diameter of the bottle mouth
d_bottle = 27;

// Inner diameter of the bottle opener mouth
d_opener_inner = 28.25;

// Inner height of the bottle opener mouth
h_opener_inner = 10;

// Wall thickness of the bottle opener mouth
thickness_wall_opener = 3;

// Wall thickness of the printed ring
thickness_wall_ring = 2;

// Tolerance of the printed ring versus the bottle mouth
tolerance_bottle = 0.5;

// Tolerance of the printed ring versus against the opener 
tolerance_ring = 0.5;

d_opener_outer = d_opener_inner + 2 * (thickness_wall_opener + tolerance_ring);

d_ring_outer = d_opener_outer + 2 * thickness_wall_ring;


difference ()
{
    union ()
    {
        cylinder (d = d_opener_inner, h = h_opener_inner);
        difference ()
        {
            cylinder (d = d_ring_outer, h = 2 * thickness_wall_ring);
            
            translate ([0, 0, thickness_wall_ring])
                cylinder (d = d_opener_outer + 2 * tolerance_ring, h = 3 * thickness_wall_ring);
        }
    }
    translate ([0, 0, -1])
        cylinder (d = d_bottle + tolerance_bottle, h = 2 * h_opener_inner);
    
    translate ([0, 0, -0.01])
        cylinder (d1 = d_bottle + 2, d2 = d_bottle + tolerance_bottle, h = 1);
    
    difference ()
    {
        translate ([0, 0, -0.01])
            cylinder (d = d_ring_outer + 2, h = 1);
        
        translate ([0, 0, -0.02])
            cylinder (d2 = d_ring_outer + 0.01, d1 = d_ring_outer - 2, h = 1.03);
    }
}