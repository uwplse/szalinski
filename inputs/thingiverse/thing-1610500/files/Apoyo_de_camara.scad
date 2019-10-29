// Creacion de cuña paramétrica para apoyo de camara en cuad

//Variables:
ancho=25;
largo=40;
grueso=2; // En el vertice de la cuña.
angulo=15; // En grados, menor de 90º

// Creacion del la cuña en los siguientes pasos: 
// 1. Creacion de un cilindro para la base del la cuña
// 2. Al cilindro anterior le hacemos una interseccion booleana para quedarnos con el cuarto inferior.
// 3. Se le crea un cubo superior para generar el grueso de la cuña
// 4. Se gira todo el cuerpor de la cuña el angulo
// 5. Se elimina la parte por debajo del plano XY

// 5.Sustraccion del cuerpo cubo de sobrante al cuerpo base
difference(){
// 4.Rotacion del cuerpo base
rotate([0,-angulo,0])
// 3. Cuerpo de la cuña incluido el gruueso
    union(){
    // 2.Cuerpo de la cuña
    intersection(){
    // 1. Cilindro base
    rotate([90,0,0])
    cylinder(r=ancho,h=largo,$fn=50, center=true);
    // 2.Cubo para Base
    translate([0,-((largo/2)+1),-ancho-2])
    cube([ancho+2,largo+2,ancho+2]);
    }
    //3.cubo de grosor superior
    translate([0,-largo/2,0])
    cube([ancho,largo,grueso]);
}
// 5.cubo para eliminiacion del sobrante
translate([-1,-((largo/2)+1),-ancho-2])
cube([ancho+2,largo+2,ancho+2]);
}