// HexaGon
// Gravi Trax  
// Build Element V4
// NIS


// aussenform

/* [HexaGon blue] */

// HexaGon high
hex_h  = 10; // [5:1.0:170]

// HexaGon Radius Bottom
hex_r1 = 26; // [20:1.0:40]
// print 53.5 - other 52 schmaeler gemacht

// HexaGon Radius Top
hex_r2 = 26; // [20:1.0:40]
// ----------------------------------------------

/* [Snap (yellow)] */

// Snap Top high (clip)
snap_cut = 3;  // [1:0.5:5]

// Snap Bottom high (hole) depth
snap_h = 4;  // [2:1.0:6]

// Snap Top radius (outside)
hex_in = 33.9; // [32:0.1:36]

// Snap Border thickness (yellow)
hex_cut_rand = 7;  // [5:0.5:10] 
// hoeher = breiter
// breite snapper

// Snap Bottom Hole (inside)
hex_cut = 34.9;  // [33:0.1:37]
// hoeher = mehr platz

// ######################################################################

/* [Hidden] */

hex_in_h  = snap_cut + hex_h;
hex_in_r1= hex_in/2; // kleiner, schnapp bereich
hex_in_r2= hex_in/2;

// loch cutt
hex_cut_r1= (hex_cut)/2; // main snap 34, unten
hex_cut_r2= (hex_cut-hex_cut_rand)/2;
hex_cut_h  = snap_h + hex_h;


module hexagon_go()
{
    difference()
    {
        union() 
        {
            color("blue") cylinder(hex_h,r1=hex_r1,r2=hex_r2,center=false, $fn=6);
            color("yellow") cylinder(hex_in_h,r1=hex_in_r1,r2=hex_in_r2,center=false, $fn=6);
        }
        
        cylinder(h=snap_h,r1=hex_cut_r1,r2=hex_cut_r1,center=false, $fn=6);        
        translate([0,0,snap_h]) 
            cylinder(h=hex_h-snap_h+snap_cut,r1=hex_cut_r1,r2=hex_cut_r2,center=false, $fn=6);      
      
        for (run =[1:6]) {
            rotate([0,0,run*60]) translate([0,-1.5,hex_h]) 
            cube([100,3,10], center=false);
        } 
    }
}


// hexagon();
hexagon_go();
