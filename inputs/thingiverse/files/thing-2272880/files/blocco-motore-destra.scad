blocMotDx();

module blocMotDx(){

x_cube=90;
y_cube=75; //80
thickness=10;
cut=thickness+20;
r_axis=4.5;
r_motorshaft=3.5;
r_motorbolt=3.8/2;
r_vite=5.5/2; //screw M5 for 3DRAG
bolt_distance = 31;
r_boltplates=1.6;
y_motor=-y_cube/5.71;//-14
x_motor=x_cube/9;//10

difference(){
    
translate([-5,0,0]) cube([x_cube,y_cube,thickness],center=true);
    
     //motore 
  translate([-x_motor-10,y_motor,0]) { 
cylinder(h=cut,r=r_motorshaft, center=true, $fn=100);    
translate([0,0,-thickness/2]) cylinder(h=2,r=11.5, center=true, $fn=100);    
translate([bolt_distance/2,bolt_distance/2,0]) cylinder(h=cut,r=r_motorbolt, center=true, $fn=100); 
translate([-bolt_distance/2,bolt_distance/2,0]) cylinder(h=cut,r=r_motorbolt, center=true, $fn=100); 
translate([bolt_distance/2,-bolt_distance/2,0]) cylinder(h=cut,r=r_motorbolt, center=true, $fn=100); 
translate([-bolt_distance/2,-bolt_distance/2,0]) cylinder(h=cut,r=r_motorbolt, center=true, $fn=100);     
}
//fissaggio asta
 translate([-x_motor+35,y_motor,0])
cylinder(h=cut,r=r_axis,center=true,$fn=100);

//fissaggio sulla stampante
 translate([-5,y_cube/2 -10,0])
 cylinder(h=cut,r=r_vite,center=true,$fn=100);
 translate([-x_cube/2+10,y_cube/2 -10,0])
 cylinder(h=cut,r=r_vite,center=true,$fn=100);
 translate([x_cube/2-20,y_cube/2 -10,0])
 cylinder(h=cut,r=r_vite,center=true,$fn=100);

//fissaggio doppio estrusore
translate([-x_cube/2,-9,0])  //y era 0
         {
translate([-1,0,0])
  cylinder(h=30,r=3.5/2,$fn=100,center=true);
             //tolto per ora
//translate([-1,20,0])
  //cylinder(h=30,r=3.5/2,$fn=100,center=true);
translate([-1,-20,0])
  cylinder(h=30,r=3.5/2,$fn=100,center=true);
         }
         
         //tagli per ridurre tempo di lavoro
         
         translate([30,-38,0])
         rotate(30,0,0)
         cube([60,30,30],center=true);
         
         //translate([-50,-36,0])
         //rotate(-40,0,0)
         //cube([30,20,20],center=true);
   } 
}

