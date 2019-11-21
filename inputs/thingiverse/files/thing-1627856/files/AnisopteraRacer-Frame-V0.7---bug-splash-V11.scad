lenX     = 35;
lenY     = 33;

motD     =  8.5; //Diametre moteur
dX       =  12;
thick    =  3;
q        = 15;
housingh = 12; // Hauteur des blocs moteurs
camangle = 20; //

anglmod = 20; // valeur de modification de l'angle des bras avant


// 600 mah 1S NANOTech Turnigy
  batt1L = 79;
  batt1l = 19;
  batt1h = 7;

// 300 mah 2S
//batt2L = 43; //45
//batt2l = 16.8; //17
//batt2h = 13; //12

// 350 mah 1S 130C
batt3L = 52;
batt3l = 30;
batt3h = 5;

// Bloc central
blocL = 36;
blocl = 18;
bloch = 16;


minblochh =(bloch-2)/2;
echo ("Z du bloc central");
echo (minblochh);

lenL = sqrt((lenX-dX)*(lenX-dX)+lenY*lenY);
armL = lenL-motD/2;

angl = acos((lenX-dX)/lenL);
echo ("Angle");
echo(angl);
echo ("Longueur des bras");
echo(armL);
echo ("Longueur");
echo(lenL);

minbatth = -4+10.5;
h1 = minbatth+batt1h/2;
//h2 = minbatth+batt2h/2;
h3 = minbatth+batt3h/2;


c = 15;

a = 2*((cos(90-camangle))*bloch);


echo("a");
echo (a);

echo("c");
echo (c);

module profile(sz) translate([0,0, sz]) rotate([0, 90, 0]) {
     hull() {
        translate([  02,0,0]) cylinder(d=thick+0, h=0.1, $fn=4*q);
        translate([ sz+0.5,0,-1]) cylinder(d=thick/3, h=0.1, $fn=4*q);
    }
}
module motor(a) translate([lenL,0,0]) {
    //color("silver")     translate([0,0, 1.1]) cylinder(h=20, d=motD-0.5,$fn=4*q);
    //color("darkorange") translate([0,0, 22]) cylinder(h=3, d=56,$fn=10*q);
     {
       color("pink") translate([0,0,minblochh-7]) difference() {
            translate([     0,0, 0])  cylinder(h=housingh, d=motD*1.7 , $fn=4*q);
            translate([     0,0,-1])  cylinder(h=       3, d=motD*0.75, $fn=4*q);
            translate([     0,0, 1])  cylinder(h=housingh, d=motD+0.0 , $fn=4*q);
            translate([-motD/2,-2.3*a, 0])  rotate([0,0,10*a]) cube([motD,2,housingh*3], center=true);
            difference() {
                translate([0,0, housingh*0.75])  cylinder(h=housingh, d=motD*3, $fn=4*q);
                translate([0,0, housingh*0.75])  cylinder(h=housingh*0.25, d1=motD*1.7,d2=motD*1.1, $fn=4*q);
            }
            difference() {
                translate([0,0, -housingh*0.5 ])  cylinder(h=housingh, d=motD*3, $fn=4*q);
                translate([0,0, 0])  cylinder(h=housingh*0.5, d2=motD*1.7,d1=motD*1.2, $fn=4*q);
            }
        }
        translate([-lenL,0, -0]) difference() {
            union() {
              color("green")  hull() {
                    translate([ armL*0.,-3,bloch+1  ])  rotate([0,90,0])    cylinder(h=0.1, d=2,  $fn=12);    
                    translate([ armL*0., 3,bloch+1  ])  rotate([0,90,0])    cylinder(h=0.1, d=2,  $fn=12);   
                    translate([ armL*0.24, 0,bloch+1  ])  rotate([0,90,0])    cylinder(h=0.1, d=2,  $fn=12);   
                    translate([ armL*0.32, 0,15-bloch ])    rotate([0,90,0])    cylinder(h=0.1, d=2,  $fn=18);    
                    translate([ armL*0.4, 0,bloch-0.5  ])  rotate([0,90,0])    cylinder(h=0.1, d=4.5,$fn=18); 
                    translate([ armL*0.7, 0,bloch-(5)  ])   rotate([0,90,0])    cylinder(h=0.1, d=3,  $fn=18); 
                }               
            color("red")    hull() {
                    translate([ armL*0.34,0,-2])  profile(bloch+1.5);  
                    translate([ armL*0.63,0, 4])  profile(bloch-6.5); 
                }            
               hull() {
                    translate([ armL*0.55,0, 4])  profile((bloch)-6); 
                    translate([ armL*0.98,0, 4])  profile((bloch)/2);  
                }
            }          
        }
    }
}

module scisky() translate([0,0,0])  {
    color("green")  translate([  0,  0,     0])          cube([33.8,19.8,0.8], center=true);
    color("silver") translate([-29.48/2,0,1.8])          cube([ 6.7, 7.9,2.8], center=true);
    color("green")  translate([  1,  0,  -1.4])          cube([30.5,19.8,2  ], center=true);
    color("white")  translate([ 29.48/2-3-4.4,3,0.4])    cube([ 6.1, 4.4,4.1], center=false);
    color("white")  translate([ 29.48/2-3-4.4,-7.4,0.4]) cube([ 6.1, 4.4,4.1], center=false);
    color("red")    translate([  0.5, 9.5, 0])           cube([ 3,   3,  2  ], center=true);
    color("red")    translate([  0.5,-9.5, 0])           cube([ 3,   3,  2  ], center=true);
    color("red")    translate([-11,   9.5, 0])           cube([ 3,   3,  2  ], center=true);
    color("red")    translate([-11,  -9.5, 0])           cube([ 3,   3,  2  ], center=true); 
    }
    
module batt1() { 
    translate([(blocL/2)-(batt1L/2)+1,0,h1]) color("silver")         translate([0,0,0]) minkowski() {
             cube([batt1L-4, batt1l-4, batt1h-4], center=true);
             sphere(r=2, $fn=2*q);
        }
    translate([-(batt1L*3/4)+(blocL/2)-(batt1L/2)+2,5,h1]) color("red")    rotate([0,90,0]) cylinder(h=20,d=2, $fn=2*q);
    translate([-(batt1L*3/4)+(blocL/2)-(batt1L/2)+2,3,h1]) color("black")  rotate([0,90,0]) cylinder(h=20,d=2, $fn=2*q);
    }
module batt3() { 
    translate([(blocL/2)-(batt3L/2)+1,0,h3]) color("silver")         translate([0,0,0]) minkowski() {
             cube([batt3L-4, batt3l-4, batt3h-4], center=true);
             sphere(r=2.25, $fn=2*q);
        }
    translate([-(batt3L*3/4)+(blocL/2)-(batt3L/2)+2,5,h3]) color("red")    rotate([0,90,0]) cylinder(h=20,d=2, $fn=2*q);
    translate([-(batt3L*3/4)+(blocL/2)-(batt3L/2)+2,3,h3]) color("black")  rotate([0,90,0]) cylinder(h=20,d=2, $fn=2*q);
    }
    
module body() {
   color("green") difference() {
        scale([3,1.8,1.5])   sphere(r=10,   center=true);
        translate([0,9,-3])  cube([30,4,2], center=true);
       
    }
}  

module camera(camangle) color("grey") translate([ 29,0,11]) rotate([0,90-camangle,0]) {
            difference() {
            color ("blue") union() {
            translate([  6.5,    -7, -14])           rotate([0,0,0]) minkowski() {cube([1, 14,16], center=false); sphere(r=0.5); } //cam plate BOTTOM
            translate([  -7.5,    -7, 3])  rotate([0,90,0]) minkowski() {cube([1, 14,15], center=false); sphere(r=0.5); } //cam plate FRONT
            translate([  - 8.5,   -7, -12])  rotate([0,0,0]) minkowski() {cube([1, 14,15], center=false); sphere(r=0.5); } //cam plate TOP
            }
            union() {
            translate([  -0.5, 0,-2])           cube([12.5, 12.5,5], center=true);
            translate([ 0, -6.750, 0])           cube([7, 10,8], center=true);
            translate([  -0.5, 0, 0])           cylinder(d=9,h=9,   center=true);
            }
        }
}

module VTX() color("grey") {
translate([  0,  0, (bloch)+3 ]) cube([24, 22,4  ], center=true); //VTX
translate([  0,  0, (bloch)-2 ]) cube([19, 13,10  ], center=true); //VTX
}
module frame() {
     
    difference() {
        union() {
            translate([  dX+anglmod/5*1,0.5,0]) rotate([0,0, angl+anglmod    ]) motor(-1); //Front Left
            translate([  dX+anglmod/5*1,-0.5,0]) rotate([0,0,-angl-anglmod    ]) motor( 1); //Front Right
            translate([ -dX-0*1,-0,0]) rotate([0,0, angl+180]) motor(-1); // Rear Right
            translate([ -dX-0*1,-0,0]) rotate([0,0,-angl+180]) motor( 1);// Rear Left
            $fn=50;
   
        union() {//bloc de base
            translate([0,0,minblochh]) minkowski() {
                 cube([blocL, blocl,bloch], center=true);
                 sphere(r=3);
            }
            camera (camangle); // commenter ave // pour se débarasser du bloc de la caméra
            
            
        }
    }
        
        scisky();
        
        translate([  -1, 0, 0]) batt1();
        translate([   1, 0, 0]) batt1();
        translate([  -1, 0, 0]) batt3();
        translate([   1, 0, 0]) batt3();
        translate([  -0, 0,-2  ]) minkowski() {cube([28, 13,40  ], center=true); sphere(r=0); }         //bloc vertical pour ajourement du bas
        translate([  -0, 0,20  ])           cube([30, 13,20  ], center=true);                            //bloc vertical pour ajourement du haut
        translate([  15, 0, 1])             cube([10, 13, 6.5], center=true);                            //bloc horizontal interieur face avant
        translate([  0,  0, (bloch-2)/2 ])  cube([34, 30,(bloch-1)  ], center=true);                    //bloc transversal central
        translate([ -5,  0, 2.5  ])         cube([18, 30,10  ], center=true);                            //bloc transversal bas de scisky
        translate([-21.9,0, 2  ])           cube([20, 14, 7  ], center=true);                            //bloc sortie USB
        
        VTX();
    }
        difference() {
            color("gold") union()  {
            //translate([-3,0,18.72])  cube([4, 13.5,1.6], center=true); //top bar
            translate([  0,  0, (bloch) ]) cube([24, 19,2  ], center=true); //VTX Platform
            translate([ 3,0,-3.19])  cube([4, 13.5,1.5], center=true); //bottom bar
            }
            VTX();  
    }
 }
 
frame();
//VTX();
//color ("grey")    translate([  0,  0, (bloch)+2 ]) cube([24, 22,4  ], center=true); //VTX
//color ("black")    translate([  -0, 0,-2  ]) minkowski() {cube([28, 13,40  ], center=true); sphere(r=0); } //bloc vertical pour ajourement du bas
// color ("blue")     translate([  -0, 0,20  ]) cube([30, 13,20  ], center=true);                            //bloc vertical pour ajourement du haut
// color ("brown")    translate([  15, 0, 0.5]) cube([10, 13, 6.5], center=true);                            //bloc horizontal interieur face avant
// color ("red")      translate([  0,  0, (bloch-2)/2 ]) cube([34, 30,(bloch-1)  ], center=true);            //bloc transversal central
// color ("orange")   translate([ -5,  0, 2.5  ]) cube([18, 30,10  ], center=true);                          //bloc transversal bas de scisky
//color ("purple")   translate([-21.9,0, 2  ]) cube([20, 14, 7  ], center=true);                            //bloc sortie USB
 
//scisky();
//batt1();
//batt3();
//camera(camangle);



