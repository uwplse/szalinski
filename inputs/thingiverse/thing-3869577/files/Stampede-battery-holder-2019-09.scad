/*
Hi, this is my simple battery holder for many RC models. 
I made it for my Stampede 2WD in order to use a hardcase 4000mah 3s Batterie (Absima).
Turn it on the side for printing.
Greetings Daniel aka odiworst
*/

z = 2; //thickness (in mm)
x = 60; //width (centre of holes)
y = 10; //depth (in mm)
s = 8; //shift in hight compared with original holder / zero level 
w = 45; //width of cut away
r = 2.9; //radius of holes


difference(){       
        union(){
            translate ([-x/2,-y/2,0])   cube(size = [x,y,z], center = false);            //ground plate
            translate ([-(x-10)/2,-y/2,0])   cube(size = [x-10,y,z+s], center = false);  //upper block
            translate ([x/2,0,0])       cylinder(z,y/2,y/2, center=false, $fn=36);
            translate ([-x/2,0,0])       cylinder(z,y/2,y/2, center=false, $fn=36);
                  }
  ;  
    union(){
        translate ([-x/2,0,0])       cylinder(z,r,r, center=false, $fn=36);     //hole1
        translate ([x/2,0,0])       cylinder(z,r,r, center=false, $fn=36);      //hole2
        translate ([-w/2,-y/2,0])    cube(size = [w,y,s], center = false);     //cut away
  }}
