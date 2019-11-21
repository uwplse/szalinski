//bulb_up_nast
//печатать с Brim чтобы не отвалилось
dl = 50;// диаметр колбы
$fn = 200;
difference(){
hull(){
cylinder(h =12, r1 =9.8,r2 = 15, centr = true);
translate([0,0,10+dl/2])sphere(dl/2);}
hull(){
translate([0,0,-0.3])cylinder(h =12, r1 =8.8,r2 = 14, centr = true);
translate([0,0,10+dl/2])sphere(dl/2-1);}
}