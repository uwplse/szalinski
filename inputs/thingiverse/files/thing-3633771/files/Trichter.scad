// Parameters
//Aussendurchmesser unten
d_u_a =5; //[2:0.5:30]
//Innendurchmesser unten
d_u_i =3; //[0.1:0.1:29]
//"Laenge des Rohres"
h_u = 12; //[1:0.5:70]

//Aussendurchmesser oben
d_o_a = 17; //[5:0.5:40]
//Innendurchmesser unten
d_o_i =15; //[4:0.5:39]
//Hoehe des "Trichters"
h_o = 7; //[3:0.5:70]


//Rundung
ecken=60; //[2:360]

/* [Hidden] */
$fn=ecken; //[1:360]

module oben(){
      difference(){
        cylinder(h_o, d_u_a, d_o_a, false);
        cylinder(h_o, d_u_i, d_o_i, false);
    }
}

module unten(){
    translate([0,0,-h_u])
    difference(){
        cylinder(h_u, d_u_a, d_u_a, false);
        cylinder(h_u, d_u_i, d_u_i, false);
    }
}

unten();
oben();