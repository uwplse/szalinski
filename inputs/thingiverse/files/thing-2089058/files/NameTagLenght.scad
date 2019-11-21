//Name Tag - Customizable
Name = "Name";
Lenght = 50;

linear_extrude(height = 5)
translate([0, -5, 0])
text(Name);

difference(){
    hull(){
        cylinder(h=2,d=16);
        translate([Lenght,0,0])
        cylinder(h=2,d=16);
    }
    translate([Lenght,0,0])
    cylinder(h=2,d=14);

}