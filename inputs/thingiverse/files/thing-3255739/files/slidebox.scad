/* Rocchini J-F 29/11/2018 */
/* slide box generator */
/* enter theorical external dimensions of the box*/
length=171;
width=52;
height=24;
material_thickness=3;
/* 0 assembled 3D view*/
/* 1 2D elements export as  .SVG*/
view=0;

vue=view;
long=length;
larg=width;
haut=height;
ep_mat=material_thickness;


$fn=100;
module quartderond(lgr=30){
   difference(){
       square([lgr,lgr], center="true");
       circle(lgr);
   }
  }  
  
modulo=ep_mat*2;  
longueur=(1+2*floor(long/modulo/2))*modulo;
largeur=  (1+2*floor(larg/modulo/2))*modulo;
hauteur= (1+2*floor(haut/modulo/2))*modulo;  
 echo("real ext. lenght",longueur);
 echo("real ext. width",largeur); 
 echo("real ext. height ",hauteur);
 echo("real int. length",longueur-2*ep_mat);
 echo("real int. width",largeur-4*ep_mat); 
 echo("real int. height",hauteur-3*ep_mat);  
  
module horizontal_2D(longueur, largeur,ep_mat){
    difference(){
        square([largeur,longueur]);
        for(i=[ep_mat*2:ep_mat*4:largeur]){
            for(j=[0,longueur-ep_mat]){
                translate([i,j]) square([ep_mat*2,ep_mat]);
            }
        }
        for(i=[ep_mat*2:ep_mat*4:longueur]){
            for(j=[0,largeur-ep_mat]){
                translate([j,i]) square([ep_mat,ep_mat*2]);
            }
        }
    }
}

module fond_2D(longueur, largeur,ep_mat){
     horizontal_2D(longueur, largeur,ep_mat);
}

module dessus_2D(longueur, largeur,ep_mat){
union(){    
    difference(){
        horizontal_2D(longueur, largeur,ep_mat);
        translate([3*ep_mat,-3*ep_mat,0]) square([largeur-6*ep_mat,longueur]);
}
translate([2*ep_mat,ep_mat]) circle(ep_mat);
translate([largeur-2*ep_mat,ep_mat]) circle(ep_mat);
translate([3*ep_mat+10,longueur-3*ep_mat-10]) rotate([0,0,90])quartderond(10);
translate([largeur-3*ep_mat-10,longueur-3*ep_mat-10])  quartderond(10);
}
}

module arr_2D(largeur,hauteur,ep_mat){
    difference(){
    square([largeur,hauteur]);
    for(i=[0:4*ep_mat:largeur]){
            for(j=[0,hauteur-ep_mat]){
                translate([i,j]) square([ep_mat*2,ep_mat]);
            }
        }
     
   for(i=[-ep_mat:4*ep_mat:hauteur-ep_mat]){
            for(j=[0,largeur-ep_mat]){
                translate([j,i]) square([ep_mat,2*ep_mat]);
            }
        }
    }     
}

module av_2D(largeur,hauteur,ep_mat){
    difference(){
        arr_2D(largeur,hauteur,ep_mat);
        translate([0,hauteur-2*ep_mat,0]) square([largeur+1,3*ep_mat+1]);
    }
}

module cote_2D(longueur,hauteur,ep_mat){
     difference(){
        square([hauteur,longueur]);
        for(i=[ep_mat:4*ep_mat:hauteur-ep_mat]){
            for(j=[0,longueur-ep_mat]){
                translate([i,j]) square([ep_mat*2,ep_mat]);
            }
        }
        for(i=[0:ep_mat*4:longueur]){
            for(j=[0,hauteur-ep_mat]){
                translate([j,i]) square([ep_mat,ep_mat*2]);
            }
        }
    }
} 
module cote_int_2D(hauteur,longueur,ep_mat){
     square([hauteur-3*ep_mat,longueur-2*ep_mat]);
}
module separateur_2D(hauteur,largeur,ep_mat){
       square([hauteur-3*ep_mat,largeur-4*ep_mat]);
}   
module couvercle_2D(largeur,longueur,ep_mat){
    difference(){
       square([largeur-2*ep_mat,longueur-ep_mat]);
       translate([largeur-4*ep_mat,longueur-3*ep_mat]) quartderond(ep_mat*2);
       translate([ep_mat*2,longueur-3*ep_mat]) rotate([0,0,90]) quartderond(ep_mat*2);  
       translate([ep_mat*2,ep_mat*2]) rotate([0,0,-180]) quartderond(ep_mat*2);
       translate([largeur-ep_mat*4,ep_mat*2]) rotate([0,0,-90]) quartderond(ep_mat*2);
        translate([largeur/2-1.5*ep_mat,largeur/4,0]) square(ep_mat);
    } 
}
module bouton_2D(largeur,ep_mat){
    difference(){
       circle(d=largeur/4);
       translate([-ep_mat/2,-ep_mat/2,0]) square(ep_mat);     
    }
}
module pion_2D(ep_mat){
    square([ep_mat,ep_mat*2]);
}
    
//................................... 3D......................

module fond_3D(longueur, largeur,ep_mat){    
   linear_extrude(ep_mat) fond_2D(longueur, largeur,ep_mat);    
}
module dessus_3D(longueur, largeur,ep_mat){
   linear_extrude(ep_mat)  dessus_2D(longueur,largeur,ep_mat);
}

module arr_3D(largeur,hauteur,ep_mat){
    linear_extrude(ep_mat) arr_2D(largeur,hauteur,ep_mat);
}
module av_3D(largeur,hauteur,ep_mat){
    linear_extrude(ep_mat) av_2D(largeur,hauteur,ep_mat);
    
}
module cote_3D(longueur,hauteur,ep_mat){
    linear_extrude(ep_mat) cote_2D(longueur,hauteur,ep_mat);
}
module cote_int_3D(hauteur,longueur,ep_mat){
    linear_extrude(ep_mat) cote_int_2D(hauteur,longueur,ep_mat);
}
module couvercle_3D(largeur,longueur,ep_mat){
    linear_extrude(ep_mat) couvercle_2D(largeur,longueur,ep_mat);
}
module bouton_3D(largeur,ep_mat){
    linear_extrude(ep_mat) bouton_2D(largeur,ep_mat);
}
module separateur_3D(hauteur,largeur,ep_mat){
    linear_extrude(ep_mat) separateur_2D(hauteur,largeur,ep_mat);
}
module pion_3D(ep_mat){
    linear_extrude(ep_mat) pion_2D(ep_mat);
}

//****************** VUES *********************************/
if(vue==0){
    
 color("green")  fond_3D(longueur, largeur,ep_mat);
 translate([0,0,hauteur-ep_mat]) color("red") dessus_3D(longueur, largeur,ep_mat);
  translate([0,longueur-0.01,0])rotate([90,0,0])color("pink") arr_3D(largeur,hauteur,ep_mat);  
  translate([0,ep_mat,0]) rotate([90,0,0]) av_3D(largeur,hauteur,ep_mat);   
  translate([ep_mat,0,0]) rotate([0,-90,0]) color("blue")cote_3D(longueur,hauteur,ep_mat);   
  translate([largeur,0,0]) rotate([0,-90,0]) color("blue")cote_3D(longueur,hauteur,ep_mat); 
  translate([largeur-ep_mat,ep_mat,ep_mat]) rotate([0,-90,0]) color("brown")cote_int_3D(hauteur,longueur,ep_mat); 
  translate([2*ep_mat,ep_mat,ep_mat]) rotate([0,-90,0]) color("brown")cote_int_3D(hauteur,longueur,ep_mat); 
  translate([ep_mat,-largeur/4,hauteur-2*ep_mat]) color("grey") couvercle_3D(largeur,longueur,ep_mat); 
  translate([largeur/2,ep_mat/2,hauteur-ep_mat]) rotate([0,0,0]) color("red") bouton_3D(largeur,ep_mat);  
  translate([largeur/2-ep_mat/2,ep_mat,hauteur-ep_mat*2]) rotate([90,0,0]) color("black") pion_3D(ep_mat);  
}


if(vue==1){ 
   fond_2D(longueur, largeur,ep_mat);
   translate([largeur+2,0,0]) dessus_2D(longueur, largeur,ep_mat);
   translate([2*largeur+4+hauteur,0,0]) rotate([0,0,90]) av_2D(largeur,hauteur,ep_mat);
   translate([2*largeur+4+hauteur,largeur+2,0]) rotate([0,0,90]) arr_2D(largeur,hauteur,ep_mat);
    translate([2*largeur+4+4+hauteur,0,0]) cote_2D(longueur,hauteur,ep_mat);
    translate([2*largeur+4+4+4+2*hauteur,0,0]) cote_2D(longueur,hauteur,ep_mat);
   translate([2*largeur+14+3*hauteur,0,0]) couvercle_2D(largeur,longueur,ep_mat);
   translate([3*largeur/2,largeur,0])  bouton_2D(largeur,ep_mat);
    translate([ 3*largeur/2,0,0])  pion_2D(ep_mat);
    
    translate([3*largeur+14+3*hauteur,0,0]) cote_int_2D(hauteur,longueur,ep_mat);
    translate([3*largeur+14+4*hauteur,0,0]) cote_int_2D(hauteur,longueur,ep_mat);
   
}