$fn=50;

size = [ 100, 150, 50 ];
wall = [ 4, 4, 2 ];

wire_size = [ 7, 3 ];
wire_space = 7;
wires = 14;

difference()
{
    intersection()
    {
        difference(){
            cube( size );
            translate([ wall[ 0 ] / 2, wall[ 1 ] / 2, wall[ 2 ]+0.01 ])
                cube( size - wall );
        }
    }
    for( i = [1:1:wires] )
    {
        translate([ wall[ 0 ], i * ( wire_size[ 1 ] + wire_space), -wall[ 2 ] / 2 ])
            cube([ wire_size[ 0 ], wire_size[ 1 ], wall[ 2 ]*2 ]);
    }
}
