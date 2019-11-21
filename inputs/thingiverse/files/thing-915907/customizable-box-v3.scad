/* [Parameters] */
VIEW                    =        "both_opened";  // [ "both_closed": Preview, "both_opened": Open, "print":Print, "top": Single Top, "bottom": Single Bottom]
CHAMBER_DIAMETER        =       40;  // [ 20:20, 25:25, 30:30, 35:35, 40:40, 45:45, 50:50, 55:55, 60:60 ]
BOX_HEIGHT              =       15;  // [ 10:10, 15:15, 20:20, 25:25, 30:30, 35:35, 40:40, 45:45, 50:50 ]
/* [Hidden] */
WALL_LAYER_TIMES        =        6;  // [ 8:8, 16:16]
LAYER_THICKNESS         =        0.2;   // [ 0.1:0.1, 0.2:0.2, 0.3:0.3, 0.4:0.4, 0.5:0.5 ]
RESOLUTION              =       64;
TOLERANCE_LAYER         =        0.5;
wall_thickness_mm       = (WALL_LAYER_TIMES  * LAYER_THICKNESS)*2;
tolerance_mm            = LAYER_THICKNESS  * TOLERANCE_LAYER;
connector               = 7.5 - wall_thickness_mm;
$fn                     = RESOLUTION;

chamber_radius          = CHAMBER_DIAMETER/2;
box_outside             = chamber_radius + wall_thickness_mm;
cap_inside              = box_outside+tolerance_mm;
cap_outside             = cap_inside + wall_thickness_mm;

box_height_inside       = BOX_HEIGHT+connector;
box_height_bottom       = (box_height_inside/100)*61.8;
box_height_top          = box_height_inside-box_height_bottom;


//box3D_modus("bottom");

//box3D("bottom");
box3D_modus(VIEW);
//clip2D("weiblich");
//clip2D("maennlich");

module box3D_modus(modus) {
    if(modus == "top") {
        box3D("top");
    }
    
    if(modus == "bottom") {
        box3D("bottom");
    }
    
    if(modus == "both_closed") {
      translate( [      0,
                        0,
                        box_height_bottom+box_height_top ])
      rotate( [         0,
                      180,
                        0 ] )
      box3D("top");  
      box3D("bottom");
    }    
    
    if(modus == "both_opened") {
      translate( [      0,
                        0,
                        10 ] ) 
      translate( [      0,
                        0,
                        box_height_bottom+box_height_top ])
      rotate( [         0,
                      180,
                        0 ] )
      box3D("top");  
      box3D("bottom");
    }  
        
    if(modus == "print") {

      translate( [      chamber_radius + wall_thickness_mm*2,
                        0,
                        0 ] )
      box3D("top");  
      translate( [     -chamber_radius - wall_thickness_mm*2,
                        0,
                        0 ] )
      box3D("bottom");
    }    
}


module box3D(modus) {
    if(modus == "bottom") { 
                difference() {
                    rotate_extrude() {
                        box2D_wConnector("bottom");
                    }
                  
                    union() {
                      
                      for(i = [0:3]) {  
                          rotate( [  0,
                                     0,
                                     90*i ] ) 
                        translate( [ 0,
                                     0,
                                     box_height_bottom-connector/2 ] )
                        translate( [ 0,
                                     0,
                                     0 ] )
                          
                        mirror([0,1,0])  
                        rotate( [   0,
                                     270,
                                     0 ] )
                        linear_extrude(height = ((chamber_radius*2)+(wall_thickness_mm *2)+0.5)/2) {
                            clip2D("weiblich");
                        }
                    }
                }   
            }
        }  
   if(modus == "top") {
    union() {
       translate( [     0,
                        0,
                        0 ] )
       rotate( [        180,
                        0,
                        0 ] ) 
        translate( [    0,
                        0,
                        -box_height_bottom-box_height_top-connector ] ) 
        rotate_extrude() {
                        box2D_wConnector("top");
                    }
          intersection() {             
          for(i = [0:3]) {  
                          rotate( [  0,
                                     0,
                                     90*i ] ) 
                        translate( [ 0,
                                     0,
                                     box_height_top-connector/2 ] )
                        translate( [ 0,
                                     0,
                                     0 ] )
                          
                        mirror([0,0,0])  
                        rotate( [   0,
                                     270,
                                     0 ] )
                        linear_extrude(height = ((chamber_radius*2)+(wall_thickness_mm *2)+1)/2) {
                            clip2D("maennlich");
                        }           
                    }
            translate( [    0,
                            0, 
                            0.2 ] )          
            difference() {
                cylinder(       r = chamber_radius + wall_thickness_mm - LAYER_THICKNESS , 
                                h = box_height_top + wall_thickness_mm ) ;  
                translate( [    0,
                                0, 
                                0 ] )  
                cylinder(       r = chamber_radius , 
                                h = box_height_top + wall_thickness_mm ) ;    
                                } 
                    
                }
   } 
   }
}
module clip2D(modus) {
    
    toleranz_maennlich = 0;

    if(modus == "weiblich") {
    // WEIBLICH
    polygon( points =  [ [ 0,         0 ],
                         [ connector, 0 ],
                         [ connector, connector*2],
                         [ 0,         connector*3],
                         [ 0,         0 ] ] );  
    }
    
    if(modus == "maennlich") {
    // MAENNLICH
    polygon( points = [  [ 0,         0 ],
                         [ connector,  0 ],
                         [ connector,  connector*2-toleranz_maennlich],
                         [ 0,  connector*1-toleranz_maennlich],
                          
                         [ 0,          0 ] ] );
    }
}


module box2D_wConnector(modus) {
    if(modus == "top") {
        difference() {
            box2D("top");
            
            translate( [            0,
                                    0 ] )
            translate( [            chamber_radius,
                                    box_height_bottom + wall_thickness_mm] )
            square( [                wall_thickness_mm/2,
                                   connector ] );
            }
    }
    
    if(modus == "bottom") {
         difference() {
            box2D("bottom");
            
            translate( [            chamber_radius + wall_thickness_mm/2,
                                    box_height_bottom + wall_thickness_mm  ] )
            translate( [            0,
                                    -connector ] )
            square( [                wall_thickness_mm/2,
                                   connector ] );
            }
    }
}


module box2D(modus) {
      laenge = chamber_radius;     
  rundung = wall_thickness_mm; 
    
    if(modus == "top") {
    union() {
        union() {
            translate( [ 0,
                         box_height_top + 
                         box_height_bottom + 
                         wall_thickness_mm] )
            square([     laenge,
                         wall_thickness_mm ] );
                         
            translate( [ laenge,
                         wall_thickness_mm+box_height_bottom ] )
            square([     wall_thickness_mm,
                         box_height_top ] );
        }

            translate( [ laenge-wall_thickness_mm/2,
                         box_height_top + 
                         box_height_bottom +
                         wall_thickness_mm*2 ] )
            rotate( [   180,
                         0 ] )

            translate( [ -laenge+wall_thickness_mm/2,
                         0 ] )
        union() {
                    translate( [       laenge,
                                       rundung ] ) 
                    rotate( [          180,
                                       0 ] )
                    intersection() {
                        square( [  rundung,
                                   rundung ] );
                        scale( [   1.0, 
                                   1 ] )
                        circle(r = rundung );
                                }
               translate( [        (rundung/10) * 5 ,
                                  -(rundung/10) * 5 ] )
                difference() { 
                    translate( [  laenge-rundung,
                                  rundung ] ) 
                    square( [     rundung,
                                  rundung ] );  
                      
                    translate( [  laenge-rundung,
                                  rundung*2 ] ) 
                    rotate( [     180,
                                    0 ] )
                    intersection() {
                        square( [  rundung,
                                   rundung ] );
                        scale( [   0.5, 
                                   0.5 ] ) 
                        circle(r = rundung );
                    };      
                }                                         
        }
    }
} if(modus == "bottom") {     
    
    union() {              
        translate( [  (rundung/10) * 5 ,
                     -(rundung/10) * 5 ] )
        difference() { 
            translate( [  laenge-rundung,
                          rundung ] ) 
            square( [     rundung,
                          rundung ] );  
              
            translate( [  laenge-rundung,
                          rundung*2 ] ) 
            rotate( [     180,
                            0 ] )
            intersection() {
                square( [  rundung,
                           rundung ] );
                scale([0.5, 0.5])
                circle(r = rundung );
            };      
        }               
          translate([   laenge,
                        rundung ])
          square( [ wall_thickness_mm,
                    box_height_bottom] );
          
          
            square( [     laenge,
                        rundung ] ) ;                     
            translate( [       laenge,
                               rundung ] ) 
            rotate( [          180,
                               0 ] )
            intersection() {
                square( [  rundung,
                           rundung ] );
                scale([1.0, 1])
                circle(r = rundung );
                        }
            }
        }
}


