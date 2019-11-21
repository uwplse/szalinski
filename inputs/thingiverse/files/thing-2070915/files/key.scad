/* [Teeths] */
t1=7.3;
t2=6.3;
t3=8.5;
t4=8.7;
t5=5.3;
t6=7.6;
/* [Additional] */
center=10;

llave(t1,t2,t3,t4,t5,t6,center);


module llave(p1,p2,p3,p4,p5,p6,centro){
rotate([0,5,0])translate([0,0,-1])paletas(p1,p2,p3,p4,p5,p6,centro);



//rotate([0,-5,0])translate([-10,0,-1])
translate([0,14.2,0])rotate([180,-185,])translate([0,0,-1])paletas(p1,p2,p3,p4,p5,p6,centro);

//#cube([19.5,10,1],center=true);

translate([0,-4,0])rotate([90,0,0])cylinder(r=6/2,h=26,$fn=24);
translate([0,15,0])sphere(r=6/2,$fn=24);





translate([0,18-3,0])rotate([90,0,0])cylinder(r=6/2,h=20-3,$fn=24);
translate([0,15,0])sphere(r=6/2,$fn=24);

//translate([0,-28,0])sphere(r=4.6/2,$fn=24);

//toroide durante el bracito
translate([0,-3,0])scale([1,0.66,1])rotate([90,0,0])rotate_extrude(convexity = 10, $fn = 24)
translate([2, 0, 0])
circle(r = 3.6/2, $fn = 24);

/////// agarre de arriba
translate([0,20,-1])
difference(){
hull(){

translate([0,-50,0]){
    translate([-10/2,0,0])cube([10,1,2.5]);
    translate([-10,-8.65,0])rotate([0,0,60])cube([10,1,2.5]);
}

translate([0,0,-2])
mirror([1,0,0])
translate([0,-50,0]){
    translate([-10/2,0,0])cube([10,1,6]);
    translate([-10,-8.65,0])rotate([0,0,60])cube([10,1,6]);
}

translate([0,0,-2])
translate([0,-59,0])
difference(){
    cylinder(r=22/2,h=6);
    translate([-20,0,-1])cube([60,50,10]);
}
}
translate([0,-68+4,-10])cylinder(r=3.8/2,h=20,$fn=16);
}
}
module paletas(p1,p2,p3,p4,p5,p6,centro){
    placas=1.7;
    espacio=4;

    paleta(p6,placas);
    translate([0,placas,0]){
    paleta(p5,placas);
    translate([0,placas,0]){
    paleta(p4,placas);
    translate([0,placas,0]){
    paleta(centro,espacio);
    translate([0,espacio,0]){
    paleta(p3,placas);
    translate([0,placas,0]){
    paleta(p2,placas);
    translate([0,placas,0]){
    paleta(p1,placas);
    }}}}}}
    
}





module paleta(prof,ancho){
    hull(){
        cube([1,ancho,2]);
        translate([prof,0,0])translate([-2,0,1])rotate([-90,0,0])scale([2,1,1])cylinder(r=1,h=ancho,$fn=16);
    }
}








