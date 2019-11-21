// preview[view:north west, tilt:top diagonal]

/* [General] */
// How thick should be the hook itself ?
thickness = 5; // [1:100]
// What should be the width of the hook ?
width = 10; // [1:100]

/* [Shelf] */
// How thick is the shelf ?
shelf_height = 20; // [1:100]
// How long should be the shelf leg ?
shelf_deepness = 30; // [1:100]

/* [Hook] */
// How height of the hook leg ?
hook_height = 20; // [1:100]
// How long should be the hook leg ?
hook_deepness = 30; // [1:100]


union(){
//  ___
  cube([shelf_deepness+thickness,thickness,width]);
//  ___
//  |
  translate([shelf_deepness,0,0])
    cube([thickness,shelf_height +  2*thickness,width]);
  
//  ___
//  |
//  ---
  translate([shelf_deepness,shelf_height + thickness,width])
    rotate([0,180,0])
      cube([shelf_deepness, thickness,width]);
//  ___
//  |
//  ---
//    |
  translate([0,shelf_height+thickness,0])
      cube([thickness,hook_height+2*thickness,width]);
//  ___
//  |
//  ---
//     |
//  ---
  translate([thickness,shelf_height+hook_height+2*thickness,0])
    cube([hook_deepness,thickness,width]);

//  ___
//  |
//  ---
//     |
//  |---

  translate([hook_deepness,shelf_height+hook_height+thickness,0])
    cube([thickness,thickness,width]);
}
