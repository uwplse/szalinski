// <Sopak's Iphone4s Qi Wireless Charging Angled Holder> (c) by <Kamil Sopko>
// 
// <Sopak's  Iphone4s Qi Wireless Charging Angled Holder> is licensed under a
// Creative Commons Attribution-ShareAlike 4.0 Unported License.
// 
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.

chargerRadiusTolerance = 0.7;
widthTolerance=2;
heightTolerance=2;

$fn=300;

print();

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

module print(){        
    
    color("green",0.8)translate([0,0,0]){

        Holder();

        Stand();

    }
}

module Stand(){
    translate([-65/2,0,0])cubeX(size=[65,80,4],radius=2,rounded=true,$fn=30);
    difference(){
        rotate(a=-90+20, v=[1,0,0]){                    
            translate([-65/2,-50,56])cubeX(size=[6,70.5,8],radius=2,rounded=true,$fn=30);            
            translate([65/2-6,-50,56])cubeX(size=[6,70.5,8],radius=2,rounded=true,$fn=30);
            translate([7,-50,56])cubeX(size=[6,70.5,8],radius=2,rounded=true,$fn=30);
            translate([-7-6,-50,56])cubeX(size=[6,70.5,8],radius=2,rounded=true,$fn=30);            
        }
        rotate(a=55, v=[1,0,0]){
            translate([0,131/2,-1])RoundCharger();
        }
    }
}

module Holder(){
    rotate(a=55, v=[1,0,0]){
        translate([0,131/2,0]){
            difference(){
                ChargerHolder();
                translate([-50,38,-50])cube([100,100,100]);
            }
        }
    }
}    

module PhoneInCover(){
    translate([-(62+widthTolerance)/2,-(127+heightTolerance)/2,10])cubeX(size=[(62+widthTolerance),(127+heightTolerance),14],radius=2,rounded=true,$fn=30);
}

module RoundCharger(){
    translate([0,0,1])cylinder(r=36+chargerRadiusTolerance,h=9);
    translate([-15/2,-32-30,-3])cube([15,30,11]);    
    translate([-15/2,-32-30+15,-3])cube([15,15,12]);    
    translate([-15/2,-32-30+5,-3])cube([15,30,20]);    
}


module ChargerHolder(){
    difference(){
        union(){
            translate([0,0,-1])cylinder(r=39+chargerRadiusTolerance,h=12);
            translate([-(65+widthTolerance)/2,-(131+heightTolerance)/2,-1])cubeX(size=[65+widthTolerance,131+heightTolerance,23],radius=2,rounded=true,$fn=30);
            
        }
        translate([-53/2,-(131+heightTolerance)/2,10])cubeX(size=[53,131,14],radius=2,rounded=true,$fn=30);
        translate([0,0,0])RoundCharger();
        cylinder(r=36+chargerRadiusTolerance,h=30);
        PhoneInCover();
    }
}
