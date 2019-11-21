// <Sopak's Multimeter Wall Holder> (c) by <Kamil Sopko>
// 
// <Sopak's Multimeter Wall Holder> is licensed under a
// Creative Commons Attribution-ShareAlike 4.0 Unported License.
// 
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.



/* [Main Dimensions] */

//width of device
width=84;
//height of holder withot bottom(wallWidth)
height=70;
//depth of device to slide properly
depth=45;

/* [Other Dimensions] */

//back width/distance from wall  for placing probes etc
backWidth=16;
//with of wall, bottom and front
wallWidth=4.5;
//diametter of screw (screw head is  double)
screwDiameter=4;

/* [Other Values] */

//just  for cleaner boolean  operations
tolerance=0.1;
//quality
$fn=30;



//cubeX is from here http://www.thingiverse.com/thing:112008

// Include here  for customizer compatibility
//
// Simple and fast corned cube!
// Anaximandro de Godinho.
//

module cubeX( size, radius=1, rounded=true, center=false )
{
	l = len( size );
	if( l == undef )
		_cubeX( size, size, size, radius, rounded, center );
	else
		_cubeX( size[0], size[1], size[2], radius, rounded, center );
}

module _cubeX( x, y, z, r, rounded, center )
{
	if( rounded )
		if( center )
			translate( [-x/2, -y/2, -z/2] )
			__cubeX( x, y, z, r );
		else
			__cubeX( x, y, z, r );
	else
		cube( [x, y, z], center );
}

module __cubeX(	x, y, z, r )
{
	//TODO: discount r.
	rC = r;
	hull()
	{
		translate( [rC, rC, rC] )
			sphere( r );
		translate( [rC, y-rC, rC] )
			sphere( r );
		translate( [rC, rC, z-rC] )
			sphere( r );
		translate( [rC, y-rC, z-rC] )
			sphere( r );

		translate( [x-rC, rC, rC] )
			sphere( r );
		translate( [x-rC, y-rC, rC] )
			sphere( r );
		translate( [x-rC, rC, z-rC] )
			sphere( r );
		translate( [x-rC, y-rC, z-rC] )
			sphere( r );
	}
}

// end of cubeX customizer compatibility

// holder itself

difference(){
    cubeX([width+2*wallWidth,depth+wallWidth+backWidth,height+wallWidth]);
    translate([wallWidth,backWidth,wallWidth+tolerance]){
        cubeX([width,depth,height]);
        translate([2*wallWidth,wallWidth*2,2*wallWidth])cubeX([width-4*wallWidth,depth,height]);
    }
    for(z=[20:20:height-10]){
        for(x=[-20:10:20]){
            translate([(width+2*wallWidth)/2+x,-tolerance,z])rotate([-90,0,0]){
                cylinder(d=screwDiameter,h=backWidth+2*tolerance);
                translate([0,0,backWidth-screwDiameter/1.5+2*tolerance-wallWidth])cylinder(d1=screwDiameter,d2=screwDiameter*2,h=screwDiameter/1.5);
                translate([0,0,backWidth-wallWidth+2*tolerance])cylinder(d=screwDiameter*2,h=wallWidth*2);
            }
        }
    }
}

