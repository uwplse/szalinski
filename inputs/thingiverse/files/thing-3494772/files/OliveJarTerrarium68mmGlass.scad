
TerrariumBaseHeight = 17;
GlassBaseDiameter   = 67;
GlassTopDiameter    = 76;
GlassTotalHeight    = 96;

union() {
  import("./OliveJarTerrariumBase.stl", convexity=10);
  difference() {
    translate([0,0,2]) {
      cylinder(
        GlassTotalHeight,
        (GlassBaseDiameter/2)+1,
        (GlassTopDiameter/2)+1,
        false,
        $fn=100
      );
    }
    translate([0,0,2]) {
      cylinder(
        GlassTotalHeight+0.1,
        d1=GlassBaseDiameter,
        d2=GlassTopDiameter,
        false,
        $fn=100
       );
     }
    translate([0,0,TerrariumBaseHeight]) {
      cylinder(
        GlassTotalHeight,
        50,
        50,
        false,
        $fn=100
      );
    }
  }
}
