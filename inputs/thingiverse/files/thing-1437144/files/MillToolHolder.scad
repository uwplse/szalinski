// <Sopak's Mill Tool Holder> (c) by <Kamil Sopko>
// 
// <Sopak's Mill Tool Holder> is licensed under a
// Creative Commons Attribution-ShareAlike 4.0 Unported License.
// 
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.



/* [Main Dimensions] */

//width of device
width=150;
//height of step
heightOfStep=15;
//depth of device to slide properly
depthOfStep=12;
//numbero of steps
numberOfSteps=4;
//distance between tools
numberOfTools=10;
//diameter of  tools
toolDiameter=3.175;
//depth of tool  hole
toolDepth=13;
/* [Other Values] */

//just  for cleaner boolean  operations
tolerance=0.1;
//tolerance for tool diameter
toolDiameterTolerance=0.3;
//diametter of screw (screw head is  2.2*)
screwDiameter=4;
//screw  every  X each
screwEachTool=4;
//screw every each  step
screwEachStep=1;
//quality
$fn=30;

//calculations
step=(width)/(numberOfTools);


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
    union(){
        for(i=[0:numberOfSteps-1]){
            translate([0,(depthOfStep-tolerance)*i,0])cubeX([width,depthOfStep,heightOfStep*(i+1)]);    
        }
    }
    
    for(i=[0:numberOfSteps-1]){        
        for(x=[step/2:step:(width)]){
            translate([x,(depthOfStep-tolerance)*i+depthOfStep/2,(heightOfStep*(i+1))+tolerance-toolDepth])cylinder(d=toolDiameter+toolDiameterTolerance,h=toolDepth);
            translate([x,(depthOfStep-tolerance)*i+depthOfStep/2,(heightOfStep*(i+1))+tolerance-toolDiameter])cylinder(d2=toolDiameter*1.5,d1=toolDiameter+toolDiameterTolerance,h=toolDiameter);
            translate([x,(depthOfStep-tolerance)*i+depthOfStep/2,(heightOfStep*(i+1))+tolerance-toolDiameter/2])cylinder(d2=toolDiameter*2,d1=toolDiameter,h=toolDiameter/2);
        }
    }

    for(i=[0:screwEachStep:numberOfSteps-1]){        
        for(x=[step:step*screwEachTool:(width-step)]){
            rotate([-90,0,0]){
                translate([x,-heightOfStep/2-heightOfStep*i,(depthOfStep-2*tolerance)*i])cylinder(d=screwDiameter,h=depthOfStep*numberOfSteps);
                translate([x,-heightOfStep/2-heightOfStep*i,(depthOfStep-2*tolerance)*i])cylinder(d=screwDiameter*2.2,h=depthOfStep*(numberOfSteps-i-1));
                translate([x,-heightOfStep/2-heightOfStep*i,(depthOfStep-2*tolerance)*(numberOfSteps-1)])cylinder(d1=screwDiameter*2.2,d2=screwDiameter*1,h=screwDiameter);
            }
        }
    }    
    
}

