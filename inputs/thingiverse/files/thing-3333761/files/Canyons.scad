lazer();
translate([0,30,0])scale([-1,1,1])lazer();
module lazer(){
// CAÑON PRINCIPAL
 z01=0;
 translate ([0,0,z01]) cylinder(h=26,r1=10.5/2.0,r2=4.60/2,center=false, $fn=100);
 z02=z01+26;
 translate ([0,0,z02])cylinder(h=34.5, r1=4.60/2.0,r2=4.70/2, center=false, $fn=100);
 z03=z02+34.5;
 translate ([0,0,z03]) cylinder(h=2.0, r=9.72/2, center=false, $fn=100);
 z04=z03+2.0;
 translate ([0,0,z04]) cylinder(h=6.16, r1=4.98/2, r2=6.66/2, center=false, $fn=100);
 z05=z04+6.16;
 translate ([0,0,z05]) cylinder(h=1.72, r=9.7/2, center=false, $fn=100);
 z06=z05+1.72;
 translate ([0,0,z06]) cylinder(h=1.14, r=6.66/2, center=false, $fn=100);
 z07=z06+1.14;
 translate ([0,0,z07]) cylinder(h=1.48, r=9.7/2, center=false, $fn=100);
 z08=z07+1.48;
 translate ([0,0,z08]) cylinder(h=3.28, r=4.8/2, center=false, $fn=100);
 z09=z08+3.28/2;
 difference(){
   translate ([0,0,z09]) cube([1.2,9.7,3.28], true);
   union(){
   translate ([0,5.8,z09]) rotate([30,0,0])cube([1.4,3.28,6], true);
   translate ([0,-5.8,z09]) rotate([-30,0,0])cube([1.4,3.28,6], true);
   }
 }
  rotate([0,0,90])difference(){
   translate ([0,0,z09]) cube([1.2,9.7,3.28], true);
   union(){
   translate ([0,5.8,z09]) rotate([30,0,0])cube([1.4,3.28,6], true);
   translate ([0,-5.8,z09]) rotate([-30,0,0])cube([1.4,3.28,6], true);
   }
 }

 translate([0,0,39])rotate([90,0,0])scale([0.7,1,1])cylinder(h=0.8,r=5,$fn=100);
 translate([0,0,39])rotate([0,90,0])scale([1,0.7,1])cylinder(h=0.8,r=5,$fn=100);
// CAÑON SECUNDARIO
 zz01=0;
 translate([0,-6.0,zz01])cylinder(h=28.7,r=1.7,$fn=100);
 zz02=zz01+28.7;
 translate([0,-6.0,zz02])cylinder(h=2.57,r=1.25,$fn=100);
 zz03=zz02+2.57;
 translate([0,-6.0,zz03])cylinder(h=1.0,r=1.7,$fn=100);
 zz04=zz03+1.0;
 translate([0,-6.0,zz04])cylinder(h=2.57,r=1.25,$fn=100);
 zz05=zz04+2.57;
 translate([0,-6.0,zz05])cylinder(h=3.35,r1=1.7,r2=1.85,$fn=100);
 translate([-2.5,-6.0,zz01+12.5]) cube([5.0,6.0,19-12.5]);
 translate([0,-6,zz01+12.5]) cylinder(h=19-12.5,r=2.5,$fn=100);
 
// BASE CAÑON
 scale([-1,1,-1])translate([-7.9/2,-15.1/2,0])
 difference(){
  cube([7.9,15.1,59.0]);
   union() {
    translate([4,1.95,-0.05])cube([7.92,11.3,60.5]);
    translate([-0.05,1.95,40.7])cube([10,11.3,16.2]);
   }
 }
 
// SEMICILINDRO HORIZONTAL
 translate ([2,0,0])
 rotate([0,90,0])
 difference(){
  difference(){
  cylinder(h=7.03,r=10.5,$fn=100);
  translate(0,0,-0.5)cylinder(h=7.13,r=10.5-1.9,$fn=100);
  }
  translate([0,-10.6,-.005]) cube([14.06,21.1,7.04]);
 }
 translate ([2,0,0]) rotate([0,90,0])
 difference(){
    cylinder(h=3.4,r=10.5,center=false,$fn=100);
    translate([0,-10.6,-0.05]) cube([10.6,10.6*2,3.5]);
 }
// SEMICILINDRO VERTICAL CON HENDIDURA
 rotate([90,0,180])
 translate([-3,-9,-3.7/2])
 difference(){
  union(){
   cylinder(h=0.9,r=11.4,center=false,$fn=100);
   translate([0,0,0.9]) cylinder(h=1.9,r=11.0,center=false,$fn=100);
   translate([0,0,2.8]) cylinder(h=0.9,r=11.4,center=false,$fn=100);
  }
  translate([0,-11.4,-1])cube([11.4*2,11.4*2,5.1],center=false);
 }
// 4 semicilindros
 rotate([90,0,0])translate([4,-2,0])union(){
   translate([0,0,0])cylinder(h=15.0-1.7*2,r=1.7,center=true,$fn=100);
   translate([0,0,-15/2+1.7])sphere(1.7,$fn=100);
   translate([0,0,15/2-1.7])sphere(1.7,$fn=100);
 }
 rotate([90,0,0])translate([4,-7.2,0])union(){
   translate([0,0,0])cylinder(h=15.0-1.7*2,r=1.7,center=true,$fn=100);
   translate([0,0,-15/2+1.7])sphere(1.7,$fn=100);
   translate([0,0,15/2-1.7])sphere(1.7,$fn=100);
 }
 rotate([90,0,0])translate([4,-12.4,0])union(){
   translate([0,0,0])cylinder(h=15.0-1.7*2,r=1.7,center=true,$fn=100);
   translate([0,0,-15/2+1.7])sphere(1.7,$fn=100);
   translate([0,0,15/2-1.7])sphere(1.7,$fn=100);
 }
 rotate([90,0,0])translate([4,-18.4,0])union(){
   translate([0,0,0])cylinder(h=15.0-1.7*2,r=1.7,center=true,$fn=100);
   translate([0,0,-15/2+1.7])sphere(1.7,$fn=100);
   translate([0,0,15/2-1.7])sphere(1.7,$fn=100);
 }

//SEMIPRISMA Y SEMIESFERA
rotate([0,0,-90])rotate([-90,0,0])translate([0,29,5.6])
union(){
    difference(){
      cube([15,15,3.6],center=true);
      translate([-8,-7.5,-1.8])rotate([45,0,0])cube([16,6,6]);
    }
    translate([0,0.8,3.6])cube([13.8,8.6,3.6],center=true);
    translate([0,0.8,5.4])scale([1.2,.6])cylinder(h=2,r=9.3/2,center=true,$fn=100);
    translate([0,0.8,6.1])sphere(2,$fn=100);
}
//TRASERA CAÑON
 translate([4.2,-7.5,-59])rotate([0,180,0])
 difference(){
   cube([8.4,15,2.5]);
    union(){
     translate([-1,0,0])rotate([45,0,0])cube([10,2.5*1.41,2.5*1.41]);
     translate([-1,15,0])rotate([45,0,0])cube([10,2.5*1*1.41,2.5*1.41]);
   }
 }
 translate([-4.2,-5.2,-64]) cube([8.4,10.2,2.8]);
 translate([-5.3,-6.1,-65.6]) cube([10.6,12.2,1.6]);
 translate([-4.2,-5.2,-68.4]) cube([8.4,10.2,2.8]);
 translate([-5.3,-6.1,-70.0]) cube([10.6,12.2,1.6]);
 translate([-4.2,-5.2,-72.8]) cube([8.4,10.2,2.8]);
 translate([-5.3,-6.1,-74.4]) cube([10.6,12.2,1.6]);
 translate([-10.6*0.8/2,-12.2*0.8/2,-74.6]) cube([10.6*0.8,12.2*0.8,0.4]);
 translate([0,0,-73.0]) rotate([0,90,0])cylinder(r=3.3,h=1.7,center=true,$fn=100);
//ENCAJE HEXAGONAL
 translate([0,0,-14])rotate([0,90,0])difference(){
   cylinder(h=8.5,r=9.8/2,center=true,$fn=100);
   cylinder(h=8.6,r=7.05/2,center=true,$fn=6);
 }
// TOPE
 translate([0,0,-5.2])
 difference(){
   union(){
     union(){
       translate([2.5,2.5,0])cylinder(r=5,h=1.8,center=true,$fn=100);
       translate([-2.5,2.5,0])cylinder(r=5,h=1.8,center=true,$fn=100);
       translate([2.5,-2.5,0])cylinder(r=5,h=1.8,center=true,$fn=100);
       translate([-2.5,-2.5,0])cylinder(r=5,h=1.8,center=true,$fn=100);
       cube([15,5,1.8],center=true);
       cube([5,15,1.8],center=true);
     }
     intersection(){
       translate([0,0,1.8])union(){
         translate([2.5,2.5,0])cylinder(r=5,h=1.8,center=true,$fn=100);
         translate([-2.5,2.5,0])cylinder(r=5,h=1.8,center=true,$fn=100);
         translate([2.5,-2.5,0])cylinder(r=5,h=1.8,center=true,$fn=100);
         translate([-2.5,-2.5,0])cylinder(r=5,h=1.8,center=true,$fn=100);
         cube([15,5,1.8],center=true);
         cube([5,15,1.8],center=true);
       }
       union(){
         translate([0,0,1.8])cube([15,1.5,1.7],center=true);
         translate([0,3.5,1.8])cube([15,1.5,1.7],center=true);
         translate([0,-3.5,1.8])cube([15,1.5,1.7],center=true);
       }
     }
   }
   translate([0,-15/2-.5,-1.8/2-0.5])cube([15,16,4.5]);
 }
//3 piezas bajo el cañon
 translate([-2,0,4.5])rotate([0,-90,0])union(){
   scale([1,.4,1])
   union(){
     cylinder(r=2,h=8,center=true,$fn=100);
     translate([0,0,4.25])sphere(r=2,center=true,$fn=100);
   }
   translate([0,2.3+2*0.4,0])scale([1,.4,1])
   union(){
     cylinder(r=2,h=8,center=true,$fn=100);
     translate([0,0,4.25])sphere(r=2,center=true,$fn=100);
   }
   translate([0,-2.3-2*0.4,0])scale([1,.4,1])
   union(){
     cylinder(r=2,h=8,center=true,$fn=100);
     translate([0,0,4.25])sphere(r=2,center=true,$fn=100);
   }
   translate([-1,-3,-4])cube([2,2*(2.3+2*0.4),8]);
 }
// PESTAÑA ENCAJE ALA
translate([-10.8,0,-39.6-7.5]) rotate([0,-90,0])rotate([0,0,180])union(){
  cube([14.8,9.69,2.4],center=true);
  translate([7.4-1.2,0,1.8])rotate([90,0,0])cylinder(r=1.2,h=9.69,center=true,$fn=100);
  translate([7.4-1.2,0,0.6])rotate([90,0,0])cube([2.4,2.4,9],center=true);
  translate([7.4-2.8  -1.2*3,0,1.8])rotate([90,0,0])cylinder(r=1.2,h=9.69,center=true,$fn=100);
  translate([7.4-2.8  -1.2*3,0,0.6])rotate([90,0,0])cube([2.4,2.4,9.69],center=true);
  translate([7.4-2.8*2-1.2*5,0,1.8])rotate([90,0,0])cylinder(r=1.2,h=9.69,center=true,$fn=100);
  translate([7.4-2.8*2-1.2*5,0,0.6])rotate([90,0,0])cube([2.4,2.4,9.69],center=true);
  translate([-1.3,0,-5])cube([12.2,9.69,10],center=true);
  translate([-1.3,0,-10])cube([12.2,12,5],center=true); 
}
}
// REGLA
//translate([4,0,-21])cube([1,1,21]);