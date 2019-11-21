innerWidth      = 17;
innerHeight     = 6;
length          = 10;
shellThickness     = 1.6;
shellBackingThickness= 4;
grippingLedgeSize      = 1.2;
screwDiameter    = 2;
screwHeadDiameter = 5;
screwHeadHeight= 3;

difference(){
    cube([innerWidth+shellThickness*2,innerHeight+shellThickness+shellBackingThickness,length]);
    union(){
        translate([shellThickness,shellThickness,-0.05]){
            cube([innerWidth,innerHeight,length+0.5]);
        }
        translate([shellThickness+grippingLedgeSize,-0.05,-0.05]){
            cube([innerWidth-grippingLedgeSize*2,shellThickness+0.1,length+0.5]);
        }
        translate([shellThickness+innerWidth/2,shellThickness+innerHeight-0.05,length/2+0.5]){
            rotate([270,0,0]){
                cylinder(r=screwDiameter/2,h=shellBackingThickness+0.1, $fn=50);
                cylinder(r1=screwHeadDiameter/2,r2=screwDiameter/2,h=screwHeadHeight+0.1, $fn=50);
            }
        }
    }
}


