//**********************************************************Design by 3 Eixos**********************************************************//
//**********************************************************Rodrigo Franco**********************************************************// 

/* [Texto] */
//Primeira linha de texto
Texto_1="3 Eixos";
//Segunda linha de texto
Texto_2="99675-2252";
//Posição dos textos
TexPos = 1; //[0:8]
//Distancia entre textos
Tex_Dis = 5; // [0:8]
//tamanho fonte 1
Tam_Tex_1=7; //[4:10]
//tamanho fonte 2
Tam_Tex_2=4; //[4:10]
//Numero de lados do poligono
Numlado=11; //[3:20]
//Diametro da medalha
diameter=40; //[30:80]
//Posição do Furo
fur_pos="ponto1"; //[ponto1,ponto2]

/* [Config interna] */
linguagem="en";
numcam=6;
borda=2;
cambord=3;
furint=5;



//Texto
translate ([0,-TexPos,0]){
    linear_extrude (height=0.32*numcam){
        translate([0,1,0]){
    text (Texto_1, size=Tam_Tex_1, font="Arial:style=Bold",halign = "center", valign="bottom", language = linguagem);
        }
       translate ([0,-(Tex_Dis),0]){
    text (Texto_2, size=Tam_Tex_2, font="Arial:style=Bold",halign = "center", valign="top", language = linguagem);
       }
    }
}
//Medalha
    render(){
    if (fur_pos=="ponto1"){
    difference (){
    union(){
        rotate([0,0,-((Numlado-2)*90)/Numlado]){
    difference(){
    cylinder (h=numcam*0.32, d=diameter,$fn= Numlado);
        translate([0,0,(numcam-cambord)*0.32]){
        cylinder (h=cambord*0.32, d=diameter-(2*borda),$fn= Numlado);
        }
    }
}
    translate ([0,((diameter/2)-((furint/2)+(1.5*borda))),0]){
    cylinder (h=numcam*0.32, d=furint+(2*borda),$fn=30);
    }
}
    
    translate ([0,((diameter/2)-((furint/2)+(1.5*borda))),0]){
        cylinder (h=numcam*0.32, d=furint ,$fn=30);
    }
}
}
    else if (fur_pos=="ponto2"){
     difference (){
    union(){
        rotate([0,0,-((((Numlado-2)*90)/Numlado)-(180/Numlado))]){
    difference(){
    cylinder (h=numcam*0.32, d=diameter,$fn= Numlado);
        translate([0,0,(numcam-cambord)*0.32]){
        cylinder (h=cambord*0.32, d=diameter-(2*borda),$fn= Numlado);
        }
    }
}
    translate ([0,((diameter/2)-((furint/2)+(2*borda))),0]){
    cylinder (h=numcam*0.32, d=furint+(2*borda),$fn=30);
    }
}
    
    translate ([0,((diameter/2)-((furint/2)+(2*borda))),0]){
        cylinder (h=numcam*0.32, d=furint ,$fn=30);
    }
}
}
}