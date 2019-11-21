//Glasses Professor Farnsworth
$fn = 100; 
d = 1.75;//shackle diameter
hd = 10;//height of mounting arch
difference(){     
cylinder(h=43,r=43/2,r2=43/2);
union(){
translate(v=[0,0,-3/2])
cylinder(h=50,r=39/2,r2=39/2);
 translate(v=[0,0,hd])rotate([0, 90, 0 ])cylinder(100,d/2,d/2,center = true);   
    
}}
