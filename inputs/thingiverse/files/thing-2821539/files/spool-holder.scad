// Copyright (c) 2018 Adrian Weiler
// This file is licensed Creative Commons Attribution-NonCommercial-ShareAlike 4.0.
// https://creativecommons.org/licenses/by-nc-sa/4.0/

// You can get this file from http://www.thingiverse.com/thing:2821539

// Credits:
// This is a rework of the Parametric universal spool holder by rowokii
// (https://www.thingiverse.com/thing:767317)
//
// Changes made:
// - used generator expression for creating material saving cutout,
//   This allows to use a different number of cutout. Looks good with 5 cutouts.
// - added a tiny cylinder as support for easier printing of the hole of the bearing.
//   This support can (and should) be broken away after printing.
// - increased default diameter of bearing (+0.6mm) and rod (+0.3mm) for easier fit.


// bearing dimensions
bearing_d = 22.6;
bearing_h = 7;

// max and min size of the spool holder diameter
max_d = 70;
min_d = 25;

// height of the holder
cone_h = 30;

// rod diameter
rod_d = 8.4;

// number of cutouts (original is 4, works for values up tp 6)
n_cutouts = 5;

// circle control
$fa = 1;
$fs = 1;


difference(){
// cone
	cylinder(d1=max_d, d2=min_d, h=cone_h);

// cutout for the bearing
	cylinder(d=bearing_d, h=bearing_h);
	
// the center rod 
	cylinder(d=rod_d, h=cone_h);
	
// material saving cutouts
    for (a=[0:360/n_cutouts:359])
        rotate([0,0,a]) translate([max_d/1.9,0,-0.01]) cylinder(d=max_d/2, h=cone_h);
}

// printing helper
if (bearing_d > rod_d + 5)
difference() {
    union() {
        cylinder(d=rod_d+.8,h=bearing_h-0.2);
            for (a=[0:360/8:359])
                rotate([0,0,a]) translate([rod_d/2,0,bearing_h-0.2]) cube([0.4,0.4,0.2]);
    }
	cylinder(d=rod_d, h=bearing_h);
}
