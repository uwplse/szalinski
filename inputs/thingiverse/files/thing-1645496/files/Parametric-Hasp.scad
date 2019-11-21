// Hasp for fix doors, square section.
// Hasp with
G=6;
// Lenth
L=100;
// Diametre of the holes of wall fix
D=5;

// Alto de las piezas de Sujeccion

H=2.4*D;

// Diametro de las taladro interior de la aldabilla.
D2=2+sqrt((G*G)+(H*H));

// Modelado del cuerpo ppal:

// Creacion del solido envolente del modelo y posterior eliminación de los huecos
translate ([0,3*D2,0])
difference(){
// Fusion de los componentes del cuerpo ppal:
union(){
//Varilla de aldabilla
translate([0,-G/2,0])
    cube([L,G,G]);
// Aro de cogida a puerta
translate ([L,0,0])
    cylinder(h=G,d=(D2+2*G),$fn=100);
// Aro de enganche en pared
translate([2*G,G/2,0])
    cylinder (h=G,d=4*G,$fn=100);
// Prolongacion de Sujeccion a Pared
translate([0,-(G+3*D),0])
    cube ([G,G+3*D,G]);
}

// Partes a eliminar para dejar la pieza lista

// Taladro de anclaje a puerta
translate([L,0,-1])    
    cylinder(h=G+2,d=D2);
// Taladro de anclaje a pared
translate([2*G,G/2,-1])
    cylinder(h=G+2,d=2*G,$fn=100);
// Parte inferior del anclaje a la pared
translate([G,-3*G/2-1,-1])
    cube([2*G,2*G+1,G+2]);
// Pestaña
translate([3*G-1,-G*1.5,-1])
    cube([G+2,G,G+2]);
}

// Pieza de fijación a Puerta:
translate([L,0,0])
union(){
// Arco central:

difference(){
cylinder(h=H,d=D2+2*G,$fn=100);
    
translate ([0,0,-1])
    cylinder(h=H+2,d=D2,$fn=100);
translate([0,-(D2+G)/2-1.1,H/2])
    cube([D2+2*G+2,D2+G+2,H+2], center=true);
}
// Arco lateral Derecho
difference(){
 translate([D2+G,0,0])
    cylinder(h=H,d=D2+2*G,$fn=100);   
 translate([D2+G,0,-1])
    cylinder(h=H+2,d=D2,$fn=100);
 translate([0,0,-1])
    cube([D2*2+2*G+2,D2+G+2,H+2]);
 translate([D2+G+.1,-D2/2-G-2,-1])
    cube([D2+G+2,D2+D+2,H+2]);
}
// Patilla Derecha
difference(){
translate([D2+G,-D2/2-G,0])
    cube([D*2,G,H]);
translate([D2+G+D/2,-D2/2+1,H/2])
rotate([90,0,0])
cylinder(h=G+2,d=D,$fn=100);
}    
 // Arco lateral Izquierdo

mirror([1,0,0]){
difference(){
 translate([D2+G,0,0])
    cylinder(h=H,d=D2+2*G,$fn=100);   
 translate([D2+G,0,-1])
    cylinder(h=H+2,d=D2,$fn=100);
 translate([0,0,-1])
    cube([D2*2+2*G+2,D2+G+2,H+2]);
 translate([D2+G+.1,-D2/2-G-2,-1])
    cube([D2+G+2,D2+D+2,H+2]);
}
// Patilla izquierda
difference(){
translate([D2+G,-D2/2-G,0])
    cube([D*2,G,H]);
translate([D2+G+D/2,-D2/2+1,H/2])
rotate([90,0,0])
cylinder(h=G+2,d=D,$fn=50);
}    

}
}

// Pieza de cierre de la aldabilla:

//Diametro interior de la pieza de sujeccion
D3=1.5*G*sqrt(2);
// Eliminacion de huecos
difference(){
// Cuerpo base
union(){
cylinder(h=H,d=D3+2*G,$fn=100);
translate([0,-G/2-D3/2,H/2])
    cube([D3+2*G+6*D,G,H],center=true);

}
translate([0,0,-1])
    cylinder(h=H+2,d=D3);
translate([D3/2+G+D,-D3/2+1,H/2])
rotate([90,0,0])
    cylinder(h=G+2,d=D,$fn=50);
translate([-D3/2-G-D,-D3/2+1,H/2])
rotate([90,0,0])
    cylinder(h=G+2,d=D,$fn=50);
}