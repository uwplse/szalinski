//Radius is half Diameter
inner_radius=4;
//Radius is half Diameter
outer_radius=11;
width=7; 
clearance =0.15;
chamfer=0.5;
$fn=100;


//chamfer=rnd(0,2);
//inner_radius=round(rnd(1,50));
//outer_radius=round(rnd(inner_radius+5+chamfer*5 ,50));
//width=round(rnd(outer_radius-inner_radius+chamfer*2,30)); 
//clearance =0.4;
//
//$fn=100;
//echo (inner_radius,outer_radius,width, clearance ,chamfer );

color("SlateGray")races();
l=(inner_radius+outer_radius)*PI;
rr=(outer_radius-inner_radius)*(2/3)+clearance;
an=floor(l/rr);
 color("Silver")for(i=[0:360/an:360])
rotate([0,0,i])roller();




module races(){
rotate_extrude()difference(){ offset(delta=+chamfer,chamfer=true) offset(delta=-chamfer,chamfer=true)   

 
 difference(){
translate([inner_radius+(outer_radius-inner_radius)*0.5,0])   square([outer_radius-inner_radius,width],center=true);
  union(){
   offset(delta=clearance,chamfer=true)   translate([inner_radius+(outer_radius-inner_radius)*0.5,0]) square([(outer_radius-inner_radius)*(1/3),width*2],center=true);

}

}
  offset(delta=clearance,chamfer=true) hull(){
    translate([inner_radius+(outer_radius-inner_radius)*0.5,0]) square([(outer_radius-inner_radius)*(1/3),width*(2/3)],center=true);
    translate([inner_radius+(outer_radius-inner_radius)*0.5,0]) square([(outer_radius-inner_radius)*(2/3),width*(1/3)],center=true);
}}}

module roller(){
  translate([inner_radius+(outer_radius-inner_radius)*0.5,0]) 

rotate_extrude()intersection (){
 translate([outer_radius*0.5,0])square([outer_radius,width],center=true);

union(){
  offset(delta=+chamfer,chamfer=true) offset(delta=-chamfer,chamfer=true)    
 square([(outer_radius-inner_radius)*(1/3),width],center=true);
hull(){
    square([(outer_radius-inner_radius)*(1/3),width*(2/3)],center=true);
  square([(outer_radius-inner_radius)*(2/3),width*(1/3)],center=true);
}}}}



function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 