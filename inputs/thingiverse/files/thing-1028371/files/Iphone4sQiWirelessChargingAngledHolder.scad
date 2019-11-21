// <Sopak's Iphone4s Qi Wireless Charging Angled Holder> (c) by <Kamil Sopko>
// 
// <Sopak's  Iphone4s Qi Wireless Charging Angled Holder> is licensed under a
// Creative Commons Attribution-ShareAlike 4.0 Unported License.
// 
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.

//cubeX is from here http://www.thingiverse.com/thing:112008

use <cubeX.scad>

$fn=300;

print();

module print(){        
    
    color("green",0.8)translate([0,0,0]){

        Holder();

        Stand();

    }
}

module Stand(){
    translate([-65/2,0,0])cubeX(size=[65,80,4],radius=2,rounded=true,$fn=30);
    rotate(a=-90+20, v=[1,0,0]){
        translate([-65/2,-40,56])cubeX(size=[4,60,4],radius=2,rounded=true,$fn=30);
        translate([65/2-4,-40,56])cubeX(size=[4,60,4],radius=2,rounded=true,$fn=30);
        translate([-2+10,-40,56])cubeX(size=[4,60,4],radius=2,rounded=true,$fn=30);
        translate([-2-10,-40,56])cubeX(size=[4,60,4],radius=2,rounded=true,$fn=30);
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
    translate([-62/2,-127/2,10])cubeX(size=[62,127,14],radius=2,rounded=true,$fn=30);
}

module RoundCharger(){
    translate([0,0,1])cylinder(r=36,h=9);
    translate([-15/2,-32-30,-3])cube([15,30,11]);    
    translate([-15/2,-32-30+15,-3])cube([15,15,12]);    
    translate([-15/2,-32-30+20,-3])cube([15,10,20]);    
}


module ChargerHolder(){
    difference(){
        union(){
            translate([0,0,-1])cylinder(r=39,h=12);
            translate([-65/2,-131/2,-1])cubeX(size=[65,131,23],radius=2,rounded=true,$fn=30);
            
        }
        translate([-53/2,-131/2,10])cubeX(size=[53,131,14],radius=2,rounded=true,$fn=30);
        translate([0,0,0])RoundCharger();
        cylinder(r=36,h=30);
        PhoneInCover();
    }
}
