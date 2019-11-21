/*
 *      merici rameno v.1
 *
 *
 */
 
 // velikost potenciometru

osa_zavit = 7.5;
osa_hridel = 6.5;

 
 
 module potenciometr()
 {
     translate([0,0,0]) cylinder(d=16, h=9);
     translate([0,0,0]) cylinder(d=6.8, h=16);
     translate([0,0,0]) cylinder(d=5.8, h=39);
     translate([0,0,13]) cylinder(d=11, h=2, $fn=6);
     hull()
     {
        translate([0,0,5.5]) cylinder(d=16, h=2);
        translate([14,-8,5.5]) cube([1,15,2]);
     }
     translate([-1.2,-8,9]) cube([2.4,1,2]);
 }
 
 
 module zakladna()
 {
     difference()
     {
        translate([0,0,0]) cylinder(d=50,h=20);
        translate([-1.5,-8.5,9]) cube([3,2,20]);
        union()
        {
            translate([0,0,0]) cylinder(d=osa_zavit,h=20);
            hull()
            {
                translate([0,0,0]) cylinder(d=25,h=18);
                translate([20,0,0]) cylinder(d=25,h=18);
            }
        } 
        translate([0,-18,10.2]) cylinder(d=10,h=10);
        translate([0,18,10.2]) cylinder(d=10,h=10);
        translate([0,-18,0]) cylinder(d=4,h=10);
        translate([0,18,0]) cylinder(d=4,h=10);
        difference()
        {
            translate([0,0,0]) cylinder(d1=25,d2=45,h=20);
            union()
            {
                translate([0,0,0]) cylinder(d1=25,d2=25,h=20);
                translate([-10,-25,0]) cube([50,50,20]);
            }
        }
     }
 }
 
 
 module osa()
 {
     difference()
     {
         hull()
         {
            translate([0,0,0]) cylinder(d=50,h=5);
            translate([0,0,70]) sphere(d=25); 
         }
         union()
         {
            translate([0,0,0]) cylinder(d=osa_hridel,h=30);
            difference()
            {
                translate([0,0,0]) cylinder(d=44,h=70);
                union()
                {
                    translate([0,0,0]) cylinder(d=26,h=70);
                    translate([-50,23,-30]) rotate([24,0,0]) cube([100,100,100]);
                    hull()
                    {
                        translate([-2,-12,40]) rotate([0,90,0]) cylinder(d=10,h=4);
                        translate([-2,-9,30]) rotate([0,90,0]) cylinder(d=8,h=4);
                    }
                    
                }
            } 
            //srouby na osu
            translate([-3.75,10,0]) cube([7.5,3.5,30]);
            translate([0,0,7]) rotate([-90,0,0]) cylinder(d=4.5,h=30);
            translate([0,0,14]) rotate([-90,0,0]) cylinder(d=4.5,h=30);
            translate([0,0,21]) rotate([-90,0,0]) cylinder(d=4.5,h=30);

            //ocko na kabely
            translate([-15,-12,40]) rotate([0,90,0]) cylinder(d=4,h=30);
            translate([2,-17,40]) rotate([0,90,0]) cylinder(d=14,h=10);
            translate([-12,-17,40]) rotate([0,90,0]) cylinder(d=14,h=10);
            
            // horni vyrez
            translate([2,-25,70]) rotate([-30,0,0]) cube([30,50,50]);
            translate([-2,0,70]) rotate([0,90,0]) cylinder(d1=22,d2=19,h=1.5);
            hull()
            {
                translate([-22,0,70]) rotate([0,90,0]) cylinder(d=25,h=20);
                translate([-22,-20,70]) rotate([0,90,0]) cylinder(d=25,h=20);
            }
            
            //montaz potenciometru
            translate([-5,0,70]) rotate([0,90,0]) cylinder(d=osa_zavit,h=10);
            translate([-5,-1.5,76.5]) cube([20,3,3.5]);
         }
     }
     
 }
 
module podlozka()
 {
     difference()
     {
         intersection()
         {
             translate([0,0,0]) cylinder(d=55,h=13,center=true);
             translate([0,0,-8.5]) sphere(d=60,center=true);
         }
         union()
         {
            translate([0,0,6.5]) cylinder(d=50.8,h=4,center=true);
            translate([0,0,0]) cylinder(d=44,h=15,center=true);
         }
     }
 }
 
 module rameno_dlouhe(rameno_dlouhe_delka = 200)
 {
     difference()
     {
         union()
         {
             //telo
             hull()
             {
                 translate([0,0,0]) cylinder(d=25,h=5);
                 translate([0,rameno_dlouhe_delka,0]) cylinder(d=25,h=5);
             }
             // predni uchyt osy
             hull()
             {
                translate([0,0,5]) cylinder(d1=25,d2=15,h=15);
                translate([-6,10,0]) cylinder(d=3,h=20);
                translate([6,10,0]) cylinder(d=3,h=20);
             }
         }
         union()
         {
            // predni uchyt osy
            translate([0,0,0]) cylinder(d=osa_hridel,h=20);
            hull()
            {
                translate([-1,0,0]) cylinder(d=2,h=20);
                translate([-1,12,0]) cylinder(d=2,h=20);
            }
            hull()
            {
                translate([-1,12,0]) cylinder(d=2,h=20);
                translate([-13,18,0]) cylinder(d=2,h=20);
            
            }
            translate([0,7,8]) rotate([0,90,0]) cylinder(d=3.4,h=20,center=true);
            translate([-9,7,8]) rotate([0,90,0]) cylinder(d=7,h=5,center=true);
            translate([9,7,8]) rotate([0,90,0]) cylinder(d2=7,d1=5.5,h=5,center=true,$fn=6);
            translate([0,7,16]) rotate([0,90,0]) cylinder(d=3.4,h=20,center=true);
            translate([-9,7,16]) rotate([0,90,0]) cylinder(d=7,h=5,center=true);
            translate([9,7,16]) rotate([0,90,0]) cylinder(d2=7,d1=5.5,h=5,center=true,$fn=6);
             
            // zadni uchyceni potenciometru
            translate([0,rameno_dlouhe_delka,3]) cylinder(d1=17,d2=21,h=2);
            translate([5.6,rameno_dlouhe_delka-1.5,0]) cube([3,3,20]);
            translate([0,rameno_dlouhe_delka,0]) cylinder(d=osa_zavit,h=20);
            
            // odlehceni a montazni otvory
            hull()
            {
                translate([0,40,0]) cylinder(d=15,h=6);
                translate([5,30,0]) cylinder(d=5,h=6);
                translate([5,50,0]) cylinder(d=5,h=6);
            }    
            hull()
            {
                translate([0,70,0]) cylinder(d=15,h=6);
                translate([-5,60,0]) cylinder(d=5,h=6);
                translate([-5,80,0]) cylinder(d=5,h=6);
            }    
            hull()
            {
                translate([0,100,0]) cylinder(d=15,h=6);
                translate([5,90,0]) cylinder(d=5,h=6);
                translate([5,110,0]) cylinder(d=5,h=6);
            }    
            hull()
            {
                translate([0,130,0]) cylinder(d=15,h=6);
                translate([-5,120,0]) cylinder(d=5,h=6);
                translate([-5,140,0]) cylinder(d=5,h=6);
            }    
            hull()
            {
                translate([0,160,0]) cylinder(d=15,h=6);
                translate([5,150,0]) cylinder(d=5,h=6);
                translate([5,170,0]) cylinder(d=5,h=6);
            }    
         }
     }
 }
 
 module rameno_stredni(rameno_stredni_delka = 150)
 {
     difference()
     {
         union()
         {
             //telo
             hull()
             {
                 translate([0,0,0]) cylinder(d=25,h=5);
                 translate([0,rameno_stredni_delka,0]) cylinder(d=25,h=5);
             }
             // predni uchyt osy
             hull()
             {
                translate([0,0,5]) cylinder(d1=25,d2=15,h=15);
                translate([-6,10,0]) cylinder(d=3,h=20);
                translate([6,10,0]) cylinder(d=3,h=20);
             }
         }
         union()
         {
            // predni uchyt osy
            translate([0,0,0]) cylinder(d=osa_hridel,h=20);
            hull()
            {
                translate([-1,0,0]) cylinder(d=2,h=20);
                translate([-1,12,0]) cylinder(d=2,h=20);
            }
            hull()
            {
                translate([-1,12,0]) cylinder(d=2,h=20);
                translate([-13,18,0]) cylinder(d=2,h=20);
            
            }
            translate([0,7,8]) rotate([0,90,0]) cylinder(d=3.4,h=20,center=true);
            translate([-9,7,8]) rotate([0,90,0]) cylinder(d=7,h=5,center=true);
            translate([9,7,8]) rotate([0,90,0]) cylinder(d2=7,d1=5.5,h=5,center=true,$fn=6);
            translate([0,7,16]) rotate([0,90,0]) cylinder(d=3.4,h=20,center=true);
            translate([-9,7,16]) rotate([0,90,0]) cylinder(d=7,h=5,center=true);
            translate([9,7,16]) rotate([0,90,0]) cylinder(d2=7,d1=5.5,h=5,center=true,$fn=6);
             
            // zadni uchyceni potenciometru
            translate([0,rameno_stredni_delka,3]) cylinder(d1=17,d2=21,h=2);
            translate([6.5,rameno_stredni_delka-1.5,0]) cube([3,3,20]);
            translate([0,rameno_stredni_delka,0]) cylinder(d=osa_zavit,h=20);
            
            // odlehceni a montazni otvory
            translate([0,-8,0])
            {
                hull()
                {
                    translate([0,40,0]) cylinder(d=15,h=6);
                    translate([5,30,0]) cylinder(d=5,h=6);
                    translate([5,50,0]) cylinder(d=5,h=6);
                }    
                hull()
                {
                    translate([0,70,0]) cylinder(d=15,h=6);
                    translate([-5,60,0]) cylinder(d=5,h=6);
                    translate([-5,80,0]) cylinder(d=5,h=6);
                }    
                hull()
                {
                    translate([0,100,0]) cylinder(d=15,h=6);
                    translate([5,90,0]) cylinder(d=5,h=6);
                    translate([5,110,0]) cylinder(d=5,h=6);
                }    
                hull()
                {
                    translate([0,130,0]) cylinder(d=15,h=6);
                    translate([-5,120,0]) cylinder(d=5,h=6);
                    translate([-5,140,0]) cylinder(d=5,h=6);
                }    
            }
         }
     }
 }

 module rameno_kratke(rameno_kratke_delka = 70)
 {
     difference()
     {
         union()
         {
             //telo
             hull()
             {
                 translate([0,0,0]) cylinder(d=25,h=5);
                 translate([0,rameno_kratke_delka,3]) rotate([-90,0,0]) cylinder(d=7,h=1, $fn=6);
             }
             translate([0,rameno_kratke_delka,3]) rotate([-90,0,0]) cylinder(d=7,h=10, $fn=6);
             // predni uchyt osy
             hull()
             {
                translate([0,0,5]) cylinder(d1=25,d2=15,h=15);
                translate([-6,10,0]) cylinder(d=3,h=20);
                translate([6,10,0]) cylinder(d=3,h=20);
             }
         }
         union()
         {
            // predni uchyt osy
            translate([0,rameno_kratke_delka,3]) rotate([-90,0,0]) cylinder(d=2.6,h=15);
            translate([0,0,-1]) cylinder(d=osa_hridel,h=24);
            hull()
            {
                translate([-1,0,-2]) cylinder(d=2,h=24);
                translate([-1,12,-2]) cylinder(d=2,h=24);
            }
            hull()
            {
                translate([-1,12,-2]) cylinder(d=2,h=24);
                translate([-13,18,-2]) cylinder(d=2,h=24);
            
            }
            translate([0,7,8]) rotate([0,90,0]) cylinder(d=3.4,h=20,center=true);
            translate([-9,7,8]) rotate([0,90,0]) cylinder(d=7,h=5,center=true);
            translate([9,7,8]) rotate([0,90,0]) cylinder(d2=7,d1=5.5,h=5,center=true,$fn=6);
            translate([0,7,16]) rotate([0,90,0]) cylinder(d=3.4,h=20,center=true);
            translate([-9,7,16]) rotate([0,90,0]) cylinder(d=7,h=5,center=true);
            translate([9,7,16]) rotate([0,90,0]) cylinder(d2=7,d1=5.5,h=5,center=true,$fn=6);
             
            translate([0,50,0.4]) cube([6.6,6.6,1],center=true);
            translate([0,50,5.6]) cube([6.6,6.6,1],center=true);
            translate([-2.25,53.25,-2]) cylinder(d=1.6,h=10);
            translate([2.25,53.25,-2]) cylinder(d=1.6,h=10);
            translate([2.25,46.75,-2]) cylinder(d=1.6,h=10);
            translate([-2.25,46.75,-2]) cylinder(d=1.6,h=10);

            translate([0,40,-2]) cylinder(d=8,h=10);
            translate([0,25,-2]) cylinder(d=12,h=10);

            
/*            // odlehceni a montazni otvory
            translate([0,-8,0])
            {
                hull()
                {
                    translate([0,40,0]) cylinder(d=15,h=6);
                    translate([5,30,0]) cylinder(d=5,h=6);
                    translate([5,50,0]) cylinder(d=5,h=6);
                }    
                hull()
                {
                    translate([0,70,0]) cylinder(d=15,h=6);
                    translate([-5,60,0]) cylinder(d=5,h=6);
                    translate([-5,80,0]) cylinder(d=5,h=6);
                }    
                hull()
                {
                    translate([0,100,0]) cylinder(d=15,h=6);
                    translate([5,90,0]) cylinder(d=5,h=6);
                    translate([5,110,0]) cylinder(d=5,h=6);
                }    
                hull()
                {
                    translate([0,130,0]) cylinder(d=15,h=6);
                    translate([-5,120,0]) cylinder(d=5,h=6);
                    translate([-5,140,0]) cylinder(d=5,h=6);
                }    
            }
*/
         }
     }
 }
 
 module karta()
 {
     difference()
     {
         union()
         {
             translate([0,0,0]) cube([45,31,1.6]);
             translate([-3,1,1.6]) cube([29,28.4,2.6]);
         }
         union()
         {
             translate([45-2.5,2.5,0]) cylinder(d=3,h=2);
             translate([45-2.5,31.4-2.5,0]) cylinder(d=3,h=2);             
         }
     }
 }
 
 module lcd()
 {
     difference()
     {
        union()
        {
            translate([0,0,0]) cube([87,30,1.6]);
            translate([7,1.8,1.6]) cube([71,27.4,4.7]);
        }
        union()
        {
            translate([12,7.5,6]) cube([62,16.2,4]);
        }
    }
 }
 
module tlacitko()
{
    cylinder(d=9,h=0.8);
    cylinder(d=6.2,h=4);
}
 

module deska()
{
//    translate([49,67,-39]) 
//        rotate([20,0,180]) 
//            import("C:/Users/Sharkus/Downloads/Arduino_Uno_board/files/ArduinoUno.stl");

//    translate([0,0,50]) karta();
//    translate([4,6,11.5]) lcd();


    difference()
    {
        translate([67.8,50,5]) cylinder(d1=6,d2=8,h=13);
        translate([67.8,50,5]) cylinder(d=3,h=13);
    }
    difference()
    {
        translate([67.8,50+28,5]) cylinder(d1=6,d2=8,h=13);
        translate([67.8,50+28,5]) cylinder(d=3,h=13);
    }
    difference()
    {
        translate([9,5.8,16]) cube([75,31,2]);
        union()
        {
            translate([10.5,7.3,16]) cube([72,28,2]);
            translate([16,13.5,16]) cube([62,16.2,4]);
        }
    }


    difference()
    {
        union()
        {
            hull()
            {
                translate([0,-10,0]) cube([100,120,2]);
                translate([0,-7,0]) cube([96,114,19.8]);
            }
            translate([100,70,0]) cylinder(d1=80,d2=70,h=19.8);
        }
        union()
        {



            hull()
            {
                translate([16,13.5,17]) cube([62,16.2,1]);
                translate([14,11.5,20]) cube([66,20.2,0.1]);
            }            
            translate([-1,74.2,4.8]) cube([4,13,11.4]);
            translate([-1,45.8,4.8]) cube([4,10,11.4]);
            
            translate([100,70,0]) cylinder(d=50.8,h=20);
            difference()
            {
                union()
                {
                    hull()
                    {
                        translate([2,-8,0]) cube([96,116,1]);
                        translate([2,-5,0]) cube([92,110,18]);
                    }
                    translate([100,70,-2]) cylinder(d1=76,d2=66,h=20);
                }
                union()
                {
                    difference()
                    {
                        translate([40,0,13]) cylinder(d=8,h=6);
                        translate([40,0,13]) cylinder(d=3,h=5);
                    }
                    difference()
                    {
                        translate([60,0,13]) cylinder(d=8,h=6);
                        translate([60,0,13]) cylinder(d=3,h=5);
                    }
                    difference()
                    {
                        translate([10,-1,0]) cylinder(d=12,h=19);
                        translate([10,-1,0]) cylinder(d=4,h=16);
                    }
                    difference()
                    {
                        translate([90,-1,0]) cylinder(d=12,h=19);
                        translate([90,-1,0]) cylinder(d=4,h=16);
                    }
                    difference()
                    {
                        translate([10,101,0]) cylinder(d=12,h=19);
                        translate([10,101,0]) cylinder(d=4,h=16);
                    }
                    difference()
                    {
                        translate([80,101,0]) cylinder(d=12,h=19);
                        translate([80,101,0]) cylinder(d=4,h=16);
                    }
                }
            }
            translate([10,-1,16.2]) cylinder(d=8,h=5);
            translate([10,101,16.2]) cylinder(d=8,h=5);
            translate([90,-1,16.2]) cylinder(d=8,h=5);
            translate([80,101,16.2]) cylinder(d=8,h=5);
            
            translate([30,0,17.2]) cylinder(d=7,h=5);
            translate([50,0,17.2]) cylinder(d=7,h=5);
            translate([70,0,17.2]) cylinder(d=7,h=5);

        }
    }
}

module lista()
{
    difference()
    {
        union()
        {
            translate([5,0,0]) cube([50,6,1.5]);
            translate([5,2,0]) cube([50,2,3]);
            translate([17,0,0]) cube([6,6,3]);
            translate([37,0,0]) cube([6,6,3]);
        }
        union()
        {
            translate([6.5,0,0]) cube([7,6,0.5]);
            translate([10-2.25,0,0]) cylinder(d=1.5,h=10);
            translate([10+2.25,0,0]) cylinder(d=1.5,h=10);
            translate([10-2.25,6,0]) cylinder(d=1.5,h=10);
            translate([10+2.25,6,0]) cylinder(d=1.5,h=10);
            
            translate([26.5,0,0]) cube([7,6,0.5]);
            translate([30-2.25,0,0]) cylinder(d=1.5,h=10);
            translate([30+2.25,0,0]) cylinder(d=1.5,h=10);
            translate([30-2.25,6,0]) cylinder(d=1.5,h=10);
            translate([30+2.25,6,0]) cylinder(d=1.5,h=10);
            
            translate([46.5,0,0]) cube([7,6,0.5]);
            translate([50-2.25,0,0]) cylinder(d=1.5,h=10);
            translate([50+2.25,0,0]) cylinder(d=1.5,h=10);
            translate([50-2.25,6,0]) cylinder(d=1.5,h=10);
            translate([50+2.25,6,0]) cylinder(d=1.5,h=10);
            
            translate([20,3,0]) cylinder(d=3.5,h=10);
            translate([40,3,0]) cylinder(d=3.5,h=10);
        }
    }
}


module dekl()
{
    difference()
    {
        union()
        {
            difference()
            {
                union()
                {
                    translate([100,70,0]) cylinder(d1=80,d2=76,h=8);
                    hull()
                    {
                        translate([0,-10,0]) cube([100,120,0.5]);
                        translate([2,-8,0]) cube([96,116,8]);
                    }
                }
                union()
                {
                    difference()
                    {
                        union()
                        {
                            translate([5,-5,0]) cube([90,110,6]);
                            translate([100,70,0]) cylinder(d=72,h=6);
                        }
                        union()
                        {
                            translate([10,-1,0]) cylinder(d=20,h=8);
                            translate([90,-1,0]) cylinder(d=20,h=8);
                            translate([10,101,0]) cylinder(d=20,h=8);
                            translate([80,101,0]) cylinder(d=20,h=8);
                            translate([100,52,0]) cylinder(d=20,h=8);
                            translate([100,88,0]) cylinder(d=20,h=8);

                        }
                    }
                }
            }
        }     
        union()
        {
            translate([100,52,0]) cylinder(d=4.6,h=3);
            translate([100,52,3.2]) cylinder(d=12,h=8);
            translate([100,88,0]) cylinder(d=4.6,h=3);
            translate([100,88,3.2]) cylinder(d=12,h=8);


            translate([10,-1,0]) cylinder(d=4.6,h=3);
            translate([90,-1,0]) cylinder(d=4.6,h=3);
            translate([10,101,0]) cylinder(d=4.6,h=3);
            translate([80,101,0]) cylinder(d=4.6,h=3);
            
            translate([10,-1,3.2]) cylinder(d=12,h=8);
            translate([10,101,3.2]) cylinder(d=12,h=8);
            translate([90,-1,3.2]) cylinder(d=12,h=8);
            translate([80,101,3.2]) cylinder(d=12,h=8);
        }
    }
}




$fn=100;
translate([330,60,270]) rotate([0,-120,0]) rotate([0,-90,90]) rameno_kratke();
translate([200,70,343]) rotate([0,30,0]) rotate([0,-90,-90]) rameno_stredni();
translate([100,60,170]) rotate([0,-60,0]) rotate([0,90,-90]) rameno_dlouhe();
translate([100,70,80]) rotate([0,0,-90]) osa();
translate([100,70,65]) podlozka();
translate([100,70,30]) zakladna(); 
translate([0,0,0]) deska();
translate([30,0,-10]) tlacitko(); 
translate([50,0,-10]) tlacitko(); 
translate([70,0,-10]) tlacitko(); 
translate([20,0,-20]) mirror([0,0,1]) lista();
translate([0,0,-30]) mirror([0,0,1]) dekl();
