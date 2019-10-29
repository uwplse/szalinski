/********** Bottle Holder for child bed ********/

height = 50;  // Height of the bottle holder
inner_r = 37; // Inner radius of bottle holder, its the radius!!! d = 2 r !!!
material = 4; // material thickness
width = 150;  // Width of the back

$fn = 50;     // Resolution

/********** Processing ************************/

union() {


    difference() {
        
        translate( [ 0.00, inner_r, 0.00 ] ) {
            cylinder( h = height, r = inner_r + material );
        }
        
        translate( [ 0.00, inner_r, material ] ) {
            cylinder( h = height, r = inner_r );
        }
        
    }
    
    
    scale( [ 1, 1, 0.50 ] )
    union() {
    
        translate( [ -(width / 2), -material, 0.00 ] ) {
            cube( [ width, material, height / 2 ]);
        }
        
        translate( [ 0, 0, height / 2 ] ) {
            scale( [width, material, height] ) {
                rotate( [ 90, 0.00, 0.00 ] ) {
                    cylinder( r = 0.5, h = 1 );
                }
            }
        }
        
    }
    
}


