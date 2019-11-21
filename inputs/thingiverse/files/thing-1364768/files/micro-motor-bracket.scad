//Bracket for 12mm Micro Motor with Metal Gearbox.
//Oktay Gülmez, 19/02/2016.
//GNU GPL.

//parameters:
//Bracket lenght (10-20mm.)
lenght=12; 
//(Diagonal size of the nuts; small=4,4mm. or large=5,2mm.)
nuts=4.4; 

$fn=30;
module inside(){
    difference(){
        union(){
            translate([10,0,4]) rotate([0,90,0]) minkowski(){
                cube([6,6.5,30], center=true);
                cylinder(r=3);
            }
          
        }
       
    }
}

module plate(){
    difference(){
        union(){
            translate([0,0,4]) rotate([0,90,0]) minkowski(){
                cube([10,10.5,0.2], center=true);
                cylinder(r=1);
            }
          
        }
       
    }
}
    
module bracket(){    
difference(){
    union(){
        translate([lenght-4,-9,0]) cylinder(h=3, r=4);
        translate([lenght-4,9,0]) cylinder(h=3, r=4);
        
        translate([lenght/2-0.5,0,4]) rotate([0,90,0]) minkowski(){
             cube([12,12,lenght-1], center=true);
            cylinder(r=1.5);
        }
        
        translate([lenght-4,-9-4,0]) cube([4,18+8,3]);
        
        translate([lenght-8,-9,0]) cube([8,3,4.5]);
        translate([lenght-8,9-3,0]) cube([8,3,4.5]);
        
    }
    translate([lenght-4,-9,-1]) cylinder(h=5, r=1.2);
        translate([lenght-4,9,-1]) cylinder(h=5, r=1.2);
    translate([lenght-4,-9,1.5]) cylinder(h=2.5, r=nuts/2+0.2, $fn=6);
        translate([lenght-4,9,1.5]) cylinder(h=2.5, r=nuts/2+0.2, $fn=6);
    
    translate([lenght-8-1,-9,4.5]) rotate([0,90,0]) cylinder(h=10, r=1.5);
    translate([lenght-8-1,9,4.5]) rotate([0,90,0]) cylinder(h=10, r=1.5);
    
    inside();
    translate([0,0,0]) plate();
    translate([5.2,0,0]) plate();
     translate([8.5,0,0]) plate();
    
    translate([lenght/2,0,0]) cube([lenght+2,12.5,10], center=true);
    
    translate([-1,-15,-5]) cube([lenght+2,30,5]);
        
}
}

translate([0,0,lenght]) rotate([0,90,0]) bracket();

