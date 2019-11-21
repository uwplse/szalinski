//Customizable_holder.scad v0.5
//by Benjamen Johnson

// GNU General Public License, version 2
// http://www.gnu.org/licenses/gpl-2.0.html


//default values

// Diameter of the holder in mm
d_sphere=27;

// Diameter of the cylinder cut out in mm 
d_hole=9;

// Height of the hole above the base in mm
h_hole=5; 

// Diameter of the magnet in mm
d_magnet=14;

// Height of the magnet in mm
h_magnet=4;

difference() {
    // create the body
    sphere(d_sphere/2, center=true);
    
    // delete one hemisphere
    translate([0,0,-d_sphere/2])cube(d_sphere,d_sphere,d_sphere/2,center=true);
    
    // remove the cutout
    translate([0,d_sphere/2,d_hole/2+h_hole]) rotate([90,0,0]) cylinder(h=d_sphere,r=d_hole/2);
    
    // make recess for magnet
    cylinder(h=h_magnet, r=d_magnet/2);
    }