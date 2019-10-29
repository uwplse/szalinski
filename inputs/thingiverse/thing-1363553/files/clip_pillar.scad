/*********** CLIP PILLAR **********************/

saeule = 100;       // width of the pillar
toleranz = 1.5;     // tolerance on each site
dicke = 4;          // material thickness



/******************** Processing *******************/

$fn = 50;

difference() {
    
    union() {
    
        cube([ saeule + ( toleranz * 2 ) + ( dicke * 2 ),
               saeule + ( toleranz * 2 ) + ( dicke * 2 ),
               dicke ]);
        
        translate([ -2, 1 + dicke, 0 ]) {
            difference() {
                
                cylinder( r = dicke + 2, h = dicke );
                
                cylinder( r = 2, h = dicke );
                
            }
        }
        
        translate([ 1 + dicke, -2, 0 ]) {
            difference() {
                
                cylinder( r = dicke + 2, h = dicke );
                
                cylinder( r = 2, h = dicke );
                
            }
        }
        
    }
    
    translate([ dicke, dicke, 0 ]) {
        cube([  saeule + ( toleranz * 2 ),
                saeule + ( toleranz * 2 ),
                dicke ]);
    }
    
    translate([ dicke * 5, dicke * 5, 0 ]) {
        rotate([ 0, 0, 135 ]) {
            cube([ 1, saeule, dicke ]);
        }
    }
    
}



    