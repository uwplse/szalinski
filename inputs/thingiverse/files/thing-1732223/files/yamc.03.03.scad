/*
 Yet Another Parametric Measuring Cups
 on http://www.thingiverse.com/thing:1732223
 by fpetrac
 Licensed under the Creative Commons - Attribution - Non-Commercial license.
*/


/* 
////  the main funcion is 
////  yamc(size,unit,shape,form_factor=1) were:
    
////    unit="cl","ml","oz","mm" (mm is used to set the radius of semispere); 
////    shape=1,2,3,4 (4 different shape); 
////    form_factor= is an optional value normally is 1. It is used to realize cup series. 
    
////    See also the examples at the end of file. 
*/

//$fn=64;

//start Customizer APP frontend

//cups volume
size=15; //[1:1000]
//volume measurement unit:
unit="ml"; //[cl,ml,oz,mm]
//cups shape
shape=4; //[1:Up,2:Down,3:Sphere,4:HalfHandle]
//form factor 1 is the default It is used to realize cup series: 
form_factor=1; //[1.0,1.25,1.55,1.75,2.0]

yamc(size,unit,shape,form_factor);

//End Customizer APP frontend


function mm2mm(mm) = pow(10,(1/3*(log(mm)-log(PI*2/3))));  //return semisphere radius in mm from mm^3 volume
function ml2mm(ml) = pow(10,(1/3*(log(1000*ml)-log(PI*2/3))));//return semisphere radius in mm  from ml volume 
function cl2mm(cl) = pow(10,(1/3*(log(10000*cl)-log(PI*2/3))));//return semisphere radius in mm from cl volume 
function oz2mm(oz) = pow(10,(1/3*(log(29573.5295625*oz)-log(PI*2/3))));//return semisphere radius in mm from oz volume

function ml2M(ml) = ml2mm(ml)/24;
function cl2M(cl) = cl2mm(cl)/24;
function oz2M(oz) = oz2mm(oz)/24;



module handle1t(x,h,p=1,u="cl",f=1){    
m= u=="cl" ? cl2M(x) : u=="ml" ? ml2M(x) : u=="oz" ? oz2M(x) : u=="mm" ? x/24 : 0 ;
fsize= x>999 ? m*10 : x>99 ? m*11 : x>9 ? m*14 : m*15;
translate([0,0,h*m]){
    difference(){     
        minkowski(){
            hull() {
                translate([78*m*f,0,0]) cylinder(1*m,15*m,15*m);
                cylinder(1*m,24*m*p,24*m*p);
            }
            sphere(1*m,true);   
        }
        //normal words
        union(){
            translate([78*m*f,0,-5*m]) cylinder(10*m,7*m,7*m);
            translate([68*m*f,7*m,0.01*m]) 
                rotate([180,0,0])
                    linear_extrude(height = 2*m, center = false)
                    if(u!="mm") text(str(x,u),size=fsize,font = "Arial:style=Bold ",halign ="right");
        }
        /*//through words
      union(){
            translate([78*m*f,0,-5*m]) cylinder(10*m,7*m,7*m);
            translate([68*m*f,7*m,3*m]) 
                rotate([180,0,0])
                    linear_extrude(height = 6*m, center = false)
                    if(u!="mm") text(str(x,u),size=fsize,font = "Bauhaus93",halign ="right");
        }*/
    }
}
}


module handle2t(x,h,p=1,u="cl",f=1){
m= u=="cl" ? cl2M(x) : u=="ml" ? ml2M(x) : u=="oz" ? oz2M(x) : u=="mm" ? x/24 : 0 ;
fsize= x>999 ? m*8 : x>99 ? m*9 : x>9 ? m*11 : m*12;   
translate([0,0,h*m])
   difference(){ 
            translate([0,0,0])
                minkowski(){
                    difference(){ 
                        hull() {
                            translate([78*m*f,0,0]) cylinder(1*m,15*m,15*m);
                            cylinder(1*m,24*m,24*m);
                        }
                        difference(){
                            translate([0*m,0,-2*m]) cube([78*m*f,35*m,4*m]);
                            union(){
                                translate([78*m*f,0,-3*m]) cylinder(6*m,15*m,15*m);
                                translate([0,0,-3*m])cylinder(6*m,24*m,24*m);
                            }
                        }
                    }
                sphere(1*m,true);   
                }
               union(){
            translate([78*m*f,0,-3*m]) cylinder(6*m,7*m,7*m);
            translate([60*m*f,-2*m,0.01*m]) 
                rotate([180,0,0])
                    linear_extrude(height = 2*m, center = false)
                    if(u!="mm")text(str(x,u),size=fsize,font = "Arial:style=Bold ",halign ="right");
               } 
        }
    /*translate([60*m,-2*m,0.5*m]) 
                rotate([180,0,0])
                    linear_extrude(height = 2*m, center = false)
                    text(str(x,u),size=m*10,font = "Arial:style=Bold ",halign ="right");*/
        
}

module yamc(x,u,shape,f=1){
m= u=="cl" ? cl2M(x) : u=="ml" ? ml2M(x) : u=="oz" ? oz2M(x) : u=="mm" ? x/24 : 0 ;
    if(shape==1){
        difference(){
            minkowski(){
                cylinder(24*m,24*m,20*m);
                sphere(1*m,true);
            }
            sphere(24*m);
        }
        handle1t(x,25,20/24,u,f);   
    } else
    if(shape==2){
        difference(){
            union(){
                minkowski(){
                    cylinder(24*m,24*m,20*m);
                    sphere(1*m,true);
                }
                handle1t(x,0,1,u,f);               
            }
            sphere(24*m);
        }
   } else   
   if(shape==3){
        difference(){
            union(){
                minkowski(){
                    difference(){
                        sphere(24*m);
                        translate([0,0,-25*m]) cylinder(50*m,50*m,50*m,true);
                    }
                    sphere(1*m,true);
                }
                handle1t(x,0,1,u,f);
            }
            sphere(24*m);
        }
    }
    if(shape==4){
        difference(){
            union(){
                minkowski(){
                    difference(){
                        sphere(24*m);
                        translate([0,0,-25*m]) cylinder(50*m,50*m,50*m,true);
                    }
                    sphere(1*m,true);
                }       
                handle2t(x,0,1,u,f);
            }
            sphere(24*m);
        }
    }   
}
   





//------Example------
//yamc(2,"oz",1);
//yamc(5,"cl",2);
//yamc(10,"mm",3);
//yamc(15,"ml",4);

//Differnet Shape and unit
/*
r=8;
translate([0,0,0]) yamc(20,"cl",4);
translate([5*r,10*r,0]) yamc(2,"oz",3);
translate([9*r,18*r,0]) yamc(15,"ml",2);
translate([12*r,24*r,0]) yamc(20,"mm",1);
*/

// Normal Series
/*
t=4;
r=7;
u="cl";
translate([0,0,0]) yamc(8,u,t);
translate([0,10*r,0]) yamc(4,u,t);
translate([0,18*r,0]) yamc(2,u,t);
translate([0,25*r,0]) yamc(1,u,t);
*/


// Stakable Series
/*
t=4;
r=7;
u="cl";
translate([0,0,0])    yamc(7,u,t,1);
translate([0,10*r,0]) yamc(4,u,t,1.25);
translate([0,18*r,0]) yamc(2,u,t,1.55);
translate([0,25*r,0]) yamc(1,u,t,1.9);
*/


// Generator Normal Series
/*
t=4;
r=7;
u="ml";
translate([0,0,0])    yamc(30,u,t);
translate([0,9*r,0]) yamc(60,u,t);
translate([0,19.5*r,0]) yamc(80,u,t);
translate([0,31*r,0]) yamc(125,u,t);
translate([0,45*r,0]) yamc(250,u,t);
*/



