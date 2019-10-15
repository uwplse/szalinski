

// Generate just a narrow test profile to ensure it fits your monitor
test_profile = 0; // [0: Full width, 1: Test profile]

hook_height=170;  //Height of the hook - dropping it 40 mm below top 
thickness = 3.0;  // thickness
shelf_width = 10; // Width of the perch shelf (mm).
extra_hanger_perch = 1; // [0: No extra perches, 1: Add extra hanger perches for stability]
extra_perch_length = 12; //if adding extra perches, this is how large they will be in mm

module Rod() //rod module
{
    
    union() {
        if(extra_hanger_perch) {
        translate([thickness*2+extra_perch_length-0.1,0,hook_height/3-10])rotate([0,0,90]) union() {
          //cube([thickness*2, thickness*2, hook_height/2]);
          translate([0,0,0]) rotate([0,90,00]) cube([thickness*2, extra_perch_length, shelf_width ]);
          translate([0,0,hook_height/4]) rotate([0,90,00]) cube([thickness*2, extra_perch_length, shelf_width]);
          translate([0,0,hook_height/2]) rotate([0,90,00]) cube([thickness*2, extra_perch_length, shelf_width]);
            cube([shelf_width, thickness*2, hook_height/2]);
              }
          }
        difference() {
                    cube([thickness*2, shelf_width, hook_height]);
            //add back support rods - 12mm
      
                    femaleConnector();
                }
                 translate([0,0,hook_height]) {
                     maleConnector();
                 }
            }
}


module Perch() // Top level module
{
    rotate([90,0,0]) union() {
        translate([0,0,0]) {
            Rod();
        }
        translate([30,0,0]) {
            Rod(); 
        }
    }
}
module maleConnector() 
{
    translate([2.2,0,0]) cube([thickness*2-4.4, shelf_width-2, 6.2]); //-male rod
    translate([0,0,6.2]) cube([thickness*2, shelf_width-2, 2]); //-male - cross piece
}

module femaleConnector() 
{ //be sure to take this as the difference
    translate([1.5,0,0]) cube([thickness*2-3, shelf_width-2, 7.2]); //-female rod
    translate([0,0,4.4]) cube([thickness*2+2, shelf_width-1.7, 3.6]); //-female - cross piece
}

module Profile()
{
    intersection() {
        Perch();
        cube([1000,1000,2],center=true);
    }
}



if (test_profile == 1) {
    Profile();
} else {
    
    Perch();
}
