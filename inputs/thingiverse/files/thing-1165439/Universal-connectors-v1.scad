/* 
 * Universal connectors generator
 * See connectors type to choose from
 * all units are in milimeters
 *
 * author R. A. - 2015/11/30
 * e-mail: thingiverse@dexter.sk
 * Thingiverse username: dexterko
 *
 * Feel free to modify and distribute, but please keep the credits;-)
 */
    
    
outer_diameter = 15;
inner_diameter = 8;
connect_length = 20;
faces = 100; // [6:100]
connector_type = "XX_conn"; // [L_conn:Flat L connector - 2 connects, T_conn:Flat T connector - 3 connects, X_conn:Flat X connector - 4 connects, LL_conn:Edge Connector - 3 connects, TT_conn:T Connector with side connect - 4 connects, XT_conn:X Connector with  side-connect - 5 connects, XX_conn:full 3D Cross Connector - 6 connects]

if (connector_type == "L_conn") {
    L_conn(outer_diameter, inner_diameter, connect_length, faces);
} else if (connector_type == "T_conn") {
    T_conn(outer_diameter, inner_diameter, connect_length, faces);
} else if (connector_type == "X_conn") {
    X_conn(outer_diameter, inner_diameter, connect_length, faces);
} else if (connector_type == "LL_conn") {
    LL_conn(outer_diameter, inner_diameter, connect_length, faces);
} else if (connector_type == "TT_conn") {
    TT_conn(outer_diameter, inner_diameter, connect_length, faces); 
} else if (connector_type == "XT_conn") {
    XT_conn(outer_diameter, inner_diameter, connect_length, faces);
} else if (connector_type == "XX_conn") {
    XX_conn(outer_diameter, inner_diameter, connect_length, faces);


}


module L_conn(outer_diameter, inner_diameter, connect_length, faces) {
    difference() {
        union() {
            // Vertical connect
            cylinder(d = outer_diameter, h = connect_length + outer_diameter/2, $fn = faces);
    
            // Edge connect - solid, no holes
            translate([0, 0, connect_length+outer_diameter/2])
            sphere(d = outer_diameter, $fn = faces);
    
            // Horizontal connect
            rotate([90, 0, 0])
            translate([0, connect_length+outer_diameter / 2, 0])
            cylinder(d = outer_diameter, h = connect_length + outer_diameter / 2, $fn = faces);
        }

        // Inner hole - vertical
        cylinder(d = inner_diameter , h = connect_length, $fn=faces);
    
        // Inner hole - horizontal
        rotate([90, 0, 0])
        translate([0, connect_length + outer_diameter / 2, outer_diameter / 2])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);
        }
    }

module T_conn(outer_diameter, inner_diameter, connect_length, faces) {
    difference() {
        union() {
            // Vertical connects - upper & lower
            cylinder(d = outer_diameter, h = (connect_length * 2 + outer_diameter), $fn = faces);
    
            // Horizontal connect - left
            rotate([90, 0, 0])
            translate([0, connect_length + outer_diameter / 2, 0])
            cylinder(d = outer_diameter, h = connect_length + outer_diameter / 2, $fn = faces);
        }

        // Inner hole - vertical
        cylinder(d = inner_diameter , h = (connect_length * 2 + outer_diameter), $fn=faces);
    
        // Inner hole - horizontal
        rotate([90, 0, 0])
        translate([0, connect_length + outer_diameter / 2, outer_diameter / 2])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);
        }
    }
    
module X_conn(outer_diameter, inner_diameter, connect_length, faces) {
    difference() {
        union() {
            // Vertical connects - upper & lower
            cylinder(d = outer_diameter, h = (connect_length * 2 + outer_diameter), $fn = faces);
    
            // Horizontal connect - left & right
            rotate([90, 0, 0])
            translate([0, connect_length + outer_diameter / 2, 0 - (connect_length + outer_diameter/2)])
            cylinder(d = outer_diameter, h = (connect_length * 2 + outer_diameter), $fn = faces);
        }

        // Inner hole - vertical
        cylinder(d = inner_diameter , h = (connect_length * 2 + outer_diameter), $fn=faces);
    
        // Inner hole - horizontal (left + right)
        rotate([90, 0, 0])
        translate([0, connect_length + outer_diameter / 2, outer_diameter / 2])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);

        rotate([90, 0, 0])
        translate([0, connect_length + outer_diameter / 2, 0 - (connect_length + outer_diameter/2)])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);
        }
    }
    

module LL_conn(outer_diameter, inner_diameter, connect_length, faces) {
      difference() {
        union() {
            // Vertical connect
            cylinder(d = outer_diameter, h = connect_length + outer_diameter/2, $fn = faces);
    
            // Edge connect - solid, no holes
            translate([0, 0, connect_length+outer_diameter/2])
            sphere(d = outer_diameter, $fn = faces);
    
            // Horizontal connect 1
            rotate([90, 0, 0])
            translate([0, connect_length+outer_diameter / 2, 0])
            cylinder(d = outer_diameter, h = connect_length + outer_diameter / 2, $fn = faces);
            // Horizontal connect 2
            rotate([90, 0, 90])
            translate([0, connect_length+outer_diameter / 2, 0])
            cylinder(d = outer_diameter, h = connect_length + outer_diameter / 2, $fn = faces);
        }

        // Inner hole - vertical
        cylinder(d = inner_diameter , h = connect_length, $fn=faces);
    
        // Inner hole - horizontal 1
        rotate([90, 0, 0])
        translate([0, connect_length + outer_diameter / 2, outer_diameter / 2])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);

        // Inner hole - horizontal 2
        rotate([90, 0, 90])
        translate([0, connect_length + outer_diameter / 2, outer_diameter / 2])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);
        }
    }  

module TT_conn(outer_diameter, inner_diameter, connect_length, faces) {
    difference() {
        union() {
            // Vertical connects - upper & lower
            cylinder(d = outer_diameter, h = (connect_length * 2 + outer_diameter), $fn = faces);
    
            // Horizontal connect - left
            rotate([90, 0, 0])
            translate([0, connect_length + outer_diameter / 2, 0])
            cylinder(d = outer_diameter, h = connect_length + outer_diameter / 2, $fn = faces);
            // Horizontal connect - front
            rotate([90, 0, 90])
            translate([0, connect_length + outer_diameter / 2, 0])
            cylinder(d = outer_diameter, h = connect_length + outer_diameter / 2, $fn = faces);
        }

        // Inner hole - vertical
        cylinder(d = inner_diameter , h = (connect_length * 2 + outer_diameter), $fn=faces);
    
        // Inner hole - horizontal left
        rotate([90, 0, 0])
        translate([0, connect_length + outer_diameter / 2, outer_diameter / 2])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);
        // Inner hole - horizontal front
        rotate([90, 0, 90])
        translate([0, connect_length + outer_diameter / 2, outer_diameter / 2])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);
        }
    }
  
module XT_conn(outer_diameter, inner_diameter, connect_length, faces) {
    difference() {
        union() {
            // Vertical connects - upper & lower
            cylinder(d = outer_diameter, h = (connect_length * 2 + outer_diameter), $fn = faces);
    
            // Horizontal connect - left & right
            rotate([90, 0, 0])
            translate([0, connect_length + outer_diameter / 2, 0 - (connect_length + outer_diameter/2)])
            cylinder(d = outer_diameter, h = (connect_length * 2 + outer_diameter), $fn = faces);
            // Horizontal connect - front
            rotate([90, 0, 90])
            translate([0, connect_length + outer_diameter / 2, 0])
            cylinder(d = outer_diameter, h = connect_length + outer_diameter / 2, $fn = faces);
        }

        // Inner hole - vertical - upper & lower
        cylinder(d = inner_diameter , h = (connect_length * 2 + outer_diameter), $fn=faces);
    
        // Inner hole - horizontal - left & right
        rotate([90, 0, 0])
        translate([0, connect_length + outer_diameter / 2, outer_diameter / 2])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);

        rotate([90, 0, 0])
        translate([0, connect_length + outer_diameter / 2, 0 - (connect_length + outer_diameter/2)])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);
        
        // Inner hole - horizontal front
        rotate([90, 0, 90])
        translate([0, connect_length + outer_diameter / 2, outer_diameter / 2])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);
        }
    }
    
 module XX_conn(outer_diameter, inner_diameter, connect_length, faces) {
    difference() {
        union() {
            // Vertical connects - upper & lower
            cylinder(d = outer_diameter, h = (connect_length * 2 + outer_diameter), $fn = faces);
    
            // Horizontal connect - left & right
            rotate([90, 0, 0])
            translate([0, connect_length + outer_diameter / 2, 0 - (connect_length + outer_diameter/2)])
            cylinder(d = outer_diameter, h = (connect_length * 2 + outer_diameter), $fn = faces);
            // Horizontal connect - front
            rotate([90, 0, 90])
            translate([0, connect_length + outer_diameter / 2, 0])
            cylinder(d = outer_diameter, h = connect_length + outer_diameter / 2, $fn = faces);
            // Horizontal connect - rear
            rotate([90, 0, 90])
            translate([0, connect_length + outer_diameter / 2, 0 - (connect_length + outer_diameter/2)])
            cylinder(d = outer_diameter, h = connect_length + outer_diameter / 2, $fn = faces);
        }

        // Inner hole - vertical - upper & lower
        cylinder(d = inner_diameter , h = (connect_length * 2 + outer_diameter), $fn=faces);
    
        // Inner hole - horizontal - left & right
        rotate([90, 0, 0])
        translate([0, connect_length + outer_diameter / 2, outer_diameter / 2])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);

        rotate([90, 0, 0])
        translate([0, connect_length + outer_diameter / 2, 0 - (connect_length + outer_diameter/2)])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);
        
        // Inner hole - horizontal front
        rotate([90, 0, 90])
        translate([0, connect_length + outer_diameter / 2, outer_diameter / 2])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);
        
        // Inner hole - horizontal rear
        rotate([90, 0, 90])
        translate([0, connect_length + outer_diameter / 2, 0 - (connect_length + outer_diameter/2)])
        cylinder(d  = inner_diameter, h = connect_length, $fn = faces);
        }
    }
    
 