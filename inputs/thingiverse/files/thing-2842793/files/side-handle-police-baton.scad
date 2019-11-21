echo(version=version());
 
length = 30; 

color("grey")
rotate([90,90,0])
   cylinder(h=length, r=1.5,$fn=20);

translate([0, -6, 0]) 
rotate([90,90,90])
cylinder(h=10, r=1.5 ,$fn=20);

translate([10, -6, 0]) 
rotate([90,90,90])
cylinder(h=2, r=2,$fn=20);