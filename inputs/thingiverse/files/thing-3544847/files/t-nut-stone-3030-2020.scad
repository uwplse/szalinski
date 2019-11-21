// Aufloesung von Kugeln und Zylindern
$fn=111;

// Spiel in der Nut
eps=0.2;  // [0,.1,.2,.3,.4,.5,.6]

// Gewindenenndurchmesser. Sinnvolle kombinationen: P20 und 2.4 bis 4, P30 und 4 bis 6 
m=4; // [2.4,3,4,5,6]
// Profilnennweite
p=30; // [20,30]

nutStone(p, m);

/*
translate ( [ 0,  0,0] ) nutStone(20, 2.4);
translate ( [ 0, 10,0] ) nutStone(20, 3);
translate ( [ 0, 20,0] ) nutStone(20, 4);
translate ( [ 0, 30,0] ) nutStone(20, 5);

translate ( [15,  0,0] ) nutStone(30, 3);
translate ( [15, 10,0] ) nutStone(30, 4);
translate ( [15, 20,0] ) nutStone(30, 5);
translate ( [15, 30,0] ) nutStone(30, 6);
*/

module nutStone(p=20, m=3) {
    b=m*.85; // +.24;
    difference(){
        if (p==20) { stone20(); } else { stone30(); }
        translate ( [ 0, 0,   0] ) cylinder ( d =b,           h=10, center = true); 
        translate ( [ 0, 0, 5/2] ) cylinder ( d1=b-1, d2=b+2, h= 2, center = true); 
    }
}

module stone20(){
    color("lightgray") {
        b=m*.85; // +.24;
        intersection(){
            intersection(){
                difference(){
                    union(){
                        cylinder ( d=10, h=3.4, center = true);
                        translate ( [ 0, 0, 0] ){
                            cylinder(d=6, h=4.4, center = true);
                            translate ( [ 5/2, 3/2, 0] ) cube     ( [5, 3, 3.4], center = true);
                            translate ( [-5/2,-3/2, 0] ) cube     ( [5, 3, 3.4], center = true);
                            }
                        translate ( [ 0, 0, .5] ){
                            cylinder(d=6, h=4.4, center = true);
                            translate ( [ 3/2, 3/2, 0] ) cube     ( [3, 3, 4.4], center = true);
                            translate ( [-3/2,-3/2, 0] ) cube     ( [3, 3, 4.4], center = true);
                            }
                        }
                    }
                translate ( [ 0, 0, .5] ) cube     ( [10, 6-eps, 4.4], center = true);
                }
            translate ( [ 0, 0, .5] )  cylinder ( d1=8, d2=18, h=4.4, center = true);
            }
        }
    }
module stone30(){
    b=m*.85; // +.24;
    color("lightblue") {
        intersection(){
            intersection(){
                difference(){
                    union(){
                        cylinder ( d=16, h=3.4, center = true);
                        translate ( [ 0, 0, 0-.9] ){
                            cylinder(d=16, h=6, center = true);
                            translate ( [ 8/2, 5/2, 0] ) cube     ( [8, 5, 6], center = true);
                            translate ( [-8/2,-5/2, 0] ) cube     ( [8, 5, 6], center = true);
                            }
                        translate ( [ 0, 0, .75] ){
                            cylinder(d=8, h=4.6, center = true);
                            translate ( [ 4/2, 4/2, 0] ) cube     ( [4, 4, 4.4], center = true);
                            translate ( [-4/2,-4/2, 0] ) cube     ( [4, 4, 4.4], center = true);
                            }
                        }
                    }
                translate ( [ 0, 0, 0] ) cube     ( [16, 8-eps, 6], center = true);
                }
            translate ( [ 0, 0, -.25] )  cylinder ( d1=13, d2=22, h=6.25, center = true);
            }
        }
    }

