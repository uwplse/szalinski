$fn=36;

union(){
 cylinder(h=5, d=5, center=false);
 cylinder(h=1, d=7, center=false);
 translate([0,0,5])
    scale([1,1,0.5]) 
     sphere(d=5);
}