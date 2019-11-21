// Thickness to print rod + clip etc
thickness = 7;
// Pole(+pad) length
distance  = 100;
// The width of your phone/device in mm
phone_width = 8.7;

stick_angle = 0;      // [-90:90]
phone_clip_angle = 2; // [0:5]

// Whether to print the circle segment pad on the end
with_pad = "yes";     // [yes,no]
// The angle of the circle segment to print
ring_angle = 60;      // [1:360]
// The Diameter of the pad ring
pad_diameter = 120;   

clip_height = thickness*3;

translate([-distance/2,0,0])
rotate([0,0,-90])
union(){
    cube([thickness,thickness*2+phone_width,thickness],true);
    rotate([-phone_clip_angle/2,0,0])
    translate([0,-((thickness+phone_width)/2),(clip_height-thickness)/2])
        cube([thickness,thickness,clip_height],true);
    rotate([phone_clip_angle/2,0,0])
    translate([0,((thickness+phone_width)/2),(clip_height-thickness)/2])
        cube([thickness,thickness,clip_height],true);
    rotate([stick_angle,0,0])
    translate([0,-0.1+thickness+(phone_width/2)])
    rotate([-90,0,0])
        if(with_pad=="yes"){
            cylinder(distance-thickness/2, thickness/2-0.1, thickness/2-0.1, $fn=20);
        } else {
            cylinder(distance, thickness/2-0.1, thickness/2-0.1, $fn=20);
        }
    if(with_pad == "yes"){
        rotate([stick_angle,0,0])
        translate([0,(pad_diameter/2)+(phone_width/2)+thickness+distance,0])
        rotate([0,0,-(90+(ring_angle/2))])
        partial_ring(ring_angle, pad_diameter/2)
        translate([thickness/2,0,0])
            basic_shape(thickness);
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