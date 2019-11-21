$fn=20;
use <write/Write.scad>

//arma un peine por partes
//
//mango
//cuerpo
//dientes
//texto
//
//Parametros
//largo mango / Handle's long
lm = 80;//largo mango / Handle's long
//largo cuerpo / Body's long
lc = 80;//largo cuerpo / Body's long
//radio mayor / larger radius
rmy = 12.5;//radio mayor / larger radius
//radio menor / smaller radius
rme = 6;//radio menor / smaller radius
//espesor / comb thickness
esp = 2;//espesor del peine / comb thickness
//radio del agujero / hole radius
ag = 3;//radio del agujero / hole radius
//ancho de la base del diente / tooth's base width
ad = 3;//ancho de la base del diente / tooth's base width
//ancho de la punta del diente / tooth's top width
pd = 1;//ancho de la punta del diente / tooth's top width
//separacion entre dientes / tooth separation
sep = 2;//separación entre bases del diente / tooth separation
//texto a grabar
texto = "Victoria";//nombre a imprimir
//Reforzar mango? (0=No, 1=Si)
refuerzo = 1;
//
//Modulos
//Modulo mango
module mango(lm,rmy,rme,esp,ag){
difference(){
	hull(){
		cylinder(h=esp,r=rmy);
		translate ([lm-rmy-rme,rmy-rme,0]) cylinder(h=esp,r=rme);
		}
	translate([0,0,-0.2]) cylinder(h=esp+1,r=ag);
	}
}
//
//Modulo cuerpo
module cuerpo(lm,lc,rmy,esp,ad,sep){
//primero calculo cuanto tiene que medir el cuerpo
//para que los espacios al ppio y fin sean parejos
cd = ceil((lc) / (ad + sep));//cantidad de dientes
ac = cd * (ad + sep) + sep;//ancho del calado
//dibujo el cuerpo
difference(){
	hull(){
		translate([lm-rmy,0,0]) cylinder(h=esp,r=rmy);
		translate([lm+lc-rmy,0,0]) cylinder(h=esp,r=rmy);
	}
	//calado del cuerpo
	translate([lm-rmy,-1.2*rmy,0]) cube([ac,1.4*rmy,esp]);
	}
}
//
//Modulo dientes
module dientes(lm,lc,rmy,esp,ad,pd,sep){
cd = ceil((lc) / (ad + sep));//cantidad de dientes
for (i=[1:cd]){
	hull(){
		translate([lm-rmy+i*(ad+sep)-ad,rmy/2,0]) cube([ad,0.1,esp]);
		translate([lm-rmy+i*(ad+sep)+(ad-pd)/2-ad,-rmy,0]) cube([pd,0.1,esp]);
	}
}
}
//
//modulo Texto
module texto(rmy,texto){
translate ([rmy, 0, esp]) write (texto,font="orbitron.dxf");
}

//ejecutar
mango(lm,rmy,rme,esp,ag);
cuerpo(lm,lc,rmy,esp,ad,sep);
dientes(lm,lc,rmy,esp,ad,pd,sep);
texto(rmy,texto);

if (refuerzo == 1){
	//Refuerzo mango
	difference(){
		translate([0,0,esp]) mango(lm,rmy,rme,esp,ag);
		translate([0,0,esp]) scale ([0.9,0.9,1]) mango(lm,rmy,rme,esp,ag);
	}
}
