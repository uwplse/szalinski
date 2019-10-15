traxxasInnerDiameter = 3.35;
traxxasHeight        = 4;
tubeInnerDiameter    = 2.85;
tubeOutterDiameter   = 5.15;
tubeHeight = 4;
outterWall = 1.2;

fn=25;

union(){
  cylinder(r=tubeInnerDiameter/2, h= tubeHeight+outterWall, $fn=fn);
  translate([0,0,tubeHeight+outterWall])cylinder(r=traxxasInnerDiameter/2, h= traxxasHeight, $fn=fn);
  difference(){
    cylinder(r=tubeOutterDiameter/2+outterWall, h= tubeHeight+outterWall, $fn=fn);
    cylinder(r=tubeOutterDiameter/2, h= tubeHeight, $fn=fn);
  }
}