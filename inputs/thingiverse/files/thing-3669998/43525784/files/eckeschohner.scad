strip_width = 25;
min_wall = 2;
edge_radius = 1;

rotate_extrude(angle = 90, $fn=20) shape();
rotate([90, 0, 0]) 
    linear_extrude(strip_width) shape();   
translate ([-strip_width, 0, 0]) 
    rotate([90, 0, 90]) 
        linear_extrude(strip_width) shape();    

module shape() 
    polygon( points=[
    [edge_radius, -strip_width/2 - 2],
    [edge_radius + min_wall + 1, -strip_width/2 - 2], 
    [edge_radius + min_wall + 1, -strip_width/2 - 1],
    [edge_radius + min_wall, -strip_width/2], 
    [edge_radius + min_wall, strip_width/2], 
    [edge_radius + min_wall + 1, strip_width/2 + 1], 
    [edge_radius + min_wall + 1, strip_width/2 + 2], 
    [edge_radius, strip_width/2 + 2],] );