//Pumkin

//How Many "Humps"
Humps = 12;

//Stalk Height
Height = 20;

//Radius Of Each Sphere
Radius = 12;
color("orange")
for(n = [0:1:Humps]){
    rotate([0, 0, n * 360/Humps]){
        translate([Radius,0,0])
        sphere(Radius);
    }
}
color("Green")
cylinder(Height,Radius/4,Radius/4);