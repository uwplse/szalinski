// Dacia Lodgy phone holder clip on ventilation flap
// Clip composé de deux bras et d'un embout incliné
// sur lequel glisser le support du smartphone

// Dimensions des bras
larg = 5; // Largeur des bras
ep = 4; // Epaisseur des bras
long1 = 40; // Longueur bras supérieur
long2 = 32; // Longueur bras inférieur
dist = 6; // distance d'écart entre les bras
d= 2*ep+dist; //  
r= d/2;
rayon=200; // Rayon de courbure du bras inférieur
rayonplus=rayon+10;
a=asin(long2/rayon); // Angle d'ouverture du bras inférieur

// Dimensions de l'Embout glissière
x1 = 7; 
x2 = 3;
x3 = 1.5;
h1 = 16;
h2 = 2.3;
h3 = 8;
y1 = d;
y2 = 2;
y3 = d;

// Bras supérieur droit
module brassup(){
   translate([r,0,0]) cube([long1,ep,larg],center=false);    
   translate([r+long1,0,0])cube([ep,2*ep,larg],center=false); 
    }
//brassup();

// Bras inférieur courbe
module brasinf(){
 translate([r+long2,0.75*ep+ dist,0]) cylinder(larg,r=0.75*ep,$fn=50);
 translate([r,-rayon+ep+dist+0.28*ep,0])
difference(){
 translate([0,0,0])
 rotate_extrude(convexity=10)
  translate([rayon, 0]) square(size = [ep, larg], center = false);
  translate([-rayonplus,-rayonplus,0])cube([rayonplus,2*rayonplus,larg], center = false);
  rotate(-a) translate([0,-rayonplus,0])cube([rayonplus,2*rayonplus,larg], center = false);  
};
}
//brasinf();

// Renfort Bras inférieur
module renfort(){
   translate([ep/2,ep+dist+0.7*ep,0])
   linear_extrude(height = larg/2) polygon([[0,0],[0,10],[long2,0]]); 
      }
//renfort();
      
// Renfort Bras supérieur
module renforts(){
   translate([ep/2,0.2*ep,0])
   linear_extrude(height = larg/2) polygon([[0,0],[0,-10],[long1,0]]); 
      }
//renforts();
      
// module clip
module clip() {
    union(){
        brasinf();
        brassup();
        }
}
//clip();

//module embout 
module embout(){
   union() {
     translate([0,0,0])cube([x1,y1,h1],center=false);
     translate([-x2,y1-y3,h1/2-h2/2])cube([x2,y3,h2],center=false);
     translate([-x2,y1-y3,h1/2-h3/2])cube([x2,y3,0.5],center=false); // cloison fine à  découper après impression  
     translate([-x2,y1-y2,h3/2])cube([x2,y2,h3],center=false);   
     translate([-x2-x3,y1-y3,h3/2])cube([x3,y3,h3],center=false);  
   }
   }
   
 // Module embout incliné
   module embouti(){
 difference(){     
  rotate([0, 30, 0]) translate([0,0,0]) embout(); // embout incliné
  translate([0,0,-4])cube([20,d,4],center=false); // embout raboté en bas
  translate([r+3,ep,0])cube([5,dist,h1],center=false); // embout raboté au milieu 
     }
 }

union(){
    clip();
    renfort();
    renforts();
    embouti();
}

// jean-Nicolas Maisonnier - 24 février 2019