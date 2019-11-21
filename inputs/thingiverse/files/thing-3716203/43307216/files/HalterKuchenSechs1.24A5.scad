h = 11; l = 215; b = 155; r = 32; rk = 2;
module Platte (){
hull(){
translate([l/2-rk, b/2-rk, rk], true){
    sphere(rk);
    cylinder (h, r=rk);}
translate([-(l/2-rk), b/2-rk, rk], true){
    sphere(rk);
    cylinder (h, r=rk);}
translate([-(l/2-rk), -(b/2-rk), rk], true){
    sphere(rk);
    cylinder (h, r=rk);}
translate([l/2-rk, -(b/2-rk), rk], true){
    sphere(rk);
    cylinder (h, r=rk);}
}
}

difference(){ 
    Platte ();
    translate([0, (b-4*r)/6+r, -h]) 
    cylinder (3*h, r=r, true);
    translate([0, -((b-4*r)/6+r), -5]) 
    cylinder (3*h, r=r, true);
    translate([(l-6*r)/4+2*r, (b-4*r)/6+r, -h]) 
    cylinder (3*h, r=r, true);
    translate([-((l-6*r)/4+2*r), -((b-4*r)/6+r), -h]) 
    cylinder (3*h, r=r, true);
    translate([-((l-6*r)/4+2*r), (b-4*r)/6+r, -h]) 
    cylinder (3*h, r=r, true);
    translate([(l-6*r)/4+2*r, -((b-4*r)/6+r), -h]) 
    cylinder (3*h, r=r, true);
}
