$fn=50;

// The radius of the inner ball. 
ball_size = 8.5;
// the size of the cube
cube_size = 16;
// radius of the empty space inside the cube. Ideally about 60-70% of the size of the cube 
inner_void_size = 10.5;

module hollowed_square(){
    translate([0,0,cube_size/2]){
        difference(){
            cube(size=cube_size, center=true);
            sphere(inner_void_size);
        }
    }
}

module inner_ball(){
    translate([0,0,ball_size]){
        sphere(ball_size);
    }
}

hollowed_square();
inner_ball();