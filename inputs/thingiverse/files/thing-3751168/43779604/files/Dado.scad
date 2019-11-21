/*[ propiedades del dado]*/
//escala = 20; //[10, 20, 30, 50, 100]
escala = 20;//[5 : 100]

difference(){
//cuerpo del dado
    intersection(){
        cube(escala, center=true);
        sphere(escala-(escala/4),$fn=escala*5);
    }
//cara del 1
   translate([escala/2,0,0])
   sphere(escala/10,$fn=escala);
  
//cara del 3
   translate([0,escala/2,0])
   sphere(escala/10,$fn=escala);
   translate([escala/4,escala/2,escala/4])
   sphere(escala/10,$fn=escala);
   translate([-escala/4,escala/2,-escala/4])
   sphere(escala/10,$fn=escala);
    
//cara del 5
   translate([0,0,escala/2])
   sphere(escala/10,$fn=escala);
   translate([escala/4,escala/4,escala/2])
   sphere(escala/10,$fn=escala);
   translate([-escala/4,-escala/4,escala/2])
   sphere(escala/10,$fn=escala);
   translate([escala/4,-escala/4,escala/2])
   sphere(escala/10,$fn=escala);
   translate([-escala/4,escala/4,escala/2])
   sphere(escala/10,$fn=escala);
   
//cara del 6
   translate([-escala/2,escala/4,escala/4])
   sphere(escala/10,$fn=escala);
   translate([-escala/2,0,escala/4])
   sphere(escala/10,$fn=escala);
   translate([-escala/2,-escala/4,escala/4])
   sphere(escala/10,$fn=escala);
   translate([-escala/2,escala/4,-escala/4])
   sphere(escala/10,$fn=escala);
   translate([-escala/2,0,-escala/4])
   sphere(escala/10,$fn=escala);
   translate([-escala/2,-escala/4,-escala/4])
   sphere(escala/10,$fn=escala);
   
//cara del 4
   translate([-escala/4,-escala/2,escala/4])
   sphere(escala/10,$fn=escala);
   translate([-escala/4,-escala/2,-escala/4])
   sphere(escala/10,$fn=escala);
   translate([escala/4,-escala/2,-escala/4])
   sphere(escala/10,$fn=escala);
   translate([escala/4,-escala/2,escala/4])
   sphere(escala/10,$fn=escala);
   
//cara del 2
   translate([-escala/4,escala/4,-escala/2])
   sphere(escala/10,$fn=escala);
   translate([escala/4,-escala/4,-escala/2])
   sphere(escala/10,$fn=escala);
   }