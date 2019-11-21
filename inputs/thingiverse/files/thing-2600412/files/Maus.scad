//battery cover for AMIR DE1-CP9
difference(){
   
   union(){
       //main body
       minkowski(){
        cube([46.75, 23, 1], center=true);
        cylinder($fn=50, r=2,h=0.5);
        }
       //rront Clip
       translate([14,13.5,2])
        cube([5, 5, 2], center=true);
        translate([-14,13.5,2])
        cube([5, 5, 2], center=true);
       //rear Clip
       union(){
        translate([0,-13.5,2])
        cube([5, 4, 1], center=true);
           
       translate([0,-12.5,1])
        cube([5, 2, 3], center=true);
       }
       }
      //recess
       translate([0,-10,0])
        cube([25, 2, 3], center=true);
    
       }
  