//---------------------------------------------------------------
//   Bars ring generator
//   Generador de anillos de barras
//     2018-07-26 -- 2018-07-27
//
//   Released under the GPL license
//   Publicado bajo licencia GPL
//     https://www.gnu.org/licenses/gpl.html
//---------------------------------------------------------------

//Middle bars witdth - Anchura de las barras del medio
ancho_barra = 1; //[0.5: 0.1: 10]
//End bars radius - Radio de la barra final
ancho_barra_final=1.25; //[0.5: 0.125: 10]
//Shape parameter A - Par&aacute;metro de forma A
caida_lateral_sup = 1.125; //[1: 0.125: 1.5]
//Shape parameter B - Par&aacute;metro de forma B
abombamiento_sup = 1.5; //[1.125: 0.125: 1.75]
//Deepth between bars - Profundidad entre barras
relieve = 1.5; //[1.125: 0.125: 1.75]
//Number of bars - N&uacute;mero de barras
num_barras = 10; //[2: 1: 50]
//Heigth of the ring - Altura del anillo
alto_anillo = 3.5; //[1.5: 0.125: 7.5]
//Size of the ring - Talla del anillo
interior_anillo = 10; //[2.5: 0.125: 100]
//Resolution of relief - Resoluci&oacute;n del relieve (5 or 6)
resolucion_relieve = 4; //[3: 1: 6]
//Resolution of ring - Resoluci&oacute;n del aro (5 or 6)
resolucion_aro = 4; //[2: 1: 6]
//Generate a ring or a section - Generar un anillo o una secci&oacute;n
generar_anillo = 1; //  [1:Ring,0:Section]

num_circulos = (num_barras -1) / 2;

x_cuerpo_central = num_circulos * ancho_barra + ancho_barra_final + ancho_barra/2;
y_cuerpo_central_fin = alto_anillo - (ancho_barra )/(relieve );
y_cuerpo_central_inicio = ancho_barra_final*1.125;
y_mover_baras_superiores = alto_anillo-abombamiento_sup-(ancho_barra/relieve);
//echo(ancho_barra/relieve); echo(y_mover_baras_superiores);

module circulo(num, num_max){
  if(num >= 0){
    union(){
      translate([num*ancho_barra,sqrt(1 - (num*num)/num_max)*abombamiento_sup,0])circle(r=ancho_barra/relieve, center=true, $fn=(pow (2, resolucion_relieve)) );
      circulo(num-1, num_max);
    }
  }
}

module circulos(num_max){
  circulo(num_max, num_max * num_max*caida_lateral_sup);
}

module forma(){
  num_max = num_circulos * num_circulos*caida_lateral_sup;
  barra_intermedia = num_circulos / 2;
  puntos_poligono = [
    [0, 0],
    [0, y_cuerpo_central_fin - ( (num_barras == 2) ? ancho_barra/2 : 0)],
    [barra_intermedia*ancho_barra, y_mover_baras_superiores + sqrt(1 - ((barra_intermedia*barra_intermedia)/num_max))*abombamiento_sup - ( (num_barras == 2) ? ancho_barra/2 : 0)],
    [num_circulos*ancho_barra, y_mover_baras_superiores + sqrt(1 - ((num_circulos*num_circulos)/num_max))*abombamiento_sup],
    [num_circulos*ancho_barra, y_cuerpo_central_inicio],
    [x_cuerpo_central, y_cuerpo_central_inicio],
    [x_cuerpo_central, 0]
  ];
  //echo(num_max);
  union(){
    union(){
      polygon(points = puntos_poligono);
      intersection() {
        translate([0,y_mover_baras_superiores,0])circulos(num_circulos);
        square(size = [x_cuerpo_central, 4], center = false);
      }
    }
    translate([x_cuerpo_central,ancho_barra_final,0])circle(r=ancho_barra_final, center=true, $fn=(pow (2, resolucion_relieve)) );
  }
}

module anillaco(){
  rotate_extrude(angle = 360, $fn = (pow (2, resolucion_aro)))
  rotate([0,0,90])
  translate([0, interior_anillo, 0])forma();
}

union(){
  if(generar_anillo){
    translate([0, 0, ancho_barra_final * 2 + ancho_barra * num_barras / 2])
      union(){
        anillaco();
        mirror([0,0,1])anillaco();
      }
  }else{
    rotate([90,0,0])union(){
      linear_extrude(height = interior_anillo * 2)forma();
      mirror([1,0,0])linear_extrude(height = interior_anillo * 2)forma();
    }
  }
}