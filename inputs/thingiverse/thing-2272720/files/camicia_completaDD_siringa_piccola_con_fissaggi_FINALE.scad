use<camicia.scad>;
use<tubo esternoDD.scad>;

/*useful parameters:
Syringe radius: R_Siringa
Total height: H_camicia

Change value to DEBUG to see the internal part
*/

R_Siringa=9.6;
SpessorePareteSiringa=0.5;
R_camicia=31;
SpessoreMinimoCamicia=3;
H_camicia=74.15;
SpessoreMinimoSup=4;
DEBUG=0; //1:cut vertically, 2:cut horizontally

//pezzi fissaggio
r_axis=4.35;
H=12;




 union(){   
CreaCamicia(R_Siringa,SpessorePareteSiringa,R_camicia,SpessoreMinimoCamicia,H_camicia,SpessoreMinimoSup,DEBUG);
    
     rotate([0,0,90])
     {
    translate([r_axis+12,-8.5,-42.5])
     cylinder(h=H,r=r_axis-1, center=true, $fn=100);
      translate([-r_axis-12,-8.5,-42.5])
     cylinder(h=H,r=r_axis-1, center=true, $fn=100);
     }
     
 }

module CreaCamicia(R_Siringa,SpessorePareteSiringa,R_camicia,SpessoreMinimoCamicia,H_camicia,SpessoreMinimoSup,DEBUG){
difference(){
union(){
translate([-46,22,H_camicia/2-10])
    rotate([0,90,0])
 tuboesterno(5,28,4.5,5,80);
translate([-46,-22,-H_camicia/2+10])
    rotate([0,90,0])
 tuboesterno(5,28,4.5,5,80);    
 camicia(R_Siringa,R_camicia,H_camicia,80);}
    /*translate([7.5,0,0])
   rotate([0,0,180]) */
    camicia(R_Siringa+SpessorePareteSiringa,R_camicia-SpessoreMinimoCamicia,H_camicia-SpessoreMinimoSup,80);
 // fori ingresso/uscita
 translate([-R_camicia+5,22,H_camicia/2-10])
    rotate([0,90,0])
    cylinder(h=R_camicia+20,r=3.5,center=true,$fn=50);
     
    translate([-R_camicia+5,-22,-H_camicia/2+10])
    rotate([0,90,0])
    cylinder(h=R_camicia+20,r=3.5,center=true,$fn=50);

//cutting cubes, si attivano se DEBUG!=0
if (DEBUG==1) {
     
     translate([R_camicia,R_camicia,0]) cube([R_camicia*2,R_camicia*2,H_camicia+10],center=true);
} 
if (DEBUG==2) {
     
     translate([0,0,H_camicia/2]) cube([R_camicia*2,R_camicia*2,H_camicia],center=true);
} 
  

}

}
