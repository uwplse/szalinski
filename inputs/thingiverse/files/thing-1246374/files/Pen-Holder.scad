thickness = 1.5;
height    = 5;
diameter  = 11;
rows = 6;

// Print ending rings?
with_end_rings = "yes"; // [yes,no]

// The angle to cut out for the opening (110 seems to work well)
opening_angle = 110; // [0:359]


radius = diameter / 2;
cap_angle = opening_angle+10;

height_scale = height/thickness;

scale([1,1,height_scale]){
    union(){
        if(with_end_rings=="yes"){
            for(i = [-1:2:1]){
                translate([-(radius + thickness/2),(i*((((rows/2)+0.5)*(diameter+thickness))))-i*thickness/2,thickness/2])
                ring(diameter*0.6){
                     basic_shape(thickness);
                }
            }
        }

        translate([0,-(((diameter+thickness)*(rows/2))- (radius + thickness/2)), 0])
        for(side = [-1:1:0]){
            translate([side*(diameter+thickness+0.1),0,0]){
                mirror([side,0,0]){
                    for(i = [0:rows-1]){
                        translate([0,i*(diameter+thickness+0.1),0]){
                            difference(){
                                rotate([0,0,opening_angle/2]){
                                    translate([0,0,thickness/2])
                                        partial_ring(360-opening_angle, radius)
                                            translate([thickness/2,0,0]) basic_shape(thickness);
                                }
                                if(opening_angle > 0){
                                    for(k=[-1:2:1]){
                                        translate([(radius + thickness/2)*sin(90-(opening_angle/2)), k*(radius + thickness/2)*cos(90-(opening_angle/2)), thickness/2]) 
                                        rotate([0,0,-k*(90-(cap_angle/2))])
                                        translate([-(thickness/2),0,0])
                                        scale(1.3) 
                                        difference(){
                                            cube(thickness,true);
                                            translate([-thickness/2,0,0]) rotate([0, 90, 180]) hull(){
                                                translate([0,0,-thickness/2.7]) sphere((thickness-0.04)/2, $fn=20);
                                                linear_extrude(thickness/100) basic_shape(thickness-0.01);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

module basic_shape(thickness) {
    minkowski(){
        square([thickness-thickness/2,thickness-thickness/2], true);
        circle(thickness/4, $fn=10);
    }
}

module partial_ring(angle, radius){
    intersection(){
        ring(radius)
            children(0);  
        translate([0,0,-50])
            linear_extrude(100)
                slice_of_pie(angle, radius*2);
    }
}

module ring(radius){
    rotate_extrude(){
        translate([radius, 0, 0]) children(0);
    }
}

module slice_of_pie(angle=90, r=1){
    if(angle<=90){
        intersection(){
            circle(r);
            polygon([[0,0 ], [cos(angle) * r * 2, sin(angle) * r*2],[r*2,0]]);
        }
    } else if(angle <= 180)  {
        intersection(){
            circle(r);
            polygon([[0,0], [r*2,0], [0,r*2], [cos(angle) * r * 2, sin(angle) * r*2]]);
        }
    } else {
        mirror([0,1,0])
        difference(){
            circle(r);
            slice_of_pie(360-angle, r);
        }
    }
}