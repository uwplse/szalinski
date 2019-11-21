/*
// RECURSION 3D. Sci-Fi City Builder


// Por: Fernando Jerez Garrido
// http://www.thingiverse.com/thing:1680965

// Developed on: OpenSCAD version 2016.05.12 (git 7b8265a) 
// Tested on printer: BQ Prusa i3 Hephestos
//
// Hints for print:
// NO SUPPORTS!! : geometry generated print well without supports. 
// INFILL recomended:15%-20% Acts as support from inside and the roofs/flat parts prints better. 



// Random seed (for testing in OpenSCAD)
seed=round(rands(1,1000000,1)[0]); // random seed
echo (str("Seed: ",seed)); 
*/

// Seed (engraved at the bottom of figure)
seed = 492431;

// Kind of base (poligonal , rectangle or circle)
base = "rectangle"; // [poligon:Poligonal, rectangle:Rectangle, circle:Circle]

// Base height.
base_height = 2;         

/* [Poligonal Base] */

// Number of sides
num_sides = 8;      
// Side Length (size of figure is calculated from number and length of sides)
//side_length = 9.75;        
side_length = 50;

// Position of figure (inscribed or circumscribed to polygon)
position = "inscribed"; // [inscribed:inscribed, circumscribed:Circumscribed]
//Separation from border of poligon
separation = 1;
// You may need supports if figure is wider than base-poligon.
supports="yes"; // [yes:Yes. make supports, no:No. I can do it with my slicer software]



/* [Rectangle base] */

// Size in X axis
size_x = 80;    
// Size in Y axis
size_y = 80;


/* [Circular base] */
// Diameter of circle
diameter = 80;



 
/* [Hidden] */
$fn=40; // Number of faces for cylinders
min_size = 3; // stops recursion at this size
level_height = 1; // height of levels. works good with 1, higher heights make weird things



randoms = rands(0,1000,10000,seed); // random sequence



if(base=="poligon"){
    poligonal_base(side_length,num_sides,base_height);
}else if(base=="circle"){
 
          if(base_height>0){
              difference(){
                  cylinder(r=diameter/2,h=base_height);        
                  translate([0,3.5,-0.1]) mirrored_seed();
              }
          }

          translate([0,0,base_height])
              cylinder_rec([diameter,diameter, level_height],0); // Begins the Cylinder
    
      }else if(base=="rectangle"){
 
          if(base_height>0){
              difference(){
                  cube([size_x,size_y,base_height],center=true);
                  translate([0,3.5,-base_height*0.5-0.1]) mirrored_seed();
              }
          }        
          translate([0,0,base_height*0.5])
              cube_rec([size_x,size_y,level_height],0); // Cube
    }
    
    





// Returns the n-th number modularized into range[a,b]
function random(a,b,n)= a+( ceil(randoms[n%3000]) % (1+(b-a)) );


    
 


module mirrored_seed(){
    

    
    mirror([1,0,0])
        linear_extrude(height = 1) {
            // avoid the e+006 notation for numbers with more than 6 digits
            if(seed>=1000000){
                text(text = str(floor(seed/1000000),(seed%1000000)), size = 3, halign = "center");
            }else{
                text(text = str(seed), size = 3, halign = "center");
            }
        }
}

module poligonal_base(lado,numlados,altura){

    // espacio que sobresale la circunferencia creada sobre la base
    borde = separation;          

    // Datos calculados
    // radio de la circunferencia inscrita (apotema)
    alfa = 360/numlados;
    ap = lado / (2*tan(alfa/2));

    // radio de la circuferencia circunscrita
    semilado = lado / 2;
    radio = sqrt(ap*ap+semilado*semilado);

    // Base poligonal con boquete
    difference(){
        rotate([0,0,alfa/2]) cylinder(r1=radio,r2=radio,h=altura,$fn=numlados);
        translate([0,0,-0.01]){
            cylinder(r = 2.5,h=altura,$fn=50);
        }
        rotate([0,0,-90])
            translate([0,3,-0.1])
                mirrored_seed();
    }

    
    // FIGURA
    translate([0,0,altura]){
        if(position=="inscribed"){
            // inscribed
            cylinder_rec([(ap-borde)*2,(ap-borde)*2,level_height],0); 
        }else{
            // Circumscribed
            cylinder_rec([(radio+borde)*2,(radio+borde)*2,level_height],0); 
            if(supports=="yes"){
                // ads supports if needed
                if ( (radio+borde - ap)>=1.5){
                    diam = (radio+borde)*2;
                    sep = 3; // separation (mms entre barras)
                    numbarras =1+(diam / sep);
                    intersection(){
                        difference(){
                            union(){
                                for(i=[1:numbarras]){
                                    translate([-0.4+((i-(numbarras/2)) *sep),0,-altura/2 -0.3])
                                        cube([0.6,diam,altura-0.6],center=true);
                                }
                                translate([0,0,-altura-0.01])
                                    cylinder(r=(radio+borde)+1.5,h=0.3);                        
                            }
                            union(){
                                for(i=[1:numbarras]){
                                    translate([0,-0.4+((i-(numbarras/2)) *sep),0])
                                        cube([diam,1.5,altura],center=true);
                                }
                            }
                          
                            
                            
                            translate([0,0,-altura-0.02])
                                rotate([0,0,alfa/2]) 
                                    cylinder(r=radio+1.5,h=altura,$fn=numlados);
                        }
                        translate([0,0,-altura-0.01])
                            cylinder(r=(radio+borde)+1.5,h=altura);
                    }
                    
                }
            }
        }
    }
}


module cube_rec(size,rn){
    sx = size[0];
    sy = size[1];
    sz = size[2];

    diameter = min(sx,sy);
    radius = diameter/2;
    
    r=1;
 
    cube(size,center=true);
    
    if(sx>=min_size && sy>=min_size){ 
        opcion = random(1,6,rn);
      
        if(opcion==1){
            // Reduce
            reduce = 0;
            translate([0,0,sz]){     
                cube_rec([sx-reduce,sy-reduce,sz],rn+1);
            }
        }else if(opcion==2){
            // Divide en X
            translate([0,0,sz]){     
                translate([sx/4,0,0])
                    cube_rec([sx/2-r,sy-r,sz],rn+11);
                translate([-sx/4,0,0])
                    cube_rec([sx/2-r,sy-r,sz],rn+97);
            }
        }else if(opcion==3){
            // Divide en Y
            translate([0,0,sz]){     
                translate([0,sy/4,0])
                    cube_rec([sx-r,sy/2-r,sz],rn+31);
                translate([0,-sy/4,0])
                    cube_rec([sx-r,sy/2-r,sz],rn+51);
            }
        }else if(opcion==4){
            // Piramide
            t1=0.2;
            translate([0,0,0]){
                // Centro
                difference(){
                    rotate([0,0,45]) cylinder(r1 = radius*1.15,r2 = radius*1.15,h=diameter*0.3,$fn=4);
                    scale([1,1,1.3]){
                    translate([0,radius*1.05,0]) rotate([0,90,0]) cylinder(r = radius*0.5,h=diameter,$fn=40,center=true);
                    translate([0,-radius*1.05,0]) rotate([0,90,0]) cylinder(r = radius*0.5,h=diameter,$fn=40,center=true);
                    rotate([0,0,90]){
                        translate([0,radius*1.05,0]) rotate([0,90,0]) cylinder(r = radius*0.5,h=diameter,$fn=40,center=true);
                        translate([0,-radius*1.05,0]) rotate([0,90,0]) cylinder(r = radius*0.5,h=diameter,$fn=40,center=true);
                    }
                    }
                }
                
                
                // Cubo_rec
                translate([0,0,diameter*0.3])
                  cube_rec([diameter*0.8,diameter*0.8,sz],rn+1);
                
                // rellena laterales
                translate([radius*0.8,0,0])
                  cube_rec([diameter*0.2,diameter*0.6,sz],rn+23);
                translate([-radius*0.8,0,0])
                  cube_rec([diameter*0.2,diameter*0.6,sz],rn+57);
                translate([0,radius*0.8,0])
                  cube_rec([diameter*0.6,diameter*0.2,sz],rn+73);
                translate([0,-radius*0.8,0])
                  cube_rec([diameter*0.6,diameter*0.2,sz],rn+11);

                translate([radius*0.8,radius*0.8,0]) cylinder_rec([diameter*0.2,diameter*0.2,sz],rn+34);
                translate([radius*0.8,-radius*0.8,0]) cylinder_rec([diameter*0.2,diameter*0.2,sz],rn+36);
                translate([-radius*0.8,radius*0.8,0]) cylinder_rec([diameter*0.2,diameter*0.2,sz],rn+38);
                translate([-radius*0.8,-radius*0.8,0]) cylinder_rec([diameter*0.2,diameter*0.2,sz],rn+43);
                
                    
                
                //Lateral cubes
                if(sx>sy){
                    space = sx-sy;
                    translate([radius+space/4,0,0])
                        cube_rec([space/2-r,sy-r,sz],rn+61);
                    translate([-(radius+space/4),0,0])
                        cube_rec([space/2-r,sy-r,sz],rn+73);
                }else{
                    space = sy-sx;
                    translate([0,radius+space/4,0])
                        cube_rec([sx-r,space/2-r,sz],rn+51);
                    translate([0,-(radius+space/4),0])
                        cube_rec([sx-r,space/2-r,sz],rn+97);
                }
            }
        }else if(opcion==5){
            // Tower
            
            if(radius>10){
                altura = diameter*0.75;
                translate([0,0,altura/2]){
                    difference(){
                        union(){
                            cube([diameter,diameter*0.1,altura],center=true);
                            cube([diameter*0.1,diameter,altura],center=true);
                            translate([0,0,altura*0.1])
                            cylinder(r1=0,r2=altura*0.4,h=altura*0.4);
                        }
                        translate([altura*0.95,diameter*0.5,altura*0.15])
                        rotate([90,0,0]) cylinder(r = altura*0.8,h=diameter,$fn=50);
                        translate([-altura*0.95,diameter*0.5,altura*0.15])
                        rotate([90,0,0]) cylinder(r = altura*0.8, h=diameter,$fn=50);
                        translate([-diameter*0.5,altura*0.95,altura*0.15])
                        rotate([0,90,0]) cylinder(r = altura*0.8, h=diameter,$fn=50);
                        translate([-diameter*0.5,-altura*0.95,altura*0.15])
                        rotate([0,90,0]) cylinder(r = altura*0.8, h=diameter,$fn=50);
                        
                        translate([0,0,-altura/2]) scale([1,1,2]) sphere(altura*0.25);
                    }
                    difference(){
                        union(){
                            cube([diameter,diameter*0.05,altura],center=true);
                            cube([diameter*0.05,diameter,altura],center=true);
                            translate([0,0,altura*0.1])
                            cylinder(r1=0,r2=altura*0.4,h=altura*0.4);
                        }
                        translate([altura*1,diameter*0.5,altura*0.15])
                        rotate([90,0,0]) cylinder(r = altura*0.8,h=diameter,$fn=50);
                        translate([-altura*1,diameter*0.5,altura*0.15])
                        rotate([90,0,0]) cylinder(r = altura*0.8, h=diameter,$fn=50);
                        translate([-diameter*0.5,altura*1,altura*0.15])
                        rotate([0,90,0]) cylinder(r = altura*0.8, h=diameter,$fn=50);
                        translate([-diameter*0.5,-altura*1,altura*0.15])
                        rotate([0,90,0]) cylinder(r = altura*0.8, h=diameter,$fn=50);
                        
                        translate([0,0,-altura/2]) scale([1,1,2]) sphere(altura*0.25);
                    }

                }
                cylinder_rec([radius*0.5,radius*0.5,sz],rn+77);
                translate([radius*0.55,radius*0.55,0]) cube_rec([radius*0.9,radius*0.9,sz],rn+23);
                translate([radius*0.55,-radius*0.55,0]) cube_rec([radius*0.9,radius*0.9,sz],rn+53);
                translate([-radius*0.55,radius*0.55,0]) cube_rec([radius*0.9,radius*0.9,sz],rn+73);
                translate([-radius*0.55,-radius*0.55,0]) cube_rec([radius*0.9,radius*0.9,sz],rn+123);
    
                translate([0,0,altura])
                    cube_rec([altura*0.55,altura*0.55,sz],rn+111);
            
                //Lateral cubes
                if(sx>sy){
                    space = sx-sy;
                    translate([radius+space/4,0,0])
                        cube_rec([space/2-r,sy-r,sz],rn+61);
                    translate([-(radius+space/4),0,0])
                        cube_rec([space/2-r,sy-r,sz],rn+73);
                }else{
                    space = sy-sx;
                    translate([0,radius+space/4,0])
                        cube_rec([sx-r,space/2-r,sz],rn+51);
                    translate([0,-(radius+space/4),0])
                        cube_rec([sx-r,space/2-r,sz],rn+97);
                }
            }else{
                translate([0,0,sz]){     
                    cube_rec([sx-1,sy-1,sz],rn+1);
                }
            }
        }else{
            // Cambia a Cilindro
            translate([0,0,0]){     
                diameter = min(sx,sy);
                radius = diameter/2;
                cylinder_rec([diameter-1,diameter-1,sz],rn+10);
                //Lateral cubes
                if(sx>sy){
                    space = sx-sy;
                    translate([radius+space/4,0,0])
                        cube_rec([space/2-r,sy-r,sz],rn+25);
                    translate([-(radius+space/4),0,0])
                        cube_rec([space/2-r,sy-r,sz],rn+30);
                }else{
                    space = sy-sx;
                    translate([0,radius+space/4,0])
                        cube_rec([sx-r,space/2-r,sz],rn+47);
                    translate([0,-(radius+space/4),0])
                        cube_rec([sx-r,space/2-r,sz],rn+50);
                }
                
            }
            
        }
    }
}

module cylinder_rec(size,rn){
    sx = size[0];
    sy = size[1];
    sz = size[2];
    radius = min(sx,sy) /2;
    diameter = radius*2;
    
    cylinder(h=sz,r1=radius,r2=radius-1,center=false);
    
    
    if( (diameter)>=min_size){ 
        opcion = random(1,5,rn);
         
        if(opcion==1){
            // Reduce
            translate([0,0,sz]){     
                cylinder_rec([sx-2,sy-2,sz],rn+1);
            }
        }else if(opcion==2){
            // Columnitas
            translate([0,0,sz]){     
                // tronco central
                difference(){
                cylinder(r1=radius*0.8,r2 = radius*0.9,h=radius*0.6,$fn=20);
                union(){
                    numcols = 8;
                    for(i=[1:numcols]){
                        rotate([0,0,22.5+i*360.0/numcols])
                            translate([radius*0.5,0,0])
                                rotate([0,90,0])
                                    scale([2,1,1])
                                        cylinder(r=radius*0.2,h=radius*0.6,$fn=50);
                    }
                }
                }
            
                // recursion -->cylinder_rec
                translate([0,0,radius*0.6])
                cylinder_rec([diameter*0.9,diameter*0.9,sz],rn+1);
          
          }
        }else if(opcion==3){
            // knob
            difference(){
                union(){
                    cylinder(r=radius*0.9,h=radius*0.3);
                    translate([0,0,radius*0.3])
                        cylinder(r1=radius*0.9,r2=radius*0.8,h=radius*0.1);
                }
                union(){
                    for(i = [0:45:359]){
                        rotate([0,0,i]) translate([radius,0,0]) cylinder(r=radius*0.2,h=radius*0.41);
                    }
                    
                }
            }
            
            // recursion -->cylinder_rec
            translate([0,0,radius*0.4]){
                cylinder_rec([diameter*0.8,diameter*0.8,sz],rn+97);
            }
          
            
        }else if(opcion==4){
          
                // Arcs
                union(){
                    intersection(){
                        sphere(radius*0.95);
                        translate([0,0,radius/2])
                            cube([diameter*0.1,diameter,radius],center=true);
                    }
                    intersection(){
                        sphere(radius*0.95);
                        translate([0,0,radius/2])
                            cube([diameter,diameter*0.1,radius],center=true);
                    }
                }
                // Cupula
                difference(){
                    sphere(radius*0.85);
                    translate([0,0,-radius/2])
                    cube([diameter,diameter,radius],center=true);
                }


//          translate([0,0,radius*0.8])
//            cylinder(r=radius*0.4,h=radius*0.1);
          
            translate([0,0,radius*0.8])
                cylinder_rec([diameter*0.5,diameter*0.5,1],rn+1);
        }else{
            // Cambia a cubo
            translate([0,0,sz]){     
                cube_rec([2*(radius-sz)*0.7,2*(radius-sz)*0.7,sz],rn+5);
            }
            // 4 cilindros 
            translate([radius*0.75,0,sz])
                cylinder_rec([radius*0.25,radius*0.25,sz],rn+11);
            translate([-radius*0.75,0,sz])
                cylinder_rec([radius*0.25,radius*0.25,sz],rn+13);
            translate([0,radius*0.75,sz])
                cylinder_rec([radius*0.25,radius*0.25,sz],rn+17);
            translate([0,-radius*0.75,sz])
                cylinder_rec([radius*0.25,radius*0.25,sz],rn+23);
            
        }
    }    
    
}





