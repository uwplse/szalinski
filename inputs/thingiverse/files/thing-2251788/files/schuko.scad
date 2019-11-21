/*
 Parametric Schuko CEE 7/3 socket
 
 Copyright 2017 Anders Hammarquist <iko@iko.pp.se>
 Licensed under Creative Commons - Attribution - Share Alike
 
 Made using a negative "profile punch" that can be extracted
 and used to "punch" a schuko socket into any sufficiently large solid.
*/

// Diameter of cover
coverdiameter = 50; // [50:100]

// Thickness of cover
coverthickness = 4.8; // [2:0.2:15]

// Center screw offset (extreme values disables screw hole)
screwoffset = 0; // [-11:0.5:11]

// This is the socket punch. Includes cut-out for
// earthing contacts and holes for pins and center screw.
// Maximum screw offset from center is 10mm (use a larger
// value to remove the hole for the screw).
module schuko(screwoffset=0, screwdia=3.5, screwhead=6.5, screwsink=3)
{
    module earthing()
    {
        intersection() {
            union() {
                translate([-22,-2,3])
                    cube([6,4,20]);
                translate([-19,-2,17.5])
                    rotate([0,-30,0])
                        cube([15, 4, 4]);    
            }
            translate([-22,-3,3])
                cube([22,6,20]);
        }
    }
    
    difference() {
        union() {
            translate([0,0,-1])
                cylinder(r=39/2, $fn=80, h=18.5);
	                
            // Earthing cutouts
            color([1,1,1]) {
                earthing();
                
                rotate([0,0,180]) 
                    earthing();
                
            }             
            
            // Power pins
            translate([0,10,0])
                cylinder(r=7/2, $fn=15, h=30);
            translate([0,-10,0])
                cylinder(r=7/2, $fn=15, h=30);
            
            if (abs(screwoffset) <= 10) {
                // Center screw
                translate([screwoffset,0,0])
                    cylinder(r=screwdia/2, $fn=15, h=30);
                translate([screwoffset,0,0])
                    cylinder(r=screwhead/2, $fn=15, h=17.5+screwsink);
            }
        }
        
        // Side key profile
        translate([5.4/2,16.9,3]) 
            cube([7,3,20]);
        translate([-5.4/2-7,16.9,3])
            cube([7,3,20]);
        translate([5.4/2,-20.4,3])
            cube([7,3.5,20]);
        translate([-5.4/2-7,-20.4,3])
            cube([7,3.5,20]);
    }
}


rotate([0,0,0]){
    difference(){
        union() {
            translate([0,0,0])
                cylinder(r=44/2, $fn=16, h=21.5);
            // Lip
            rotate_extrude($fn=80) {
                polygon(points=[[0,0], [coverdiameter/2,0], 
                [coverdiameter/2+0.2*coverthickness,coverthickness],
                [0,coverthickness]]);
            }
            
            // Pin guard: 9.5 x 28.5 x 3mm (rounded ends)
            translate([-4.75,-14.25,21.5])
                cube([9.5, 28.5, 3]);

            // center screw standoff: 6 x 2.5 (above pin guard) x 2 - 3 
            // ( 8mm inside, 14 - 12.2 mm outside)    
            translate([-7.25, -3, 21.5])
                cube([2.5, 6, 5.5]);
            translate([4.75, -3, 21.5])
                cube([2.5, 6, 5.5]);

        }
        schuko(screwoffset=screwoffset);
    }
}
