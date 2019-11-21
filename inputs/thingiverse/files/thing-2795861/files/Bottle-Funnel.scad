$fn=70;

nozzleOD = 19;
nozzleLength = 15;

funnelHeight = 35;
funnelDiameter = 50;

wallThickness = 2;

finWidth = 3;

difference(){
    positive();
    negative();
}
module positive(){
    cylinder(d=nozzleOD,h=nozzleLength + funnelHeight);
    cylinder(d1=funnelDiameter,d2=nozzleOD,h=funnelHeight);
    rotate([0,0,0]) fin();
    rotate([0,0,120]) fin();
    rotate([0,0,240]) fin();
}
module fin(){
    translate([0,-(finWidth/2),0]) cube([funnelDiameter/2-5,finWidth,funnelHeight-5]);
}
module negative(){
    cylinder(d=nozzleOD-(wallThickness*2),h=nozzleLength + funnelHeight);
    cylinder(d1=funnelDiameter-(wallThickness*2),d2=nozzleOD-(wallThickness*2),h=35);
}