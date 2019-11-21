

a = 72; //расстояние между отверстиями крепления
b = 77; // диаметр выреза под лопасти

difference(){
color("blue")union(){
    hull(){

   translate([b/2,b/2,0])cylinder(d=8, h = 2.5, $fn = 33);
    translate([-b/2,b/2,0])cylinder(d=8, h = 2.5, $fn = 33); 
     translate([b/2,-b/2,0])cylinder(d=8, h = 2.5, $fn = 33);
     translate([-b/2,-b/2,0])cylinder(d=8, h = 2.5, $fn = 33);
    
    }
    
   translate([a/2,a/2,0])cylinder(d=10, h = 4.5, $fn = 33);
    translate([-a/2,a/2,0])cylinder(d=10, h = 4.5, $fn = 33); 
     translate([a/2,-a/2,0])cylinder(d=10, h = 4.5, $fn = 33);
     translate([-a/2,-a/2,0])cylinder(d=10, h = 4.5, $fn = 33);  
}      
  translate([a/2,a/2,-5])cylinder(d=4.2, h = 25, $fn = 33);
    translate([-a/2,a/2,-5])cylinder(d=4.2, h = 25, $fn = 33);
     translate([a/2,-a/2,-5])cylinder(d=4.2, h = 25, $fn = 33);
     translate([-a/2,-a/2,-5])cylinder(d=4.2, h = 25, $fn = 33);
     translate([0,0,-5])cylinder(d=b, h = 25, $fn = 33);
    
}

 color("blue")for (i = [1:24]){
rotate([90,0,15*i])translate([0,1.25,2.5])
cylinder(h =b/2+1, d =2.5, $fn =50,centr = true);}


/*translate([0,56,-5])cylinder(d1=109, d2 = 121, h = 80, $fn = 90);
hull(){
translate([0,2,12.5])cube([25,30,25],center = true);
translate([0,50,12.5])cube([108,1,25],center = true);
}
translate([0,-6,15])cube([15.5,10,33],center = true);


difference(){
union(){
hull(){
translate([0,0,2])cube([21,17,4],center = true);
translate([0,16,0])cylinder(d=9, h = 4, $fn = 90);}
translate([0,0,12.5])cube([21,17,25],center = true);
}
translate([0,0,17.5])cube([15.5,10.5,25],center = true);
translate([0,16,-15])cylinder(d=4.5, h = 33, $fn = 90);}
*/