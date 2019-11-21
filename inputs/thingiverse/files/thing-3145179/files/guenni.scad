$fn=64;
$name="Günni"; //Auf der Schubladenrückseite
module Fuss(hoehe)
{
translate ([0,0,hoehe/2]) cylinder (r=2.5, h=hoehe, center=true) ;
translate([0,0,hoehe]) sphere (r=2.5);    
cylinder (r1=6, r2=2.5, h=2.5, center=true);
};
module wuerfel()
{minkowski()
    {
    sphere(r=2, center=true);
    cube ([5,5,5], center=true);
    };   
}

module seitenstrebe ()
{cube([90,8,2], center=true);
};
module querstrebe()
{difference (){ cube([8,45,2], center=true);
    translate ([0,0,1]) cube([0.5,35,1], center=true);
    translate ([2,0,1]) cube([0.5,35,1], center=true);
    translate ([-2,0,1]) cube([0.5,35,1], center=true);
    
    
    
    
    } 
};



module knopf()
{  rotate([0,270,0]) 
    hull(){
    cylinder(r=3, h=3, center=true);
    sphere(r=3, center=true);
    };

    
}
    

module seitenbrett()
{difference() {rotate ([90,0,0]) cube ([35,10,2], center=true);
     rotate([90,0,0]) translate([-13.5,-2,0]) linear_extrude(2) text("COLMIC", font = "Gill Sans MS", size=5, center=true);}
};

module sitz()
{
    difference () {minkowski()  { cube([35,35,25], center=true);
        sphere(r=2.5, center=true);}
        
        translate([0,0,-9.5]) cube([40,35,10], center=true); 
        translate([0,0,-10.5]) cube([30,40,10], center=true);
        translate([0,0,3.5]) cube([40,35,10], center=true);
    }
    translate([12,0,15]) difference() { 
        rotate([0,-90,0]) cylinder(h=12, r1=5, r2=1, center=true);
        translate ([1,0,0]) rotate([0,-90,0]) translate ([0,0,-1])cylinder(h=10, r1=4.5, r2=1.5, center=true);
    }
};
module bar_halter()
{ cylinder (r=3, h=5, center=true);
    translate([0,-1.5,-2]) cube([10,3,4]);
    translate ([10,0,0]) rotate([0,90,90]) cylinder (r=3, h=5, center=true);
    translate([10,-1.5,-3]) rotate ([0,-45,0]) cube([14,3,4]);
    difference() {
        translate ([20,0,10]) rotate([0,90,90]) cylinder (r=3, h=5, center=true);
       translate ([20,0,10]) rotate([0,90,90]) cylinder (r=2, h=10, center=true);
    }
};
module rod_halter()
{ cylinder (r=3, h=5, center=true);
    translate([0,-1.5,-2]) cube([10,3,4]);
    translate ([10,0,0]) rotate([0,90,90]) cylinder (r=3, h=5, center=true);
    translate([10,-1.5,-3]) rotate ([0,-45,0]) cube([14,3,4]);
    difference() {
        translate ([20,0,10]) rotate([0,90,90]) cylinder (r=3, h=5, center=true);
       translate ([20,0,11.5]) rotate([0,90,90]) cylinder (r=2, h=10, center=true);
    }
};
module bar()
{
 difference() {
        rotate([90,0,0]) cylinder(r=2, h=55, center=true);
        rotate ([0,90,0]) translate ([-2.5,17,0]) cylinder (r=1.5, h=7, center = true);
        rotate ([0,90,0]) translate ([-2.5,12,0]) cylinder (r=1.5, h=7, center = true);
        rotate ([0,90,0]) translate ([-2.5,7,0]) cylinder (r=1.5, h=7, center = true); 
        rotate ([0,90,0]) translate ([-2.5,2,0]) cylinder (r=1.5, h=7, center = true);
        rotate ([0,90,0]) translate ([-2.5,-3,0]) cylinder (r=1.5, h=7, center = true);
        rotate ([0,90,0]) translate ([-2.5,-8,0]) cylinder (r=1.5, h=7, center = true); 
        rotate ([0,90,0]) translate ([-2.5,-13,0]) cylinder (r=1.5, h=7, center = true);
        rotate ([0,90,0]) translate ([-2.5,-18,0]) cylinder (r=1.5, h=7, center = true);
 }
    };
    
 module schublade()
 {
   difference(){ 
      cube([38.5,33.5,8.50], center=true);
      translate ([0,0,1]) cube([33.5,30.5,8.5], center=true);
       rotate([90,0,-90]) translate([-8.0,-2,18.5]) linear_extrude(1) text($name, font = "Gill Sans MS", size=4, center=true);
      };
  translate ([21.5,0,0]) knopf();
      }
      
    module sitzkiepe()
{      
Fuss(50);
translate ([0,45,0]) Fuss(50);
translate ([40,0,0]) Fuss(50);
translate ([40,45,0]) Fuss(50);
translate ([80,0,0]) Fuss(60);
translate ([80,45,0]) Fuss(60);

translate([40,4,10]) seitenstrebe();
translate([40,41,10]) seitenstrebe();
translate ([0,22.5, 10]) querstrebe();
//translate ([10,22.5, 10]) querstrebe();
//translate ([20,22.5, 10]) querstrebe();
//translate ([30,22.5, 10]) querstrebe();
translate ([40,22.5, 10]) querstrebe();
translate ([50,22.5, 10]) querstrebe();
translate ([60,22.5, 10]) querstrebe();
translate ([70,22.5, 10]) querstrebe();
translate ([80,22.5, 10]) querstrebe();

translate ([0,0,10])wuerfel();
translate ([40,0,10])wuerfel();
translate ([80,0,10])wuerfel();
translate ([0,45,10])wuerfel();
translate ([40,45,10])wuerfel();
translate ([80,45,10])wuerfel();

translate ([87,0,10]) knopf();
translate ([87,45,10]) knopf();

translate ([40,-7,10])  rotate ([90,180,90]) knopf();
translate ([-7,0,10])  rotate ([90,180,0]) knopf();
translate ([40,52,10])  rotate ([90,180,270]) knopf();
translate ([-7,45,10])  rotate ([90,180,0]) knopf();

translate([20,0,10]) seitenbrett();
translate([20,45,10]) rotate([0,0,180]) seitenbrett();
translate ([20,22.5,25]) sitz();
translate ([80,45,40]) bar_halter();
translate ([80,0,40]) bar_halter();
translate ([100,22.5,50]) bar();
translate([0,0,40]) rotate([180,0,-90]) rod_halter();
translate([80,0,25]) rotate([180,180,90]) rod_halter();
}
translate ([0,0,1.3]) sitzkiepe();
//translate ([40,-40,4.25]) schublade();
//translate ([40,-80,4.25]) schublade();

