//ball jar gnat trap
//Joshua Case
//9-25-19
//a slow and painful death to all of these tiny vermin

verticalThickness = 1.8;    //Vertical Thickness of the entire part. 
funnelHeight = 45;          //Height of funnel above (below) top surface of jar. 
funnelBaseDiameter = 74;    //Jar Inner Diameter. allowance for measurement tolerance not included.
flareDiameter = 82;         //Jar Outer Diameter
holeDiameter = 8;
$fn=60;                     //Segments per rotation

difference(){
conePrimitive();
translate([0,0,-verticalThickness]) conePrimitive();
}




module conePrimitive(){


difference(){
    union(){
translate([0,0,verticalThickness]) rotate([0,0,0]) cylinder(h=funnelHeight,d1=funnelBaseDiameter,d2=holeDiameter);
translate([0,0,0]) rotate([0,0,0]) cylinder(h=verticalThickness,d=flareDiameter);
    }
translate([0,0,0]) rotate([0,0,0]) cylinder(h=funnelHeight+verticalThickness,d=holeDiameter);    
    
}
}