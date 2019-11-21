//parameters
radius=30;
side=6;
height=10;

//commands

translate([0, 0, height])
 cylinder(h=20, r1=radius, r2=0, $fn=side, center=false);
 
rotate(a=[0, 180, 0])
 cylinder(h=20, r1=radius, r2=0, $fn=side, center=false);

difference(){
 cylinder(h=height, r1=radius, r2=radius, $fn=side, center=false);
translate([0,0, height/2])
rotate(a=[90,0, 0]) 
    cylinder(h=60, r1=2.5, r2=2.5, $fn=100, center=true);
}