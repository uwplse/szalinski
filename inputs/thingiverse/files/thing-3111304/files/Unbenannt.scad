//preview[view:south, tilt:top]

// Draw a path here.
normalized_path = [[[0, 1], [-1, -0.866], [1, -0.866]],[[0, 1, 2]]]; //[draw_polygon:2x2]


scale_factor_x = 5; //[1:25]
scale_factor_y = 5; //[1:25]
twist_angle = 5;//[0:130]
//please set the height, so that the vase looks good. Then size it up in your slicer
height = 40;//[1:500]
linear_extrude(height = height,twist=twist_angle, scale=[scale_factor_x, scale_factor_y]) polygon(normalized_path[0],center = true);