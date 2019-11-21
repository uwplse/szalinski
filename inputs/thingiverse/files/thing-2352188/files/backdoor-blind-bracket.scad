module backdoor_blind_bracket(base=[23,15,2], height=35) {   
    difference() {
        // Build the main body
        union() {
            cube(base, true);
            
            translate([0,base[1]/2-1,base[2]+6.5]) 
                cube([base[0], 2, 15], true);
            
            translate([0,base[1]/2-1,(base[2]/2)+15]) 
                linear_extrude(height=height-15, scale=[.5,1]) 
                    square([base[0], 2], true);
            
            translate([-1,base[1]/2-2,1]) 
                linear_extrude(height=4, scale=[1,0]) 
                    rotate([180, 0, 0]) 
                        square([2, 4]);
            
            translate([0,base[1]/2-1,height]) 
                rotate([90,0,0]) 
                    cylinder(2, r = base[0]/2/2, $fn=30, center=true);   
            
            translate([0,base[1]/2-4,height]) 
                rotate([90,0,0]) 
                    cylinder(4, r=1, $fn=30, center=true);
        }
        
        // Put screw holes in base
        translate([base[0]/2-5,-base[2]/2,0]) 
            cylinder(10, r=1.375, $fn=30, center=true);
        
        translate([-base[0]/2+5,-base[2]/2,0]) 
            cylinder(10, r=1.375, $fn=30, center=true);
    }
}

backdoor_blind_bracket();
