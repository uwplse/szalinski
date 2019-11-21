/////////////////////////////////////
// PROYECTO MESA JUEGOS
// MESA CON FOSO E ILUMINACION
// TAPAS SUPERIORES DESMONTABLES
// ACCESORIOS DE ENCASTRE EN RANURA LATERAL
// PARAMETRIZADA EN ALTURA ANCHURA Y LARGO
// DISEÑO PARA TABLERO DE 12MM GROSOR
// DISEÑADO PARA CORTES RECTOS
// DISEÑO PARA ENSAMBLE A TORNILLADO OCULTO
// JOSUE GONZALEZ 24/7/2017
////////////////////////////////////



//--parametros de la MESA
altura=750;
ancho=900;
largo=1500;
fondo_foso=100; // minimo 6cm
ala=150; // ala para apoyo brazos minimo 10
espesor_tablero=12;
//--parametros de diseño
// foso= ancho/largo - ala
ancho_foso=ancho-ala-ala;
largo_foso=largo-ala-ala;
es=espesor_tablero;



// foso

//--base foso
translate([0,0,0])
cube([ancho_foso,largo_foso,es]);

//--laterales foso interior led
union(){
translate([0,0,es])
color( "blue", 0.4 )
cube([es,largo_foso,fondo_foso]);
translate([ancho_foso-es,0,es])
color( "blue", 0.4 )
cube([es,largo_foso,fondo_foso]);
translate([es,0,es])
color( "red", 0.4 )
cube([ancho_foso-es-es,es,fondo_foso]);
translate([es,largo_foso-es,es])
color( "red", 0.4 )
cube([ancho_foso-es-es,es,fondo_foso]);
}
//--barra led 1cm de alto
//--ojo a modo de ilustracion
union(){
translate([0,0,12+fondo_foso-50])
color( "white", 1.0 )
cube([12,largo_foso,10]);
translate([ancho_foso-12,0,12+fondo_foso-50])
color( "white", 1.0 )
cube([12,largo_foso,10]);
translate([12,0,12+fondo_foso-50])
color( "white", 1.0 )
cube([ancho_foso-24,12,10]);
translate([12,largo_foso-12,12+fondo_foso-50])
color( "white", 1.0 )
cube([ancho_foso-24,12,10]);
}
//--laterales foso exterior
union(){
translate([-es,-es,0])
color( "orange", 0.4 )
cube([es,largo_foso+es+es,fondo_foso+es]);
translate([ancho_foso,-es,0])
color( "orange", 0.4 )
cube([es,largo_foso+es+es,fondo_foso+es]);
translate([0,-es,0])
color( "green", 0.4 )
cube([ancho_foso,es,fondo_foso+es]);
translate([0,largo_foso,0])
color( "green", 0.4 )
cube([ancho_foso,es,fondo_foso+es]);
}

// alas

// alas
union() {
translate([-ala,0,fondo_foso+es])
color( "red", 0.4 )
cube([ala,largo_foso,es]);
translate([ancho_foso,0,fondo_foso+es])
color( "red", 0.4 )
cube([ala,largo_foso,es]);

translate([-ala,-ala,fondo_foso+es])
color( "blue", 0.4 )
cube([ancho,ala,es]);
translate([-ala,largo-ala-ala,fondo_foso+es])
color( "blue", 0.4 )
cube([ancho,ala,es]);
}

// tapas

//--tapas
union(){
translate([0,0,fondo_foso+es])
color( "purple", 0.4 )
cube([ancho_foso,largo_foso/5,es]);

translate([0,largo_foso/5,fondo_foso+es])
color( "purple", 0.4 )
cube([ancho_foso,largo_foso/5,es]);
translate([es,largo_foso/5-15,fondo_foso])
color( "purple", 0.4 )
cube([ancho_foso-es-es,30,es]);



translate([0,(largo_foso/5)*2,fondo_foso+es])
color( "purple", 0.4 )
cube([ancho_foso,largo_foso/5,es]);
translate([es,(largo_foso/5)*2-15,fondo_foso])
color( "purple", 0.4 )
cube([ancho_foso-es-es,30,es]);    

translate([0,(largo_foso/5)*3,fondo_foso+es])
color( "purple", 0.4 )
cube([ancho_foso,largo_foso/5,es]);
translate([es,(largo_foso/5)*3-15,fondo_foso])
color( "purple", 0.4 )
cube([ancho_foso-es-es,30,es]); 

translate([0,(largo_foso/5)*4,fondo_foso+es])
color( "purple", 0.4 )
cube([ancho_foso,largo_foso/5,es]);
translate([es,(largo_foso/5)*4-15,fondo_foso])
color( "purple", 0.4 )
cube([ancho_foso-es-es,30,es]);
}



//--faldon

// refuerzos superiores
union(){
translate([-20-es,-20-es-20,fondo_foso-8])
color( "blue", 0.4 )
cube([20,largo_foso+es+es+20+20+20+20,20]);

translate([ancho_foso+es,-es-20-20,fondo_foso-8])
color( "blue", 0.4 )
cube([20,largo_foso+es+es+20+20+20+20,20]);

translate([-20-es-20,-20-es-20,fondo_foso-8])
color( "blue", 0.4 )
cube([20,largo_foso+es+es+20+20+20+20,20]);

translate([ancho_foso+es+20,-es-20-20,fondo_foso-8])
color( "blue", 0.4 )
cube([20,largo_foso+es+es+20+20+20+20,20]);


translate([0-es,-20-es,fondo_foso-8])
color( "red", 0.4 )
cube([ancho_foso+es+es,20,20]);

translate([-es,largo-ala-ala+es,fondo_foso-8])
color( "red", 0.4 )
cube([ancho_foso+es+es,20,20]);

translate([0-es,-20-es-20,fondo_foso-8])
color( "red", 0.4 )
cube([ancho_foso+es+es,20,20]);

translate([-es,largo-ala-ala+es+20,fondo_foso-8])
color( "red", 0.4 )
cube([ancho_foso+es+es,20,20]);
}

// refuerzos inferiores
union(){
translate([-20-es,-20-es-20,0])
color( "blue", 0.4 )
cube([20,largo_foso+es+es+20+20+20+20,20]);

translate([ancho_foso+es,-es-20-20,0])
color( "blue", 0.4 )
cube([20,largo_foso+es+es+20+20+20+20,20]);

translate([-20-es-20,-20-es-20,0])
color( "blue", 0.4 )
cube([20,largo_foso+es+es+20+20+20+20,20]);

translate([ancho_foso+es+20,-es-20-20,0])
color( "blue", 0.4 )
cube([20,largo_foso+es+es+20+20+20+20,20]);


translate([0-es,-20-es,0])
color( "red", 0.4 )
cube([ancho_foso+es+es,20,20]);

translate([-es,largo-ala-ala+es,0])
color( "red", 0.4 )
cube([ancho_foso+es+es,20,20]);

translate([0-es,-20-es-20,0])
color( "red", 0.4 )
cube([ancho_foso+es+es,20,20]);

translate([-es,largo-ala-ala+es+20,0])
color( "red", 0.4 )
cube([ancho_foso+es+es,20,20]);
}

//faldones interiores
union(){
translate([-es-40-es,-es-40,0])
color( "white", 0.4 )
cube([es,largo_foso+es+es+80,fondo_foso+12]);

translate([ancho_foso+40+es,-es-40,0])
color( "white", 0.4 )
cube([es,largo_foso+es+es+80,fondo_foso+es]);

translate([-50-es-2,-es-40-es,0])
color( "white", 0.4 )
cube([ancho_foso+100+es+es+4,es,fondo_foso+es]);

translate([-50-es-2,largo_foso+40+es,0])
color( "pink", 0.4 )
cube([ancho_foso+100+es+es+4,es,fondo_foso+es]);
}

//faldones exterior rail acesorios
union(){
translate([-es-40-es-es,-es-40-es,0])
color( "orange", 0.4 )
cube([12,largo_foso+es+es+80+es+es,fondo_foso+es-60]);
translate([-es-40-es-es,-es-40-es,fondo_foso+es-(fondo_foso+es-(fondo_foso+es-60)-20)])
color( "orange", 0.4 )
cube([es,largo_foso+es+es+80+es+es,fondo_foso+es-(fondo_foso+es-60)-20]);


translate([ancho_foso+40+es+es,-es-40-es,0])
color( "orange", 0.4 )
cube([es,largo_foso+es+es+80+es+es,fondo_foso+es-60]);
translate([ancho_foso+40+es+es,-es-40-es,fondo_foso+es-(fondo_foso+es-(fondo_foso+es-60)-20)])
color( "orange", 0.4 )
cube([es,largo_foso+es+es+80+es+es,fondo_foso+es-(fondo_foso+es-60)-20]);


translate([-50-es-es-2,-es-40-es-es,0])
color( "green", 0.4 )
cube([ancho_foso+100+es+es+es+es+4,es,fondo_foso+es-60]);
translate([-50-es-es-2,-es-40-es-es,fondo_foso+es-(fondo_foso+es-(fondo_foso+es-60)-20)])
color( "green", 0.4 )
cube([ancho_foso+100+es+es+es+es+4,es,fondo_foso+es-(fondo_foso+es-60)-20]);

translate([-50-es-es-2,largo_foso+40+es+es,0])
color( "green", 0.4 )
cube([ancho_foso+100+es+es+es+es+4,es,fondo_foso+es-60]);
translate([-50-es-es-2,largo_foso+40+es+es,fondo_foso+es-(fondo_foso+es-(fondo_foso+es-60)-20)])
color( "green", 0.4 )
cube([ancho_foso+100+es+es+es+es+4,es,fondo_foso+es-(fondo_foso+es-60)-20]);
}

//patas
union(){
translate([-es-20-20-es-es,-es-20-20-es-es-es,-altura+fondo_foso+es])
color( "grey", 0.4 )
cube([100,es,altura]);
translate([-es-es+ancho_foso,-es-20-20-es-es-es,-altura+fondo_foso+es])
color( "grey", 0.4 )
cube([100,es,altura]);
translate([-es-20-20-es-es,-es-20-20-es-es,-altura+fondo_foso+es])
color( "BLUE", 0.4 )
cube([20,20,altura-fondo_foso-es]);
translate([+20+20+es+4+ancho_foso,-es-20-20-es-es,-altura+fondo_foso+es])
color( "grey", 0.4 )
cube([20,20,altura-fondo_foso-es]);
    

translate([-12-20-20-es-es,20+20+es+es+es+largo_foso,-altura+fondo_foso+es])
color( "grey", 0.4 )
cube([100,es,altura]);
translate([-es-es+ancho_foso,20+20+es+es+es+largo_foso,-altura+fondo_foso+es])
color( "grey", 0.4 )
cube([100,es,altura]); 
 translate([-es-20-20-es-es,-es-es+4+20+20+es+es+es+largo_foso,-altura+fondo_foso+es])
color( "grey", 0.4 )
cube([20,20,altura-fondo_foso-es]); 
translate([+es+20+20+ancho_foso+4,20+20+es+largo_foso+4,-altura+fondo_foso+es])
color( "grey", 0.4 )
cube([20,20,altura-fondo_foso-es]);


translate([-es-20-20-es-es-es,-es-20-20-es-es,-altura+fondo_foso+es])
color( "RED", 0.4 )
cube([es,100,altura]);
translate([-es-20-20-es-es-es,-es-es+largo_foso,-altura+fondo_foso+es])
color( "grey", 0.4 )
cube([es,100,altura]);



translate([20+20+es+es+es+ancho_foso,-es-20-20-es-es,-altura+fondo_foso+es])
color( "grey", 0.4 )
cube([es,100,altura]);
translate([20+20+es+es+es+ancho_foso,-es-es+largo_foso,-altura+fondo_foso+es])
color( "grey", 0.4 )
cube([es,100,altura]);



}
//perforaciones

//perforaciones cables led a foso
*union(){
translate([3+es,50,3+fondo_foso-30])
color( "black" )
rotate([90,0,0])
cylinder(r=6/2,h=300,$fn=100);
translate([60,-es-es-es-es,20])
color("white")
rotate([90,90,0])
import ("arduino.stl");
translate([-20-es,-es-20,3-30])
color( "black" )
rotate([0,0,0])
cylinder(r=15/2,h=70,$fn=100);
}