/* [Parameters] */
VIEW                    =  0;  // [ 0:Preview (Front / Text), 1:Preview (Back / Frame), 2:Print ]
PATTERN_SHAPE           =  32;     // [ 2:Triangle, 4:Square, 32:Circle ]

LENGTH                  =  24.5*5;
WIDTH                   =  15.3*5 ;
HEIGHT_TOTAL            =  0.8*5;
FRAME_WIDTH             =  1*5;   // [ 0.1:0.1, 0.2:0.2, 0.3:0.3, 0.4:0.4, 0.5:0.5, 0.6:0.6, 0.7:0.7, 0.8:0.8, 0.9:0.9, 1:1, 1.1:1.1, 1.2:1.2, 1.3:1.3, 1.4:1.4, 1.5:1.5, 1.6:1.6, 1.7:1.7, 1.8:1.8, 1.9:1.9, 2:2]
/* [Hidden] */
////-------------------------------------------------------
TEXT                    = "";
RESOLUTION              =  16;  // [ 32:32 (RECOMMENDED), 64:64, 128:128, 256:256]
LAYER_HEIGHT            =  0.2; // OBJEKT
WALL_THICKNESS_IN_LAYER =  2;
OFFSET_RADIUS           =  0.3;
TOLERANZ_PRO_SEITE      =  0.2; 
FRAME_HEIGHT            = HEIGHT_TOTAL/2;
MASK_LENGTH             = LENGTH - FRAME_WIDTH*2;
MASK_WIDTH              = WIDTH - FRAME_WIDTH*2;;
$fn                     = RESOLUTION;
wanddicke               = LAYER_HEIGHT * WALL_THICKNESS_IN_LAYER;
aussen_breite           = MASK_WIDTH + FRAME_WIDTH*2;
aussen_laenge           = MASK_LENGTH + FRAME_WIDTH*2;

laenge_komplett         = MASK_WIDTH + FRAME_WIDTH*2 + OFFSET_RADIUS;
breite_komplett         = MASK_LENGTH + FRAME_WIDTH*2 + OFFSET_RADIUS;
////-------------------------------------------------------


//kadinsky(0.5);
view();


module view() {    
    if(VIEW == 0) {
        // FRONT
        rotate( [    180,
                     0,
                     0 ] )
        translate( [ -LENGTH/2,
                     -WIDTH/2,
                     0 ] )
        komplett();
    } else {
        if(VIEW == 1) {
            // BACK
            translate( [ -LENGTH/2,
             -WIDTH/2,
             0 ] )
            komplett();
        } else {
            // PRINT 
            translate( [ -LENGTH/2,
             -WIDTH/2,
             0 ] )
            komplett();
        }
    }
}



module komplett() {
    union() {
    difference() {
        difference() {
            frame();
            kreise(1, 1, 2.5);
            }
        text_frame(TEXT, 0.675 * 5 );
        }
    halterung();
}  
    
}


module kreise(radius, abstand, space) {
    
abstand_komplett        = FRAME_WIDTH + OFFSET_RADIUS/2 + space;
abstand_komplett_mitte  = FRAME_WIDTH + OFFSET_RADIUS + space;
        
x0                      =   abstand_komplett;
x1                      =   breite_komplett/2 - abstand_komplett_mitte/2;
x2                      =   breite_komplett/2 + abstand_komplett_mitte/2;
x3                      =   (breite_komplett - abstand_komplett/2) - abstand_komplett/2;
y0                      =   abstand_komplett;
y1                      =   laenge_komplett - abstand_komplett;

x_differenz             =   x1 - x0;
y_differenz             =   y1 - y0;
kreis_abstand           =   radius*2 + abstand;
x_i                     =   floor(x_differenz / kreis_abstand)-1;
y_i                     =   floor(y_differenz / kreis_abstand)-1;   
groesse_gesamt          =   (y_i * kreis_abstand) + radius*2;  
groesse_gesamt_x        =   (x_i * kreis_abstand) + radius*2 + radius;
    
groesse_differenz       =   (y_differenz - groesse_gesamt) / 2;
groesse_differenz_x      =  (x_differenz - groesse_gesamt_x) / 2;

     
for(h = [ 0 : 1]) {   
    

     translate( [ radius + groesse_differenz_x + (h*x2-h*x0),
                  radius + groesse_differenz,
                  0 ] )   

    for(j = [ 0 : y_i] ) { 
        for(i = [ 0 : x_i] ) {
            if( j%2 == 0 ) {
                    color("yellow")
                    translate( [    x0 + radius, 
                                    y0, 
                                    0 ] )
                    translate( [    i*kreis_abstand,
                                    j*kreis_abstand,
                                    -((HEIGHT_TOTAL*5)*2)/2 ] ) 
                    cylinder(       r  = radius,
                                    h  = (HEIGHT_TOTAL*5)*2,
                                    $fn = PATTERN_SHAPE); 
                    
                } else {
                    color("yellow")
                    translate( [    x0, 
                                    y0, 
                                    0 ] )
                    translate( [    i*kreis_abstand,
                                    j*kreis_abstand,
                                    -((HEIGHT_TOTAL*5)*2)/2 ] ) 
                    cylinder(       r  = radius,
                                    h  = (HEIGHT_TOTAL*5)*2,
                                    $fn = PATTERN_SHAPE );           
                }
            } 
        }  
}
    

    
}


module kadinsky(space) {

    abstand_komplett       = FRAME_WIDTH + OFFSET_RADIUS/2 + space;
    abstand_komplett_mitte = FRAME_WIDTH + OFFSET_RADIUS + space;

    translate( [    breite_komplett/2,
                    laenge_komplett/2,
                    0 ] ) 
    %cube( [        FRAME_WIDTH,
                    laenge_komplett,
                    2 ], 
                    center = true );
    
    
    translate( [    breite_komplett/2,
                    laenge_komplett/2,
                    0 ] ) 
    %cube( [         abstand_komplett_mitte,
                    laenge_komplett,
                    2 ], 
                    center = true );
    
    translate( [    abstand_komplett/2,
                    laenge_komplett/2,
                    0 ] ) 
    %cube( [        abstand_komplett,
                    laenge_komplett,
                    2 ], 
                    center = true );
    
    translate( [    breite_komplett - abstand_komplett/2,
                    laenge_komplett/2,
                    0 ] ) 
    %cube( [        abstand_komplett,
                    laenge_komplett,
                    2 ], 
                    center = true );
    
    
    translate( [    breite_komplett/2,
                    abstand_komplett/2,
                    0 ] ) 
    %cube( [        breite_komplett,
                    abstand_komplett,
                    2 ], 
                    center = true );
    
    translate( [    breite_komplett/2,
                    laenge_komplett - abstand_komplett/2,
                    0 ] ) 
    %cube( [        breite_komplett,
                    abstand_komplett,
                    2 ], 
                    center = true );
    
    
    
}



module text_frame(text, text_size) {
    
color("yellow")   
translate( [    breite_komplett/2,
                laenge_komplett/2,
                (FRAME_HEIGHT*-1) / 2 ] ) 
linear_extrude( height = FRAME_HEIGHT) {
rotate( [       0,
                180,
                90 ] )
text(           str(text), 
                size        =  text_size, 
                halign      = "center", 
                valign      = "center" );
}
}




module muster() {
    
    
    for(i = [0:4]) {
    translate( [    4*i,
                    0,
                    0 ] )
    cylinder(r = 2);
    }
        
    
}


module frame() {

color("black") 
translate( [    OFFSET_RADIUS,
                OFFSET_RADIUS,
                0 ] )
 
linear_extrude( height = FRAME_HEIGHT) {
    
    offset(     r      = OFFSET_RADIUS) {
        
    square ( [  aussen_laenge   - OFFSET_RADIUS,
                aussen_breite   - OFFSET_RADIUS ] );
    } 
}
 }


module halterung() {
translate( [ FRAME_WIDTH/2 + OFFSET_RADIUS/2,
             FRAME_WIDTH/2 + OFFSET_RADIUS/2,
             0 ] )

translate([    0,
               0,
               FRAME_HEIGHT ] )
    
linear_extrude( height = FRAME_HEIGHT) {
   difference() {
             square( [  MASK_LENGTH + FRAME_WIDTH,
                        MASK_WIDTH + FRAME_WIDTH ] );
       
            translate( [    FRAME_WIDTH/2,
                            FRAME_WIDTH/2 ])
             square( [  MASK_LENGTH,
                        MASK_WIDTH ] );
            }   
    }   
}