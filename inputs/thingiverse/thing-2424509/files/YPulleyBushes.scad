// YPulleyBushes
difference(){
translate([0,0,0])
    rotate(a=[0,0,90])cylinder(r=3.5,h=1.3,$fn=1000); /*outer diameter - change r for radius of outside diameter - change h for z axis height of washers.*/
translate([0,0,-1])
    rotate(a=[0,0,90])cylinder(r=2.6,h=8,$fn=1000); /*hole for the bolt - change r for radius of inside diameter*/
}
difference(){
    translate([0,0,1.3])
    rotate(a=[0,0,90])cylinder(r=2.8,h=2,$fn=1000);
translate([0,0,-1])
    rotate(a=[0,0,90])cylinder(r=2.6,h=8,$fn=1000); /*hole for the bolt - change r for radius of inside diameter*/
}