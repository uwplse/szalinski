// Charger Hole
hole = 50;
// Hole circularity
holeHeightRatio = 0.6;
// Hole->Base distance
distance = 70;
// Base height
height = 60;
// Base width
width = 90;
// Base hold Angle
angle=3;
// Body Text
text="RafaelEstevam";
// Body thickness
thickness=2;
// Thickness of base reinforcement 
thicknessBase=6;

difference(){        
    hull()
    {
        scale([1,holeHeightRatio,1])
            cylinder(r=hole,h=thickness);
        translate([-width/2,-distance-hole,0]) 
            cube([width,20,thickness]);
    }
    translate([0,0,-0.25]) 
        scale([1,holeHeightRatio,1])
            cylinder(r=hole*0.8,h=thickness+0.5);
    translate([0,-distance/2-hole,-.5])
        linear_extrude(height=3)
            text(text,size=8,halign="center");
}
translate([-width/2,-distance-hole+thicknessBase,0]) 
    rotate([-angle,0,0]) 
        support_largeBase();
        //cube([width,thickness,height]);

module support_largeBase()
{
    rotate([0,90,0])
      linear_extrude(height=width)
        polygon([[0,0],[0,-thicknessBase],
                 [-height,-thickness],[-height,0]]);
}