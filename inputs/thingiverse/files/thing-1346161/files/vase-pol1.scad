num_corners=5;//[3:1:10]
height=100;//[40:10:150]
base_radius=40;//[30:5:80]
angle_twist=-90;//[-180:10:180]
top_scale=.6;//[.1:.2:2]
linear_extrude(height = height, center = false, convexity = 50, twist = angle_twist,scale=top_scale,$fn=num_corners,slices=height)
 circle(base_radius);