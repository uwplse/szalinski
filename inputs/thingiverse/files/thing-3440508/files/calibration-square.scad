/* cailbration square
20190220 P. de Graaff
*/
//dimensions of the baseplate in mm
dimension=120;//[100:10:200]
//baseplate height in mm
height=1;
//nozzle diameter in mm
nozzle=0.4;
//circle diameter
drill=20;

//Achsenvermessung
difference(){
    cube([dimension,dimension,height]);
    for(i=[0:1:7]){
        translate([dimension/2,dimension/2,-1])rotate([0,0,45/2+i*45])translate([dimension/3,0,0])cylinder(d=drill,h=10,$fn=100);
    }
}
for (i=[1:1:dimension/10-1]){
    translate([-0.4+i*10,0,1])cube([2*nozzle,10,0.5]);
    translate([0,-0.4+i*10,1])cube([10,2*nozzle,0.5]);
    translate([-0.4+i*10,dimension-10,1])cube([2*nozzle,10,0.5]);
    translate([dimension-10,-0.4+i*10,1])cube([10,2*nozzle,0.5]);
}
translate([dimension/2-nozzle,0,1])cube([2*nozzle,dimension,0.5]);
translate([0,dimension/2-nozzle,1])cube([dimension,2*nozzle,0.5]);
rotate([0,0,45])translate([0,-nozzle,1])cube([sqrt(dimension*dimension+dimension*dimension),2*nozzle,0.5]);
translate([dimension,0,0])rotate([0,0,135])translate([0,-nozzle,1])cube([sqrt(dimension*dimension+dimension*dimension),2*nozzle,0.5]);

translate([11,2,1])linear_extrude(height = 1,convexity=4)text("X", size = 8, font ="Arial", $fn = 100);
translate([2,11,1])linear_extrude(height = 1,convexity=4)text("Y", size = 8, font ="Arial", $fn = 100);