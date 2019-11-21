$fn = 16;

//CUSTOMIZER VARIABLES

//Bastion radius in playset raster size multiples

n_per_size = 3;         // Number of nozzle places per size (front to back) [1:32]
n_sizes = 5;            // Number of nozzle places for different sizes (left to right) [1:32]

d_bore = 6.6;           // Size of bore for nozzles (choose 6.6 for M6) [1:26] 
d_wrench = 7;           // Wrench size in mm (typical value is 7) [1:36] 

w_chamfer = 0.5;        // Chamfer width in mm [0:4] 

separation = 1.5;       // Separation of nozzle recesses [1.5:6] 

roundness = 5;          // Nozzle stand corner radius [0:24] 

l_bore = 8;             // Depth of bore for nozzle thread [0:24] 
l_hex = 1;              // Depth of recess for hex nut [0:10] 
l_bottom = 1;           // Thickness of stand bottom [0:10]

//CUSTOMIZER VARIABLES END

d_hex = d_wrench / 0.866 + w_chamfer;

difference ()
{
    translate ([roundness, roundness, 0])
        linear_extrude (l_bore + l_hex + l_bottom, convexity = 10)
            minkowski ()
            {
                square ([n_sizes * (d_hex + separation) - 2 * roundness, n_per_size  * (d_hex + separation) - 2 * roundness]);
                circle (d = 2 * roundness);
            }
    
    for (i = [1:n_per_size])
        for (j = [1:n_sizes])
            translate ([(j - 0.5) * (d_hex + separation), (i - 0.5) * (d_hex + separation), 0])
        {
            translate ([0, 0, l_bottom])
                cylinder (d = d_bore, h = 2 * l_bore);
            
            translate ([0, 0, l_bottom + l_bore - w_chamfer])
                cylinder (d1 = d_bore, d2 = d_bore + w_chamfer, h = w_chamfer + 0.01);
            
            translate ([0, 0, l_bottom + l_bore])
                cylinder (d = d_hex, h = l_bore, $fn = 6);
            
            translate ([0, 0, l_bottom + l_bore + l_hex - w_chamfer])
                cylinder (d1 = d_hex, d2 = d_hex + w_chamfer, h = w_chamfer + 0.01, $fn = 6);
            

        }
}