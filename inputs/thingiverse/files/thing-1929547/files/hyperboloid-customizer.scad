post_radius = 0.5;//[0:0.1:50]
post_height = 50;//[0:0.1:100]
//How many sides make up the post.
post_fragment_number = 10; //[0:1:20]
//Vertical position of the post in mm from the center point. | 'post_position_Xaxis' and 'post_position_Yaxis' change the radius of the inside hole.
post_position_Xaxis = 5;//[-50:0.1:50
post_position_Yaxis = 15.5;//[-50:0.1:50
//Adjusting this into the positive or negative values will raise or lower the post in the z-axis from the horizon.
post_position_Zaxis = 0;//[-50:0.1:50
//Rotation about the X axis, from the +Y axis, toward the +Z axis.
post_tilt_Xaxis = 40;//[0:0.1:90]
//Rotation about the Y axis, from the +Z axis, toward the +X axis.
post_tilt_Yaxis = 0;//[0:0.1:90]
//Rotation about the Z axis, from the +X axis, toward the +Y axis.
post_tilt_Zaxis = 0;//[0:0.1:90]
//How many posts are used when revolving with 'post_revolve'.
post_count = 250;//
//The degree of revolve
post_revolve = 360; //[0:0.1:360]
//If you want to get a little crazy 'post_twist', 'post_scale', and 'post_slices' control the twist, scale, and slices of the post. you can obtain different effects and patterns when you experiment with these options.
post_twist = 0; //
post_scale = 1;//
post_slices = 0;//

for(a = [0:1/post_count:1])
    rotate(a * post_revolve){
        translate([ post_position_Xaxis, post_position_Yaxis, post_position_Zaxis]){ 
            rotate([post_tilt_Xaxis, post_tilt_Yaxis, post_tilt_Zaxis]){
                linear_extrude(height = post_height, twist = post_twist, scale = post_scale, slices = post_slices){
                    circle(r = post_radius, $fn = post_fragment_number);
                }
            }
        }
    }


// by Nick at midheaventech@gmail.com