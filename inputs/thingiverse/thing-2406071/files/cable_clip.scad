Openning_Width = 4;
Wall_Thickness = 3.2;
Cable_Diameter = 8.2; 
Side_Thickness = 2.8;
Height = 17;
Side_Width = 8;
Extra_Width = 3;
Cylinder_Quality = 20;

difference(){
cylinder(d=Cable_Diameter+Wall_Thickness,h=Height,$fn=Cylinder_Quality);
translate([-Openning_Width/2,0,-.5])
cube([Openning_Width,Cable_Diameter+Wall_Thickness,Height*3]);
cylinder(d=Cable_Diameter,h=Height*3,center=true,$fn=Cylinder_Quality*0.9);
}
translate([-(Cable_Diameter+Wall_Thickness+Extra_Width)/2,-Side_Thickness-Cable_Diameter/2-Wall_Thickness/8])
cube([Cable_Diameter+Wall_Thickness+Extra_Width,Side_Thickness,Height]);

translate([-(Cable_Diameter+Wall_Thickness+Extra_Width)/2,-Side_Width-Side_Thickness-Cable_Diameter/2-Wall_Thickness/8])
cube([Cable_Diameter+Wall_Thickness+Extra_Width,Side_Width+Side_Thickness,Side_Thickness]);