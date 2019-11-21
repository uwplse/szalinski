//Pipping Dimensions
//All measurements below in mm

//Main Pipe Diameter
D=80;
//Main Pipe Height
H=110;
//Top Edge Diameter
E=90;
//Top Edge Height
L=30;
//Inside Pipe Diameter
D2=75;
//Inside Pipe Height
H2=240;

module pipeout(){
color("green",1.0) union (){
    cylinder(L,E,E,Center=true,$fn=100);
    translate([0,0,80]) cylinder(H,D,D,center=true,$fn=100);}
    
}
module pipein(){
    cylinder(H2,D2,D2,center=true,$fn=100);}
    
    difference(){pipeout(); pipein();}