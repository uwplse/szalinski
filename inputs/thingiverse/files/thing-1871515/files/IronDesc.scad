$fn=64;
L=190;     //длина планки
H=5;       //толщина планки
td=20;     //диаметр под трубу

xd=38;     // расстояние между трубками
dd=25;     //расстояние от края до отверстий
N=5;       //количество труб
w=20;      //ширина упора

difference(){
    cube([H,L,w]);
    translate([-0.1,dd/2,w/2])rotate([0,90,0]){
        cylinder(r=3,h=H+0.2);
        translate([0,0,H-2])cylinder(r1=0,r2=5,h=2.5);
        }
    translate([-0.1,L-dd/2,w/2])rotate([0,90,0]){
        cylinder(r=3,h=H+0.2);
        translate([0,0,H-2])cylinder(r1=0,r2=5,h=2.5);
        }
}
difference(){
    translate([H,dd,0])cube([td+2,L-dd*2,w]);
    for (i=[0:N-1]){
        translate([H+td/2,dd+i*xd,-0.1])cylinder(d=td,h=w+0.2);
       hull(){
           translate([H,(td/sin(60))/2+dd+td/2+2+i*xd,-0.1])rotate([0,0,-30])cube([td/sin(60)+2.1+1,0.2,w+0.2]);
           translate([H,dd+(i+1)*xd,-0.1])cube([td+2.1,0.1,w+0.2]);
       }
    }  
}
