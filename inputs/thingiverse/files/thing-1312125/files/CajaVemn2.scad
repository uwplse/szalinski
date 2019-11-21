pared = 3;
alto_caja = 70;
ancho_caja = 60;

alto_base_sd = 8;
alto_soporte_sd = 38; 

espesor_v = 1.2;
ancho_v = 20;

alto_tapa = 5;



module caja (){    
    difference(){cube([ancho_caja,ancho_caja,alto_caja], center=true);
    translate([0,0,pared])cube([ancho_caja-(pared*2),ancho_caja-(pared*2),alto_caja], center=true);}
}

module lineaV (){
    rotate([0,atan(ancho_caja/alto_caja),0])cube([ancho_v,espesor_v,alto_caja*ancho_caja], center=true);
}

module lineasv(){
    translate([0,(ancho_caja/2),0]) lineaV();
    translate([0,-(ancho_caja/2),0]) rotate([0,0,180])  lineaV();
    translate([(ancho_caja/2),00,0]) rotate([00,0,90])  lineaV();
    translate([-(ancho_caja/2),0,0]) rotate([0,0,270])  lineaV();
}

module sd(){
    translate([0,0,(alto_caja/2-alto_base_sd)*-1+alto_soporte_sd/2])
    difference(){
    //	SD Standard: 32.0×24.0×2.1 mm 
    cube([30,5,alto_soporte_sd], center =true);
    translate([0,0,15]) scale(1.1) cube([24,2.1,32], center =true);
    translate([0,0,20])
    rotate([90,0,0])scale([1.2,1,1])cylinder(h=10, r1=10, r2=10, center=true);
}}

module pisosd(){    
    translate([0,0,((alto_caja/2)-(pared/2))*-1])
hull(){
    translate([0,0,  alto_base_sd-pared])
        cube([30,5,pared], center = true);    
    cube([45,20,pared], center = true);    
//    scale([2,1,1])cylinder(h=3, r1=12, r2=12);
    }
}

module borde_tapa(){
translate([0,0,(alto_caja/2)-alto_tapa])
difference(){
cube([ancho_caja, ancho_caja, pared], center=true);

hull(){    
translate([0,0,pared/2 -1]) 
    cube([ancho_caja-pared *3, ancho_caja-(pared*3), 2], center=true);
translate([0,0, -pared/2]) 
    cube([ancho_caja-(pared*2), ancho_caja-(pared*2), 1], center=true);
};
}}



module caja_completa(){   
difference(){
union(){
    caja();
    borde_tapa();        
    }

lineasv();}

sd();
pisosd();
}


caja_completa();

