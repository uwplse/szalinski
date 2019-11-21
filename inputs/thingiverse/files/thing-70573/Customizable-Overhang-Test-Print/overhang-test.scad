$width=10;
$depth=5;
$innerRadius=30;
$startAngle=35;

$baseRadius=8;

$block1=$innerRadius+$depth+1;
$block2=$block1*2;

rotate([-90,0,0])
 difference()
 {
  translate([0,$innerRadius*sin($startAngle),0])
  rotate_extrude(convexity=6,$fn=150)
   translate([$innerRadius,0,0])
    square([$depth,$width]);

  // Now remove 3/4 of the 'donut'
  // remove below  
  translate([-$block1,0,-1])
   cube([$block2,$block2,$width+2]);

  // remove side
  translate([0,-$block1,-1])
   cube([$block1,$block2,$width+2]);
 }

// base
translate([-($innerRadius*cos($startAngle)+$depth/2),
             $width/2,0])
  cylinder(h=$baseHeight,r=$baseRadius);


