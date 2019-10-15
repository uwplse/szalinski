//
//
//  Parametric mounting bracket
//
//  All dimensions are in mm
//
//

InsideWidth = 50;   // width of object being held
InsideHeight = 35.2;  // height of object being held
Span = 20;          // how wide you want the bracket to be
Thickness = 4;      // how thick the bracket material will be
FlangeSize = 20;    // how far the mounting flanges will stick out
Hole = 1;           // 1 = Holes, 0 = No holes
HoleDiameter = 4;   // size of mounting holes on the flanges

// Ok, begin

difference () {

union () {

cube([InsideWidth+(Thickness*2),Thickness,Span]);
cube([Thickness, InsideHeight+Thickness,Span]);
translate([InsideWidth+Thickness,0,0]) 
  cube([Thickness, InsideHeight+Thickness,Span]);
translate([-FlangeSize, InsideHeight,0])
  cube([FlangeSize+Thickness,Thickness,Span]);
translate([InsideWidth+Thickness, InsideHeight,0])
  cube([FlangeSize+Thickness,Thickness,Span]);
}

 if (Hole) {
 translate([-FlangeSize/2,InsideHeight,Span/2]) 
     rotate ([90,0,0]) 
     cylinder (h = Thickness+7, r=HoleDiameter/2, center = true, $fn=50);
 translate([InsideWidth+(Thickness*2)+FlangeSize/2,InsideHeight,Span/2]) 
     rotate ([90,0,0]) 
     cylinder (h = Thickness+7, r=HoleDiameter/2, center = true, $fn=50);
 }
}