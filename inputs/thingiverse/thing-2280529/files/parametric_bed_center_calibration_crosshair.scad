echo(version=version());

// make it smaller than the max sizes of the bed
widthSquare = 200; 
// multiple of your deposition line width
wallThickness = 0.8; // 
// multiple of your z resolution including the first layer thickness
height = 0.25;
// is used for redering glitches
tolerance = 0.5;

union(){
  difference(){
    cube([widthSquare,widthSquare,height], center=true);
    for (x=[0:1:3]){
      rotate([0,0,x*90]){
        translate([widthSquare/4-wallThickness/4,widthSquare/4-wallThickness/4,0]){
          cube([widthSquare/2-1.5*wallThickness,widthSquare/2-1.5*wallThickness,height+tolerance], center=true);
        }
      }
    }
  }
  difference(){
    cylinder(d=widthSquare, h=height, center=true, $fn=50);
    cylinder(d=widthSquare-2*wallThickness, h=height+tolerance, center=true, $fn=50);
  }
}