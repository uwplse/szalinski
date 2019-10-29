//baca interior 
//MEDIDAS Y PARAMETROS
ancho_tubo=17;


alto_tubo=27;


profundidad_baca=600;


ancho_baca=1260;



altura_baca=100;


profundidal_placa=260;


altura_placa=130;


ancho_solapa=50;


distancia_agujeros=230;

difference(){
union(){
//largueros
translate([0,0,0])
  cube([profundidad_baca,ancho_tubo,alto_tubo]);
  translate([0,ancho_baca-ancho_tubo,0])
  cube([profundidad_baca,ancho_tubo,alto_tubo]);
  
//travesaños
  translate([ancho_tubo,0,-ancho_tubo])
  cube([alto_tubo,ancho_baca,ancho_tubo]);
  translate([profundidad_baca-alto_tubo,0,-ancho_tubo])
  cube([alto_tubo,ancho_baca,ancho_tubo]);
  translate([((profundidad_baca-alto_tubo-alto_tubo-alto_tubo-alto_tubo-alto_tubo)/4)+alto_tubo,0,-ancho_tubo])
  cube([alto_tubo,ancho_baca,ancho_tubo]);
  translate([((profundidad_baca-alto_tubo-alto_tubo-alto_tubo-alto_tubo-alto_tubo)/4)+((profundidad_baca-alto_tubo-alto_tubo-alto_tubo-alto_tubo-alto_tubo)/4)+alto_tubo+alto_tubo,0,-ancho_tubo])
  cube([alto_tubo,ancho_baca,ancho_tubo]);
   translate([((profundidad_baca-alto_tubo-alto_tubo-alto_tubo-alto_tubo-alto_tubo)/4)+
    ((profundidad_baca-alto_tubo-alto_tubo-alto_tubo-alto_tubo-alto_tubo)/4)+((profundidad_baca-alto_tubo-alto_tubo-alto_tubo-alto_tubo-alto_tubo)/4)+alto_tubo+alto_tubo+alto_tubo,0,-ancho_tubo])
  cube([alto_tubo,ancho_baca,ancho_tubo]);
  
 //tope posterior
translate([0,ancho_tubo,-ancho_tubo])
  cube([ancho_tubo,alto_tubo,altura_baca]);
translate([0,ancho_baca-ancho_tubo-alto_tubo,-ancho_tubo])
  cube([ancho_tubo,alto_tubo,altura_baca]);
  translate([ancho_tubo,ancho_tubo,-ancho_tubo+altura_baca-alto_tubo])
  cube([ancho_tubo,ancho_baca-ancho_tubo-ancho_tubo,alto_tubo]);
  
//placas sujeccion
translate([(profundidad_baca/2)-(profundidal_placa/2),0,0])
union(){
translate([0,-2,0])
  cube([profundidal_placa,2,altura_placa]);
  translate([0,ancho_baca,0])
  cube([profundidal_placa,2,altura_placa]);
}
//solapa
difference(){
union(){
translate([(profundidad_baca/2)-(profundidal_placa/2),0,0])
union(){
translate([0,-2,altura_placa])
  cube([profundidal_placa,ancho_solapa,2]);
  translate([0,ancho_baca-ancho_solapa+2,altura_placa])
  cube([profundidal_placa,ancho_solapa,2]);
}
}
translate([(profundidad_baca/2)-(distancia_agujeros/2),ancho_solapa/2,alto_tubo/2])
rotate([0,0,0])
cylinder(r=8/2,h=2000,$fn=50);
translate([(profundidad_baca/2)+(distancia_agujeros/2),ancho_solapa/2,alto_tubo/2])
rotate([0,0,0])
cylinder(r=8/2,h=2000,$fn=50);

translate([(profundidad_baca/2)-(distancia_agujeros/2),(2+ancho_baca)-(ancho_solapa/2),alto_tubo/2])
rotate([0,0,0])
cylinder(r=8/2,h=2000,$fn=50);
translate([(profundidad_baca/2)+(distancia_agujeros/2),(2+ancho_baca)-(ancho_solapa/2),alto_tubo/2])
rotate([0,0,0])
cylinder(r=8/2,h=2000,$fn=50);
}

}

//agujeros
translate([(profundidad_baca/2)-(distancia_agujeros/2),-50,alto_tubo/2])
rotate([-90,0,0])
cylinder(r=8/2,h=2000,$fn=50);
translate([(profundidad_baca/2)+(distancia_agujeros/2),-50,alto_tubo/2])
rotate([-90,0,0])
cylinder(r=8/2,h=2000,$fn=50);

translate([(profundidad_baca/2)-(distancia_agujeros/2),-50,(altura_placa/5)*2])
rotate([-90,0,0])
cylinder(r=8/2,h=2000,$fn=50);
translate([(profundidad_baca/2)+(distancia_agujeros/2),-50,(altura_placa/5)*2])
rotate([-90,0,0])
cylinder(r=8/2,h=2000,$fn=50);

translate([(profundidad_baca/2)-(distancia_agujeros/2),-50,(altura_placa/5)*3])
rotate([-90,0,0])
cylinder(r=8/2,h=2000,$fn=50);
translate([(profundidad_baca/2)+(distancia_agujeros/2),-50,(altura_placa/5)*3])
rotate([-90,0,0])
cylinder(r=8/2,h=2000,$fn=50);

translate([(profundidad_baca/2)-(distancia_agujeros/2),-50,(altura_placa/5)*4])
rotate([-90,0,0])
cylinder(r=8/2,h=2000,$fn=50);
translate([(profundidad_baca/2)+(distancia_agujeros/2),-50,(altura_placa/5)*4])
rotate([-90,0,0])
cylinder(r=8/2,h=2000,$fn=50);

}







