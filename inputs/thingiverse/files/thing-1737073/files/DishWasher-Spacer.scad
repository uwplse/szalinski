/*
// dgazineu@gmail.com (Douglas Gazineu)
// Rev1: 2016-08-25 :: Initial Release
//
*/

/* [General Options] */
Length=40;//[35:55]
Height=9;
Width=18; //[14:30]
Hanging_Hole=1; //[0:No,1:Yes]
Hanging_Hole_Diameter=8;

module spacer(){
    $fn=20;   
    difference(){
        fitting(Height);
        union(){
            if (Hanging_Hole ==1 ) cylinder( h = 2*Height, d = Hanging_Hole_Diameter, center=true);
            translate([-Length+8,0,0]) scale([1,1.2,1]) difference(){
                fitting(2*Height);
            }
        }
    }
}

module fitting(Height){
    $fn=20;
    difference(){
        hull(){
            translate([-Length/2, -Width/2, -Height/2]) cube([Length/3, Width, Height]);
            translate([Length/2, 0, 0]) scale([1.25,1,1]) cylinder( h = Height, d = 6, center=true);
        }
        union(){
            translate([Length/2-3, Width/2+(10-Width/2), 0]) scale([1,1.35,1])cylinder( h = 2*Height, d = 13, center=true);
            translate([Length/2-3, -Width/2-(10-Width/2), 0]) scale([1,1.35,1])cylinder( h = 2*Height, d = 13, center=true);
        }
    } 
}
module view(){
   spacer();
}

view();
