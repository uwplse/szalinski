num_corners=4;
height=100;
base_radius=40;
angle_twist=-90;
top_scale=.6;
linear_extrude(height = height, center = false, convexity = 50, twist = angle_twist,scale=top_scale,$fn=num_corners,slices=height)
 circle(base_radius);