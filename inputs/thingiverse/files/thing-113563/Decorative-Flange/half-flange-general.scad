// general size flange 
// July 5, 2013
// R Lazure

Inside_Diameter=100;//[10:200]
Flange_Lip=15;//[5,10,15,20,25,30]
Edge_Height=15;//[5,10,15,20,25,30]
$fa=2+1;
thickness=1.95+.05;
OD= Inside_Diameter+2*Flange_Lip+2*thickness;
ODrad= OD/2;
IDrad= Inside_Diameter/2;
innerrad= IDrad+thickness;

intersection(){
	translate([-ODrad-15,-OD-30,0]) cube(OD+30,OD+30,OD+30);
 difference() {
   union(){
     cylinder(thickness, ODrad, ODrad);
    cylinder(Edge_Height, innerrad, innerrad);
          }
   translate([0,0,-10]) cylinder(Edge_Height+20,Inside_Diameter/2,Inside_Diameter/2);
             }
		}

 
