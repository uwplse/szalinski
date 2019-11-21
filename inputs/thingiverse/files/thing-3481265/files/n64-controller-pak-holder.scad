//Number of cart slots per row
cart_count = 4; //[1:1:8]
//Number of rows
cart_rows = 2; //[1:1:5]

module cart_cup(cup_height, cup_width, cup_depth, cart_hole_depth, support_legs_length, cup_angle) {
    
    difference() {
        
        union() {
            hull() {
                cube([cup_width, cup_depth, cup_height], false);
            }
            
            for(j = [cup_width/4, cup_width*3/4]) {
            
                translate([j - 10/2, -(support_legs_length*cos(cup_angle)), 
                                                cup_depth*sin(cup_angle)])
                cube([10,   support_legs_length*cos(cup_angle),
                            support_legs_length*sin(cup_angle)]);
            }

        }
        translate([cup_width/2,0,cup_height-cart_hole_depth])
        children();
    }
}

module n64pak() {
    translate([-51/2,25,-0])
    linear_extrude(38)
    polygon([[0,0],[0,10],[1,13],[2,14],[4,15.5],
            [51-4,15.5],[51-2,14],[51-1,13],[51,10],[51,0]]);
    
};

module cart_stand(  amount_of_carts, delta_y, delta_h, angle,
                    cup_height, cup_width, cup_depth, cart_hole_depth) {

    cut_from_bottom = sin(angle)*cup_depth;
                        
    difference() {
        union() {
            for(j = [0:cart_rows-1]){
                for(i = [0:amount_of_carts-1]) {
                    translate([j*cup_width, -i*delta_y, -cut_from_bottom])
                    rotate([angle, 0, 0]) 
                        if (i==(amount_of_carts-1))
                            cart_cup(   cup_height + i*delta_h, cup_width, cup_depth,  
                                        cart_hole_depth, support_legs_length,                                                 angle) 
                            #children();
                        else
                            cart_cup(   cup_height + i*delta_h, cup_width, cup_depth,  
                                       cart_hole_depth, 0, 0)
                            #children();
                        
                        
                    
                }
            }
        }
        //ground
        translate([-1, -delta_y*amount_of_carts - support_legs_length, -cut_from_bottom - support_legs_length])
        cube([cup_width*cart_rows+2, delta_y*(amount_of_carts+1) + support_legs_length, cut_from_bottom + support_legs_length]);
    }
}

//cart_stand(  amount_of_carts, delta_y, delta_h, angle,
//             cup_height, cup_width, cup_depth, cart_hole_depth, support_legs_length)

cart_stand(cart_count, 50, 0, 0, 20, 78, 50, 15, 0) n64pak();
