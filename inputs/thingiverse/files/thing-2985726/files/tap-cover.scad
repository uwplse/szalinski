// just a quick water tap screw cap cover

topdia=10.7;
topHight=6.7;
$fn=80;
tex="H";// text on top
 
difference(){
 cylinder(d=topdia,h=topHight);
   difference(){//cut out around center
     translate([0,0,topHight-4.5])cylinder(d=topdia+0.1,h=2.8);
     translate([0,0,topHight-4.5])cylinder(d=topdia-0.5,h=2.8);
   }
   // slot cutouts
   translate([-topdia/2,-0.5,3])cube([topdia,1,4.5]);
   rotate([0,0,90])translate([-topdia/2,-0.5,3])cube([topdia,1,4.5]);
   // inside cutout
   translate([0,0,3])cylinder(d=topdia-3,h=topHight-2);
   // text on top
   translate([-2.5,-2.5,-0.5])
   linear_extrude(height = 1, center = false, convexity = 10, twist = 0)
   text(tex,5);
  
}