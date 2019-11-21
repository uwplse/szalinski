use<write/Write.scad>
//parametros
//Radio Base / Base Radius
radio_mayor = 50;//Radio Base Exterior
//Radio Superior / Upper Radios
radio_menor = 40;//Radio superior
//Radio Base Interior / Inner Base Radius
radio_minimo = 35;//Radio Base Interior
//Altura / Heigh
altura = 25;
//Resolucion / Resolution
segmentos = 100;
//Texto / Text
texto = "Olivia";

//Cono exterior
difference(){
	cylinder(r1=radio_mayor, r2=radio_menor, h=altura,$fn=100);
	cylinder(r1=radio_mayor-espesor, r2=radio_menor - 1.4, h=altura+1,$fn=segmentos);
}

//Cono interior
difference(){
	cylinder(r1=radio_minimo, r2=radio_menor, h=altura,$fn=100);
	cylinder(r1=radio_minimo-espesor, r2=radio_menor - 1.4, h=altura+1,$fn=segmentos);
}

//Base
cylinder(r=radio_mayor,h=1.4,$fn = segmentos);

//Texto
pos = radio_mayor - (altura / 2) * (radio_mayor - radio_menor) / altura;
espesor = 8*(radio_mayor - radio_menor) / altura;

writecylinder(texto,[0,0,0],pos-espesor/2,altura+4,t=espesor);
rotate (90,90,0) writecylinder(texto,[0,0,0],pos-espesor/2,altura+4,t=espesor);
rotate (180,180,0) writecylinder(texto,[0,0,0],pos-espesor/2,altura+4,t=espesor);
rotate (270,270,0) writecylinder(texto,[0,0,0],pos-espesor/2,altura+4,t=espesor);