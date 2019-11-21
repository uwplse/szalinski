radius = 25;//[5:100]
wall = 2;//[1:10]
height = 130;//[50:150]
twist = 60;//[0:180]


difference(){
linear_extrude(height = height, center = false, convexity = 0, twist = twist, slices=height/20)
circle(r = radius, $fn=6);
translate([0,0,wall])
linear_extrude(height=height-wall+1, center=false, convexity=0, twist=twist, slices=height/20)
circle(r = radius-wall, $fn=6);
}