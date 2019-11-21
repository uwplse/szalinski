$fn = 150; // Resolution [50:Low, 100:Medium, 150:Good]

// bash command: openscad -o connector.stl -D 'id1=3.2'  -D 'id2=3.2' parametric_connector.scad

// Barbs with 5 segments and 50% increase of tube inner diameter.

id1 = 3.2; // Inner tube diameter 1
id2 =  6.4; // Inner tube diameter 2

echo(id1=id1);
echo(id2=id2);

/* [Hidden] */
// Barb profile for a 1.5mm inner diameter tube:
tube_i_d = 1.5; 
d1_1 = 1.4;
d2_1 = tube_i_d;
h1 = .1;
h2 = .6;
d2_3 = 1.5 * d2_1;
h3 = 1.6;
d2_4 = .8 * d2_3; 
h4 = 1.8;
scale_fact5 = 1.7;
d1_5 = d2_4;
d2_5 = d2_4 * scale_fact5; 
h5 = (d2_5 - d1_5) / 2;
d_trough = 1.2;
h_all_barb = h1 + h2 + h3 + h4 + h5;

// Middle part
scaling1 = id1 / tube_i_d;
scaling2 = id2 / tube_i_d;
d_fact1 = 2.5;
d_fact2 = 1.5;
mid_part_h_fact = .3;
h1_mid = id1 > id2 ? h_all_barb * scaling1 * mid_part_h_fact : h_all_barb * scaling2 * mid_part_h_fact;

d_bigger = id1 > id2 ? id1 : id2;
d_max_scaled = d_bigger / tube_i_d * d2_5;
h_mid = d_bigger / tube_i_d * h5;
//------------------------------------------------------

module hose_barb(i_d = 1.5){
    // one side of the connector
    scale(i_d / tube_i_d)
    difference(){
        translate([0, 0, -h5])
        union(){
            translate([0, 0, -h4])
            union(){
                cylinder(d = d2_4, h = h4); //segment 4
                translate([0, 0, -h3]){
                    union(){
                        cylinder(d1 = d2_1, d2 = d2_3, h = h3); //segment 3
                        translate([0, 0, - h2]){
                            union(){
                                translate([0, 0, - h1])
                                cylinder(d1 = d1_1, d2 = d2_1, h = h1); //segment 2
                                cylinder(d = d2_1, h = h2); //segment 1
                            }
                        }
                    }
                }
            }
        }
        h_all = h1 + h2 + h3 + h4 + h5;
        translate([0, 0, -(h_all + .1) ])
        cylinder(d = d_trough, h = h_all + .2);
    }
}

module middle_part(){
    // Connects both barbs
    difference(){
        union(){
            translate([0, 0, h1_mid])
            scale(scaling2)
            cylinder(d1 =  d_max_scaled/scaling2, d2 = d1_5,  h = h5);
            rotate([180,0,0])
            scale(scaling1)
            cylinder(d2 = d1_5 , d1 =  d_max_scaled/scaling1, h = h5 );
            cylinder(d = d_max_scaled, h = h1_mid);
        }
        translate([0, 0, -.01 - h5*scaling1])
        cylinder(d1 = scaling1 * d_trough , d2 = scaling2 * d_trough, h = h1_mid + h5* (scaling1 + scaling2) + .02);
    }
}

module connector(){
    intersection(){
        translate([0, 0, h_all_barb * scaling1])
        union(){
            hose_barb(id1);
            middle_part();
            translate([0, 0, h1_mid])
            rotate([180, 0, 0])
            hose_barb(id2);
        }
        
        h_cut = h1_mid + h_all_barb * (scaling1 + scaling2) + 0.1;
        translate([0, 0, -0.05])
        translate([0, 0, h_cut / 2])
        cube([d_max_scaled * .95, d_max_scaled * .95, h_cut],center=true);
    }
}

connector();
