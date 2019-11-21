
TerrariumBaseHeight = 17;
GlassHolderDiameter = 80;

union() {
  import("./OliveJarTerrariumBase.stl", convexity=10);
  difference() {
    translate([0,0,2]) {
      cylinder(
        TerrariumBaseHeight-2,
        (GlassHolderDiameter/2)+1,
        (GlassHolderDiameter/2)+1,
        false,
        $fn=100
      );
    }
    translate([0,0,2]) {
      cylinder(
        TerrariumBaseHeight-1,
        GlassHolderDiameter/2,
        GlassHolderDiameter/2,
        false,
        $fn=100
      );
    }
  }
}