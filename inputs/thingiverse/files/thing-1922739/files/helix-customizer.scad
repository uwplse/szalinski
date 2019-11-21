// number of fragments | a higher fragment count will result in slower render times '20' is sufficient.
fn = 20; // [0:100]
//  "sugar phosphate backbones" | part of helix_base module | if adjusted also consider adjusting 'post_distance_apart' or 'center_bridge_length'.
post_radius = 2; // [0:500]
// part of helix_base module | if adjusted also consider adjusting 'center_bridge_length'.
post_distance_apart = 10; // [0:500]
// "base pairs" length between "sugar phosphate backbones" | part of helix_base module | if adjusted also consider adjusting 'post_distance_apart'.
center_bridge_length = 20; // [0:500]
// part of helix_base module | thickness of "basepairs" in relevence to the the Y-axis of 'helix_base' before "linear_extrude" is implemented. further explanation is below.
center_bridge_width = .6; // [0:0.1:500]
// 'helix_height' adjusts the height of the linear_extruded 'helix_base' module | 'helix_height, helix_twists, helix_twists' all work hand in hand and should be experimented to fully understand the linear_extrude's nature.
helix_height = 72; // [0:500]
// 'helix_twists' adjusts the degree of twist in the linear_extruded 'helix_base' module.
helix_twists = 360; // [0:3600]
// 'helix_slices' adjusts the number of slices used in the linear_extruded 'helix_base' module | more slices = higher resolution and longer render times, less slices = the contrary | 200 is sufficient.
helix_slices = 500; // [0:500]
// this is fun try changing from 0-3 to scale 'helix_base' as it reaches its specified height in 'helix_height' | '1' = 1to1 scale, 0 = 1to0, 2 = 1to2 scale and so on in sequential order.
helix_scale = 1; // [0:10]
// the radius of the differenced circle that creates the spaces between each "base pair" | if adjusted you may also want to adjust 'center_bridge_length' and 'post_distance_apart'.
spacer_radius = 8.15; // [0:500]
// the height of the differenced circle changing this will result in a visual thickness change, in the Z-axis, of each "basepair".
spacer_height = 4; // [0:550]
// the point in the Z-axis at which the spacers will start appearing | 'spacer_start, spacer_increment_distance, and spacer_increment_height all work together to create the "base pairs/ bridges" that appear between each "sugar phosphate backbone/post".
spacer_start = 0; // [0:550]
// the distance between each spacer changing this will result in a visual thickness change, in the Z-axis, of each "basepair".
spacer_increment_distance = 6; // [0:500]
// the height to which the spacers ascend to and then stop being produced.
spacer_increment_height = 100; // [0:500]
// the radius of the circle where the standing platform is located at the base of the helix.
base_platform_radius = 18; // [0:500]
// the height of the above said platform.
base_platform_height = 3; // [0:100]
// the controls the number of sides the platform has, 0 defaults to 'fn'.  3, 4, 5, 6 ...
base_platform_shape = 6; // [0:50]
module helix_basic(){
    translate([-post_distance_apart,0,0]){
        circle(post_radius,$fn = fn);
    }
    translate([post_distance_apart,0,0]){
        circle(post_radius, $fn = fn);
    }

    square([center_bridge_length,center_bridge_width],center = true);
}
// the basic 2D shape that the helix is extruded upon.
union(){
    difference(){
        linear_extrude(height = helix_height, twist = helix_twists, slices =    helix_slices, scale = helix_scale){
            helix_basic();
        }
        for (a = [ spacer_start : spacer_increment_distance : spacer_increment_height])
            translate([0, 0, a]) {
                linear_extrude(height = spacer_height, center = true){
                    circle(spacer_radius, $fn = fn);
                }
            }
    }
 cylinder(r = base_platform_radius, height = base_platform_height, center = true, $fn = base_platform_shape);   
}
// this combines/unions the extruded 2D shape 'helix_basic', and the subtracted/differenced spacers, with the standing platform. If you want to see subtracted spacers as part of the model while keeping the integrity of the model you can press F12 which activates the "throwntogether  view option under the view menu in MacOSX.
//changing '$fn = 100', and 'helix_slices' to lower values will result in faster render times at a lower resolution as mentioned above | the render time currently is around 1 min, but will vary based on the hardware inside the machine of use.
// by Nick at midheaventech@gmail.com
