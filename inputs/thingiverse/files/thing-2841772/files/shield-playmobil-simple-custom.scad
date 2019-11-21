echo(version=version());
 
 name = "Name"; 
 
 color("grey")   
 cylinder(h=2, r=20);
 color("red")
 translate([-8, 8, 2])
    linear_extrude(1)
        text(name, size = 4);
 
translate([-5, 0, 2]) cylinder(h=5, r=1,$fn=20);

translate([5, 0, 2]) cylinder(h=5, r=1,$fn=20);

translate([-6, 0, 7]) 
    rotate([90,90,90])
        cylinder(h=12, r=1.5,$fn=20);