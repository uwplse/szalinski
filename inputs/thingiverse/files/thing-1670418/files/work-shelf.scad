////MY work shelf

/////////////////////////////////////////////////////
//////////////////// PARAMETERS  ////////////////////
/////////////////////////////////////////////////////

height = 18;    //material thickness
ply_h = 2;      //ply thickness (for paneling)
ply_l = 600;    //ply length (for paneling)

top_shelf_xtra_height = 100;

length = 200;   //depth of shelf
w1 = 900;       // outside width1
w2 = 600;       // outside width2

middle_support_width1=100;
middle_support_width2=50;
num_selves = 2;
shelf_height = 200;

actual_shelf_height = shelf_height - height;

W = 1200;       //4 feet sheet, square
/////////////////////////////////////////////////////
/////////////////////// RENDER  /////////////////////
/////////////////////////////////////////////////////

//side_support();
//single_shelf();

//complete assembly of the bench
full_assembly();

//square([W, W]); //4 feetx 4 feet square

//uncomment below and render, then export/save as dxf file for routing
//projection(cut=false) dxf_assembly();

/////////////////////////////////////////////////////
/////////////////////// Module  /////////////////////
/////////////////////////////////////////////////////

// dxf assembly perfectly fits a 3 feet by 2 feet bench, 
// 20 cms deep 2 shelf into a 4 feet x 4 feet
// mdf/ply board

module dxf_assembly() {
    
    union() {
        translate( [0, length, 0] ) rotate( [0,0,270] ) single_shelf();
        translate( [1.2*length + 0, 1.2*length + length, 0] ) rotate( [0,0,270] ) single_shelf();
        translate( [2.4*length + 0, 1.4*length + length, 0] ) side_support();
        translate( [3.6*length + 0, 1.4*length + length, 0] ) side_support();
        for( i = [0 : 1 : 4] )
            translate( [4.8*length + 0, 1.4*length + length + i*1.5*middle_support_width1, 0] ) middle_support(middle_support_width1);
        for( i = [0 : 1 : 1] )
            translate( [4.8*length + 0, 0*length + 0*length + i*1.2*middle_support_width1, 0] ) middle_support(middle_support_width1);
        for( i = [0 : 1 : 2] )
            translate( [0, 2.4*length + length + i*1.5*middle_support_width1, 0] ) middle_support(middle_support_width1);
        for( i = [0 : 1 : 3] )
            translate( [1.2*length, 3.6*length + length + i*1.5*middle_support_width2, 0] ) middle_support(middle_support_width2);
    }
}

//assembly of the whole bench
module full_assembly() {
    
    union() {
        rotate( [90, 0, 0] ) side_support();
        for( i = [ shelf_height : shelf_height : shelf_height*num_selves ] )
        {
            rotate( [0, 0, 180] ) translate( [-length, -w1, i - height] ) single_shelf();  
        }
        translate( [w1 - 1.5*length, w2 + length/2, 0] ) rotate( [90, 0, 90] ) side_support();
        
        for( n = [0 : 1 : num_selves - 1] )
        {   
            translate( [0,0,n*shelf_height] ) {
                for(j = [0 : w1/3 : w1 - 1] )
                    translate([ height, j, 0 ]) rotate( [90, -90, -90] ) middle_support(middle_support_width1);
                for(j = [0 : w2/2 : w2 - 1] )
                    translate( [w2 - j, w1, 0] ) rotate( [90, -90, 0] ) middle_support(middle_support_width1);
                
                #translate([ length, w1/2, 0 ]) rotate( [90, -90, -90] ) middle_support(middle_support_width2);
                #translate([ w2/2, w1 - length + height, 0 ]) rotate( [90, -90, 0] ) middle_support(middle_support_width2);
            }  
        }
        #translate( [0, -height, 0] ) rotate( [0,-90,0] ) cube( [ply_l, w1 + height, ply_h] );
        
        #translate( [w2 + height, w1, 0] ) rotate( [0,-90,90] ) cube( [ply_l, w2 + height, ply_h] );
    }
}

//a single shelf
module single_shelf(peg = true) {
    difference() {
        union() {
            plank_withNotches(length, height, w1);
            translate( [ length, 0 , 0] ) rotate( [ 0, 0, 90] ) plank_withNotches(length, height, w2);     
        }
        if( peg )
        {
            translate( [ 0, length - 10 , 0] )
                for(i = [ 25.4 : 25.4 : 60 ] )
                    for(j = [ 25.4 : 25.4 : w1 - length] )
                        translate( [i, j, 0] ) cylinder( r = 25.4 / 8, h = height );
            translate( [ -w2  +20 , length - 3*25.4 , 0] )
                for(i = [ length : 25.4 : w2 ] )
                    for(j = [ 25.4 : 25.4 : 60] )
                        translate( [i, j, 0] ) cylinder( r = 25.4 / 8, h = height );    
        }
    }
}

//partial self
module plank_withNotches(l, h, w) {
    union() {
        cube( [ l, w, h], false );
        //notches
        translate( [l/3 - h/2, w - h, 0] ) cube( [h, 2*h, h], false );
        translate( [2*l/3 - h/2, w - h, 0] ) cube( [h, 2*h, h], false );   
    }
}

//side supports of the bench
module side_support(peg = true) {
    difference() {
        cube( [length, top_shelf_xtra_height + shelf_height*( 1 + num_selves), height] );
        for( i = [ shelf_height : shelf_height : shelf_height*num_selves ] )
        {
            translate( [length/3 - height/2, i - height, 0] ) cube( [height, height, height], false );
            translate( [2*length/3 - height/2, i - height, 0] ) cube( [height, height, height], false ); 
        }
        if( peg )
        {
            for(n = [ 0 : 1 : num_selves - 1] )              
                translate( [0, n*shelf_height, 0] ) 
                    for(i = [ 25.4 : 25.4 : length ] )
                            for(j = [ 25.4 : 25.4 : shelf_height - 30] )
                                translate( [i, j, 0] ) cylinder( r = 25.4 / 8, h = height );
            
            translate( [0, num_selves*shelf_height, 0] ) 
                for(i = [ 25.4 : 25.4 : length ] )
                    for(j = [ 25.4 : 25.4 : top_shelf_xtra_height + shelf_height - 30] )
                        translate( [i, j, 0] ) cylinder( r = 25.4 / 8, h = height );    
        }
    }
}

// Small boards used to distribute the shelves weight
// along the front/back edge
module middle_support(w) {
    cube( [actual_shelf_height, w, height ], false );
}