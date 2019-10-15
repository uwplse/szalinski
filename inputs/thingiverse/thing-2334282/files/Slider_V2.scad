//Slider Base Dimensions
Width = 8;
Length = 16;
Thickness = 1.25;

//////Peg Dimensions//////
Diameter = 6.75; //Increse if slider is too loose, decrease if too snug
Height = 3;

module slider_base(x,y){  //Cutout slot, (x,y) = position
translate([0,0,0]){
union(){
cube([Length-Width,Width,Thickness]);
translate([0,Width/2,0]){
    cylinder(r=Width/2,h=Thickness);
}
translate([Length-Width,Width/2,0]){
    cylinder(r=Width/2,h=Thickness);
}
}
}
}
module peg(x,y,z){
translate([x,y,z]){
    cylinder(r=Diameter/2,h=Height);
}
}
union(){
slider_base();
peg(Length-Width/2-Diameter/2,Width/2,Thickness);
}