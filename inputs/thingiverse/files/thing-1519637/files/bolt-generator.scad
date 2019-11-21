Bolt_quality = 200;
//Amount of Sides
Top_Sides = 5;
/////////////////////
Bolt_Height = 5;
//twists per milimeter
Twist_Setting = 1;
//Diameter of whole bolt.
Bolt_Diameter = 3;
//
twist_per_rot = Twist_Setting*365*Bolt_Height;
linear_extrude(height = Bolt_Height, center = false, convexity = 10, twist = twist_per_rot)
translate([Bolt_Diameter*.85, 0, 0])
circle(r = 1);
cylinder(r=(Bolt_Diameter*1.75)/2,h = Bolt_Height);
$fn = Bolt_quality;
cylinder(r = Bolt_Diameter*1.5,h = 1, $fn = Top_Sides, center = false);