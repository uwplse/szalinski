cableDiameter = 5.6;

//Create main body
difference() {
    color("blue") 
        cube([25, 50, 10]);
    
    translate([5, 0, 5])
        rotate([-90, 0, 0])
            color("red") 
                cylinder(d=cableDiameter, 50, $fn = 50);
    
    translate([20, 0, 5])
        rotate([-90, 0, 0])
            color("red") 
                cylinder(d=cableDiameter, 50, $fn = 50);
    
    translate([5, 12, 2]) 
        color("green") 
            cube([15, 25, 6]);
    
    translate([5, 17, 2]) 
        color("green") 
            cube([15, 15, 8]);
}

//Create text
rotate(-90)
    color("yellow") {
        translate([-14.3, 1, 10])
            linear_extrude(0.5) 
                text("Vict", 6);
    
        translate([-16.3, 19.3, 10])
            linear_extrude(0.5) 
                text("WAN", 5);
    
        translate([-49.3, 1, 10])
            linear_extrude(0.5) 
                text("Tx", 6);
    
        translate([-49.8, 18.5, 10])
            linear_extrude(0.5) 
                text("Rx", 6);
        
    }

//Create box cover
rotate([0, 180, 0]) 
    translate([0, 0, -8])
        difference() {
            
            translate([5, 17, 0]) 
                color("green") 
                    cube([15, 15, 8]);
            
            translate([6, 19, 0]) 
                color("yellow") 
                    cube([13, 11, 6]);
            
            translate([5, 19, 0]) 
                color("blue") 
                    cube([15, 11, 0.5]);
           
            translate([5, 17, 3])
                rotate([-90, 0, 0])
                    color("red") 
                        cylinder(d=cableDiameter, 15, $fn = 50);
            
            translate([20, 17, 3])
                rotate([-90, 0, 0])
                    color("red") 
                        cylinder(d=cableDiameter, 15, $fn = 50);      
                     
                translate([10, 17, 0])
                    color("yellow")
                        cube([5, 15, 5]);  
        }

//Create wire caps
module cap() {
    translate([12, -8, 0]) {
        #difference() {
            cylinder(r=2, 6, $fn = 50);
            cylinder(r=1, 6, $fn = 50);
        }
    }
}

module capsLine() {
    cap();
    translate([-20, 0, 0]) 
        cap();
    translate([-10, 0, 0]) 
        cap();
    translate([10, 0, 0]) 
        cap();
}

capsLine();
translate([0, -10, 0]) capsLine();