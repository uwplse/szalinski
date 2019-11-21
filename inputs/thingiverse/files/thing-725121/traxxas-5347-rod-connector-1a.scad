//-- Parametric Traxxas 5347 carbon fiber rod connector
//-- Parametric: rod diameter can be adjusted as well as length and tolerance
//-- Assembly requires epoxy glue.
//-- AndrewBCN - Barcelona - March 2015
//-- GPLV3
//-- Please read the terms of the GPLV3 and please comply with it
//-- if remixing this part. Thank you.


// Parameters

// Rod diameter
Rod_diam=8; // [6:8]

// Part additional length
add_len=30; // [30:40]

// Print tolerance
tolerance=0.4; // [0.0,0.1,0.2,0.3,0.4]

/* [Hidden] */
$fn=32;

diam1=Rod_diam+tolerance;
diam2=diam1+4; // 2mm walls
diam3=7.2+tolerance; // Traxxas diameter
diam4=diam3+1;

// really simple code

// bottom
difference() {
  cylinder(r=diam2/2, h=add_len-14);
  translate([0,0,-0.1]) cylinder(r=diam1/2, h=9.1);
}
// top
difference() {
  translate([0,0,add_len-14]) cylinder(r1=diam2/2, r2=diam4/2, h=16);
  translate([0,0,add_len-4]) cylinder(r=diam3/2, h=8);
}