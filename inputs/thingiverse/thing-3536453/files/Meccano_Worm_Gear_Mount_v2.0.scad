// 22.25
// 43.00
// 22.32



//--main frame
module Main_frame(){
cube([22.25,43-22.25/2,22.25], false);
translate([(22.25/2),43-22.25/2,0]) {
    cylinder($fn=50,22.25, d = 22.25,true);
}
}

//--shaft hole
module Shaft_hole() {
    rotate([90,0,0]){
    translate([22.25/2,15.9,-80]){
        cylinder($fn=50,100,d=9.8,true);
        }
    }
}

module Upper_Slot() {
    translate([22.25/2,0,18.5]){
      // rotate([0,45,0]){
        cube([8.8,100,8.8],true);
        }
   // }
}

module Lower_Slot() {
    translate([0,14,-6]){
      // rotate([0,45,0]){
        cube([16,30,6.5],true);
        }
   // }
}

module Vertical_Cuts() {
//--back cut 1
    translate([2,2,4]) {
        cube([18.24,21,22.25], false);
      }
//--back cut 2 - nut recess
    translate([3.05,7.95,2]) {
        cube([16.15,30,4], false);
      }

    //--front slot 1
    translate([3.05,25,2]) {
        cube([16.15,30,25], false);
        }
        
    //--front slot 2
    translate([-1,29,5]) {
        cube([35,30,25], false);
       }
    
    //--back hole
    translate([22.25/2,15.75,-1]) {
        rotate([0,0,0]){    
            cylinder($fn=50,80,d=9.8,false);
        }
    }
  
}

//--combine objects
difference() {
    Main_frame();
    Shaft_hole();
    Upper_Slot();
   // Lower_Slot();
    Vertical_Cuts();
}  
