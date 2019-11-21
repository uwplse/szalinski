Height = 100;
Twist = 360;
Scale = 1.5;
Slices = 10;
Radius = 30;
//Set to 0 if not hole desired
HoleRadius = 3;

difference(){
    translate([0, 0, Height/2]){
        linear_extrude(height = Height, twist = Twist, scale = Scale, center = true, slices = Slices)
            circle(Radius);
    }
    scale([0.85,0.85,0.85]){
        translate([0, 0, Height*.75]){
            linear_extrude(height = Height, twist = Twist, scale = Scale,        center = true, slices = Slices)
                circle(Radius);
        }
    }
    cylinder(100, HoleRadius, HoleRadius, center=true);
}