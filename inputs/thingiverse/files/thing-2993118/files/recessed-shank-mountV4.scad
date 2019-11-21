// spacer and seal for beer faucet shanks in coolers.
// my cooler inside ~335mm, outside ~390mm
// cut depth (thickness) 29mm
// optional captive nut
// install with epoxy plastic weld glue to seal it up
// Jim Dodgen April 2018

thickness=29;  // thickness of inner wall to outerwall

shank_hole=23.8; // diameter of shank hole 7/8

hole_size=44.5;  // 1 3/4 inch hole saw -- size of hole cut from inside cooler
  
mount_thickness=28; // where the shank nut sits
flange_thickness=4; // flange on inside
flange_brim_size=8;
bevel_offset=15;
// hidden
$fs=0.1; // def 1, 0.2 is high res (fragment)
$fa=1;//def 12, 3 is very nice (angle)

inside_curve_radius = 335/2;
outside_curve_radius = 390/2;

offset=thickness;
// code

overall_height=flange_thickness+thickness;

difference() {
union()
{     
    cylinder(h=overall_height-flange_thickness, r=hole_size/2, center=false); // in hole insert part     
    translate([0,0,overall_height-flange_thickness]) {    // move to top    
        curved_flange(curve_radius=outside_curve_radius,diameter=hole_size, thickness=flange_thickness); // top curve
        
    }
    
    difference() {    
            curved_flange(curve_radius=inside_curve_radius, diameter=hole_size+(flange_brim_size*2),thickness=flange_thickness); // bottome curve with flange
            on_deck=(hole_size+(flange_brim_size*2)+(flange_thickness*2)/2)-flange_thickness-8;
            translate([0,0,on_deck-bevel_offset]) {
                difference() {
                    sphere(r=100, hole_size+(flange_brim_size*2)+flange_thickness-8);
                    sphere(r=100, hole_size+(flange_brim_size*2)-flange_thickness-9);
                }
            }  
    }
}
cylinder(h=overall_height+10, r=shank_hole/2,center=false); // drill hole
}

module curved_flange(curve_radius, diameter, thickness)
{
height=curve_radius;    
difference(){
translate([0,-(200/2),-curve_radius + thickness],center = false) 
    {
    rotate([90,0,180]) {    
       difference() {
           cylinder(r=curve_radius, h=height); 
            cylinder(r=curve_radius-thickness, h=height,center = false);
        translate([-curve_radius,-curve_radius-30,0]) cube([curve_radius*2,curve_radius*2-20,curve_radius*2+10],center = false);
            translate([0,100,100]) {
                rotate ([270,0,0]) 
                { 
                    difference(){ // cut out a disk
                       cylinder (h = curve_radius, r=curve_radius,center = true);
                       cylinder (h = curve_radius, r=(diameter/2),center = true);
                   }
                }
            }
        }
    }
}
translate([100,-100,0])  rotate([0,180,0]) cube (200, 200,0);
}
}
