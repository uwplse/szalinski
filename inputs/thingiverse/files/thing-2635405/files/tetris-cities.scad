// RECURSION 3D. Version 1.0

// Por: Fernando Jerez Garrido

// License Creative Commons CC


/*******************************

    CUSTOMIZATION
    
********************************/

// Pieces: O I S Z L J T Single/double/triple/corner
part = "I"; // [O:O-piece, I:I-piece, S:S-piece, Z:Z-piece, L:L-piece, J:J-piece, T:T-piece , single: Single, double: Double, triple:Triple, corner:Corner]

// Base height.
base_height = 3;

// Grid size
grid = 20;

/*******************************
   GLOBAL PARAMETERS
********************************/
/* [Hidden] */

// Random seed (for testing on openSCAD)
 seed=round(rands(1,1000000,1)[0]); // random seed
 echo (str("Seed: ",seed)); 


// Seed (engraved at the bottom of figure)
//seed= 883488; //220505  494781 530840 471624(piramide) 122706(torre)

tolerance = 0.1; // like the 'Horizontal expansion' in Cura Slicer
t2=tolerance*2;

$fn=40; // Number of faces for cylinders
min_size = 3; // stops recursion at this size
level_height = 1; // height of 'levels'. works good with 1, higher heights make weird things



randoms = rands(0,1000,3000,seed); // random sequence

/* BEGIN */

if(part == "single"){
    size_x = grid-t2;
    size_y = grid-t2;
    cube([size_x,size_y,base_height],center=true);
    translate([0,0,base_height*0.5])
    cube_rec([size_x,size_y,level_height],0); // Cube
}else
if(part == "double"){
    size_x = 2*grid-t2;
    size_y = grid-t2;
    cube([size_x,size_y,base_height],center=true);
    translate([0,0,base_height*0.5])
    cube_rec([size_x,size_y,level_height],0); // Cube
}else
if(part == "triple"){
    size_x = 3*grid-t2;
    size_y = grid-t2;
    cube([size_x,size_y,base_height],center=true);
    translate([0,0,base_height*0.5])
    cube_rec([size_x,size_y,level_height],0); // Cube
}else
if(part == "corner"){
    size_x = grid*2-t2;
    size_y = grid-t2;
    cube([size_x,size_y,base_height],center=true);
    translate([0,0,base_height*0.5])
    cube_rec([size_x,size_y,level_height],0); // Cube

    translate([-grid*0.5,grid-tolerance,0]){
        cube([grid-t2,grid,base_height],center=true);
        translate([0,0,base_height*0.5])
        cube_rec([grid-t2,grid,level_height],1235); // Cube
    }
}else
if(part == "O"){
    size_x = grid*2-t2;
    size_y = grid*2-t2;
    cube([size_x,size_y,base_height],center=true);
    translate([0,0,base_height*0.5])
    cube_rec([size_x,size_y,level_height],0); // Cube
}else
if(part == "I"){
    size_x = grid*4-t2;
    size_y = grid-t2;
    cube([size_x,size_y,base_height],center=true);
    translate([0,0,base_height*0.5])
    cube_rec([size_x,size_y,level_height],0); // Cube
}else
if(part == "Z"){
    size_x = grid*2-t2;
    size_y = grid-t2;
    cube([size_x,size_y,base_height],center=true);
    translate([0,0,base_height*0.5])
    cube_rec([size_x,size_y,level_height],0); // Cube

    translate([grid*0.5,grid-tolerance,0]){
        cube([grid-t2,grid,base_height],center=true);
        translate([0,0,base_height*0.5])
        cube_rec([grid-t2,grid,level_height],9876); // Cube
    }
    translate([-grid*0.5,-(grid-tolerance),0]){
        cube([grid-t2,grid,base_height],center=true);
        translate([0,0,base_height*0.5])
        cube_rec([grid-t2,grid,level_height],1234); // Cube
    }
}else
if(part == "S"){
    size_x = grid*2-t2;
    size_y = grid-t2;
    cube([size_x,size_y,base_height],center=true);
    translate([0,0,base_height*0.5])
    cube_rec([size_x,size_y,level_height],0); // Cube

    translate([-grid*0.5,grid-tolerance,0]){
        cube([grid-t2,grid,base_height],center=true);
        translate([0,0,base_height*0.5])
        cube_rec([grid-t2,grid,level_height],9876); // Cube
    }
    translate([grid*0.5,-(grid-tolerance),0]){
        cube([grid-t2,grid,base_height],center=true);
        translate([0,0,base_height*0.5])
        cube_rec([grid-t2,grid,level_height],876); // Cube
    }
}else
if(part == "J"){
    size_x = grid*3-t2;
    size_y = grid-t2;
    cube([size_x,size_y,base_height],center=true);
    translate([0,0,base_height*0.5])
    cube_rec([size_x,size_y,level_height],0); // Cube

    translate([-grid,grid-tolerance,0]){
        cube([grid-t2,grid,base_height],center=true);
        translate([0,0,base_height*0.5])
        cube_rec([grid-t2,grid,level_height],1235); // Cube
    }
}else
if(part == "L"){
    size_x = grid*3-t2;
    size_y = grid-t2;
    cube([size_x,size_y,base_height],center=true);
    translate([0,0,base_height*0.5])
    cube_rec([size_x,size_y,level_height],0); // Cube

    translate([grid,grid-tolerance,0]){
        cube([grid-t2,grid,base_height],center=true);
        translate([0,0,base_height*0.5])
        cube_rec([grid-t2,grid,level_height],3345); // Cube
    }

}else
if(part == "T"){
    size_x = grid*3-t2;
    size_y = grid-t2;
    cube([size_x,size_y,base_height],center=true);
    translate([0,0,base_height*0.5])
    cube_rec([size_x,size_y,level_height],0); // Cube

    translate([0,grid-tolerance,0]){
        cube([grid-t2,grid,base_height],center=true);
        translate([0,0,base_height*0.5])
        cube_rec([grid-t2,grid,level_height],9876); // Cube
    }

}
   
    
    





// Returns the n-th number modularized into range[a,b]
function random(a,b,n)= a+( ceil(randoms[n%3000]) % (1+b-a) );


/*****************************
    MODULES
******************************/


module cube_rec(size,rn){
    sx = size[0];
    sy = size[1];
    sz = size[2];
    
    diameter = min(sx,sy);
    radius = diameter/2;    
    
    r=1;
 
    cube(size,center=true);
    
    if(sx>=min_size && sy>=min_size){ 
        opcion = random(1,7,rn);
      
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
                translate([0,0,diameter*0.3+0.5])
                  cube_rec([diameter*0.8,diameter*0.8,sz],rn+1);
               
               
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
            
        }else if(opcion==5){
            // Piramide 2
            t1=0.2;
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
                translate([0,0,diameter*0.3+0.5])
                  cube_rec([diameter*0.8,diameter*0.8,sz],rn+1);                

            translate([0,0,sz]){

                
                // rellena laterales
                translate([radius*0.8,0,0])
                  cube_rec([diameter*0.15,diameter*0.6,sz],rn+23);
                translate([-radius*0.8,0,0])
                  cube_rec([diameter*0.15,diameter*0.6,sz],rn+57);
                translate([0,radius*0.8,0])
                  cube_rec([diameter*0.6,diameter*0.15,sz],rn+73);
                translate([0,-radius*0.8,0])
                  cube_rec([diameter*0.6,diameter*0.15,sz],rn+11);

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
        }else if(opcion==6){
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
    
    cylinder(h=sz,r=radius,center=true);
    
    
    if( (diameter)>=min_size){ 
        opcion = random(1,8,rn);
         
        if(opcion==1){
            // Reduce
            translate([0,0,sz]){     
                cylinder_rec([sx-1,sy-1,sz],rn+1);
            }
        }else if(opcion==2){
          // Columnitas
          translate([0,0,0]){     
            numcols = 8;
            for(i=[1:numcols]){
              rotate([0,0,i*360.0/numcols])
                translate([radius*0.75,0,-0.5])
                  cylinder(r=radius*0.1,h=radius*0.6,$fn=50);
            }
            // tronco central
            cylinder(r1=radius*0.5,r2 = radius*0.9,h=radius*0.6,$fn=20);
            
            // recursion -->cylinder_rec
            translate([0,0,radius*0.6+0.5])
              cylinder_rec([diameter*0.9,diameter*0.9,sz],rn+1);
          
          }          
        }else if(opcion==3){
          // columna de discos
          col_h = radius*0.2;
          //numcols = round(rands(3,6,1)[0]);
          numcols = 1+random(3,6,rn+1);
          for(i=[1:numcols]){
            translate([0,0,(i-1)*col_h])
              cylinder(r1=radius*0.5,r2=radius*0.7,h=col_h,$fn=50);
          }
          translate([0,0,(numcols)*col_h])
            cylinder(r1=radius*0.7,r2=radius,h=col_h,$fn=50);
          
          cylinder(r1=radius*0.5,r2=radius*0.5,h=col_h*(numcols+1),$fn=50);
          // recursion -->cylinder_rec
          translate([0,0,col_h*(numcols+1)+0.5])
            cylinder_rec([diameter,diameter,sz],rn+2);
          
            
        }else if(opcion==4){
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
                    sphere(radius*0.85);
                    translate([0,0,-radius/2])
                    cube([diameter,diameter,radius],center=true);
                }
            }


//          translate([0,0,radius*0.8])
//            cylinder(r=radius*0.4,h=radius*0.1);
          
            translate([0,0,1])
                cylinder_rec([diameter*0.7,diameter*0.7,1],rn+1);
            
        }else if(opcion==5){
            // Columnitas
            translate([0,0,sz-0.5]){     
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
                translate([0,0,radius*0.6+0.5])
                cylinder_rec([diameter*0.9,diameter*0.9,sz],rn+1);
          
          }
        }else if(opcion==6){
            // knob
            translate([0,0,sz*0.5]){
                difference(){
                    union(){
                        cylinder(r=radius*0.9,h=radius*0.3);
                        translate([0,0,radius*0.3])
                            cylinder(r1=radius*0.9,r2=radius*0.8,h=radius*0.1);
                    }
                    union(){
                        for(i = [0:45:359]){
                            rotate([0,0,i]) translate([radius,0,0]) cylinder(r=radius*0.2,h=radius*0.41,$fn=20);
                        }
                        
                    }
                }
                
                // recursion -->cylinder_rec
                translate([0,0,radius*0.4]){
                    cylinder_rec([diameter*0.8,diameter*0.8,sz],rn+97);
                }
            }
          
            
        }else if(opcion==7){
          
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





