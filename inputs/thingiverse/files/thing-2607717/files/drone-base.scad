module stem()
{
    difference() {
        cylinder( h = 31, d1 = 6, d2 = 5, $fn = 80 );

        // Magnet cutout
        translate( v = [ 0, 0, 29.4 ] ) {
            cylinder( h = 1.7, d = 3.75, $fn = 80 );
        }
    }
}

module base( captured_washer = false )
{
    base_height = 4;
    translate_z = 47;

    difference() {
        // Main base
        translate( v = [ 0, 0, -49.5 ] ) {
            intersection() {
                sphere( d = 100, $fn = 300 );
                translate( v = [ 0, 0, translate_z ])
                    cylinder( h = base_height, d = 27, $fn = 80 );
            }
        }
    }
}

base();
stem();
