$fn=64;
Lw=80; //расстояние от стены
Dt=10.2; //диаметр трубки
DtH=10; //высота охвата трубки
WL=50;//длина планки
WH=10;//толщина планки
HH=DtH+2;

dOkr=30; //скругление у основания

//cylinder(d=Dt+3*2,h=DtH);
//translate([Lw,-WL/2,0])cube([WH,WL,DtH]);
module shHole(diam){
    cylinder(d=diam,h=40);
        cylinder(d1=diam+4,d2=diam,h=3);
        translate([0,0,-80])cylinder(d=diam+4,h=80);
}

difference(){
    hull(){
        cylinder(d=Dt+3*2,h=HH);
        scale([1,1,1])translate([Lw,-WL/2,0])cube([0.01,WL,HH]);
    }
    cylinder(d=Dt,h=DtH);
    translate([Lw-7,WL/4+3,HH/2])rotate([90,0,90-10]){
        shHole(4);
    }
    
    mirror([0,1,0])translate([Lw-5,WL/4+3,HH/2])rotate([90,0,90-10]){
        shHole(4);
    }
    
    
    
    hull(){
        
        translate([Lw-WH-dOkr/2,(Dt+6)/2+dOkr/2,-0.01])cylinder(d=dOkr,h=HH+0.02);
        translate([-10,(Dt+6)/2+dOkr/2,-0.01])cylinder(d=dOkr,h=HH+0.02);
        
        
    }
    mirror([0,1,0])hull(){
        translate([Lw-WH-dOkr/2,(Dt+6)/2+dOkr/2,-0.01])cylinder(d=dOkr,h=HH+0.02);
        translate([-10,(Dt+6)/2+dOkr/2,-0.01])cylinder(d=dOkr,h=HH+0.02);
        
    }
}