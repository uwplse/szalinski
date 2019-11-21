/*
    A simple swirly container / by Marcus Scheunemann
*/

/* [Base] */

size            = 40;

// Between 0 (square) and Size/2 (circle).
corner_radius   = 15;

/* [Container] */ 

height          = 100;

bottom_height   = 5;

//Dependent of Height
twists          = 150;

direction       = 1; // [1:Left, -1:Right]

//thickness of wall
wall_thickness  = 1.6;

roundness = 100; // [1:100] 

//in relation to Base
opening_ratio   = 1.5;

/* [Hidden] */
scale = opening_ratio;
$fn     = 100;

module round_square(l, r){
    
    if (2*r >= l) {
        
        circle(l/2, $fn = roundness);
        
    } else {
    
    
        minkowski()
        {
            if (r > 0)
                circle(r, $fn = roundness);
            
            //resize square so the quadratic hull remains the same
            square(l- 2*r, center = true);
        }
    }
}

module make_base() {

        linear_extrude(
            height = bottom_height,
            twist  = twists*bottom_height/height*direction, 
            slices = bottom_height * 10, 
            scale  = (bottom_height/height)*(scale-1)+1, 
            convexity = 100) { 
        
            round_square(size, corner_radius);
        }
       
}

module make_container() {
    
    linear_extrude(height = height, twist = twists*direction, slices = height * 10, scale = scale, convexity = 100) { 
        difference() {
        
        round_square(size, corner_radius);
        
         offset(r = -wall_thickness)
            round_square(size, corner_radius);
        
        }
    }
    
}

union() {
    make_base();  
    make_container();
}