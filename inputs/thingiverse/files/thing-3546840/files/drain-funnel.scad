// Outer diamater of the hole funnel should fit in.
outerDiameter = 200;

// Hole at the bottom of the funnel. Typically smaller then you overflow cup below.
drainHoleDiameter = 80;

// Thickness of the main body
wallThinkness = 4;

// Thickiness of the upper rim
rimThinkness = 4;

// Width of the rim (also how far should the cone start from the edge of the rim)
rimWidth = 4;

// Height of the funnel
height = 100;

module drain_funnel(){
  $fn=100;

  difference() {
    cylinder(h=height, d1=outerDiameter-rimWidth*2, d2=drainHoleDiameter);
    cylinder(h=height, d1=outerDiameter-rimWidth*2-wallThinkness, d2=drainHoleDiameter-wallThinkness);
  }
  difference() {
    cylinder(h=height, d1=outerDiameter, d2=drainHoleDiameter);
    cylinder(h=height, d1=outerDiameter-8, d2=drainHoleDiameter-wallThinkness);
    translate([0,0,height/2+rimThinkness]) cube([outerDiameter*2,outerDiameter*2,height], center=true);
  }
}

drain_funnel();
