$fs = 0.01;
difference() {
    //base
cube([123,55,28]);
translate([0,0,5]) rotate([30,0,0]) 
    { 
        //bell 
        cube([123,46,28]);
        // screw holes bell
        translate([5,23,-50]) {
            cylinder(50,d=2.5);     
            translate([113,0,0]) cylinder(50,d=2.5);
        }
        
        // wire hole
        translate([40,(46/2)-(25/2),-30])  
        translate([25/2,25,30]) rotate([180,0,0]) linear_extrude(height=30,scale=2.5) translate([-25/2,0,0]) square([25,25]); 
    
        //cube([15,25,25]);

    }
    // wire guide
    translate([16,57,0]) rotate([67,0,40]) {
        cylinder(45, d=5);
        translate([-2.5,-50,0]) cube([5,50,45]);
    }
  translate([15,27,0]) {
   {    cylinder(10,d=4);     
        translate([0,0,10]) { 
            linear_extrude(height= 3, scale=2) circle(r = 2);
            translate([0,0,3]) cylinder(20, d= 8);
        }
   }
   
   translate([93,0,0]) 
   {    cylinder(10,d=4);     
        translate([0,0,10]) { 
            linear_extrude(height= 3, scale=2) circle(r = 2);
            translate([0,0,3]) cylinder(20, d= 8);
        }
   }
}
}
//translate([0,0,5]) rotate([30,0,0]) color([0,0,1]) cube([123,46,28]);




