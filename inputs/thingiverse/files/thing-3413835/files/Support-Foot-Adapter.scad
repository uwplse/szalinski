$fa=1*1;
$fs=0.25*1;

// compensate cut-out precision: my printer tends to print cut-outs 0.4 mm too small. Add this to value to cut-out, e.g. screw boring. Adjust this setting according to the precision of your printer
cutout_precision = 0.4;

// side on which to place for opening for nut 
nut_pos = "outside"; // [inside, outside]

// thickness of holder
thn_adapter = 15;

// height of holder on flat part, mid/shoulder part is scaled accordingly
h_adapter = 18;

// width of foot (width of foot slider cut-out)
w_foot = 25;

// thickness of foot (depth of foot slider cut-out)
thn_foot = 8;

// foot holder screw diameter: M6
d_foot_screw = 6;

// rail screws diameter: M8
d_rail_screw = 8;

// rail screws: diameter of M8 hex head (flat sides)
d_head_rail_screw = 12.7; // 10.4;

// thickness of screw head / opening depth
thn_head = 5;

// center-center distance between openings for rail screws. Adjust this according to your router. 
delta_rail = 84;

// rounding
rounding_radius=2;


l_adapter = delta_rail + 20;
thn_adapter_mod = thn_adapter-2*rounding_radius;
h_adapter_mod = h_adapter-1*rounding_radius;  // only 1 due to reduced shoulder offset
z_rail = h_adapter_mod / 2;


// compensate for cut-out precision
d_foot_screw_mod = d_foot_screw + cutout_precision;
d_rail_screw_mod = d_rail_screw + cutout_precision;
d_head_rail_screw_mod = d_head_rail_screw + cutout_precision;
w_foot_mod = w_foot + cutout_precision;


difference() {
    minkowski() {
        union() {
            translate([-l_adapter/2, 0, 0])
                cube([l_adapter, h_adapter_mod, thn_adapter_mod]);

            shoulder();
        }
        sphere(rounding_radius);
    }
    
    
    // foot cut-out
    translate([-w_foot_mod/2, -h_adapter_mod, thn_adapter_mod+rounding_radius-thn_foot])
        cube([w_foot_mod, h_adapter_mod*3, thn_foot]); 

    if (nut_pos == "inside") {
        rail(thn_adapter-rounding_radius-thn_head);
    } else {
        rail(-rounding_radius);
    }
    
    translate([0, h_adapter_mod, -h_adapter])   
        cylinder(h_adapter*2, d=d_foot_screw_mod);
}


module shoulder() {
    translate([0,h_adapter_mod,0]) {
         linear_extrude(thn_adapter_mod)
            polygon(points = [[-w_foot_mod/2-10,0], [-w_foot_mod/2-5,h_adapter_mod/2],
                              [w_foot_mod/2+5,h_adapter_mod/2], [w_foot_mod/2+10,0]]);
    } 
}


module rail(y_rail) {
    translate([0, z_rail, y_rail]) {
        
        translate([delta_rail/2, 0, 0]) {
            hex_nut(d_head_rail_screw_mod, thn_head);
            screw();
        }
        translate([-delta_rail/2, 0, 0]) {
            hex_nut(d_head_rail_screw_mod, thn_head);
            screw();
        }
    }
}

module screw() {
    screw_len = 100; 
    translate([0, 0, -screw_len/2]) {
        cylinder(screw_len, d=d_rail_screw_mod);
    }
}


module hex_nut(d_head_flat, thn_head) {
    r = (d_head_flat/2) / cos(30);
    linear_extrude(thn_head)
        polygon(points = [[r, 0], [r * cos(60), r * sin(60)],
                          [r * cos(120), r * sin(120)], 
                          [r * cos(180), r * sin(180)],
                          [r * cos(240), r * sin(240)], 
                          [r * cos(300), r * sin(300)]]);
}