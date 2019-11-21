// <Sopak's Iphone4s Qi Wireless Charging Holder> (c) by <Kamil Sopko>
// 
// <Sopak's  Iphone4s Qi Wireless Charging Holder> is licensed under a
// Creative Commons Attribution-ShareAlike 4.0 Unported License.
// 
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.

//cubeX is from here http://www.thingiverse.com/thing:112008

use <cubeX.scad>

chargerRadiusTolerance = 0.7;
widthTolerance=2;
heightTolerance=2;

$fn=300;

print();

module print(){
    
    color("green",0.8)translate([0,0,0])ChargerHolder();
    
}

module PhoneInCover(){
    translate([-(62+widthTolerance)/2,-(127+heightTolerance)/2,10])cubeX(size=[(62+widthTolerance),(127+heightTolerance),14],radius=2,rounded=true,$fn=30);
}

module RoundCharger(){
    translate([0,0,1])cylinder(r=36,h=9);
    translate([-15/2,-32-40,0])cube([15,40,13]);
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
