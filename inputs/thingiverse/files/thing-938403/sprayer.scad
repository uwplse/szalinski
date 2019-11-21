//
//  sprinkle nozzle for watering can
//
//  design by egil kvaleberg, 23 july 2015
//

// assuming no bevel, in millimeters
cone_dia = 130; 

cone_len = 60;

// cone shape, range 0.0 to close to 1.0
cone_bevel = 0.53; 
// neck nominal diameter
neck_dia = 25;
// neck cone added diameter, 0.0 for straight 
neck_cone = 1.3;

neck_len = 30;

wall = 1.5;

nozzle_dia = 1.8;
nozzle_dist = 12;

/* [Hidden] */

d = 0.01;
wa = cos(atan2(cone_dia/2, cone_len));
wdx = wall/wa;
wdz = wa*wall;
neck_dia1 = neck_dia;
neck_dia2 = neck_dia+neck_cone;

module ray(d, a) {
    translate([0, 0, wall+cone_len]) rotate([180+atan2(d, cone_len), 0, a]) cylinder(r=nozzle_dia/2, h=2*cone_len, $fn=8); 
}    
module cone(r1, r2, h) {
    slope = cone_bevel * r1;
    intersection () {
        cylinder(r1=r1, r2=r2, h=h, $fn=60); 
        cylinder(r1=r1-slope, r2=r1-slope+h, h=h, $fn=60);
    }
}  

module sprayer() {
    difference () {
        union () {
            cone(cone_dia/2+wall, neck_dia1/2+wall, wall+cone_len); 
            translate([0, 0, wall+cone_len]) cylinder(r1=neck_dia1/2+wall, r2=neck_dia2/2+wall, h=neck_len, $fn=60);
        }
        union () {
            translate([0, 0, wall]) cone(cone_dia/2-wdx, neck_dia1/2, cone_len-wdz);
            translate([0, 0, wall+cone_len-wdz-d]) cylinder(r1=neck_dia1/2, r2=neck_dia2/2, h=d+wdz+neck_len+d, $fn=60);
            ray(0, 0);
            for (d = [nozzle_dist:nozzle_dist:cone_dia/2-wall]) 
                for (a = [0 : 360/floor(2*3.14*d / nozzle_dist) : 360-1])
                    ray(d, a);        
        }
    } 
}

//intersection () {
sprayer();
//cube([cone_dia/2, cone_dia/2, cone_len+neck_len+2*wall]);
//}