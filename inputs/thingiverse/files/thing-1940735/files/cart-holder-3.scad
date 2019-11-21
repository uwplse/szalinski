//Amount of cart slots
cart_count = 4; //[1:1:8]
//Cart type
cart_type = 5; //[0:Snes PAL, 1:Snes NTSC, 2:N64, 3:Gameboy/GBA, 4:DS/3DS, 5:NES]
//Support leg length (mm);
support_legs_length = 0; //[0:1:100]

module cart_cup(cup_height, cup_width, cup_depth, cart_hole_depth, support_legs_length, cup_angle) {
    
    difference() {
        
        union() {
            translate([0,cup_depth/2,0])
            hull() {
                translate([cup_depth/2,0,0])
                cylinder(h=cup_height, d=cup_depth);
                
                translate([cup_width-cup_depth/2,0,0])
                cylinder(h=cup_height, d=cup_depth);
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
    
module nescart() {
    translate([-108/2,5,0])
    linear_extrude(24)
    polygon([[0,0],[108,0],
            [108,19],[0,19]]);
    
    translate([-122/2,5,24])
    linear_extrude(110)
    polygon([[0,0],[122,0],
            [122,19],[0,19]]);
    
};
    
module snescart_pal() {
    translate([-130/2,5,0])
    linear_extrude(88)
    polygon([[0,0],[130,0],
            [130,10],[127,16],[120,18],[100,20],[70,22],
            [60,22],[30,20],[10,18],[3,16],[0,10]]);
    
};


module snescart_ntsc() {
    translate([-130/2,5,0])
    linear_extrude(88)
    polygon([
        [-4,0],[-4,19],[17,19],[17,22],
        [113,22],[113,19],[134,19],[134,0]    
    ]);
    
};

module gameboycart() {
    translate([-58/2,3,0])
    linear_extrude(65)
    polygon([[0,0],[58,0],
            [58,8],[0,8]]);
    
};

module dscart() {
    translate([-34/2,3,0])
    linear_extrude(35)
    polygon([[0,0],[34,0],
            [34,4.5],[0,4.5]]);
    
};

module n64cart() {
    translate([-118/2,5,0])
    linear_extrude(76)
    polygon([[0,0],[0,9],[1,13],[2,15],[3,16],[6,18],[9,19],
            [118-9,19],[118-6,18],[118-3,16],[118-2,15],[118-1,13],[118,9],[118,0]]);
    
};

module cart_stand(  amount_of_carts, delta_y, delta_h, angle,
                    cup_height, cup_width, cup_depth, cart_hole_depth, support_legs_length) {

    cut_from_bottom = sin(angle)*cup_depth;
                        
    difference() {
        union() {
            
            for(i = [0:amount_of_carts-1]) {
                translate([0, -i*delta_y, -cut_from_bottom])
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
        //ground
        translate([0, -delta_y*amount_of_carts - support_legs_length, -cut_from_bottom - support_legs_length])
        cube([cup_width, delta_y*(amount_of_carts+1) + support_legs_length, cut_from_bottom + support_legs_length]);
    }
}

//cart_stand(  amount_of_carts, delta_y, delta_h, angle,
//             cup_height, cup_width, cup_depth, cart_hole_depth, support_legs_length)

//cart_type: [0:Snes PAL, 1:Snes NTSC, 2:N64, 3:Gameboy/GBA, 4:DS/3DS]

if (cart_type == 0) {
    cart_stand(cart_count, 30, 15, 30, 30, 150, 30, 15, support_legs_length) snescart_pal();
}
if (cart_type == 1) {
    cart_stand(cart_count, 30, 15, 30, 30, 150, 30, 15, support_legs_length) snescart_ntsc();
}
if (cart_type == 2) {
    cart_stand(cart_count, 26, 15, 30, 30, 130, 26, 15, support_legs_length) n64cart();
}
if (cart_type == 3) {
    cart_stand(cart_count, 14, 8, 30, 15, 68, 14, 6, support_legs_length) gameboycart();
}
if (cart_type == 4) {
    cart_stand(cart_count, 9, 5, 30, 12, 40, 10, 6, support_legs_length) dscart();
}
if (cart_type == 5) {
    cart_stand(cart_count, 30, 15, 30, 45, 130, 30, 23, support_legs_length) nescart();
}
