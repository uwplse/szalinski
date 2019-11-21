/* [Hidden] */
COIN_BORDER_THICKNESS                  =   1.6;  
COIN_ITSELF_THICKNESS                  =   1.53;  
COIN_DIAMETER                          =  20.88;  
COIN_MIDDLE_HOLE_DIAMETER              =   4.46;   
COIN_BORDER_INNER_LENGTH               =   1;    
COIN_BORDER_OUTER_LENGTH               =   1;   

FINGER_TOLERANZ_DIAMETER               =   1.50;  

STRUCTURE_DEPTH_0                      =   0;    
STRUCTURE_DEPTH_1                      =   0;  
STRUCTURE_DEPTH_2                      =   2;
STRUCTURE_DEPTH_0_5                    =    1.5;
STRUCTURE_OFFSET                       =   0.1;   

RESOLUTION                             = 128;   
STRUCTURE_DIAMETER                     =  20;       
RING_CIRCLE_DIAMETER_HEIGHT            =   4;       
RING_OFFSET                            =   0.10;   
RING_SCALE                             =   0.75;   

/* [Parameters] */
COLOR_SCHEME                           =  2;        // [  0:Silver, 1:Pink, 2:Grey ]
VIEW                                   =  1;        // [  0:Preview, 2:Ring, 1:Print ]
FINGER_DIAMETER                        = 16;        // [ 14:14 mm, 16:16 mm, 18:18 mm, 20:20 mm, 22:22 mm, 24:24 mm]
STRUCTURE_THICKNESS_TIMES              =  3;     // [  5:5, 6:6, 7:7, 8:8, 9:9, 10:10]
/* [Hidden] */
$fn                                    = RESOLUTION;
coin_radius                            = COIN_DIAMETER/2;
coin_middle_hole_radius                = COIN_MIDDLE_HOLE_DIAMETER/2;
coin_border_inner_radius               = coin_middle_hole_radius + COIN_BORDER_INNER_LENGTH*2;
coin_border_outer_radius               = coin_radius - COIN_BORDER_OUTER_LENGTH*2;


structure_height                       = COIN_ITSELF_THICKNESS * STRUCTURE_THICKNESS_TIMES;
structure_height_segment               = (structure_height - (STRUCTURE_OFFSET*2)) / 12;
structure_radius                       = STRUCTURE_DIAMETER/2;

ring_circle_radius                     = RING_CIRCLE_DIAMETER_HEIGHT/2 - (RING_OFFSET);
finger_total_radius                    = (FINGER_DIAMETER + FINGER_TOLERANZ_DIAMETER) /2;

structure_ausschnitt                   = finger_total_radius;

color_profiles                         = [ [ "Snow",        // coinMiddle
                                             "Gainsboro",        // coinOutIn
                                             "FloralWhite",      // connector
                                             "Seashell",         // structur
                                             "Linen"             // ring
                                                ],
                                           [ "Snow",             // coinMiddle
                                              "Gainsboro",       // coinOutIn
                                              "Pink",            // connector
                                              "Pink",            // structur
                                              "Pink"             // ring
                                                ],
                                           [ "grey",       // coinMiddle
                                             "grey",       // coinOutIn
                                             "grey",       // connector
                                             "grey",       // structur
                                             "grey"        // ring
                                                ] ] ;                    
//---------------------------------------------------------------
// http://www.thingiverse.com/thing:902701/edit

RING_CIRCLE_STRAIGHT                   =  (structure_height_segment+RING_OFFSET) * 1; // 3 ?? 


if(VIEW == 0) {
    object_total_view();
} else if( VIEW == 1) {
    object_total_print();
} else if( VIEW == 2) {
    finger_ring3D();
}



module object_total_print() {
        translate( [    structure_radius + 2 + coin_middle_hole_radius,
                        0.00,
                        0.00 ] ) 
      coin_holder();

        union() {
            structure3D();
                
            translate( [        0, 
                                0, 
                                0  ] ) 
            translate( [        0, 
                                0, 
                                -RING_CIRCLE_DIAMETER_HEIGHT/2 ] ) 
            translate( [        0, 
                                0, 
                                finger_total_radius + RING_CIRCLE_STRAIGHT + 
                                RING_CIRCLE_DIAMETER_HEIGHT/2 + structure_height  ] )
            finger_ring3D();
        } 
} 

module object_total_view() {
    rotate( [        0.00,
                     0.00,
                      90.00 ] ) 
    union() {
    translate( [    0.00,  
                    0.00,
                    COIN_BORDER_THICKNESS/2 ] )
    coin();
    
    coin_holder();
    translate( [    0.00,
                    0.00,
                    COIN_ITSELF_THICKNESS ] ) 
        union() {
            structure3D();
                
            translate( [        0, 
                                0, 
                                0  ] ) 
            translate( [        0, 
                                0, 
                                -RING_CIRCLE_DIAMETER_HEIGHT/2 ] ) 
            translate( [        0, 
                                0, 
                                finger_total_radius + RING_CIRCLE_STRAIGHT + 
                                RING_CIRCLE_DIAMETER_HEIGHT/2 + structure_height  ] )
            finger_ring3D();
        }
    }
}

module coin_holder() {  
    color(color_profiles[COLOR_SCHEME][2])
    union() {
       translate([ 0,
                   0,
                   COIN_ITSELF_THICKNESS-0.1 ] )  
        //coin_connector(0.2);
        cylinder(   r = coin_middle_hole_radius,
                    h = structure_height/2+0.1);
        cylinder(   r = coin_middle_hole_radius,
                    h = COIN_ITSELF_THICKNESS);  
    }
}


module coin_connector(toleranz) {
    negativ_toleranz = toleranz;
    a                =         [    [  0, 0 ],
                                    [  0, COIN_MIDDLE_HOLE_DIAMETER/2-negativ_toleranz ],
                                    [  COIN_MIDDLE_HOLE_DIAMETER/2-negativ_toleranz, COIN_MIDDLE_HOLE_DIAMETER/2-negativ_toleranz ] ] ;
    translate(-triangle_centroid_vertex_array(a))
    linear_extrude( height = structure_height/2+0.1) {
    polygon(    points   = a, 
                paths    = [ [  0, 1, 2 ] ] );
    } 
}
module structure_negativ(laenge) {

    rotate( [       0.00,
                   90.00,
                    0.00 ] ) 
    rotate_extrude() {
    translate( [        finger_total_radius,
                        0 ] ) 
    offset(             r = RING_OFFSET ) 
        translate( [    (RING_CIRCLE_STRAIGHT * 2 ) / 2,
                        0.00 ] ) 
        union() {      
                 translate( [   -RING_CIRCLE_STRAIGHT + RING_OFFSET,
                                laenge/2*-1] ) 
                square([        RING_CIRCLE_STRAIGHT - RING_OFFSET + RING_CIRCLE_DIAMETER_HEIGHT/2, 
                                laenge ] );
                }  
        
    }
}

module finger_ring3D() {
    color(color_profiles[COLOR_SCHEME][4])
    translate( [     0.00,
                     0.00,
                     0.00 ] )
    translate( [     0.00,
                     0.00,
                     0] )
    rotate( [        0.00,
                    90.00,
                     0.00 ] ) 
    rotate_extrude() {
        finger_ring2D();
    }
}

module finger_ring2D() {

translate( [    finger_total_radius,
                 0.00 ] ) 
offset(          r = RING_OFFSET ) {
    translate( [    (RING_CIRCLE_STRAIGHT * 2 ) / 2,
                    0.00 ] ) 
        union() {
            difference() {                
                scale( [        RING_SCALE, 
                                1 ] )
                circle(         ring_circle_radius);
                    
                translate( [   -RING_CIRCLE_DIAMETER_HEIGHT,
                                -RING_CIRCLE_DIAMETER_HEIGHT / 2 ] )
                square( [       RING_CIRCLE_DIAMETER_HEIGHT,
                                RING_CIRCLE_DIAMETER_HEIGHT ] );
            }
            translate( [    -RING_CIRCLE_STRAIGHT + RING_OFFSET,
                            -ring_circle_radius ] ) 
            square([        RING_CIRCLE_STRAIGHT - RING_OFFSET, 
                            ring_circle_radius * 2 ] );
        }   
    }
}

module structure3D() {
    color(color_profiles[COLOR_SCHEME][3])
    difference() {
        rotate_extrude( ) {
            structure2D();
        }   
        translate( [    0,
                        0,
                        -0.1 ] ) 
                cylinder(   r = coin_middle_hole_radius+0.1,
                    h = structure_height/2+0.1);
    
    }
}

module structure2D() {
   translate( [ structure_radius - STRUCTURE_DEPTH_2 - STRUCTURE_OFFSET, 
             0.00, 
             0.00 ] ) 
translate( [ 0.00, 
             STRUCTURE_OFFSET ] )
offset(  r = STRUCTURE_OFFSET )
    polygon( points = [ [ 0.00, 0.00 ],
                        [ STRUCTURE_DEPTH_2, 0.00 ],
                        [ STRUCTURE_DEPTH_2, structure_height_segment*1 ],
                        [ STRUCTURE_DEPTH_1, structure_height_segment*2 ],
                        [ STRUCTURE_DEPTH_2, structure_height_segment*3 ],
                        [ STRUCTURE_DEPTH_2, structure_height_segment*4 ],
                        [ STRUCTURE_DEPTH_2, structure_height_segment*5 ],
                        [ STRUCTURE_DEPTH_0_5, structure_height_segment*6 ],
                        [ STRUCTURE_DEPTH_0_5, structure_height_segment*7 ],
                        [ STRUCTURE_DEPTH_1, structure_height_segment*8 ],
                        [ STRUCTURE_DEPTH_0_5, structure_height_segment*9 ],
                        [ STRUCTURE_DEPTH_0_5, structure_height_segment*10 ],
                        [ STRUCTURE_DEPTH_2, structure_height_segment*11 ],
                        [ STRUCTURE_DEPTH_2, structure_height_segment*12 ],
                        [ 0.00,              structure_height_segment*12 ] ],          
             paths = [  [ 0, 1, 2, 3,4,5,6,7,8,9,10,11,12,13,14 ] ] );
square( [    structure_radius - STRUCTURE_DEPTH_2,  structure_height ]) ;
    
}

module coin() {
    union() {
        union() {
            color(color_profiles[COLOR_SCHEME][1])   
            ring(       coin_radius,
                        coin_border_outer_radius,
                       COIN_BORDER_THICKNESS ) ;
                
            color(color_profiles[COLOR_SCHEME][1])          
           ring(       coin_border_inner_radius,
                        coin_middle_hole_radius,
                        COIN_BORDER_THICKNESS ) 
            ;
            }
        color(color_profiles[COLOR_SCHEME][0])
        ring(       coin_border_outer_radius+0.1,
                    coin_border_inner_radius,
                    COIN_ITSELF_THICKNESS ) ;
    }
}

module ring(aussen, innen, hoehe) {
    
translate( [    0,
                0,
                -hoehe/2 ] )
    difference() {
        cylinder(       r = aussen,
                        h = hoehe );
        
        translate( [     0,
                         0,
                        -1  ] ) 
        cylinder(       r = innen,
                        h = hoehe+2 );
    }   
}


function triangle_centroid_vertex_array(v)      = [  (v[0][0]+v[1][0]+v[2][0])/3, 
                                                     (v[0][1]+v[1][1]+v[2][1])/3, 
                                                     (v[0][2]+v[1][2]+v[2][2])/3 ];

