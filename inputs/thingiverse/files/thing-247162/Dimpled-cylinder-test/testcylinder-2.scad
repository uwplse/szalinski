extrusion_layer_height = .25;
cylinder_radius = 20;
cylinder_thickness = 3;

// No dimples in this number of layers on top and bottom.
top_and_bottom_layers = 3;

// How many rows of dimples you want.
n_tiers = 8;

// Make this an even number.
layers_per_tier = 16;

// How deep the dimples should be.
dimple_depth = 1;

// Every other tier is offset from the one below.
dimples_per_tier = 4;

/* [Hidden] */
tier_height = layers_per_tier * extrusion_layer_height;
padding = top_and_bottom_layers * extrusion_layer_height;
cylinder_height = n_tiers * tier_height + 2 * padding;


dimple_radius = (dimple_depth * dimple_depth + tier_height * tier_height / 4) / (2 * dimple_depth);

difference() {
  cylinder(h = cylinder_height, r = cylinder_radius, $fn = 100);
  translate([0, 0, -.5]) cylinder(h = cylinder_height + 1, r = cylinder_radius - cylinder_thickness);
  for (z = [0:(n_tiers + 1)/2 - 1], i = [0:(dimples_per_tier - 1)]) {
   rotate(i * 360/dimples_per_tier, [0, 0, 1])
   translate([0, cylinder_radius + dimple_radius - dimple_depth, padding + tier_height/2 + 2 * z * tier_height])
   sphere(r = dimple_radius, $fn = 20);
 }
 for (z = [0:n_tiers/2 - 1], i = [0:(dimples_per_tier - 1)]) {
   rotate(i * 360/dimples_per_tier + 180/dimples_per_tier, [0, 0, 1])
   translate([0, cylinder_radius + dimple_radius - dimple_depth, padding + 1.5*tier_height + 2 * z * tier_height])
   sphere(r = dimple_radius, $fn = 20);
 }
}