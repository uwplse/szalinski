include <write/Write.scad>
//Message
message = "neomakr";
//Font
Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/braille.dxf":Braille]
//Font Size
font_size = 10;
//Font Thickness
font_thickness = 5;
//Base Thickness
base_thickness = 10;

union(){
linear_extrude(height=base_thickness,center=true){
union(){
difference(){
translate([15,0]){polygon(points=[[0,0],[15,18.5],[15,-15.5]], paths=[[0,1,2]]);}
square([50,50],center=true);
}
difference(){
translate([0,15]){polygon(points=[[0,0],[-15.5,15],[18.5,15]], paths=[[0,1,2]]);}
square([50,50],center=true);
}
difference(){
difference(){square([50,50],center=true);
polygon(points=[[-34.8,0],[-19.8,18.7],[-19.8,-15.7]], paths=[[0,1,2]]);}
polygon(points=[[0,-34.8],[18.7,-19.8],[-15.7,-19.8]], paths=[[0,1,2]]);}
}
}
writecube(message,[3,3,font_thickness/2],face="top",h=font_size,t=font_thickness,[50,50,base_thickness],center=true);
}


