$fn=180;
wandstaerke = 4;
h_cleantec  = 25;
h_fraese    = 20;
h_zwischen  = 10;

//d_cleantec  = 35.2; // innen
d_cleantec  = 35.9; // innen

// Schlauch von Bernd
d_fraese_l  = 28.4; // innen, größerer von beiden
d_fraese_s  = 20.6;

// Neue Werte von mir
d_fraese_l  = 32.0; // innen, größerer von beiden
d_fraese_s  = 20.1;

// gemessene Werte am Fraesanschluss
// 32.7-33.5
// 21-21.6

// fraseanschluss-schlauch: aussen: 37 => 41.5 gedehnt über dem Anschluss

o_kabelbinder=2;
h_kabelbinder=5;
d_kabelbinder=1.4;

// wulst am Ende des fräserseitigen Anschlusses
h_wulst=2;
o_wulst=1;
d_wulst=1;


// Noppen zur Aufnahme des cleantec Schlauchs
h_noppen=6;
d_noppen=3;
b_noppen=10;
o_noppen=5;


module ring(d_in, d_out, h) {
    union(){
        difference (){
            cylinder (d=d_out, h=h);
            cylinder (d=d_in, h=h);
        }
    }
}

module noppen_ring(d_in, d_out, h, b, n) {
    intersection(){
        difference (){
            cylinder (d=d_out, h=h);
            cylinder (d=d_in, h=h);
        }
        union(){
            cube([d_out/2, b, h]);
            rotate(a=120, v=[0,0,1]) {
                cube([d_out/2, b, h]);
            }
            rotate(a=240, v=[0,0,1]) {
                cube([d_out/2, b, h]);
            }
        }
    }
}


/*#polyhedron(*/
  /*points=[ [2,2,2],  [2,0,2],  [0,0,2],  [0,2,2], // the four points at base*/
           /*[0,0,0]  ],                                 // the apex point */
  /*faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side*/
              /*[1,0,3],[2,1,3] ]                         // two triangles for square base*/
 /*);*/







// cleantec side:
difference(){
    cylinder (d=d_cleantec + 2 * wandstaerke, h=h_cleantec);
    cylinder (d=d_cleantec                  , h=h_cleantec);
}
translate([0,0,o_noppen]) {
    noppen_ring(d_in = d_cleantec - d_noppen, d_out=d_cleantec, h=h_noppen, b=b_noppen, n=3);
}

// fraese side:
translate([0, 0, 1] * (h_cleantec + h_zwischen)){
    scale([d_fraese_s/d_fraese_l, 1, 1]) {
        difference(){
            cylinder (d=d_fraese_l + 2 * wandstaerke, h=h_fraese);
            cylinder (d=d_fraese_l                  , h=h_fraese);
            
            // kabelbinder
            translate([0, 0, 1] * (h_fraese - h_kabelbinder - o_kabelbinder - h_wulst - o_wulst)) {
                ring (d_in = d_fraese_l + 2 * wandstaerke - d_kabelbinder, d_out = d_fraese_l + 2 * wandstaerke , h=h_kabelbinder);
            }
        }
        // wulst
        translate([0, 0, 1] * (h_fraese - h_wulst - o_wulst)) {
            ring (d_in = d_fraese_l + 2 * wandstaerke, d_out = d_fraese_l + 2 * wandstaerke + d_wulst , h=h_wulst);
        }
        
        // innenwülste
        for (i=[1:4]){
            translate([0, 0, 1] * (18/4*i )) {
                ring (d_in = d_fraese_l - 0.5, d_out = d_fraese_l, h=0.9);
            }
        }
    }
}
// zwischenraum:
difference(){
    hull () {
        translate([0, 0, 1] * (h_cleantec)) {
            cylinder (d=d_cleantec + 2 * wandstaerke, h=0.0001);
        }
        translate([0, 0, 1] * (h_cleantec + h_zwischen)) {
            scale([d_fraese_s/d_fraese_l, 1, 1]) {
                cylinder (d=d_fraese_l + 2 * wandstaerke, h=0.0001);
            }
        }
    }

    hull () {
        translate([0, 0, 1] * (h_cleantec)) {
            cylinder (d=d_cleantec                  , h=0.0001);
        }
        translate([0, 0, 1] * (h_cleantec + h_zwischen)) {
            scale([d_fraese_s/d_fraese_l, 1, 1]) {
                cylinder (d=d_fraese_l                  , h=0.0001);
            }
        }
    }
}


