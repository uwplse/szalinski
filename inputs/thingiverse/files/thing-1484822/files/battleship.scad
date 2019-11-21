

module body(){
hull(){
minkowski(){
translate([15,-25,-20])rotate([0,0,90])cube([50,30,10]);//center of body
sphere(3,$fn=100);
}
minkowski(){
translate([-1.5,-75,-20])cube([3,3,10]);//front point
sphere(3,$fn=100);
}
minkowski(){
translate([0,45,-20])cylinder(10,5,5,$fn=100);//rear of ship
sphere(3,$fn=100);
}
}}


//module front(){
//hull(){
   
//translate([-10,-100,-22])rotate([-45,0,0])cube([20,20,20]);

//translate([-2.5,-78,-30])cube(5);//front cut out
//difference(){
body();
front();
//}

module cannon(){
minkowski(){
translate([-5,-5,-5])cube([10,10,5]);//gun hub
sphere(3,$fn=100);
}

translate([-5,-5,-2])rotate([90,0,0])cylinder(10,1.5,1.5,$fn=100);//gun

translate([0,-5,-2])rotate([90,0,0])cylinder(10,1.5,1.5,$fn=100);//gun

translate([5,-5,-2])rotate([90,0,0])cylinder(10,1.5,1.5,$fn=100);//gun
}


translate([0,-35,0])cannon();
hull(){
translate([-12.5,0,-7])cube([25,25,5]);//ship deck
translate([-7.5,-25,-7])cube([15,15,5]);//ship deck
}

translate([0,-15,5.75])rotate([0,0,50])cannon();

translate([-10,-5,-5])cube([20,25,10]);

hull(){
translate([-2,5,5])cylinder(10,3,3,$fn=100);
translate([2,5,5])cylinder(10,3,3,$fn=100);
translate([0,10,5])cylinder(10,3,3,$fn=100);    
}
translate([0,6,17])cube(5,center=true);


translate([17.75,0,-18.5])rotate([90,-0,90])text("USA", size =8);

translate([-17.750,18.50,-18.5])rotate([90,-0,-90])text("USA", size =8);









