//card size with sleeve
// Width
Wb=63;
// Lenght
Lb=88;
//Height - total height of a card pile
Hb=30;
// offset for card+sleeve vs. Box
m=2;
//bottom Thickness
bt=2;
//box thickness
e=1.5; 
// box pillar width
p=10;
//Box Fillet
f=8;
//hollow base
hb=1;//[0:close,1:Hollow]
//hollow size
hs=15;
//X Array copy
ROWS=1;
//Y Array copy
COLS=1;

$fn=50;
    W=Wb+2*m;
    L=Lb+2*m;
    H=Hb+bt-1.5;


module rectangular_array( rows,cols, d1, d2) {
    for ( i= [0:1:rows-1])  {
        for ( j= [0:1:cols-1]) {
            translate([d1*i,d2*j,0,]) 
            children();
        }
    }
}

module Filletminus (r,X,Y,Z,E,a,b,c,t1,t2,t3) {
    translate([X,Y,Z]){
    rotate([t1,t2,t3]){
    mirror([a,b,c]){
    angles = [0, 90];
    points = [
    for(a = [angles[0]:1:angles[1]]) [r * cos(a), r * sin(a)]
];
    linear_extrude (E){
    polygon(concat([[0, 0]], points));
        }
    }
}
}
}
module Filletplus (r,X,Y,Z,E,a,b,c,t1,t2,t3) {
    translate ([X,Y,Z]){
        rotate([t1,t2,t3]){
        mirror ([a,b,c]){
            difference (){
                cube([r,E,r]);   
                mirror ([0,1,0]){
                    translate ([r,0,r]){
                        rotate ([0,0,90]){   
                            mirror([1,0,1]){
                        
                                angles = [0, 90];
                                points = [
                                for(a = [angles[0]:1:angles[1]]) [r * cos(a), r * sin(a)]];
                                union(){
                                translate ([0,0,-1]){    
                                linear_extrude (E+2){
                                    polygon(concat([[0, 0]], points));
                                     }}
                                 translate([0,-1,-1]){cube([r,1,E+2]);}
                                 translate([-1,-1,-1]){cube([1,r+1,E+2]);}
                                 }
                            }
                        }
                    }
                }
             }
         }
        }
    }
}
 

rectangular_array( rows=ROWS,cols=COLS, d1=W+e, d2=L+e)

union() {

    difference() {
            difference (){
                  minkowski()
            {
                translate([1.5,1.5,0]){ cube([W+2*e-3,L+2*e-3,H+1.5]);}
                translate([0,0,0]){cylinder(H+1.5,r=1.5);} 
           }
           translate([-2,-2,H+1.5]){cube([W+2*e+4,L+2*e+4,H+3]);}
       }         
        
        if (hb==1){
         fb=5;
            translate ([hs+fb,hs+fb,-1]){
                minkowski()
            {    

                cube([W-2*hs+2*e-2*fb,L-2*hs+2*e-2*fb,bt+1]);
                cylinder(bt+1,fb); 
            }
     }
} 
        translate([e,e,bt]) {
    cube([W,L,H+2]);
        }
        translate ([p+e,-1,bt]) {
    cube([W-2*p,L+4*e,H+2]);
        }
        translate ([-1,p+e,bt]) {
    cube([W+4*e,L-2*p,H+2]);
        }
        translate([p+e-f,-1,H+1.5-f]) {
        cube([W-2*p+2*f,L+2+2*e,f+1]);
        }
        translate([-1,p+e-f,H+1.5-f]) {
        cube([W+2*e+2,L-2*p+2*f,f+1]);
        }
        
    }
    Filletminus(f,p+e-f,e,H+1.5-f,e,0,0,0,90,0,0);
    Filletminus(f,p+e-f,L+2*e,H+1.5-f,e,0,0,0,90,0,0);
    Filletminus(f,W-p+e+f,e,H+1.5-f,e,1,0,0,90,0,0); 
    Filletminus(f,W-p+e+f,L+2*e,H+1.5-f,e,1,0,0,90,0,0);
    Filletminus(f,0,p+e-f,H+1.5-f,e,1,0,0,0,90,0); 
    Filletminus(f,W+e,p+e-f,H+1.5-f,e,1,0,0,0,90,0);
    
       Filletminus(f,W+e,L+e-p+f,H+1.5-f,e,1,1,0,0,90,0);
       Filletminus(f,0,L+e-p+f,H+1.5-f,e,1,1,0,0,90,0);
//    
    Filletplus(p/2,p+e,0,bt,e,0,0,0,0,0,0); 
    Filletplus(p/2,p+e,L+e,bt,e,0,0,0,0,0,0);
    Filletplus(p/2,W-p+e,0,bt,e,1,0,0,0,0,0); 
    Filletplus(p/2,W-p+e,L+e,bt,e,1,0,0);
    Filletplus(p/2,0,p+e,bt,e,0,1,0,0,0,90);
    Filletplus(p/2,W+e,p+e,bt,e,0,1,0,0,0,90);
    Filletplus(p/2,e,L-p+e,bt,e,0,1,0,0,0,-90);
    Filletplus(p/2,W+2*e,L-p+e,bt,e,0,1,0,0,0,-90);

}



