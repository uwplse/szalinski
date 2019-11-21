include <polyround.scad>;

cuff_and_mount_overlap = 3;

arm_width = (106+75)/2; // in mm
arm_height = 65;// in mm
arm_length = 80; // in mm

print_width = 5;

rounding_radius = 1.75;

mount_total_width = 50.853;
mount_total_height = 14.07 ;


// How long the part that attaches to the detector is
mount_length = 125;


// the lil insert that goes down into the arm
mount_insert_width = 9.8;
mount_insert_length = 13;
mount_insert_height = 3;


screw_cutout_offset_v = mount_length/2;
screw_head_cutout_d = 13.25;
screw_head_cutout_h = 3.83+.4; // .4 is to account for the curve
screw_cutout_d = 5;


// Strap
strap_width = 55;
strap_height = 4;


eps = 0.01;
eps2 = eps*2;

$fn = $preview ? 64 : 128;

echo(sqrt(4.86*4.86+11.38*11.38));


main();
module main() {
    
    difference() {
        union() {
            cuff();
                
            translate([-mount_total_width/2,-mount_total_height-arm_width/2-print_width+cuff_and_mount_overlap,0])
                mount();
            
            translate([-mount_insert_width/2,-mount_insert_height-arm_width/2-print_width+cuff_and_mount_overlap-5.0699,screw_cutout_offset_v-mount_insert_length/2])
                mount_insert();
        }  /// End Union
        
        
        /**
         *   All the stuff cutout from the whole thing
         */
        translate([0,0,screw_cutout_offset_v])
            rotate([90,0,0])
               cylinder(d=screw_cutout_d,h=100);
        
        // The screw head cutout, the 1.8 is to account for the curve
        translate([0,-arm_width/2+0.6,screw_cutout_offset_v])
            rotate([90,0,0])
               cylinder(d=screw_head_cutout_d,h=screw_head_cutout_h);
        
        /**
         *      Strap Cutout
         */
        translate([-(arm_width+30)/2,arm_height-arm_width/2-strap_height-print_width-1,(arm_length-strap_width)/2])
            strap_cutout();
    }
}


module mount_insert() {
    union() {
        cube([mount_insert_width, mount_insert_height, mount_insert_length]);
 
        translate([0,5.495,-mount_insert_length+1.22])
         rotate([25,0,0])
        cube([mount_insert_width, mount_insert_height, mount_insert_length]);
    }
}


module strap_cutout() {

    // top rounding off
    translate([0,strap_height/2,strap_width-strap_height])
        rotate([0,90,0])
            cylinder(d=strap_height, h=arm_width+30);
    
    // bottom rounding off
    translate([0,strap_height/2,0])
        rotate([0,90,0])
            cylinder(d=strap_height, h=arm_width+30);
    
    cube([arm_width+30, strap_height, strap_width-strap_height]);

}

module cuff() {

    union() {

        /**
         *   The straight part above the cuff if it's too short
         */
        difference() {
            // the cube
            translate([-(arm_width+2*print_width)/2,0,0])
               cube([arm_width+2*print_width, arm_height-arm_width/2,arm_length]);

            // the cutout
             translate([-(arm_width)/2,-eps,-eps])
               cube([arm_width, arm_height-arm_width/2+eps2,arm_length+eps2]);
            
            
            /**
             *  Cuff Rounding
             */
            translate([arm_width/2+print_width-rounding_radius,arm_height-arm_width/2-rounding_radius,arm_length/2])
                roundcorner(arm_length,rounding_radius);
            
            translate([arm_width/2+rounding_radius,arm_height-arm_width/2-rounding_radius,arm_length/2])
                rotate([0,0,90])
                    roundcorner(arm_length,rounding_radius);
            
             translate([-arm_width/2-rounding_radius,arm_height-arm_width/2-rounding_radius,arm_length/2])
                roundcorner(arm_length,rounding_radius);
            
            translate([-arm_width/2-print_width+rounding_radius,arm_height-arm_width/2-rounding_radius,arm_length/2])
                rotate([0,0,90])
                    roundcorner(arm_length,rounding_radius);
            
            
        
        }
        
        
        difference() {
            // main tube for the cuff
            cylinder(d=arm_width+2*print_width, h=arm_length);
            translate([0,0,-2.5])
                cylinder(d=arm_width, h=arm_length+5);
            
            
            // cube to cut out the top of the tube
            translate([0,arm_width/2,(arm_length+2.5)/2])
                cube([arm_width+2*print_width,arm_width,arm_length+5], center=true);
            
        }
    }
}


module mount() {
    linear_extrude(mount_length)
    round2d(2,4,$fn=32)
    polygon([[0,0],[4.513,-2.13],[9.754,9.087],[41.138,9.087],[46.321,-2.13],[mount_total_width,0],[44.323,14.087],[6.569,14.087]]);
}







/**
 * Extra Modules
 */

// This module creates the shape that needs to be substracted from a cube to make its corners rounded.
module roundcorner(h,radius) {
    $fn = 64;
//This shape is basicly the difference between a quarter of cylinder and a cube
    difference() {        
       translate([radius/2+0.1,radius/2+0.1,0]){
          cube([radius+0.202,radius+0.1,h+0.2],center=true); // All that 0.x numbers are to avoid "ghost boundaries" when substracting
       }

       cylinder(h=h+0.3,r=radius,center=true);
    }
}



module roundcornerinside(h,radius) {
    $fn = 64;
//This shape is basicly the difference between a quarter of cylinder and a cube
    difference() {        
       translate([radius/2+0.01,radius/2+0.01,0]){
          cube([radius+0.01,radius+0.01,h],center=true);         // All that 0.x numbers are to avoid "ghost boundaries" when substracting
       }

       cylinder(h=h+0.02,r=radius,center=true);
    }
}