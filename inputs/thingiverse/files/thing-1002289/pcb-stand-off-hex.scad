hole_r = 1.5;
hex_r = 4; 
hex_Height = 8;
Rows = 3;
Cols= 3;

module pcbstand() {
difference() {
    cylinder(r=hex_r,h=hex_Height,$fn=6);
    translate([0,0,-1])cylinder(r=hole_r,h=hex_Height+2,$fn=50);

}
}
for (y=[1:Cols])
    for (x=[1:Rows])
        translate([x*((hex_r*2)+2),y*((hex_r*2)+2),0])pcbstand();