//---------------------------------------------------------------
//   Generador de piezas Exin Castillos
//
//   Publicado bajo licencia Creative Commons Atribucion-NoComercial-CompartirIgual:
//     https://creativecommons.org/licenses/by-nc-sa/4.0/deed.es
//   Released under the Creative Commons Attribution-Non Commercial-ShareAlike license:
//     https://creativecommons.org/licenses/by-nc-sa/4.0/
//---------------------------------------------------------------

/* [Comun] */
tipo_pieza = 1; //[1:Bloque/Placa, 2:Curva, 3:Poligono, 4:Esquina]
//Es un remate liso o tiene tetones
es_remate = 0; //[1:Si, 0:No]
//Altura de la pieza en exinios
altura = 1; //[0.5:0.5:2]

/* [Bloque] */
//Anchura del bloque
anchura = 2; //[1:20]
//Largura del bloque
largura = 1; //[1:20]

/* [Curva] */
//Diametro en exinios de la curva
diametro = 7; //[5:2:19]
//Numero total de tetones de la circunferencia
numero_tetones = 16; //[8:4:64]
//Los tetones de la pieza, no rebasar el medio arco
tetones_corte = 3; //[1:64]
//Recto si ira junto a un bloque
tipo_corte_1 = 1; //[1:Recto, -1:Diagonal]
//Recto si ira junto a un bloque
tipo_corte_2 = 1; //[1:Recto, -1:Diagonal]

/* [Poligonal] */
//Numero de lados del poligono
lados_poligono = 3; //[3:12]

/* [Esquina] */
//Angulo de la esquina
angulo_esquina = 90; //[15:90]

/* [Hidden] */
exinio = 12.35;
exiniz = 12.5;
tetonr = 4.8; //radio teton
tetonz = 2; //altura teton (sin parte biselada)
tetonbr = 0.5; //radio parte biselada teton
huecox = 2*tetonr; //anchura hueco
grosorx = (exinio-huecox)/2; //grosor pared exterior lateral
grosorz = 2.5; //grosor pared superior
detalle = 16; // definicion de las curvas


mostrar();

module mostrar(){
   if(tipo_pieza==1) bloque();
   else if (tipo_pieza==2) curva();
   else if (tipo_pieza==3) poligono();
   else if (tipo_pieza==4) esquina(angulo_esquina);
}

module bloque(){
   difference(){
      //bloque macizo y tetones
      union(){
         cube([anchura*exinio, largura*exinio, altura*exiniz]);
         if(es_remate==0)
            for(x=[1:anchura])
               for(y=[1:largura])
                  translate([exinio*(x-0.5), exinio*(y-0.5), 1*altura*exiniz]) 
                     teton();
      }
      //huecos
      union(){
         for(x=[1:anchura])
            for(y=[1:largura])
               translate([exinio*(x-0.5), exinio*(y-0.5), 0]) 
                  hueco();
      }
   }
}

module baldosa(){
   difference(){
      cube([anchura*exinio, largura*exinio, altura*exiniz]);
      union(){
         for(x=[1:anchura])
            for(y=[1:largura])
               translate([exinio*(x-0.5), exinio*(y-0.5), 0]) 
                  hueco();
      }
   }
}

module curva(){
   //bloque
   difference(){
      union(){
         cylinder(altura*exiniz, d=diametro*exinio, $fn=detalle*diametro);
         //tetones
         if(es_remate==0)
            for(n=[1:numero_tetones])
               rotate([0,0,360/numero_tetones*n])
                  translate([(diametro-1)/2*exinio, 0, altura*exiniz])
                     teton();
      }
      union(){
         //hueco central
         translate([0,0,-.5])
            cylinder(altura*exiniz+1, d=(diametro-2)*exinio, $fn=detalle*(diametro-2));
         //hueco bajos
         translate([0,0,(altura*exiniz-grosorz)/2])
            rotate_extrude($fn=detalle*diametro)
               translate([(diametro-1)/2*exinio, 0, 0])
                  square([huecox,altura*exiniz-grosorz+.001], true);
         //corte
         union(){
            translate([-diametro*exinio*0.55, tipo_corte_1*exinio/2, -(altura*exiniz-tetonz)*.5])
             cube([diametro*exinio*1.1, diametro*exinio, (altura*exiniz+tetonz)*2]);
            rotate([0,0,180+360/numero_tetones*(tetones_corte-(tipo_corte_1+tipo_corte_2)/2)])
                translate([-diametro*exinio*0.55, tipo_corte_2*exinio/2, -(altura*exiniz-tetonz)*.5])
                 cube([diametro*exinio*1.1, diametro*exinio, (altura*exiniz+tetonz)*2]);
         }
      }
   }
   //pared corte 1
   if((diametro<=7)&&(tipo_corte_1<0))
      translate([-(diametro-2)/2*exinio*cos(360/numero_tetones/diametro*2) -grosorx/2*0 , exinio/2*tipo_corte_1, 0])
          rotate([0,0,180])
           cube([huecox+grosorx, grosorx, altura*exiniz]);
   else
      translate([-(diametro-2)/2*exinio*cos(360/numero_tetones/diametro*2) -grosorx/2 , exinio/2*tipo_corte_1, 0])
          rotate([0,0,180])
           cube([huecox+grosorx, grosorx, altura*exiniz]);
   
   //pared corte 2
   if((diametro<=7)&&(tipo_corte_1<0))
       rotate([0,0,360/numero_tetones*(tetones_corte-(tipo_corte_1+tipo_corte_2)/2)])
           translate([-(diametro)/2*exinio*cos(360/numero_tetones/diametro*2) +grosorx/1.25 , -exinio/2*tipo_corte_2, 0])
                   cube([huecox+grosorx, grosorx, altura*exiniz]);
   else
       rotate([0,0,360/numero_tetones*(tetones_corte-(tipo_corte_1+tipo_corte_2)/2)])
           translate([-(diametro)/2*exinio*cos(360/numero_tetones/diametro*2) +grosorx/2 , -exinio/2*tipo_corte_2, 0])
                   cube([huecox+grosorx, grosorx, altura*exiniz]);
}

module poligono(){
   if(lados_poligono>4){
      union(){
         partePoligono();
         mirror([1,0,0]) partePoligono();
      }
   }
   else{
      esquina(30*lados_poligono - 30);
   }
}

module esquina(ang){
   union(){
      parteEsquina(ang);
      mirror([1,0,0]) parteEsquina(ang);
      //teton medio
      if(es_remate==0)
         translate([0, exinio/(2*sin(ang/2)), 2*exiniz])
            teton();
   }
}

module parteEsquina(ang){
   difference(){
      rotate([0,0, -ang/2])
         difference(){
            union(){
               //bloque macizo y teton extremo
               translate([-exinio,-exinio,0])
                  cube([exinio, 9*exinio, 2*exiniz]); //15 grados: 8+1 exinio (1/tan(ang/2)+1)
               if(es_remate==0)
                  translate([-exinio/2, -exinio/2, 2*exiniz])
                     teton();
            }
            //huecos
            union(){
               //hueco bajo teton
               translate([grosorx-exinio, grosorx-exinio, -0.001]) 
                  cube([huecox,huecox,2*exiniz-grosorz]);
               //hueco bajo esquina
               translate([grosorx-exinio, grosorx, -0.001]) 
                  cube([exinio,huecox+8*exinio,2*exiniz-grosorz]);
               //quita un exinio bajo la parte del teton
               translate([-exinio,-exinio,0])
                  cube([exinio, exinio, exiniz]);
               //corte para placa y baldosa
               if(altura < 1)
                  translate([-exinio,-exinio,0])
                     cube([2*exinio, 9*exinio, 1.5*exiniz]);
            }
         }
      //plano de corte
      translate([0, 0, -.5*exiniz])
         cube([6*exinio, 12*exinio, 3*exiniz]);
   }
}


module partePoligono(){
   difference(){
      rotate([0,0, -180/lados_poligono])
         difference(){
            union(){
               //bloque macizo y teton
               translate([-exinio,0,0])
                  cube([2*exinio, exinio, 2*exiniz]);
               if(es_remate==0)
                  translate([exinio/2, exinio/2, 2*exiniz])
                     teton();
            }
            //huecos
            union(){
               //huecos bajo teton y esquina
               for(n=[0:1])
                  translate([grosorx-exinio*n, grosorx, -0.001]) 
                     cube([huecox,huecox,2*exiniz-grosorz]);
               //quita un exinio bajo la parte del teton
               cube([exinio, exinio, exiniz]);
               //corte para placa y baldosa
               if(altura < 1)
                  translate([-exinio,0,0])
                     cube([2*exinio, exinio, 1.5*exiniz]);
            }
         }
      //plano de corte
      translate([-2*exinio, 0, 0])
         cube([2*exinio, 2*exinio, 2*exiniz]);
   }
}

module teton(){
   union(){
      cylinder(tetonz, r=tetonr, $fn=detalle);
      translate([0,0,tetonz]){
         rotate_extrude($fn=detalle)
            translate([tetonr-tetonbr,0,0])
               circle(tetonbr, $fn=16);
         cylinder(tetonbr, r=tetonr-tetonbr, $fn=detalle);
      }
   }
}

module hueco(){
   translate([grosorx-exinio/2, grosorx-exinio/2, -0.001])
      cube([huecox,huecox,altura*exiniz-grosorz]);
}