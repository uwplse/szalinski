InnerHoleDiameter = 8; // [5:40]
SmallestReelDiameter = 30; // [10:120
LargestReelDiameter = 80; // [10:120]
Height = 15; // [10:30]
ArmWidth = 10; // [5:20]
NumberOfArms = 6; // [2, 4, 6, 8, 10]
render(convexity=1){
    difference(){
      union(){
        intersection(){
          cylinder(d1=LargestReelDiameter, d2=SmallestReelDiameter, h=Height);
          for (i=[0:(360/NumberOfArms):360]){
            rotate([0, 0, i]) cube([LargestReelDiameter, ArmWidth, Height*3], center=true);
          }
        }
      }
      cylinder(d=InnerHoleDiameter, h=Height, $fn=36);
    }
}