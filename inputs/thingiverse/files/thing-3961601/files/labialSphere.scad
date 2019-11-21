/*Caja para labiales de Gaby

Todos los valores en milimietros

https://federico.bitonte.com

*/
//What to print? - Que imprimir
imprimir = "ambas"; //["caja","tapa","ambas"]
//box diameter - diametro de la caja
diametro = 15;
//wall thickness - Grosor de la pared
grosor_pared  = 1;
//box height - Altura de la caja
altura_caja = 10;
// offset between the box and the lid heights - Diferencia de altura entre la caja y la tapa (para poder agarrarla par abrirla)
diferencia_tapa = 5;
//Steps - Pasos (caras de la caja)
$fn = 8; // 
//Box color (only for preview) - Color de la caja
color_caja = "Black";
//Lid color (for preview only) Color de la tapa
color_tapa = "DeepPink";
//text, if any - Texto tapa
texto = "René   ";
//Font - Tipografía
typo = "la chata:style=Bold"; //["la chata:style=Bold", "Ink Free:style=Bold","Verdana:style=Bold", "Maiandra GD MT:style=Bold"]
//Font Size - Tamaño letra
letra_size = 2;
//Text offset pos - Alinear texto (suele ser la mitad del tamaño de la letra multiplicado por la cantidad de letras)
texto_alinear = 4;

module caja(){
    difference(){
        color(color_caja)
        cylinder (r=diametro/2, h = altura_caja);
    
        color ("gray")
        translate ([0,0,(altura_caja)])
        sphere (r=(diametro-grosor_pared)/2);
    }
    color(color_caja)
        cylinder (r=diametro/2, h = grosor_pared);
}

module tapa(){
    difference(){
        color(color_tapa)
        cylinder (r=((diametro+grosor_pared)/2), h = altura_caja-diferencia_tapa);
    
        color (color_tapa)
        translate ([0,0,grosor_pared])
        cylinder (r=((diametro)/2), h = altura_caja-diferencia_tapa);
    }
    
    color(color_tapa)
    translate([-texto_alinear,-letra_size/2,grosor_pared])
    linear_extrude(1)
    text(texto, size=letra_size, direction="ltr", spacing=1.1, font=typo);
}

module print(){
    
    if (imprimir == "caja" || imprimir == "ambas"){
        caja();
    }
    
    if (imprimir == "ambas"){
        translate ([diametro+10,0,0])
        tapa();
    }
    
    if (imprimir == "tapa"){
        //translate ([diametro+10,0,0])
        tapa();
    }
    
}

print();
    