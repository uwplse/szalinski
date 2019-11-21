/* [Piece Dimensions] */
//of piece (mm)
Height = 2; //[1:10]
//of piece (mm)
Diameter = 30; //[5:50]
radius = Diameter/2;
extra = 1.02; //[0.96, 0.97, 0.98, 0.99, 1.00, 1.01, 1.02, 1.03, 1.04, 1.05]
interRowDistance = sin(60) * extra;

/* [Grid Size] */
Rows = 4; //[1:20]
oddRows = ( Rows % 2 );
rowStart = -1 * ceil ( ( Rows - oddRows ) / 2 ) + ( 1 - oddRows);
rowEnd   =      floor( ( Rows - oddRows ) / 2 );

Cols = 5; //[1:20]
oddCols = ( Cols % 2 );
colStart = -1 * ceil ( ( Cols - oddCols ) / 2 ) + ( 1 - oddCols);
colEnd   =      floor( ( Cols - oddCols ) / 2 );

colSpace = extra * Diameter;
rowSpace = colSpace  * sin(60);

main();

module main() {
	xExtent = Diameter + ( Cols - 1 ) * colSpace;
    yExtent = Diameter + ( Rows - 1 ) * rowSpace;
    echo("Extent of grid: Y: ", yExtent, " X: ", xExtent);
	union() {
		for ( row = [ rowStart : rowEnd ] ) {
			for ( col = [ colStart : ( colEnd - abs(row % 2) ) ] ) {
				translate(v=[ ( col + ( abs(row % 2) - ( 1 - oddCols ) ) / 2 ) * colSpace,
                               ( row                  - ( 1 - oddRows )   / 2 ) * rowSpace,
                               0 ]
				)
				{
					cylinder(h = Height, r = radius);
				}
			}
		}
	}
}
  