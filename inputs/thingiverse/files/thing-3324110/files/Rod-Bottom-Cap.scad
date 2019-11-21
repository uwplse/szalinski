// Rod_Bottom_Cap
//
// This is part of my project to set up a 5 gallon bucket to store all of my 3d printer filament.
// The plan is to stack the filament along a 1" wooden dowel
// A cap on the bottom will hold the filament so you can pick it all up at once and it will keep the dowel vertical when empty.
// Probably will want a handle on the top for ergonomics when lifting the filament out
// May need some features for holding dessicant.
    // Bulk or packets?
//
// Made by Adam Britt
//
// Revision 0   12/30/2018
    // Original
//
///////////////////////////////////////////////////////////////
//
// Global resolution
$fs = 0.010;    // Don't generate smaller facets than 0.010 in, which is the lower bound that SCAD will accept
$fa = 5;        // Don't generate larger angles than 5 degrees
//
// Material Property Declarations
PLA_CTE = 0.000085 * 5/9; // Coefficient of thermal expansion converted from 1/Celsius to 1/Fahrenheit
    // 7.4x10^-4 C^-1 https://www.researchgate.net/post/What_is_the_coefficient_of_the_linear_thermal_expansion_of_PLA_polylactic_acid_polymer
    // 8.5x10^-5 C^-1 https://omnexus.specialchem.com/polymer-properties/properties/coefficient-of-linear-thermal-expansion
//
// Geometry Declarations
bf_d = 4.000;   // Bottom Flange Diameter [inches]
bf_t = 0.250;   // Bottom Flange Thickness [inches]
f_r = 0.250;    // Fillet Radius [inches]
h_d = 0.185;    // Screw Hole Diameter [inches]
cs_d = 0.350;   // Countersink diameter [inches]
cs_a = 82;      // Coutersink angle [degrees]
c_id = (0.985+1.030)/2;     // Collar Inner Diameter [inches]
                                // Measured at 0.985-1.030"
c_wt = 0.125;               // Collar Wall Thickness [inches]
c_od = c_id+c_wt*2;         // Collar Outer Diameter [inches]
                                // Spool IDs measured at 
                                // 2.035" (Filament Outlet)
                                // 2.084" (Silhouette)
c_h = 2.000;                // Collar Height [inches]
//
// Calculate anti-shrinkage correction for scaling
    // Collar ID is selected for driving dimension for correction factor as it it the most important fit
CTE_DIM = c_id;
K_CTE = (c_id + (c_id * PLA_CTE * (392-69))) / c_id;
//
// Call main module and build it all, scaled from in to mm, and scale up to account for thermal shrinkage.
scale([K_CTE,K_CTE,K_CTE]) scale(v=[25.4,25.4,25.4]) main();
//
// Module Definitions
//
// Main module to combine other modules
    // Add the flange, collar, and the fillet
    // Subtract the countersink and the screw hole
module main(){
    difference(){
        union(){
            // additive modules
            flange();
            collar();
            fillet();
        }
        union(){
            // subtractive modules
            hole();
            countersink();
        }
    }
}
// Bottom Flange
    // Just make a cylinder
module flange(){
    cylinder(h=bf_t, r=bf_d/2, center=false);
}
// Collar
    // Create a cylinder for OD
    // Create a cylinder for ID
    // Subtract the ID from the OD
module collar(){
    difference(){
        cylinder(h=c_h, r=c_od/2, center=false);
        translate([0,0,-0.1*c_h]) cylinder(h=c_h*1.2, r=c_id/2, center=false);
    }
}
//Fillet
    // Create a square, revolve it
    // Create a circle, revolve it
    // Subtract the circular revolution from the square revolution
module fillet(){
    difference(){
        rotate_extrude(){
            translate([c_od/2,bf_t,0]){
                square(size = f_r, center = false);
            }
        }
        rotate_extrude(){
            translate([c_od/2+f_r,bf_t+f_r,0]){
                circle(r=f_r);
            }
        }
    }
}
// Screw Hole
    // Just a cylinder of sufficient size to pass the screw
module hole(){
    translate([0,0,-0.1*bf_t]) cylinder( h = bf_t*1.2, r = h_d/2, center = false);
}
// Countersink in Bottom Flange for Screw Head
module countersink(){
    cs_h = (cs_d/2)/(tan(cs_a/2));  // Calculate actual countersink height
    // Create cs_h2 and cs_d2 that add some stock to the cutting tool to avoid preview/manifold issues
    cs_h2 = cs_h * 1.1;
    cs_d2 = 2*cs_h2*tan(cs_a/2);
    // base = opposite
    // height = adjacent
    // tan(cs_a/2) = base/height
    // height = base/tan(cs_a/2)
        // base = radius = cs_d/2
    // height = (cs_d/2)/(tan(cs_a/2))
    //union(){
        translate([0,0,-0.1*cs_h])cone(cs_h2,cs_d2/2);
        //translate([0,0,-0.2*bf_t]) cylinder(h=bf_t*0.2, r=cs_d/2, center=false);
    //}
}
module cone(height, radius, center = false) {
    cylinder(height, radius, 0, center);
}
// Report key parameters
echo("The collar ID is c_id = ", c_id, " inches.");
echo("CTE correction factor is K_CTE = ",K_CTE, ".");
echo("CTE correction factor as measured is ", 1.0075/0.992, ".");