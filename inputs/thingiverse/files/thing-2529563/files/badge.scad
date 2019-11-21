/* ------------------------------
--------- badge scuola ----------
-------------------------------*/

//base
base_larghezza = 40;
base_lunghezza = 150;
base_altezza = 4;

//edge smooth
edge = 3;

//
riga1 = "LEONARDO";
riga2 = "PETRILLO";
profondita = 3;
dimensione = 13;

//hole
hole_la = 8;
hole_lu = 20;
hole_y = 10;
hole_x1 = base_larghezza/2 - hole_lu/2 ;
hole_x2 = base_larghezza/2 + hole_lu/2 ;
hole_r = hole_la/2;

$fn = 100;

/* ----------------------------
------------ BUILD ------------
-----------------------------*/

difference() {
//base
cube([base_larghezza, base_lunghezza, base_altezza]);

// edge
    difference() {
    cube([edge*2, edge*2, base_altezza*2], center = true);
    translate([edge, edge, 0])
    cylinder(base_altezza*2, edge, edge, true); }

    translate ([base_larghezza, 0, 0])
    rotate ([0,0,90])
    difference() {
    cube([edge*2, edge*2, base_altezza*2], center = true);
    translate([edge, edge, 0])
    cylinder(base_altezza*2, edge, edge, true); }

    translate ([0, base_lunghezza, 0])
    rotate ([0,0,270])
    difference() {
    cube([edge*2, edge*2, base_altezza*2], center = true);
    translate([edge, edge, 0])
    cylinder(base_altezza*2, edge, edge, true); }
    
    translate ([base_larghezza, base_lunghezza, 0])
    rotate ([0,0,180])
    difference() {
    cube([edge*2, edge*2, base_altezza*2], center = true);
    translate([edge, edge, 0])
    cylinder(base_altezza*2, edge, edge, true); }
    
// hole
    translate([hole_x1, hole_y, 0])
    cylinder(base_altezza, hole_r, hole_r);
    
    translate([hole_x2, hole_y, 0])
    cylinder(base_altezza, hole_r, hole_r);
    
    translate([base_larghezza/2-hole_lu/2, hole_y-hole_r, 0])
    cube([hole_lu, hole_r*2, base_altezza]);

// text
    translate([base_larghezza/2, hole_y*2, base_altezza-profondita])
    rotate ([0, 0, 90])
    linear_extrude(10) 
    text(riga1, dimensione);

    translate([base_larghezza/2+dimensione+1, hole_y*2, base_altezza-profondita])
    rotate ([0, 0, 90])
    linear_extrude(10) 
    text(riga2, dimensione);
}


/*
difference() {
    // esterno
    cylinder(h = base_altezza, d1 = base_larghezza, d2 = base_larghezza + apertura, center = true);

    // interno
    translate([0,0,rialzo])
    cylinder(h = top_altezza, d1 = top_larghezza, d2 = top_larghezza + apertura, center = true);
}
*/