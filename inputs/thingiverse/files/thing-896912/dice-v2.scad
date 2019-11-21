RESOLUTION                          = 64 ;      // [ 8,16,32,64,128,256]
SQUARE_LENGTH                       = 20.00 ;   // [ 10:100]

LAYER_THICKNESS                     =  0.2 ;   // [ 0.1:0.5]
WALL_THICKNESS_IN_LAYER             =  6 ;      // [ 1:20]

SPHERE_DIA_IN_PERCENTAGE            =  4.0;       // [ 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7 ]

//-----------------------------------------------------
$fn                         = RESOLUTION;
KUGEL_RADIUS                = (SQUARE_LENGTH*SPHERE_DIA_IN_PERCENTAGE)/100;
wandstaerke_mm              = LAYER_THICKNESS * WALL_THICKNESS_IN_LAYER;
echo(wandstaerke_mm);
wuerfel_komplett            = SQUARE_LENGTH + wandstaerke_mm *2;
kugel_komplett_radius       = KUGEL_RADIUS + wandstaerke_mm;
//-----------------------------------------------------

wuerfel_komplett();

module wuerfel_komplett() {
        difference() {
        difference() {
            wuerfel_difference();
            numbers_negativ();
        }
    translate( [    0,
                    0,
                    0 ] )
    union() {
        union() {
            translate( [    0,
                            0,
                            (SQUARE_LENGTH /2)*-1 ] )   
            cylinder(       r = KUGEL_RADIUS+wandstaerke_mm/2, 
                            h = SQUARE_LENGTH );
            rotate( [      90,
                            0,
                            0 ] ) 
            translate( [    0,
                            0,
                            (SQUARE_LENGTH /2)*-1 ] )    
            cylinder(       r = KUGEL_RADIUS+wandstaerke_mm/2, 
                            h = SQUARE_LENGTH );
        }
        
    rotate( [      0,
                   90,
                    0 ] ) 
    translate( [    0,
                    0,
                    (SQUARE_LENGTH /2)*-1 ] )    
    cylinder(    r = KUGEL_RADIUS+wandstaerke_mm/2, 
             h = SQUARE_LENGTH  );   
}
}
    
}



module numbers_negativ() {
    laenge = wuerfel_komplett/2; 
    //%cube(laenge); 
    x = laenge ; 
    y = laenge ; 
    z = laenge ;

    length = sqrt( pow(x, 2) + pow(y, 2) + pow(z, 2) );
    b = acos(z/length);
    c = (x==0) ? sign(y)*90 : ( (x>0) ? atan(y/x) : atan(y/x)+180 ); 

    sphere(kugel_komplett_radius+wandstaerke_mm*0.5);
    /*    
    rotate([    0, 
                b, 
                c ] ) 
    cylinder(   h = length, 
                r = 0.25);
    */
     for(i = [ [  laenge*0.35,  laenge*0.35,  laenge*0.35 ],
               [  laenge*0.65,  laenge*0.65,  laenge*0.65 ], 
               [  (laenge*0.35)*-1,  (laenge*0.35),  (laenge*0.35) ],
               [  (laenge*0.65)*-1,  (laenge*0.65),  (laenge*0.65) ],
               [  (laenge*0.35)*-1,  (laenge*0.35),  (laenge*0.35)*-1 ]  ] ) {
    translate(i)
    sphere(     r = kugel_komplett_radius );
}

        
}


module wuerfel_difference() {
   difference() {
        cube(  [ wuerfel_komplett-0.2,
                 wuerfel_komplett-0.2, 
                 wuerfel_komplett-0.2 ], center = true );
        mirrorSeite(); 
   }
}


module mirrorSeite() {
       
seite();
mirror( [ 0, 1, 0 ] ) seite(); 
mirror( [ 1, 1, 0 ] ) seite();
mirror( [ 1, 0, 0 ] ) mirror( [ 1, 1, 0 ] ) seite();   
mirror( [ 1, 0, 1 ] ) mirror( [ 1, 0, 0 ] ) mirror( [ 1, 1, 0 ] ) seite();
mirror( [ 0, 0, 1 ] ) mirror( [ 1, 0, 1 ] ) mirror( [ 1, 0, 0 ] ) mirror( [ 1, 1, 0 ] ) seite();
}



module seite_hilfe() {
    for(i = [0:len(punkte)-1]) {
        translate(punkte[i])
        sphere(0.1);   
        //translate(punkte[i])
        //text(str(i), size = 1);   
    }  
}



module seite() {
    
punkte  = [        [ -SQUARE_LENGTH/2, SQUARE_LENGTH/2, -SQUARE_LENGTH/2 ],
                   [  SQUARE_LENGTH/2, SQUARE_LENGTH/2, -SQUARE_LENGTH/2 ],
                   [ -SQUARE_LENGTH/2, SQUARE_LENGTH/2,  SQUARE_LENGTH/2],
                   [ SQUARE_LENGTH/2, SQUARE_LENGTH/2,  SQUARE_LENGTH/2],
                   [ 0, 0 ] ];  
    
translate(    [   0,
                  wandstaerke_mm,
                  0 ] )
    
polyhedron(       points = punkte, 
                  faces  = [ [ 0, 1, 2 ], 
                             [ 1, 3, 2 ],
                             [ 2, 3, 4 ],
                             [ 3, 1, 4 ],
                             [ 0, 4, 1 ],
                             [ 2, 4, 0 ] ] ) ;
} 