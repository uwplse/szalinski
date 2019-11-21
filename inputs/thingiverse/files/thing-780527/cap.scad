// krytka na kameru notebooku
// by geniv

/* [Global] */

// inner width
vnitrniSirka=12; // [5:40]

// wall thickness
sirkaSteny=4; // [2:8]

// height
vyska=25; // [10:30]

// width
sirka=24; // [10:30]

/* [Hidden] */
$fn=40;

/* [Hidden] */
minkowskiSirka=2;

module main() {
  vnitrniSirka=vnitrniSirka+minkowskiSirka;  // fix minkowski
  minkowski() {
    difference() {
        union() {
            translate([0,vnitrniSirka/2,vyska])
            rotate([0,90,0])
            cylinder(r=(vnitrniSirka+sirkaSteny+sirkaSteny)/2,h=sirka); 
            
            translate([0,-sirkaSteny,0])
            cube([sirka,vnitrniSirka+2*sirkaSteny,vyska]);
        }
        translate([-1,vnitrniSirka/2,vyska])
        rotate([0,90,0])
        cylinder(r=vnitrniSirka/2,h=sirka+2);
        
        color("blue") 
        translate([-1,0,-1])
        cube([sirka+2,vnitrniSirka,vyska+1]);
    }
    cylinder(r=minkowskiSirka/2);
  }
}

main();
//color("red") translate([0,1,-1]) cube(11);