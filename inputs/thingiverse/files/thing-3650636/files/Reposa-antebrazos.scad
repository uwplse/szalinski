/////////////////////////////// Reposa antebrazos///////////////////////////////


////////////////// Creado por Luis Rodríguez para la Fundación ONCE - 2019 /////////////////



//Este software se distribuye bajo licencia Creative Commons - Attribution - NonCommercial - ShareAlike license.
//https://creativecommons.org/licenses/by-nc-sa/4.0/
//Este software no tiene ningún tipo de garantía y el usuario será el único responsable de su uso



//////////Este reposa antebrazos está pensado para dar un soporte adicional a los antebrazos de aquellas personas que por uno u otro motivo no tengan posibilidad de mantenerlos cuando trabajan sobre una mesa//////////


///////////////Todos los parámetros están medidos en milímetros///////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////Parámetros definibles por el usuario////////////////////



/*[Parámetros de la mesa]*/

//Grosor de la mesa 
GrueMesa = 30;           //[10:0.1:45]

//¿El canto de la mesa es plano o redondeado?
Borde_Mesa = "Plano";      //[Plano:Plano, Redondeado:Redondeado]



/*[Parámetros del reposa antebrazos]*/

//Si se desea que el reposa antebrazos dé un mayor acceso al cuerpo
Escotadura = "No";      //[Derecha:Con Escotadura Derecha, Izquierda:Con Escotadura Izquierda, No:Sin escotadura]

//Profundidad total del reposa antebrazos
ProfTotal = 245;          //[190:5:300]

//Parte voladiza del reposa antebrazos (donde realmente se hace el apoyo)
ProfVol = 160;           //[100:5:210]

//Anchura del reposa antebrazos
AnchoTotal = 200;        //[150:1:250]

//Grosor sobre la mesa
GrueSoMesa = 5;           //[4:0.5:10]

//Grosor mínimo de la parte inferior  
GrosMinInf = 6;          //[4:0.5:10]

//Grosor máximo de la parte inferior 
GrosMaxInf = 10;         //[6:0.5:30]



/*[Hidden]*/

Suavizado = 4;

RadCuerpo = 250;

RadioBase = (GrosMaxInf)/2;

Calc = RadCuerpo-(AnchoTotal-((RadCuerpo+AnchoTotal/2+AnchoTotal/8)-RadCuerpo));

Desplaz = ProfVol-RadioBase*3-(sqrt((RadCuerpo*RadCuerpo)-(Calc*Calc)));


///////////////////////////////////Módulos///////////////////////////////////




module Suavizado1() {
    rotate([90,90,0])
    translate([-RadCuerpo-AnchoTotal/2-AnchoTotal/8,Desplaz,-GrueSoMesa-GrueMesa-GrosMinInf-RadioBase+1])
        cylinder(GrueSoMesa+GrueMesa+GrosMinInf+RadioBase, r=RadCuerpo,$fn=160);
                    }




module Suavizado2() {
    rotate([90,90,0])
    translate([RadCuerpo-AnchoTotal/2+AnchoTotal/6,Desplaz,-GrueSoMesa-GrueMesa-GrosMinInf-RadioBase+1])
        cylinder(GrueSoMesa+GrueMesa+GrosMinInf+RadioBase, r=RadCuerpo,$fn=160);
                    }






module Base() {
    difference() {
        hull() {
            translate([ProfVol-Suavizado*2,0,0])
                cube([ProfTotal-ProfVol-Suavizado,GrueSoMesa+GrueMesa+GrosMinInf-Suavizado*2,AnchoTotal-Suavizado*2]);
            translate([0,Suavizado,0])
                cylinder(AnchoTotal-Suavizado*2, r=Suavizado,$fn=50);
            translate([ProfVol-RadioBase*2,GrueMesa+RadioBase/2,0])
                cylinder(AnchoTotal-Suavizado*2, r=RadioBase,$fn=50);
               }
        
    
        if(Escotadura=="Iquierda")
            Suavizado2();
               
        if(Escotadura=="Derecha")
            Suavizado1();
                

                  }
              }


module Principal() {
minkowski(){
Base();
sphere(r=Suavizado,$fn=20);
}
}

if (Borde_Mesa=="Redondeado")
difference(){
Principal(); 
translate([ProfVol,GrueSoMesa-Suavizado,-Suavizado]) 
            cube([ProfTotal,GrueMesa,AnchoTotal+Suavizado*2]);
translate([ProfVol,GrueMesa/2+GrueSoMesa-Suavizado,-Suavizado])
            cylinder(AnchoTotal+Suavizado*2,d=GrueMesa,$fn=50);
}

if (Borde_Mesa=="Plano")
difference(){
Principal(); 
translate([ProfVol-GrueMesa/2,GrueSoMesa-Suavizado,-Suavizado]) 
            cube([ProfTotal,GrueMesa,AnchoTotal+Suavizado*2]);
}



