/*[Lego Block Setting]*/

//Number for Dot(X)
dot_x=5;// [2:15]

//Number for Dot(Y)
dot_y=2;// [2:15]

//Lego Height
BH=9.6;//  [3.2,9.6]

/* [HIDDEN] */
P=8;    //[8]
C=4.8;  //[4.8]
H2=1.8; //[1.8]
K=0.2;  //[0.2]
SW=1.2; //[1.2]
TW=1;   //[1]

OC=(P-K/2)/2;

color ("Red")
union(){
    difference(){
        union(){
            cube([(P*dot_x)-K,(P*dot_y)-K,BH]);
            for(sy = [0 : 1 : dot_y-1]){
                for(sx = [0 : 1 : dot_x-1]){
                    translate([OC+P*sx,OC+P*sy,BH])
                    cylinder (h=H2, d=C,, $fn=50);
                }
            }
            
        }
        translate([SW,SW,0-TW])
        cube([(P*dot_x)-K-SW*2,(P*dot_y)-K-SW*2,BH]);        
    }
    for(sx = [0 : 1 : dot_x-TW]){
        translate([3.6+P*sx,SW,0])
        cube([0.6,0.3,BH-1]);
        translate([3.6+8*sx,(8*dot_y)-0.2-1.2-0.3,0])
        cube([0.6,0.3,BH-1]);
    }
    for(sy = [0 : 1 : dot_y-TW]){
        translate([1.2,3.6+8*sy,0])
        cube([0.3,0.6,BH-1]);
        translate([(8*dot_x)-0.2-1.2-0.3,3.6+8*sy,0])
        cube([0.3,0.6,BH-1]);
    }
    
    for(sy = [0 : 1 : dot_y-2]){
        for(sx = [0 : 1 : dot_x-2]){
            difference(){
                translate([7.9+8*sx,7.9+8*sy,0])
                cylinder (BH-TW, d=6.51,true, $fn=50);
                translate([7.9+8*sx,7.9+8*sy,-1])
                cylinder (BH-TW, d=4.8,true, $fn=50);            
            }
        }
    }
}