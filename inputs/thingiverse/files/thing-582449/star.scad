// Height of the container (mm).
container_height=110;
// Radius of the star's inner vertices.
inner_radius=30;
// Radius of the star's outer most edges.
outer_radius=45;
// Number of points the container will twist from top to bottom.
twists=1;  // [0:5]

difference() {
    
    union() {
        // extrude the star with a twist. 
        linear_extrude(height = container_height, twist = 72*twists, slices = container_height/2) { star(); }
        
        // add the base of the container.
        translate([0,0,-5]) linear_extrude(height = 5, twist = 0) { star(); }
        }
        
    // subtract out the inside of the container.        
    union() {
        linear_extrude(height = container_height, twist = 72*twists, slices = container_height/2) { scale([.9,.9,0])star(); }
        }
}

module star() {
        polygon(points=[
        [ 0     * outer_radius, 1.0   * outer_radius],
        [ 0.588 * inner_radius, 0.81  * inner_radius],
        [ 0.951 * outer_radius, 0.31  * outer_radius],
        [ 0.951 * inner_radius,-0.31  * inner_radius],
        [ 0.588 * outer_radius,-0.81  * outer_radius],
        [ 0     * inner_radius,-1.0   * inner_radius],
        [-0.588 * outer_radius,-0.81  * outer_radius],
        [-0.951 * inner_radius,-0.31  * inner_radius],
        [-0.951 * outer_radius, 0.31  * outer_radius],
        [-0.588 * inner_radius, 0.81  * inner_radius],
        ]);
}    
