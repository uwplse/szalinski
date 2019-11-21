/* [Global] */
// can diameter including top rim
Diameter_Including_Top_Rim = 75; // [10:200]
// rim height
Rim_Height = 3; //[1:5]
//rim thickness
Rim_Thickness_x_10 = 7; //[0:10]
// lid wall thickness
Lid_Wall_Thickness_x_10 = 15; //[1:50]
Smoothness = 60; //[1:100]

/* [Hidden] */
smooth=Smoothness;
wt=Lid_Wall_Thickness_x_10/10.0;
rimd = Rim_Thickness_x_10/10.0;
rimh = Rim_Height;
d = Diameter_Including_Top_Rim;
pad = 0.1;  // Padding to maintain manifold
r = d/2+wt+rimd;
h = rimh + wt*2; // overall lid height

union () {
  difference() {
    cylinder(h,r,r,center=false,$fn=smooth);  
    translate([0,0,wt]) cylinder(h,r-wt,r-wt,center=false,$fn=smooth);  
  }

  rotate_extrude(convexity=10, $fn = smooth)
    translate([r-wt,h-rimd,0])
    circle(rimd,$fn=smooth);

}
