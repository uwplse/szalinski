
Resolution = 100;
RollingPin_Diameter = 47.5;
Ring_Width = 6;
Ring_Thickness = 6;

$fn = Resolution;
difference(){
    cylinder(h = Ring_Width, r = RollingPin_Diameter, center = true);
    cylinder(h = Ring_Width+1, r = (RollingPin_Diameter - Ring_Thickness), center = true);
}