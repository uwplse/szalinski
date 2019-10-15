// 3.5 inch Drive to 5.25 inch Front Bay Bracket Adapter 
// Part 2: front bezel

sf=0.006;                  // shrinkage factor (ABS shrinks approximatly 0.5%-0.7% when it cools) 
tb=5;                      //thickness of the bezel
h3=26.1*(1+sf);                 //hight of 3.5" hole (25.4-26.1)
w3=102.3*(1+sf);              //width of 3.5" hole (101.6-102.3)
hb5=42.3*(1+sf);             //hight of bezel
wb5=148*(1+sf);              //width of bezel
f=30;                     // $fn=
wt=1.75;               // wall thickness


 difference() {
        union() {
            // bezel plate:
            translate([0,0,tb/2]) cube([hb5,wb5,tb], center=true);
        }
            // bezel hole:
            translate([0,0,tb/2]) cube([h3,w3,tb+2], center=true);
            // remove inside part of bezel:
            translate([0,0,tb/2+wt]) cube([hb5-2*wt,wb5-2*wt,tb], center=true);
    }
    
    // inner surround:
difference() {
             // add inner surround:
             translate([0,0,tb/2]) cube([h3+2*wt,w3+2*wt,tb], center=true);
             // remove bezel hole:
            translate([0,0,tb/2]) cube([h3,w3,tb+2], center=true);
    }
    
             // pins:
            translate([13.765,62,7.5])  cylinder(15,4,4, center=true, $fn=f);
            translate([13.765,-62,7.5])  cylinder(15,4,4, center=true, $fn=f);
            translate([-13.765,62,7.5])  cylinder(15,4,4, center=true, $fn=f);
            translate([-13.765,-62,7.5])  cylinder(15,4,4, center=true, $fn=f);
            // pin base:
            translate([13.765,62,2.5])  cylinder(5,7,7, center=true, $fn=f);
            translate([13.765,-62,2.5])  cylinder(5,7,7, center=true, $fn=f);
            translate([-13.765,62,2.5])  cylinder(5,7,7, center=true, $fn=f);
            translate([-13.765,-62,2.5])  cylinder(5,7,7, center=true, $fn=f);
    
