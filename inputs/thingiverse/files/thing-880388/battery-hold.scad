delta = 0.5;
wall = 2;
AA_r = 14.5/2;
AAA_r = 10.5/2;
h = 30;
base = 5;

n_AA_v = 4;
n_AA_h = 3;
n_AAA_v = 3;
n_AAA_h = 4;

module bat_holes(n_x, n_y, r)
{
    step = r*2 + wall;
    start = r + delta/2 + wall;
    
    for (x = [start : step : step * n_x + wall*2])
        for (y = [start: step: step * n_y + wall*2])
            translate([x, y, base])
                cylinder(r = r + delta/2, h = h);
}

module base()
{
    hole_d_AA = AA_r*2 + delta;
    hole_d_AAA = AAA_r*2 + delta;
    
    AA_sect_len = n_AA_v * hole_d_AA + wall * n_AA_v;
    AAA_sect_len = n_AAA_v * hole_d_AAA + wall * n_AAA_v;
    v_len = AA_sect_len + AAA_sect_len + wall;
    
    h_len_AA = n_AA_h * hole_d_AA + n_AA_h * wall;
    h_len_AAA = n_AAA_h * hole_d_AAA + n_AAA_h * wall;
    h_len = (h_len_AAA > h_len_AA)? h_len_AAA : h_len_AA;
        
    difference()
    {
        cube([v_len, h_len, h]);
        
        bat_holes(n_AA_v, n_AA_h, AA_r);
        
        translate([AA_sect_len, 0, 0])
            bat_holes(n_AAA_v, n_AAA_h, AAA_r);
    }   
}

base();