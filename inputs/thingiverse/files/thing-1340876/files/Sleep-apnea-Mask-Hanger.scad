$fn=50;
BackLength=55;//Back Depth
HBWidth=46;//Frame Width
HoseDiameter=25;//Hanger Diameter
FrontLength=35;//Front Height
Width=15;//Hanger Width
HangerThickenss=5;//Thickness


translate([0,0,0])cube([HangerThickenss,Width,BackLength]);
translate([HangerThickenss,0,BackLength-HangerThickenss])cube([HBWidth,Width,HangerThickenss]);
translate([HBWidth+HangerThickenss,0,BackLength-FrontLength+HoseDiameter/2-HangerThickenss])cube([HangerThickenss,Width,FrontLength-HoseDiameter/2+HangerThickenss]);
translate([HBWidth+HangerThickenss,0,BackLength-FrontLength+HoseDiameter/2])rotate([0,5,0])hanger();

module hanger(){
    difference(){
        translate([HoseDiameter/2+HangerThickenss,Width/2,0])rotate([90,0,0])cylinder(d=HoseDiameter+HangerThickenss*2,h=Width,center=true);
        union(){
            translate([HoseDiameter/2+HangerThickenss,Width/2,0])rotate([90,0,0])cylinder(d=HoseDiameter,h=Width+2,center=true);
            translate([0,-1,0])cube([HoseDiameter+HangerThickenss*2,Width+2,HoseDiameter]);
        }
    }
    translate([HoseDiameter+HangerThickenss,0,0])cube([HangerThickenss,Width,FrontLength-HoseDiameter/2]);
}