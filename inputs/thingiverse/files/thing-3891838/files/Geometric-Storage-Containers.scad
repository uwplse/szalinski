// Geometric Container/Vase
// Nick Moeggenborg
// 10/1/2019

/* [Part] */

Part = "3"; //[1:Container,2:Lid,3:Both]

/* [Container] */

// Container Shape
$fn = 3; //[3:Triangle,4:Square,5:Pentagon,6:Hexagon,7:Heptagon,8:Octagon,9:Nonagon,10:Rough Circle,100:Smooth Circle] 

// Container Diameter in mm
D_con = 75;

// Container Height in mm
H_con = 50;

// Container Thickness (walls and base) in mm
T_con = 5;

/* Lid */

// Lid Diameter in mm
D_lid = D_con + T_con;

// Lid Height in mm
H_lid = 0.25*H_con;

// Lid Thickness (walls and base) in mm
T_lid = T_con;


if (Part=="1"){
    Container();
}else if (Part == "2"){
    translate([-D_con+T_con,0,0])
    Lid();
}else {
    Container();
    Lid();
}
//


module Container()
{
    difference(){
        cylinder(h=H_con,d=D_con);
    
        translate([0,0,T_con])
            cylinder(h=1.5*H_con,d=D_con-T_con);
    }
}
//

module Lid()
{
translate([D_con+T_con,0,0])
difference(){
    cylinder(h=H_lid,d=D_lid+T_con);
    
    translate([0,0,T_lid])
        cylinder(h=1.5*H_lid,d=D_lid-T_lid);
    }
}