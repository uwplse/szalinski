//----G-L-O-B-A-L-E-N---------------------------------

VIEW                            =  3;    // [3:Non-Conductive (Button & Letter),0:Non-Conductive (Button), 1: Conductive (Badge),2:Letter,4:Preview]
COLOR_SCHEME                    =  1;    // [0:Khaki, 1:Wood, 2:Silver]

// in [mm]
BUTTON_STRAIGHT                 = 75;    // [0:100]
// in [mm]
BUTTON_ROUNDED                  = 25;    // [0:100]
// in [mm]
BADGE_ROUNDED                   =  8;     // [0:10]
LETTER                          = "A";   // TEXT

RESOLUTION                      = 64;    // [8,16,32,64,128,256]
// in [mm]
TOLERANCE_DIAMETER              =  0.3;  // [0.0, 0.1, 0.2, 0.3, 0.4, 0.5]
// in [mm]
LAYER_HEIGHT                    =  0.2;  // [0.0, 0.1, 0.2, 0.3, 0.4, 0.5]

//----------------------------------------------------
innen_gerade_radius            = BUTTON_STRAIGHT/2;
button_komplett                = BUTTON_STRAIGHT/2 + BUTTON_ROUNDED;
button_hoehe                   = BUTTON_ROUNDED;
$fn                            = RESOLUTION;
//----------------------------------------------------


ansicht(VIEW, COLOR_SCHEME);


module ansicht(VIEW_i, c_scheme) {
    COLOR_SCHEME_NAME                   = [["Khaki", "Grey"],["BurlyWood", "Grey"],["Silver", "Black"]];
    COLOR_NON_CONDUCTIVE           = COLOR_SCHEME_NAME[c_scheme][0];
    COLOR_CONDUCTIVE               = COLOR_SCHEME_NAME[c_scheme][1];
    
    if(VIEW_i == 0) {
        color(COLOR_NON_CONDUCTIVE)
        button_aussen();
    }
    
    if(VIEW_i == 1) {
        color(COLOR_CONDUCTIVE)
        rotate( [         0,
                        180, 
                          0 ] )
        translate( [      0,
                          0,
                          BADGE_ROUNDED*-1 ] )
        button_innen_wText(LETTER, TOLERANCE_DIAMETER);
    }
    
    if(VIEW_i == 2) {
        color(COLOR_NON_CONDUCTIVE)
        button_innen_textSingle(LETTER, 0, BADGE_ROUNDED/2 - LAYER_HEIGHT);
    }
    
    if(VIEW_i == 3) {
        color(COLOR_NON_CONDUCTIVE)
        button_aussen();
        
        color(COLOR_NON_CONDUCTIVE)
        button_innen_textSingle(LETTER, 0, BADGE_ROUNDED/2 - LAYER_HEIGHT);
    }
       
    if(VIEW_i == 4) {
        button_ansicht(COLOR_NON_CONDUCTIVE, COLOR_CONDUCTIVE);
    }
}

module button_ansicht(c_nCond, c_Cond) {

color(c_nCond)    
button_aussen();

color(c_Cond)
translate( [    0,
                0,
                button_hoehe-BADGE_ROUNDED ] )
button_innen_wText(LETTER, TOLERANCE_DIAMETER); 

    
color(c_nCond)
translate( [    0,
                0,
                button_hoehe - (BADGE_ROUNDED/2)- LAYER_HEIGHT] )
button_innen_textSingle(LETTER, 0, BADGE_ROUNDED/2 - LAYER_HEIGHT); 
    
    
   
}


module button_innen_textSingle(text, typo_offset_x, typo_hoehe) {
    
linear_extrude(         height     = typo_hoehe ) {
        offset(         r          = typo_offset_x)    {
            text(       str(text), 
                        size       = innen_gerade_radius-BADGE_ROUNDED,
                        valign     = "center",
                        halign     = "center" );
        }
    }  
}


module button_innen_wText(text, typo_offset_x) {
    difference() {
        translate( [    0,
                        0,
                        BADGE_ROUNDED ] )
        rotate( [       0,
                        180,
                        0 ] )
        button_innen();
        
        translate( [    0,
                        0,
                        BADGE_ROUNDED/2 ] )       
        button_innen_textSingle(LETTER, typo_offset_x, BADGE_ROUNDED/2+1);
    }  
}


module button_innen() {
    
button_gefuellt(       BADGE_ROUNDED - TOLERANCE_DIAMETER/2,
                       innen_gerade_radius-BADGE_ROUNDED, 
                       RESOLUTION , 
                       RESOLUTION  );    
}


module button_aussen() {
    difference() {
      button_gefuellt(  BUTTON_ROUNDED,
                        innen_gerade_radius, 
                        RESOLUTION , 
                        RESOLUTION  );  
      badge_negativ2();      
    }
}



module badge_negativ() {

    union() {
        union() {
            translate( [            0,
                                    0,
                                    button_hoehe ] )
            rotate( [               180,
                                    0,
                                    0 ] )
            button_gefuellt(        BADGE_ROUNDED,
                                    innen_gerade_radius-BADGE_ROUNDED, 
                                    RESOLUTION , 
                                    RESOLUTION  );    
            
            translate( [            0,
                                    0,
                                   -1 ] )
            cylinder(         r =   innen_gerade_radius-BADGE_ROUNDED,
                              h =   button_hoehe - BADGE_ROUNDED+2 );  
            }
    }
        translate( [            0,
                                0,
                                button_hoehe ] )
        cylinder(         r =   innen_gerade_radius,
                          h =   button_hoehe - BADGE_ROUNDED ); 
}

module badge_negativ2() {
    
rotate(     [   0,
              180,    
               -1  ] )
rotate_extrude() {   
    translate( [ innen_gerade_radius-BADGE_ROUNDED,
                 BADGE_ROUNDED*-1 ])
    rotate( [    180,
                 0,
                 270 ] ) 
    union() {
        union() {
            translate( [    BADGE_ROUNDED*-1-1,
                            0 ] )
            square( [       button_hoehe+1,
                            innen_gerade_radius-BADGE_ROUNDED ] );
            
            translate( [    button_hoehe - BADGE_ROUNDED, 
                            BADGE_ROUNDED*-1  ] )
            square( [       button_hoehe - BADGE_ROUNDED+1 ,
                            innen_gerade_radius] );
        }            
    translate( [    button_hoehe - BADGE_ROUNDED, 
                    0 ] )
    circle(         r = BADGE_ROUNDED );
    }
    }
}

module button_gefuellt(radius_x, translate_y, circle_RESOLUTION, rotate_RESOLUTION) {
    rotate_extrude( convexity = 10,
                    $fn       = rotate_RESOLUTION ) {

kreis_translate(    radius_x, 
                    translate_y, 
                    circle_RESOLUTION );
    }   
}


module kreis_translate(radius_x, translate_y, circle_RESOLUTION) {
    
rotate([     180,
               0, 
             270 ] )
translate([   radius_x+(radius_x*-1),
               0,
               0 ] )
    union() {
        translate ( [
                        radius_x*-1,
                        translate_y*-1,
                        0 ] )
        
        square( [   radius_x,
                    translate_y ] );
                    
        
        translate( [
                        0,
                      translate_y*-1,
                        0 ] )
                        
        kreis_ausschnitt(radius_x, circle_RESOLUTION);
        }
}


module kreis_ausschnitt(radius, RESOLUTION) {

AUSSENFLAECHE_RADIUS = radius;
CIRCLE_RESOLUTION    = RESOLUTION;

difference() {
difference() {
    circle(         r   =  AUSSENFLAECHE_RADIUS,
                    $fn =  CIRCLE_RESOLUTION );
   
    translate( [ 
                   (AUSSENFLAECHE_RADIUS+2)*-1,
                   0 ] )
    square( [      (AUSSENFLAECHE_RADIUS+2)*2,
                   (AUSSENFLAECHE_RADIUS+2)*2 ] ) ;
}

    translate( [   0,
                   (AUSSENFLAECHE_RADIUS+2)*-1 ] )
    square( [      (AUSSENFLAECHE_RADIUS+2)*2,
                   (AUSSENFLAECHE_RADIUS+2)*2 ] ) ;
    }
}