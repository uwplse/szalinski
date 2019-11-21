//
//  Parameterized handle for bit-holders.
//
//  This is a remix of
//      https://www.thingiverse.com/thing:3753399
//
//  The code is now a bit more readable and the customizer
//  interface is slightly brushed up.
//
//  Also, the socket hole for the bit-holder can now be made
//  deeper without changing the shape of the handle.
//
//  $Id: Bitholder_Handle.scad,v 1.4 2019/10/21 14:11:12 tneuer Exp tneuer $
//
//  $Log: Bitholder_Handle.scad,v $
//  Revision 1.4  2019/10/21 14:11:12  tneuer
//  Made nozzle length of grip a configurable item.
//
//  Revision 1.3  2019/10/21 12:18:35  tneuer
//  Bugfix: Socket hole was misplaced.
//
//  Revision 1.2  2019/10/21 09:12:41  tneuer
//  Added assertions for parameter values.
//
//  Revision 1.1  2019/10/18 17:32:53  tneuer
//  Initial revision
//
//

/* [ Handle ] */
// Length of grip
GripLength   = 80;
// Thickness of grip
GripDiameter = 25;
// Length of nozzle
GripNozzleLength = 20;

/* [ Bitholder Socket ] */
// Diameter of hex-part of bit holder
BitDiameter = 7.5;
// Length of hex-part of bit holder
BitLength   = 29;

/* [ Optional Stuff for Testing ] */
// Actually make the handle or just check that the socket will fit ?
MakeHandle = 1; // [0:false, 1:true]

/* [Hidden] */
$fn=50;

Delta = 0.5;    // snug fit but not too tight


module socket_hole( socket_diameter, socket_depth ) {
    cylinder( d = socket_diameter, h = socket_depth, center = false, $fn = 6 );
}

module rim( diameter, thickness ) {
    rotate_extrude( convexity = 10 )
        translate( [diameter/2-thickness/2, 0, 0] )
            circle( d = thickness );
}

module handle( diameter, length, socket_diameter, socket_depth ) {
    difference() {
        union() {
            cylinder( d1 = diameter, d2 = 14, h = GripNozzleLength );
            rim( diameter, 4 );
            translate([0, 0, -length])
                difference() {
                    cylinder( d = diameter, h = length, center = false );
                    for( i=[0:30:360] ) {
                        rotate( [0, 0, i] )
                            translate( [diameter/2+1.5, 0, 0] )
                                cylinder( d = 5, h = length, center = false );
                    }
                }
            translate( [0, 0, -length] )
                rim( diameter, 8 );
        }
        translate( [ 0, 0, GripNozzleLength-socket_depth ] )
            socket_hole( socket_diameter+Delta, socket_depth );
    }
}


assert( BitDiameter < 13,
        "BitDiameter is too large." );
assert( BitLength < GripLength,
        "BitLength must be smaller than GripLength." );

if( MakeHandle ) {
    handle( GripDiameter, GripLength, BitDiameter, BitLength );
} else {
    difference() {
        cylinder( d = 14, h = 2 );
        socket_hole( BitDiameter+Delta, 2 );
    }
}
