// A type-A ISO KF flange with 15 degree taper

od_a = 40.0; // Outer diameter of flange
id_b = 26.2; // Inner diameter on connector side where centering ring enters
id_c = 22.1; // Inner diameter of pipe
od_d = 25.4; // Outer diameter of pipe

l_rim = 3;   // height of flange rim (the 'widest' part)
l_e = 40;    // total height of connector
l_ring = 2.2;  // depth into which centering ring goes into

inner_taper = false; // Whether to add an inner 45 degree taper for easier 3d printing

//----

point_a = [0.5*id_b, 0];
point_b = [0.5*od_a, 0];
point_c = [0.5*od_a, l_rim];

fl_base = 0.5*(od_a - od_d);
point_d = [0.5*od_d, l_rim + tan(15)*fl_base];
point_e = [0.5*od_d, l_e];
point_f = [0.5*id_c, l_e];
point_g = inner_taper ? [0.5*id_c, l_ring + 0.5*(id_b-id_c)] : [0.5*id_c, l_ring];
point_h = [0.5*id_b, l_ring];

fl_points = [point_a,
             point_b,
             point_c,
             point_d,
             point_e,
             point_f,
             point_g,
             point_h];
             
rotate_extrude($fn=256) {
    polygon(fl_points);
}