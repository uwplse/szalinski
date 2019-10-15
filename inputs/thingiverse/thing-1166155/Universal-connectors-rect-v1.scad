/* 
 * Universal connectors generator - rectangular version
 * See connectors type to choose from
 * all units are in milimeters
 *
 * author R. A. - 2015/12/01
 * e-mail: thingiverse@dexter.sk
 * Thingiverse username: dexterko
 *
 * Feel free to modify and distribute, but please keep the credits;-)
 */
    
    
outer_width = 12;
hole_width = 8;
connect_length = 20;
connector_type = "XX_conn"; // [I_conn:Bare I connector - 2 connects, L_conn:Flat L connector - 2 connects, T_conn:Flat T connector - 3 connects, X_conn:Flat X connector - 4 connects, LL_conn:Edge Connector - 3 connects, TT_conn:T Connector with side connect - 4 connects, XT_conn:X Connector with  side-connect - 5 connects, XX_conn:full 3D Cross Connector - 6 connects]

if (connector_type == "I_conn") {
    I_conn(outer_width, hole_width, connect_length);
} else if (connector_type == "L_conn") {
    L_conn(outer_width, hole_width, connect_length);
} else if (connector_type == "T_conn") {
    T_conn(outer_width, hole_width, connect_length);
} else if (connector_type == "X_conn") {
    X_conn(outer_width, hole_width, connect_length);
} else if (connector_type == "LL_conn") {
    LL_conn(outer_width, hole_width, connect_length);
} else if (connector_type == "TT_conn") {
    TT_conn(outer_width, hole_width, connect_length); 
} else if (connector_type == "XT_conn") {
    XT_conn(outer_width, hole_width, connect_length);
} else if (connector_type == "XX_conn") {
    XX_conn(outer_width, hole_width, connect_length);


}

module I_conn(outer_width, hole_width, connect_length) {
    difference() {
      cube([outer_width, outer_width, connect_length*2]);
      
      translate([(outer_width-hole_width)/2, (outer_width-hole_width)/2, 0])
      cube([hole_width, hole_width, connect_length*2]);
    }
}


module L_conn(outer_width, hole_width, connect_length) {
    difference() {
        union() {
            // Vertical connect
            translate([0, 0, outer_width])
            cube([outer_width, outer_width, connect_length]);
    
            // Edge connect - solid, no holes
            cube([outer_width, outer_width, outer_width]);
    
            // Horizontal connect
            rotate([90, 0, 0])
            translate([0, 0, 0])
            cube([outer_width, outer_width, connect_length]);
        }

        // Inner hole - vertical
        translate([(outer_width-hole_width)/2, (outer_width-hole_width)/2, outer_width])
        cube([hole_width, hole_width, connect_length]);
    
        // Inner hole - horizontal
        rotate([90, 0, 0])
        translate([(outer_width-hole_width)/2, (outer_width-hole_width)/2, 0])
        cube([hole_width, hole_width, connect_length]);
        }
    }

module T_conn(outer_width, hole_width, connect_length) {
    difference() {
        union() {
            // Vertical connect
            translate([0, 0, outer_width])
            cube([outer_width, outer_width, connect_length]);
    
            // Edge connect - solid, no holes
            // cube([outer_width, outer_width, outer_width]);
    
            // Horizontal connect
            rotate([90, 0, 0])
            translate([0, 0, 0-connect_length-outer_width])
            cube([outer_width, outer_width, connect_length*2+outer_width]);
        }

        // Inner hole - vertical
        translate([(outer_width-hole_width)/2, (outer_width-hole_width)/2, outer_width])
        cube([hole_width, hole_width, connect_length]);
    
        // Inner hole - horizontal
        rotate([90, 0, 0])
        translate([(outer_width-hole_width)/2, (outer_width-hole_width)/2, 0-connect_length-outer_width])
        cube([hole_width, hole_width, connect_length*2+outer_width]);
        }
    }    
    
    
module X_conn(outer_width, hole_width, connect_length) {
    difference() {
        cube([(connect_length*2)+outer_width, (connect_length*2)+outer_width, outer_width]);
        
        translate([-1,-1,-1])
        cube([connect_length+1,connect_length+1, outer_width+2]);
        
        translate([connect_length+outer_width, -1, -1])
        cube([connect_length+1, connect_length+1, outer_width+2]);
        
        translate([-1, connect_length+outer_width, -1])
        cube([connect_length+1, connect_length+1, outer_width+2]);
        
        translate([connect_length+outer_width, connect_length+outer_width, -1])
        cube([connect_length+1, connect_length+1, outer_width+2]);
        
        // Inner hole 1
        translate([connect_length+(outer_width-hole_width)/2, 0, (outer_width-hole_width)/2])
        cube([hole_width, connect_length, hole_width]);
    
        // Inner hole 2
        translate([connect_length+(outer_width-hole_width)/2, connect_length+outer_width, (outer_width-hole_width)/2])
        cube([hole_width, connect_length, hole_width]);
        
        // Inner hole 3(see through)
        translate([0, connect_length+((outer_width-hole_width)/2), (outer_width-hole_width)/2])
        cube([connect_length*2+outer_width, hole_width, hole_width]);
        }
    }    
    

module LL_conn(outer_width, hole_width, connect_length) {
    difference() {
        union() {
            cube([connect_length+outer_width, connect_length+outer_width, outer_width]);
            translate([connect_length, connect_length, outer_width])
            cube([outer_width, outer_width, connect_length]);
        }
        translate([-1,-1,-1])  
        cube([connect_length+1,connect_length+1, outer_width+2]);
        
        // Inner hole 1
        translate([connect_length+(outer_width-hole_width)/2, 0, (outer_width-hole_width)/2])
        cube([hole_width, connect_length, hole_width]);
        
        // Inner hole 2(see through)
        translate([0, connect_length+((outer_width-hole_width)/2), (outer_width-hole_width)/2])
        cube([connect_length, hole_width, hole_width]);
        
        translate([connect_length+(outer_width-hole_width)/2, connect_length+(outer_width-hole_width)/2, outer_width])
        cube([hole_width, hole_width, connect_length]);
        }
    }    
    
module TT_conn(outer_width, hole_width, connect_length) {
    difference() {
        union() {
            cube([(connect_length*2)+outer_width, connect_length+outer_width, outer_width]);
            translate([connect_length, connect_length, outer_width])
            cube([outer_width, outer_width, connect_length]);
        }
        translate([-1,-1,-1])    
        cube([connect_length+1,connect_length+1, outer_width+2]);
        
        translate([connect_length+outer_width, -1, -1])
        cube([connect_length+1, connect_length+1, outer_width+2]);
        
        // Inner hole 1
        translate([connect_length+(outer_width-hole_width)/2, 0, (outer_width-hole_width)/2])
        cube([hole_width, connect_length, hole_width]);
        
        // Inner hole 2(see through)
        translate([0, connect_length+((outer_width-hole_width)/2), (outer_width-hole_width)/2])
        cube([connect_length*2+outer_width, hole_width, hole_width]);
        
        translate([connect_length+(outer_width-hole_width)/2, connect_length+(outer_width-hole_width)/2, outer_width])
            cube([hole_width, hole_width, connect_length]);
        }
    }    
    
module XT_conn(outer_width, hole_width, connect_length) {
    difference() {
        union() {
            cube([(connect_length*2)+outer_width, (connect_length*2)+outer_width, outer_width]);
            translate([connect_length, connect_length, outer_width])
            cube([outer_width, outer_width, connect_length]);
        }
        translate([-1,-1,-1])
        cube([connect_length+1,connect_length+1, outer_width+2]);
        
        translate([connect_length+outer_width, -1, -1])
        cube([connect_length+1, connect_length+1, outer_width+2]);
        
        translate([-1, connect_length+outer_width, -1])
        cube([connect_length+1, connect_length+1, outer_width+2]);
        
        translate([connect_length+outer_width, connect_length+outer_width, -1])
        cube([connect_length+1, connect_length+1, outer_width+2]);
        
        // Inner hole 1
        translate([connect_length+(outer_width-hole_width)/2, 0, (outer_width-hole_width)/2])
        cube([hole_width, connect_length, hole_width]);
    
        // Inner hole 2
        translate([connect_length+(outer_width-hole_width)/2, connect_length+outer_width, (outer_width-hole_width)/2])
        cube([hole_width, connect_length, hole_width]);
        
        // Inner hole 3(see through)
        translate([0, connect_length+((outer_width-hole_width)/2), (outer_width-hole_width)/2])
        cube([connect_length*2+outer_width, hole_width, hole_width]);
        
        translate([connect_length+(outer_width-hole_width)/2, connect_length+(outer_width-hole_width)/2, outer_width])
            cube([hole_width, hole_width, connect_length]);
        }
    }    
    
module XX_conn(outer_width, hole_width, connect_length) {
    difference() {
        union() {
            translate([0, 0, connect_length])
            cube([(connect_length*2)+outer_width, (connect_length*2)+outer_width, outer_width]);
            
            translate([connect_length, connect_length, connect_length+outer_width])
            cube([outer_width, outer_width, connect_length]);
            
            translate([connect_length, connect_length, 0])
            cube([outer_width, outer_width, connect_length]);
        } 
        translate([-1, -1, connect_length-1])
        cube([connect_length+1,connect_length+1, outer_width+2]);
        
        translate([connect_length+outer_width, -1, connect_length-1])
        cube([connect_length+1, connect_length+1, outer_width+2]);
        
        translate([-1, connect_length+outer_width, connect_length-1])
        cube([connect_length+1, connect_length+1, outer_width+2]);
        
        translate([connect_length+outer_width, connect_length+outer_width, connect_length-1])
        cube([connect_length+1, connect_length+1, outer_width+2]);
        
        // Inner hole 1
        translate([connect_length+(outer_width-hole_width)/2, 0, (outer_width-hole_width)/2+connect_length])
        cube([hole_width, connect_length, hole_width]);
    
        // Inner hole 2
        translate([connect_length+(outer_width-hole_width)/2, connect_length+outer_width, (outer_width-hole_width)/2+connect_length])
        cube([hole_width, connect_length, hole_width]);
        
        // Inner hole 3(see through)
        translate([0, connect_length+((outer_width-hole_width)/2), (outer_width-hole_width)/2+connect_length])
        cube([connect_length*2+outer_width, hole_width, hole_width]);
        
        // Inner hole 4
        translate([connect_length+(outer_width-hole_width)/2, connect_length+(outer_width-hole_width)/2, connect_length+outer_width])
        cube([hole_width, hole_width, connect_length]);
            
        // Inner hole 5
        translate([connect_length+(outer_width-hole_width)/2, connect_length+(outer_width-hole_width)/2, 0])
        cube([hole_width, hole_width, connect_length]);
        }
    }    
    