// Space cities generator 2018

// Fernando Jerez Garrido
// Licensed: CC-Attribution 

// Modifications by zx82net

// Hints for print:
// NO SUPPORTS!! : geometry generated print well without supports. 
// INFILL recomended:10%-20% Acts as support from inside and the top/flat parts prints better. 
// Use Gradual infill (in Cura slicer) to reduce printing time and save filament

/*******************************

    CUSTOMIZATION
    
********************************/
// Random seed (for testing on openSCAD)
 seed=round(rands(1,1000000,1)[0]); // random seed
 echo (str("Seed: ",seed)); 


// Seed (engraved at the bottom of figure)

seed = 1;



//seed = 3651874361; //multiple temples
//seed = 36; //lowrise +temple
//seed = 9783; //lowrise +temple
//seed = 19875347852347685; //lowrise with domes
//seed = 1339132; //lowrise with zigarat plaza
//seed = 978156081347560; //busy lowrise
//seed = 83276382376; //row of tiny towers
//seed = 36518743650183476781407; ////lowrise +temple


//seed = 1987534; //zigarat dome temple
//seed = 83276382376128764826; //pagoda zigarat temple
//seed = 133787123548715761854281724657816425176824571682547;//big domed temple
//seed = 237865028762078627830635870637237862378652087360857325687032; //temple mount
//seed = 8327638237612876482687235; //temple mount
//seed = 133913276541796425597; //massive temple
//seed = 13391327654179642559716432514769514976514973; //multiple temples
//seed = 19875347852347685412716246185243762186; // multiple domes and tower dome
//seed = 832763823; //two massive temples
//seed = 13378978697856247862; //big temple dome on a zigarat
//seed = 13378978; //temples and towers
//seed = 97835428726398725785476587326; // massive temple tower busy
//seed = 97835428726398725785476; // massive temple tower
//seed = 978354287263987257854; // massive temple tower
//seed = 978354287263987257854765873265872306; //temple amoung towers 
//seed = 97835428726398725785476587326587230652; //modest center tower with temples

//seed = 832763823761287648; //spires 
//seed = 133913; //spires 2 

//seed = 13378712354871576185428172465781642517682457168254;//fortress
//seed = 1337871235487157618542; //fortress


//seed = 9783542872639872578; // two towers
//seed = 1337871235487157618542817246578164251768245716825478; //two towers 
//seed = 133913276541796425597164; //two towers
//seed = 13391327654179642559; //two 
//seed = 97835; //tower and zigarat
//seed = 98023576908237638127906985127638071; // temple and zigarat


//seed = 97835428726398725785476587326587230; //massive zigarat
//seed = 365187436501834767814073; //massive zigarat
//seed = 36518743650; //tiered zigarat
//seed = 36518743650183476781407368041736140874654018; //zigarat
//seed = 980235769082376381; //zigarat with tower
//seed = 8327638237612876482687235117286872687; //small zigarat


//seed = 9783542872639872578547658732658723065238768; //plaza
//seed = 3651874365; //lowrise plaza
//seed = 365187436501834767814073680417361408; //small plaza 
//seed = 3651874365018347678140736; //plaza with arches
//seed = 13391; //plaza with arches 2
//seed = 23; //plaza with zigarat and ring of domes
//seed = 8327638237612876482687235117; // plaza and temples either side
//seed = 19875347852347685412716246185243762; //plaza with tower in center
//seed = 123765348768; // plaza


//seed = 98023576908237638; //archology
//seed = 2; //archology
//seed = 8327638237612876482687235117286872687153; //pagoda zigarat 
//seed = 83276382376128764826872351172868726; //pagoda with temples 
//seed = 978354287263987257854765873265872306523876; //central zigarat
//seed = 133787123548715761; //central busy zigarat
//seed = 133913276541796425597164325; ///central busy zigarat
//seed = 13391327654179642559716432514769514976; //archology with spires out front 


//seed = 2378650287; // tower of babel
//seed = 198753; // tower of babel 2
//seed = 1339132765417964255971643251476951497651497; // tower of babel 3
//seed = 13378712354871576185428172465; //pointy tower 
//seed = 13378712354871576185428172; //weird tower
//seed = 13391327654179; //busy tower
//seed = 8327638237612876482687235; //nice tower zigarat pagoda 
//seed = 8327638237612876482687; //zigarat tower zigarat 
//seed = 0; // busy tower
//seed = 9781560813475608754136087354168765142978358732; //very busy zigarat tower 
//seed = 90872638790; //busy zigarat tower 
//seed = 978354287263987257854765873265872306523; //funky center


//seed = 1987534785234768541271624618524376; //tower and zigarat
//seed = 8327638237612876482687235; //nice tower zigarat pagoda 
//seed = 1987534785234768541; // mix of towers
//seed = 1339; //mix of towers
//seed = 97835428726398725; //busy mix
//seed = 980235769082376381279069851276380712357816481027; //3 towers + temple
//seed = 13378978; //temples and towers
//seed = 3651874365018347678140736804173614087465401; //busy highrise



//seed = 123765; //central zigarat
//seed = 8726459781436879351697187869135476913257961323279659761325415476832571132578; //six towers
//seed = 978156081; //4 stagered towers and 2 temples
//seed = 9781560813475608754136087354168; //busy mix of towers and small domes


//seed = 993800; // intentar a 380x380
//seed= 747466;

// Kind of base (poligonal , rectangle or circle)
base = "rectangle"; // [poligon:Poligonal, rectangle:Rectangle, circle:Circle]

// Base height.
base_height = 1;         

/* [Poligonal Base] */

// Number of sides
num_sides = 6;      
// Side Length (size of figure is calculated from number and length of sides)
side_length = 20;        
// Position of figure (inscribed or circumscribed to polygon)
position = "inscribed"; // [inscribed:inscribed, circumscribed:Circumscribed]
//Separation from border of poligon
separation = 1;
// You may need supports if figure is wider than base-poligon.
supports="yes"; // [yes:Yes. make supports, no:No. I can do it with my slicer software]



/* [Rectangle base] */

// Size in X axis
size_x = 120;    
// Size in Y axis
size_y = 180;


/* [Circular base] */
// Diameter of circle
diameter = 40;



 
/* [Hidden] */
$fn=40; // Number of faces for cylinders
min_size = 3; // stops recursion at this size
level_height = 1; // height of levels. works good with 1, higher heights make weird things



randoms = rands(0,1000,3000,seed); // random sequence

 

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
                  translate([-size_x*0.5,-size_y*0.5,0]) cube([size_x,size_y,base_height],center=false);
                  translate([0,0,-0.1]) mirrored_seed();
              }
          }        
          translate([0,0,base_height])
               cube_rec([size_x,size_y,level_height],0); // Cube
    }
    
    





// Returns the n-th number modularized into range[a,b]
function random(a,b,n)= a+( ceil(randoms[n%3000]) % (1+b-a) );

/*****************************
    MODULES
******************************/
    
 


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

    
    // FIGURA!!!
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
 
    translate([-sx/2,-sy/2,0])cube(size,center=false);
    
    if(sx>=min_size && sy>=min_size){ 
        opcion = random(1,8,rn);
      
        if(opcion==1){
            // Reduce
            translate([0,0,sz]){     
                cube_rec([sx-1,sy-1,sz],rn+1);
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
            translate([0,0,sz]){
                diameter = min(sx,sy);
                radius = diameter/2;
                t1=0.2;
                translate([0,0,0]){
                    
                    // 4 piramides laterales
                    translate([radius*0.7,radius*0.7,0])
                      rotate([0,0,45])
                        cylinder(r1 = diameter*t1,r2 = diameter*t1*0.5,h=diameter*0.3,$fn=4);
                    translate([-radius*0.7,radius*0.7,0])
                      rotate([0,0,45])
                        cylinder(r1 = diameter*t1,r2 = diameter*t1*0.5,h=diameter*0.3,$fn=4);
                    translate([radius*0.7,-radius*0.7,0])
                      rotate([0,0,45])
                        cylinder(r1 = diameter*t1,r2 = diameter*t1*0.5,h=diameter*0.3,$fn=4);
                    translate([-radius*0.7,-radius*0.7,0])
                      rotate([0,0,45])
                        cylinder(r1 = diameter*t1,r2 = diameter*t1*0.5,h=diameter*0.3,$fn=4);
                    // Centro
                    rotate([0,0,45]){
                       cylinder(r1 = radius*0.9,r2 = radius*0.9,h=diameter*0.3,$fn=4);
                       translate([0,0,diameter*0.2])
                       cylinder(r1 = radius*0.9,r2 = radius*1.13,h=diameter*0.1,$fn=4);
                       
                    }
                    // Cubo_rec
                    translate([0,0,diameter*0.299])
                      cube_rec([diameter*0.798,diameter*0.798,sz],rn+1);
                    
                    // rellena laterales
                    translate([radius*0.8,0,0])
                      cube_rec([diameter*0.2,diameter*0.4,sz],rn+23);
                    translate([-radius*0.8,0,0])
                      cube_rec([diameter*0.2,diameter*0.4,sz],rn+57);
                    translate([0,radius*0.8,0])
                      cube_rec([diameter*0.4,diameter*0.2,sz],rn+73);
                    translate([0,-radius*0.8,0])
                      cube_rec([diameter*0.4,diameter*0.2,sz],rn+11);
                    
                        
                    
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
            }
            
        }else if(opcion==5){
            // Piramide
 
             faces = radius>20 ? 3*radius : 50;
             nFaces = faces>200 ? 200 : faces;
//            echo (str("nFacesT: ",nFacesT));



 //               echo (str("nFaces: ",nFaces));
            t1=0.2;
            translate([0,0,sz]){
                // Centro
                difference(){
                    rotate([0,0,45]) cylinder(r1 = radius*1.15,r2 = radius*1.15,h=diameter*0.3,$fn=4);
                    scale([1,1,1.3]){
                    translate([0,radius*1.05,0]) rotate([0,90,0]) cylinder(r = radius*0.5,h=diameter,$fn=nFaces,center=true);
                    translate([0,-radius*1.05,0]) rotate([0,90,0]) cylinder(r = radius*0.5,h=diameter,$fn=nFaces,center=true);
                    rotate([0,0,90]){
                        translate([0,radius*1.05,0]) rotate([0,90,0]) cylinder(r = radius*0.5,h=diameter,$fn=nFaces,center=true);
                        translate([0,-radius*1.05,0]) rotate([0,90,0]) cylinder(r = radius*0.5,h=diameter,$fn=nFaces,center=true);
                    }
                    }
                }
                
                
                // Cubo_rec
                translate([0,0,diameter*0.295])
                  cube_rec([diameter*0.8,diameter*0.8,sz],rn+111);
                
                // rellena laterales
                translate([radius*0.8,0,0])  cube_rec([diameter*0.15,diameter*0.55,sz],rn+23);
                translate([-radius*0.8,0,0]) cube_rec([diameter*0.15,diameter*0.55,sz],rn+57);
                translate([0,radius*0.8,0])  cube_rec([diameter*0.556,diameter*0.15,sz],rn+73);
                translate([0,-radius*0.8,0]) cube_rec([diameter*0.55,diameter*0.15,sz],rn+11);

                translate([radius*0.8,radius*0.8,0]) cylinder_rec([diameter*0.15,diameter*0.15,sz],rn+34);
                translate([radius*0.8,-radius*0.8,0]) cylinder_rec([diameter*0.15,diameter*0.15,sz],rn+36);
                translate([-radius*0.8,radius*0.8,0]) cylinder_rec([diameter*0.15,diameter*0.15,sz],rn+38);
                translate([-radius*0.8,-radius*0.8,0]) cylinder_rec([diameter*0.15,diameter*0.15,sz],rn+43);
                
                    
                
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
            
        }else if(opcion==6||opcion==8){
            // Tower
            //zx: increase faces on large towers
            faces = radius>20 ? 3*radius : 50;
            nFacesT = faces>200 ? 200 : faces;
//            echo (str("nFacesT: ",nFacesT));
            //zx: Thicken legs for very small towers for better printing
            radThresh = 13;
            radLim = radThresh*4;
            translate([0,0,sz]){
            if(radius>10){
                altura = diameter*0.75;
                translate([0,0,altura/2]){
                    difference(){
                        union(){
                            cube([diameter,diameter*0.1,altura],center=true);
                            cube([diameter*0.1,diameter,altura],center=true);
                            translate([0,0,altura*0.1])
                            cylinder(r1=0,r2=altura*0.4,h=altura*0.4, $fn=nFacesT/1.6);
                        }
                        translate([altura*0.95,diameter*0.5,altura*0.15])
                        rotate([90,0,0]) cylinder(r = altura*0.8,h=diameter,$fn=nFacesT);
                        translate([-altura*0.95,diameter*0.5,altura*0.15])
                        rotate([90,0,0]) cylinder(r = altura*0.8, h=diameter,$fn=nFacesT);
                        translate([-diameter*0.5,altura*0.95,altura*0.15])
                        rotate([0,90,0]) cylinder(r = altura*0.8, h=diameter,$fn=nFacesT);
                        translate([-diameter*0.5,-altura*0.95,altura*0.15])
                        rotate([0,90,0]) cylinder(r = altura*0.8, h=diameter,$fn=nFacesT);
                        
                        //zx: leg thickness
                        if(radius>radThresh){
                        translate([0,0,-altura/2]) scale([1,1,2]) sphere(altura*0.25);
                        }
                        else{
                        translate([0,0,-altura/2]) scale([1,1,2]) sphere(altura*(radius/radLim));
                        }
                        
                        
                    }
                    difference(){
                        union(){
                            cube([diameter,diameter*0.05,altura],center=true);
                            cube([diameter*0.05,diameter,altura],center=true);
                            translate([0,0,altura*0.1])
                            cylinder(r1=0,r2=altura*0.4,h=altura*0.4, $fn=nFacesT/1.6);
                        }
                        translate([altura*1,diameter*0.5,altura*0.15])
                        rotate([90,0,0]) cylinder(r = altura*0.8,h=diameter,$fn=nFacesT);
                        translate([-altura*1,diameter*0.5,altura*0.15])
                        rotate([90,0,0]) cylinder(r = altura*0.8, h=diameter,$fn=nFacesT);
                        translate([-diameter*0.5,altura*1,altura*0.15])
                        rotate([0,90,0]) cylinder(r = altura*0.8, h=diameter,$fn=nFacesT);
                        translate([-diameter*0.5,-altura*1,altura*0.15])
                        rotate([0,90,0]) cylinder(r = altura*0.8, h=diameter,$fn=nFacesT);
  
                        //zx: leg thickness
                        if(radius>radThresh){
                        translate([0,0,-altura/2]) scale([1,1,2]) sphere(altura*0.25);
                        }
                        else{
                        translate([0,0,-altura/2]) scale([1,1,2]) sphere(altura*(radius/radLim));
                        }
                    }

                }
                cylinder_rec([radius*0.5,radius*0.5,sz],rn+77);
                translate([radius*0.55,radius*0.55,0]) cube_rec([radius*0.9,radius*0.9,sz],rn+23);
                translate([radius*0.55,-radius*0.55,0]) cube_rec([radius*0.9,radius*0.9,sz],rn+53);
                translate([-radius*0.55,radius*0.55,0]) cube_rec([radius*0.9,radius*0.9,sz],rn+73);
                translate([-radius*0.55,-radius*0.55,0]) cube_rec([radius*0.9,radius*0.9,sz],rn+123);
    
                translate([0,0,altura])
                    cube_rec([altura*0.56,altura*0.56,sz],rn+111);
            
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
                translate([0,0,0]){     
                    cube_rec([sx-1,sy-1,sz],rn+1);
                }
            }
        }
        }else{
            // Cambia a Cilindro
            translate([0,0,sz]){     
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
    //zx:increase faces for tronco central (value might be subjective)
    faces = radius>20 ? 3*radius : 50;
    nFacesC = faces>200 ? 200 : faces;
    
    translate([0,0,-0.1]) cylinder(h=sz+.1,r=radius,center=false);
    
    
    if( (diameter)>=min_size){ 
        opcion = random(1,8,rn);
        // zx: increase faces for large radii
        faces = radius>10 ? 4*radius : $fn;; 
        $fn = faces>150 ? 150 : faces;
        if(opcion==1){
            // Reduce
            translate([0,0,0]){     
                cylinder_rec([sx-1,sy-1,sz],rn+1);
            }
        }else if(opcion==2||opcion==2){
          // Columnitas
          translate([0,0,sz]){     
            numcols = 8;
            for(i=[1:numcols]){
              rotate([0,0,i*360.0/numcols])
                translate([radius*0.75,0,0])
                  cylinder(r=radius*0.1,h=radius*0.6,$fn=50);
            }
            // tronco central
            cylinder(r1=radius*0.5,r2 = radius*0.9,h=radius*0.6,$fn=nFacesC);
            
            // recursion -->cylinder_rec
            translate([0,0,radius*0.6])
              cylinder_rec([diameter*0.85,diameter*0.85,sz],rn+1);
          
          }          
        }else if(opcion==3){
          // columna de discos
            translate([0,0,sz]){
                  col_h = radius*0.2;
                  
                  //zx: I have reduced the range here, 0-3 vs 1-7.
                  numcols = 1+random(0,3,rn+1);
                  for(i=[1:numcols]){
                    translate([0,0,(i-1)*col_h])
                      cylinder(r1=radius*0.5,r2=radius*0.7,h=col_h,$fn=50);
                  }
                  translate([0,0,(numcols)*col_h])
                    cylinder(r1=radius*0.7,r2=radius,h=col_h,$fn=50);
                  
                  cylinder(r1=radius*0.5,r2=radius*0.5,h=col_h*(numcols+1),$fn=50);
                  // recursion -->cylinder_rec
                  translate([0,0,col_h*(numcols+1)])
                    cylinder_rec([diameter*.95,diameter*.95,sz],rn+2);
            }
            
        }else if(opcion==4){
            translate([0,0,sz])
            difference(){
                
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
                    // zx: increase cupula thickness for radii <20
                    //sphere(radius*0.85);
                    sphere(radius > 20 ? radius*0.85 : (radius > 5 ? radius * 0.75 : radius *0.5));  
                    translate([0,0,-radius/2])
                    cube([diameter,diameter,radius],center=true);
                }
            }


//          translate([0,0,radius*0.8])
//            cylinder(r=radius*0.4,h=radius*0.1);
          
            translate([0,0,sz])
                cylinder_rec([diameter*0.7,diameter*0.7,1],rn+1);
            
        }else if(opcion==5){
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
                cylinder_rec([diameter*0.85,diameter*0.85,sz],rn+1);
          
          }
        }else if(opcion==6){
            // knob
            translate([0,0,sz]){
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
                    cylinder_rec([diameter*0.75,diameter*0.75,sz],rn+97);
                }
            }
          
            
        }else if(opcion==7){
          translate([0,0,sz]){ 
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


            translate([0,0,radius*0.7])
            cylinder(r1=radius*0.2,r2=radius*0.4,h=radius*0.3);
          
            translate([0,0,radius])
                cylinder_rec([diameter*0.35,diameter*0.35,1],rn+1);     
            }       
        }else{
            // Cambia a cubo
            translate([0,0,sz]){     
                cube_rec([2*radius*0.7,2*radius*0.7,sz],rn+5);
            }
            // 4 cilindros 
            translate([radius*0.85,0,sz])
                cylinder_rec([radius*0.25,radius*0.25,sz],rn+11);
            translate([-radius*0.85,0,sz])
                cylinder_rec([radius*0.25,radius*0.25,sz],rn+13);
            translate([0,radius*0.85,sz])
                cylinder_rec([radius*0.25,radius*0.25,sz],rn+17);
            translate([0,-radius*0.85,sz])
                cylinder_rec([radius*0.25,radius*0.25,sz],rn+23);
            
        }
    }    
    
}





