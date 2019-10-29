
$fn = 50;
lens_dia = 93.5; //89.4;
lens_thick = 3.75;


border_thick = 2;
border_height = 15;

handle_len = 90;

hs = 3.0; // hole size 

bevel_sz = 3;

module handle() {
    rotate( [ 90, 0, 0 ] ) {
        translate( [ 0, 0, lens_dia ] ) {
            cube( [ border_height, border_height, handle_len ], center = true);
        }
    }
}

module handle_bevel() {
    rotate( [ 90, 0, 0 ] ) {
        translate( [ -border_height/2, border_height/2, lens_dia ] )
            rotate( [ 0, 0, 45 ] )  cube( [ bevel_sz, bevel_sz, handle_len ], center = true);
        translate( [ border_height/2, border_height/2, lens_dia ] )
            rotate( [ 0, 0, 45 ] )  cube( [ bevel_sz, bevel_sz, handle_len ], center = true);
        translate( [ -border_height/2, -border_height/2, lens_dia ] )
            rotate( [ 0, 0, 45 ] )  cube( [ bevel_sz, bevel_sz, handle_len ], center = true);
        translate( [ border_height/2, -border_height/2, lens_dia ] )
            rotate( [ 0, 0, 45 ] )  cube( [ bevel_sz, bevel_sz, handle_len ], center = true);
    } 
}

module base() {
    difference() {
        handle();
        handle_bevel();
    }
    difference() {
        difference() {
            cylinder( h = lens_thick + 2 * border_thick, d = lens_dia, center = true );
            cylinder( h = lens_thick + 2 * border_thick, d = lens_dia-5, center = true );
        }
        cylinder( h = lens_thick , d = lens_dia, center = true );
    }

    difference() {
        cylinder( h = border_height, d = lens_dia + 2* border_thick, center = true);
        cylinder( h = border_height, d = lens_dia, center = true );
    }
}

module base_split() {   
    difference() {
        base();
        rotate( [ 90, 0, 0 ] ) {
            translate( [ 0, 0, lens_dia ] ) {
                cube( [ 0.5, border_height + 4, handle_len+6 ], center = true );
            }
        }
    }
}

module holes() {
    rotate( [ 90, 0, 0 ] ) {
        translate( [ 0, 0, lens_dia ] ) {
            translate( [ 0, 0, -30 ] ) rotate( [ 0, 90, 0 ] ) cylinder( h = border_height, d = hs, center = true );
            translate( [ border_height/2-2.5, 0, -30 ] ) rotate( [ 0, 90, 0 ] ) cylinder( h = 2.5, d = 6, center = false );
            translate( [ -border_height/2, 0, -30 ] ) rotate( [ 0, 90, 0 ] ) cylinder( h = 2.5, d = 6, center = false );
            
            translate( [ 0, 0, 30 ] ) rotate( [ 0, 90, 0 ] ) cylinder( h = border_height, d = hs, center = true );
            translate( [ border_height/2-2.5, 0, 30 ] ) rotate( [ 0, 90, 0 ] ) cylinder( h = 2.5, d = 6, center = false );
            translate( [ -border_height/2, 0, 30 ] ) rotate( [ 0, 90, 0 ] ) cylinder( h = 2.5, d = 6, center = false );
            
            translate( [ 0, 0, 0 ] ) rotate( [ 0, 90, 0 ] ) cylinder( h = border_height, d = hs, center = true );
            translate( [ border_height/2-2.5, 0, 0 ] ) rotate( [ 0, 90, 0 ] ) cylinder( h = 2.5, d = 6, center = false );
            translate( [ -border_height/2, 0, 0 ] ) rotate( [ 0, 90, 0 ] ) cylinder( h = 2.5, d = 6, center = false );
        }
    }
}


difference() {
    base_split();
    holes();
}
