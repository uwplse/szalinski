/*universal nozzleplate for M6 nozzles (Mk8, Ultimaker 2, Creality CR-10, Ender 2)
text, number of nozzles 
20181013 P. de Graaff
*/

//Material
Text="PLA";

//number of nozzle holes
number=4;

difference(){
    minkowski(){
        cube([len(Text)*8+number*10+2.5,10,10]);
        sphere(0.5);
    }
    for (i=[0:number-1]){
        translate([len(Text)*8+5+i*10+0.5,5,-1])cylinder(d=6,h=20,$fn=50);
    }
    //Text
     #translate([2,1,9])linear_extrude(height = 2,convexity=4)
      text(Text, size = 8, font ="Arial", $fn = 100);
}