$fn = 100;

module base() {
    
    difference() {
        linear_extrude(height=2) {
            circle(50, center=true);
        }
        
        translate([0,34,0]) {
            #cylinder(2, 2.5, 5);
        }
        
        translate([0,-34,0]) {
            cylinder(2, 2.5, 5);
        }           
        
    }
}

module cylindre() {
    
    difference() {
        translate([0,0,51]) {
            difference() {
                cylinder(100, 17, 17.5, center=true);
                #cylinder(100, 16, 16.5, center=true);
            }
        }    
        
        translate([0,0,80]) {
            cube([2,100,50], center=true);
        }
        
        translate([0,0,80]) {
            cube([100,2,90], center=true);
        }
        
    }
}

module bouchon() {
  
    linear_extrude(height=2) {
        circle(22, center=true);
    }
    
    translate([0,0,11]) {
        difference() {
            cylinder(20, 16.5, 16.5, center=true);
            #cylinder(20, 15.5, 15.5, center=true);
        }
    }
}

base();
cylindre();

translate([100,0,0]) bouchon();

