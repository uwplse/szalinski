unitSize = 25;
groundHeight=5;
miniX=20;
miniY=1;
miniZ=30;
wall=2;
$fn = 100;
translate([-miniX/2 - wall,-wall -miniY/2,groundHeight]) 
{
difference()
{
    cube([miniX + wall * 2,miniY + 2 * wall,miniZ]);
    translate([wall,wall,0 ])
    cube([miniX,miniY,miniZ + 0.01]);
    
    translate([0,-0.01,miniZ - (miniX-wall)/2 -wall])
    rotate([-90,0,0])
    translate([(miniX+wall *2)/2,0,0])
    cylinder(miniY + 2 * wall + 0.02,d=miniX-wall,d=miniX-wall);
    
    translate([wall * 1.5,-0.01,0])
    cube([miniX-wall,miniY + 2 * wall + 0.02,miniZ - (miniX-wall)/2 -wall]);
}
}
cylinder(groundHeight,d=unitSize,d=unitSize);