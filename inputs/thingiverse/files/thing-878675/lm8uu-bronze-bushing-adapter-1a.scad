//-- Customizable LM8UU graphite impregnated bronze bushing adapter
//-- for use in 3D printers
//-- by AndrewBCN - Barcelona, Spain - June 2015
//-- GPLV3

//-- Based on http://www.thingiverse.com/thing:849572 by Ruff
//-- Also based on http://www.thingiverse.com/thing:166794 by Misan

//-- Bushings must be press-fit in adapter; I recommend cooling down
//-- the bushings by storing them in the fridge for an hour or so

//-- These bushings have slightly more friction than linear bearings,
//-- but they also make a lot less noise.

// The default tolerances below work well for me with these adapters
// printed in PLA on my P3Steel, after slicing with Cura.
// outer diameter adapter bushing tolerance, must be determined empirically (by trial-and-error)
// printed adapter bushing tolerance, must be determined empirically (by trial-and-error)
// YMMV

// Parameters

// Outer diameter tolerance
od_adap_tol=-0.1;  // [-0.3,-0.2,-0.1,0.0]

// Inner diameter tolerance
id_b_tol=0.34; // [0.00:0.60]

/* [Hidden] */
$fn=50;

// Modules

// LM8UU dimensions in mm are od=15 id=8 len=24

// graphite impregnated bronze bushings from AliExpress
// have dimensions in mm od=10 id=8 len=11.7
// Two bushings and this printed adapter are needed to replace each LM8UU

difference() {
cylinder(h=24,r=(15+od_adap_tol)/2);
translate([0,0,-0.1]) cylinder(h=24.2,r=5+id_b_tol/2);
}