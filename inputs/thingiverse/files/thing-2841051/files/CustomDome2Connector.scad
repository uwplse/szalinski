/* Simple Domo V2 connector.
* Copyright (C) 2018  Juan Francisco Calvo (calvoj@gmail.com)
* 
* License: LGPL 3.0 or later
* 
* Calculo de corte de caños:
*  http://geo-dome.co.uk/2v_tool.asp
*/


module MakeConnector5(diameter_tube,diameter_screw){
    V2A = 15.86;
    V2B = 18.00;
    $fn=60;
    Tube=diameter_tube+0.2;
    H=Tube*1.8; 
    D=Tube*5.5;
   
    T=diameter_screw;
    Correccion1=-(Tube/1.4);
    Correccion2=-(Tube/3.5);
    
    echo("Diametro de la pieza:",D);
    echo("Ancho de la pieza:",H);
       module all(){
        difference(){
            translate([0,Correccion1,0])
            rotate([90,0,0])
            cylinder(d=D,h=H,center=true);
            // INICIO -> Agujeros para Caños
            for (i=[0:4]){
                rotate([V2B,72*i,0])
                cylinder(d=Tube,h=H*3);
            }
            // FIN-> Agujeros para Caños
            
            // INICIO -> Agujeros para Tornillos
            for (i=[1:5]){
                
                rotate([90,-6+i*72,0])
                //translate([8.2+i,8.2+i,0])
                translate([D/4,D/4,0])
                cylinder(d=T,h=80,center=true);
            }
            rotate([90,0,0])
            cylinder(d=T,h=80,center=true);
            // FIN -> Agujeros para Tornillo
            
            //translate([0,Correccion2-H/3,0])
            //cube([200, 0.1,200],center=true);
        }
    }
    /* INICIO CORTE Y ROTACION*/
    rotate([270,0,30])
    translate([H,H-(H/4.85),H*3]){
        difference(){
            all();
            translate([0,-H,0])
            cube([D,H,D],center=true);
        }
    }
    
     rotate([90,0,-30])
     difference(){
        all();
        translate([0,0,0])
        cube([D,H,D],center=true);
    }
       /* FIN CORTE Y ROTACION*/    
    
}


module MakeConnector6(diameter_tube,diameter_screw){
    V2A = 15.86;
    V2B = 18.00;
    $fn=60;
    Tube=diameter_tube+0.2;
    H=Tube*1.8;        
    D=Tube*5.5;
    T=diameter_screw;
    Correccion1=-(Tube/1.4);
    Correccion2=-(Tube/4);
        
    echo("Diametro de la pieza:",D);
    echo("Ancho de la pieza:",H);
    module all(){
        difference(){
            translate([0,Correccion1,0])
            rotate([90,0,0])
            cylinder(d=D,h=H,center=true);
            // INICIO -> Agujeros para Caños
            for (i=[0:5]){
                rotate([V2A,60*i,0])
                cylinder(d=Tube,h=H*3);
            }
            // FIN-> Agujeros para Caños
            
            // INICIO -> Agujeros para Tornillos
            for (i=[1:6]){
                
                rotate([90,-12+i*60,0])
                //translate([8.2+i,8.2+i,0])
                translate([D/4,D/4,0])
                cylinder(d=T,h=H*5,center=true);
            }
            rotate([90,0,0])
            cylinder(d=T,h=H*5,center=true);
            // FIN-> Agujeros para Tornillos
            
           //translate([0,Correccion2-H/3,0])
           //cube([200, .1,200],center=true);
        }
    }
    /* INICIO CORTE Y ROTACION*/
    rotate([270,0,30])
    translate([H,H-(H/4.85),H*3]){
        difference(){
            all();
            translate([0,-H,0])
            cube([D,H,D],center=true);
        }
    }
    
    rotate([90,0,-30])
    difference(){
        all();
        translate([0,0,0])
        cube([D,H,D],center=true);
    }
     /* FIN CORTE Y ROTACION*/    
}


module MakeConnector4(diameter_tube,diameter_screw){
    V2A = 15.86;
    V2B = 18.00;
    $fn=60;
    Tube=diameter_tube+0.2;
    H=Tube*1.8;       
    D=Tube*5.5;
    T=diameter_screw;
    Correccion1=-(Tube/1.6);
    Correccion2=-(Tube/4);   
    echo("Diametro de la pieza:",D);
    echo("Ancho de la pieza:",H);
    module  all(){
        difference(){
            translate([0,Correccion1,0])
            rotate([90,0,0])
            cylinder(d=D,h=H,center=true);
            // INICIO -> Agujeros para Caños
            for (i=[0:5]){
                rotate([V2A,60*i,0])
                cylinder(d=Tube,h=H*3);
            }
            // FIN-> Agujeros para Caños
            
            // INICIO -> Agujeros para Tornillos
            for (i=[1:6]){
                rotate([90,-12+i*60,0])
                translate([D/4,D/4,0])
                cylinder(d=T,h=H*5,center=true);
            }
                // FIN-> Agujeros para Tornillos
                //translate([0,Correccion2-H/3,0])
                //cube([D*5, 0.1,D*5],center=true);  //CORTE A LA MITAD DE LA PIEZA PARA DIVIDIR EN PARTES
            
                rotate([0,30,0])
                translate([0,0,(-D/1.64)])
                cube([D,D,D],center=true);
            



        rotate([90,0,0])
        cylinder(d=T,h=80,center=true);
        }
    }
    /* INICIO CORTE Y ROTACION*/
    rotate([270,0,30])
    translate([H,H-(H/3.3),H-H/5]){
        difference(){
            all();
            translate([0,-H,0])
            cube([D,H,D],center=true);
        }
    }
    
        rotate([90,0,-30])
        difference(){
        all();
        translate([0,0,0])
        cube([D,H,D],center=true);
    }
    /* FIN CORTE Y ROTACION*/    
}
/*
* Calculo de corte de caños:
*  http://geo-dome.co.uk/2v_tool.asp

Funciones disponibles
    MakeConnector4(Diametro del Tubo , Diametro de tornillos);   // Imprima 10 piezas 
    MakeConnector5(Diametro del Tubo , Diametro de tornillos);  // Imprima 6 piezas 
    MakeConnector6(Diametro del Tubo , Diametro de tornillos); // Imprima 10 piezas 

ejemplo:
        Imprime el conectoŕ del piso para caño de 10mm
        MakeConnector4(10,6);
    
*/

MakeConnector6(19.8,9);