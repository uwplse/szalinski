// number of fragments
fn = 128;//[4:2:128]
//shaft diameter
d = 80;
//total height
h = 100;
//shaft thickness
t = 1.6;//[0.8:3]
//bottom thickness
tbottom = 2;
//torus diameter factor (multiplicator for shaft thickness)
xf = 2;
//count of secondary toruses
n = 0;
 
union(){
    difference(){
        union(){
            translate([0,0,0]) cylinder(h = h-xf*t/2, d = d, center = false, $fn = fn);
            if (n>0){
            for (a =[0:1:n]){
                translate([0,0,h-xf*t/2 - (h-xf*t)/n*a]) rotate_extrude(convexity = 10, $fn = fn) translate([(d-t)/2, 0, 0]) circle(r = xf*t/2, $fn = 16);
            }
        }
        }
            translate([0,0,tbottom]) cylinder(h = h-xf*t/2, d = d - 2*t, center = false, $fn=fn);}
        
 translate([0,0,h-xf*t/2]) rotate_extrude(convexity = 10, $fn = fn) translate([(d-t)/2, 0, 0]) circle(r = xf*t/2, $fn = 16);
    }