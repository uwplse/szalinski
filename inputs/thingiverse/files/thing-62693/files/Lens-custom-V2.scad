//Customizable Open-source lens holder
// This is a cleaned up version of http://www.thingiverse.com/thing:26752

//CUSTOMIZER VARIABLES
//Defines the Diameter of the Lens 
Lens_Diameter=25.4; //Numeric value 

//Defines the Lens holder Thickness
Lens_Holder_Thickness=10;   //Numeric value 

//Defines the Lens Holder Lip Size
Lens_Holder_Lip_Size=3;     //Numeric value smaller than y

//Defines the Base Diameter
Base_Diameter=25; //Numeric value 

//Defines the Base Height
Base_Height=25;  //Numeric value 

//Defines the Guide Rod Length
Guide_Rod_Length=20; //Numeric value 

//Defines the Guide Rod Diameter
Guide_Rod_Diameter=8; //[2:12]

//Defines the Set Screw Diameter
Set_Screw_Diameter=3; //[2:10]

//Defines the Set Screw Nut Diameter
Set_Screw_Nut_Diameter=6; //[4:20]

//Defines the Set Screw Nut Thickness
Set_Screw_Nut_Thickness=3; //[2:10]





//CUSTOMIZER VARIABLES END


// ignore variable values
//Defines the Diameter of the Lens 
x=Lens_Diameter; //Numeric value 

//Defines the Lens holder Thickness
y=Lens_Holder_Thickness;   //Numeric value 

//Defines the Lens Holder Lip Size
z=Lens_Holder_Lip_Size;     //Numeric value smaller than y

//Defines the Base Diameter
X=Base_Diameter; //Numeric value 

//Defines the Base Height
Y=Base_Height;  //Numeric value 

//Defines the Guide Rod Length
e=Guide_Rod_Length; //Numeric value 

//Defines the Guide Rod Diameter
d=Guide_Rod_Diameter; //[2:12]

//Defines the Set Screw Diameter
a=Set_Screw_Diameter; //[2:10]

//Defines the Set Screw Nut Diameter
b=Set_Screw_Nut_Diameter; //[4:20]

//Defines the Set Screw Nut Thickness
c=Set_Screw_Nut_Thickness; //[2:10]


lens_holder();

module lens_holder(){
difference(){
cylinder(y/2,(x+10)/2,(x+10)/2);
cylinder((y+2)/2,(x-3)/2,(x-3)/2);
translate([0,0,1.5])cylinder((y+2)/2,(x+1)/2,(x+1)/2);
translate([0,(x+10)/2+5,(b+3)/2])rotate([90,0,0])cylinder(10,(a+1)/2,(a+1)/2);
translate([0,(x+8)/2,(b+3)/2])nuttrap();
translate([(x+15)/2,e/2,(d+6)/2])rotate([90,0,0])cylinder(e,(d+6)/2, (d+6)/2);
}
difference(){
translate([0,0,y/2])cylinder((y)/2,(x+5)/2,(x+5)/2);
cylinder((y)*2,(x+1)/2,(x+1)/2);
translate([0,(x+10)/2+5,(b+3)/2])rotate([90,0,0])cylinder(25,(b+3)/2,(b+3)/2);
translate([0,(x+8)/2,(b+3)/2])nuttrap();
}
difference(){
translate([0,(x+8)/2,0])set_screw((b+3)/2);
cylinder((y+2),(x+1)/2,(x+1)/2);
}
difference(){
translate([(x+15)/2,0,0])guide_rod();
rotate([0,0,90]){
#translate([0,((x+7)/-2)-((d)),(d+6)/2])rotate([90,0,0])cylinder(50,(a+1)/2,(a+1)/2);
translate([((x+7.5)/2)+((d+6)),0,0])rotate([0,0,90])set_screw1((d+6)/2);
}
}
translate([((x+7.5)/2)+((d+6)),0,0])rotate([0,0,90])set_screw((d+6)/2);
}

module guide_rod(){
difference(){
translate([0,e/2,(d+6)/2])rotate([90,0,0])cylinder(e,(d+6)/2, (d+6)/2);
translate([0,(e/2)+1,(d+6)/2])rotate([90,0,0])cylinder(e+2,(d+1)/2, (d+1)/2);
}
difference(){
translate([0,0,(d+6)/4])cube([(d+6),e,(d+6)/2], center = true);
translate([0,(e/2)+1,(d+6)/2])rotate([90,0,0])cylinder(e+2,(d+1)/2, (d+1)/2);
}
}

module set_screw(h){
difference(){
translate([0,5,h])rotate([90,0,0])cylinder(10,(b+3)/2, (b+3)/2);
#translate([0,10,h])rotate([90,0,0])cylinder(200,(a+1)/2, (a+1)/2);
translate([0,0,h])nuttrap();
}
difference(){
translate([0,0,h/2])cube([(b+3),10,h], center = true);
translate([0,6,h])rotate([90,0,0])cylinder(12,(a+1)/2, (a+1)/2);
translate([0,0,h])nuttrap();
}
}
module set_screw1(h){
translate([0,5,h])rotate([90,0,0])cylinder(10,(b+3)/2, (b+3)/2);
translate([0,0,h/2])cube([(b+3),10,h], center = true);

}

module nuttrap(){
translate([0,(c+1)/2,0])rotate([90,0,0])hexagon(c+1,(b+1)/2);
translate([0,0,(b*3)/2])cube([b+1,c+1,b*3],center = true);
}

module reg_polygon(sides,radius)
{
  function dia(r) = sqrt(pow(r*2,2)/2);  //sqrt((r*2^2)/2) if only we had an exponention op
  if(sides<2) square([radius,0]);
  if(sides==3) triangle(radius);
  if(sides==4) square([dia(radius),dia(radius)],center=true);
  if(sides>4) circle(r=radius,$fn=sides);
}

module hexagonf(radius)
{
  reg_polygon(6,radius);
}

module hexagon(height,radius) 
{
  linear_extrude(height=height) hexagonf(radius);
}
