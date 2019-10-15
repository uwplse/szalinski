//customizable ruler by Stu121

use<write/Write.scad>



RulerLength=10;// [1:50]
RulerText="My Ruler";
FontSize=10;
TextX=3;
TextY=18;
TextHeight=1;
NumberSize=7;//[1:15]
NumberOffset=0;//[0:3]

difference(){
hull(){

translate([0,5,0]) cube([(RulerLength*10)+10,25,2.5]);
translate([0,-5,0])  cube([(RulerLength*10)+10,1,1]);

}


}

for (i=[1:1:RulerLength]){
if (i > 9){
translate([(i*10)-2+NumberOffset,5.5,1]) write(str(i),h=NumberSize,t=2); 
}
else
translate([(i*10)+NumberOffset,5.5,1]) write(str(i),h=NumberSize,t=2); 
}
translate([1,5.5,1]) write("CM",h=5,t=2); 


for (i=[0:10:RulerLength*10]){  
translate([i+3,-4.9,0.5]) rotate([8.5,0,0]) cube([.5,10,.7]);
}

for (i=[0:1:RulerLength*10]){   //embosed ruler lines
translate([i+3,-4.9,0.4]) rotate([8.5,0,0]) cube([.25,5,.7]);
}

translate([TextX,TextY,TextHeight])  write(RulerText,h=FontSize,t=2); 