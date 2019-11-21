$fn=132;
clip();
translate([17.5,2,0]){bracket();}
module clip(){
difference(){
cube([18,10,18]);
translate([0,0,3]){cube([15,10,12]);}  
translate([5,5,15]){cylinder(3,1,2,5);}
}    
rrad = 2;
translate([0,0,rrad]){rotate([-90,0,0]){cylinder(10,rrad,rrad);}}
translate([20.5,0,2]){cube([2,10,14]);}

translate([18,0,6]){cube([2.5,10,6]);}
}


module bracket(){
difference(){
translate([.75,0,0]){cube([6,10,18]);}
union(){
translate([0,0,5.75]){cube([2.75,10,6.75]);}
translate([2.75,0,1.5]){cube([2.25,11.5,15]);}
}


    }
}