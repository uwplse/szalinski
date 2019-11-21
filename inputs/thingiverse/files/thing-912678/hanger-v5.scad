
/*
 * Customizable Closet Clothes Linking Bracket v5
 * 
 *
 * Works well when printed in Nylon 618 (or similar) for tensile
 * strength.
 *
 * Author: Jordan Husney <jordan.husney@gmail.com>
 * License: https://creativecommons.org/licenses/by-sa/4.0/
 *
 */
 
/* [Global] */

/* [Rod Hanger] */
// Rod Hanger Inner Diameter
rod_id = 1.5;                       // [0.25:0.125:2]
// Rod Hanger Thickness
rod_thick = 0.25;                   // [0.125:0.125:1]
// Rod Sleeve Length
rod_sleeve = 1.5;                   // [0.25:0.25:4]

/* [Shelf Hanger] */

// Shelf Hanger Inner Diameter
shelf_id = 1;                       // [0.25:0.125:2]
// Shelf Hanger Thickness
shelf_thick = 0.25;                 // [0.125:0.125:1]
// Shelf Sleeve Length
shelf_sleeve = 0.5;                 // [0.25:0.25:4]

/* [Stem Assembly] */

// Stem Cable Diameter
cable_diameter = 0.125;             // [0.0625:0.0625:0.5]
// Stem Length
stem_length = 2.75;                 // [0.5:0.25:12]
// Stem Interface Length
interface_length = 0.5;             // [0.25:0.25:2]

/* [Hidden] */

IN=25.4;

ROD_ID=rod_id*IN;
ROD_OD=ROD_ID+rod_thick*IN;
ROD_H=rod_sleeve*IN;

HANGER_ID=shelf_id*IN;
HANGER_OD=HANGER_ID+shelf_thick*IN;
HANGER_H=shelf_sleeve*IN;

STEM_L=stem_length*IN;
STEM_CABLE_D=cable_diameter*IN;
STEM_INTERFACE_L=interface_length*IN;
STEM_CABLE_L=STEM_L-2*STEM_INTERFACE_L;

WEIGHT_REDUCTION=0;

STEM_CABLE_XLATIONS = [
 		[ -1, 0, 0],
 		[ 0, 0, 0 ],
 		[ 1, 0, 0 ],
 		[ 0, -1, 0 ],
 		[ 0, 1, 0 ]
];

module stem_interface() {
    translate([0, -STEM_INTERFACE_L/8, 0])
    rotate([90, 0, 0])
    hull() {
        for (i = [0:1:4]) {
          // TODO: something isn't quite right here:
          translate(STEM_CABLE_D*STEM_CABLE_XLATIONS[i])
          cylinder(r=STEM_CABLE_D/2, h=STEM_INTERFACE_L/4, $fn=60, center=true);
        }
    }
}

union() {
    translate([0, STEM_INTERFACE_L, 0])
    union() {
        translate([0, STEM_CABLE_L, 0])
        union() {
            translate([0, HANGER_OD/2+STEM_INTERFACE_L-(HANGER_OD-HANGER_ID)/2, 0])
            difference()
            {
                cylinder(r=HANGER_OD/2, h=HANGER_H, center=true, $fn=60);
                
                scale([1, 1, 1.1])
                cylinder(r=HANGER_ID/2, h=HANGER_H, center=true, $fn=60);
                
                if (WEIGHT_REDUCTION) {          
                    rotate([0, 0, 60])
                    translate([0, -HANGER_OD/2, 0])
                    rotate([90, 0, 0])
                    cylinder(r=HANGER_H/3, h=HANGER_OD, center=true, $fn=60);
                    
                    rotate([0, 0, -60])
                    translate([0, -HANGER_OD/2, 0])
                    rotate([90, 0, 0])
                    cylinder(r=HANGER_H/3, h=HANGER_OD, center=true, $fn=60);
                }
            }

            translate([0, STEM_INTERFACE_L, 0])
            rotate([0, 0, 180])
            hull() {
                translate([0, STEM_INTERFACE_L, 0])
                stem_interface();

                translate([0, STEM_INTERFACE_L/4, 0])
                resize([sqrt(pow(HANGER_OD,2) - pow(HANGER_ID, 2)), STEM_INTERFACE_L/4, HANGER_H])
                stem_interface();
            }
        }

        translate([0, STEM_CABLE_L/2, 0])
        rotate([90,0,0])
        for (i = [0:1:4]) {
          translate(STEM_CABLE_D*STEM_CABLE_XLATIONS[i])
          cylinder(r=STEM_CABLE_D/2, h=STEM_CABLE_L, $fn=60, center=true);
        }
    }

    hull() {
        translate([0, STEM_INTERFACE_L, 0])
        stem_interface();

        translate([0, STEM_INTERFACE_L/4, 0])
        resize([sqrt(pow(ROD_OD,2) - pow(ROD_ID, 2)), STEM_INTERFACE_L/4, ROD_H])
        stem_interface();
    }

    translate([0, ROD_OD/-2+(ROD_OD-ROD_ID)/2, 0])
    difference()
    {
        cylinder(r=ROD_OD/2, h=ROD_H, center=true, $fn=60);
        
        scale([1, 1, 1.1])
        cylinder(r=ROD_ID/2, h=ROD_H, center=true, $fn=60);
        
        if (WEIGHT_REDUCTION) {
            rotate([0, 0, 120])
            translate([0, -ROD_OD/2, 0])
            rotate([90, 0, 0])
            cylinder(r=ROD_H/8, h=ROD_OD, center=true, $fn=60);
            
            rotate([0, 0, -120])
            translate([0, -ROD_OD/2, 0])
            rotate([90, 0, 0])
            cylinder(r=ROD_H/8, h=ROD_OD, center=true, $fn=60); 
        }
    }
}

