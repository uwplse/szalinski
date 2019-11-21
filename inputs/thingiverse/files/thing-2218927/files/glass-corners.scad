$fn=64;
a=20; //сторона уголка
h=1; //высота уголка
hg=4.8; //толщина стекла
d=3.6; //диаметр отверстия
dd=3; //смещение отверстия для крепежа от края
dg=6+0.5; //расстояние от края столика до стекла
fac=10;//фаска
cfac=3;//фаска в углу

mirror([0,0,1])
difference(){
    
    hull(){
        translate([cfac/2,cfac/2,0])cylinder(d=cfac,h=hg+h);
        translate([a-fac,fac/2,0])cylinder(d=fac,h=hg+h);
        translate([fac/2,a-fac,0])cylinder(d=fac,h=hg+h);
    }
    //cube([a,a,hg+h]);
    translate([dd,dd,-0.1])cylinder(d=d,h=hg+h+0.2);
    translate([dd,dd,hg+h-1])cylinder(d1=d,d2=d+2,h=1);
    //translate([dd,dd,hg+h-2])cylinder(d=d+4,h=hg+h+0.2);
    //translate([dg,dg,-0.1])cube([a-dg*2,a-dg*2,hg]);
    translate([dg,dg,-0.1])cube([a-dg*2+fac,a-dg*2+fac,hg]);
    
    //linear_extrude(hg+h)polygon([[0,a],[a,0],[a,a]]);
}

