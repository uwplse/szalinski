/*******************************************************************\
|         __  ____       _ ____        _ __                         |
|        /  |/  (_)___  (_) __ \____ _(_) /      ______ ___  __     |
|       / /|_/ / / __ \/ / /_/ / __ `/ / / | /| / / __ `/ / / /     |
|      / /  / / / / / / / _, _/ /_/ / / /| |/ |/ / /_/ / /_/ /      |
|     /_/  /_/_/_/ /_/_/_/ |_|\__,_/_/_/ |__/|__/\__,_/\__, /       |
|                                                     /____/        |
|*******************************************************************|
|                                                                   |
|                    Simple Wooden Latrine                          |
|                                                                   |
|                      designed by Svenny                           |
|                                                                   |
|       source: https://www.thingiverse.com/thing:3083176           |
|                                                                   |
\*******************************************************************/


/* [VIEW] */
// what to show
view = "arranged"; // [parts, arranged]
// scale
model_scale = 70;
// minimal wall thickness (real is this+plank_thickness)
min_wall_thickness = 0.8;
// roof thickness
roof_thickness = 0.8;

width = 1200 / model_scale;
length = 1200 / model_scale;
front_height = 2100 / model_scale;
back_height = 1900 / model_scale;
seat_height = 700 / model_scale;
seat_length = 0.45*length;

door_height = 1750 / model_scale;
door_hole_height = 1850 / model_scale;
door_width = 850 / model_scale;

plank_width = 190 / model_scale;
plank_thickness = 20 / model_scale;
plank_cleft = 20 / model_scale;

column_thickness = 95 / model_scale;

m_plank_thickness = plank_thickness+min_wall_thickness;

roof_offset = 120 / model_scale;

module plank_wall(length, height, thickness=m_plank_thickness, plank_width=plank_width, plank_cleft=plank_cleft) {
    cleft = plank_cleft;
    width = plank_width;
    intersection() {
        for(x=[-length/2:width+cleft:length/2])
            translate([x, 0, 0])
            cube([width, height, thickness]);
        translate([-length/2,0,0])
        cube([length, height, 2*thickness]);
    }
    translate([0, height/2, thickness/2])
    cube([length, height, min_wall_thickness], center=true);
}

module _building() {
    intersection() {
        difference() {
            hull() {
                translate([0, length/2, front_height/2])
                cube([width, 0.01, front_height], center=true);
                translate([0, -length/2, back_height/2])
                cube([width, 0.01, back_height], center=true);
            }
            translate([0, length/2, door_hole_height/2])
            cube([door_width, 3*m_plank_thickness, door_hole_height], center=true);
        }
        union() {
            for(x=[[-length/2+m_plank_thickness, 0], 
                   [-length/2+m_plank_thickness, 180],
                   [-width/2+m_plank_thickness, 90],
                   [-width/2+m_plank_thickness, 270]])
                rotate(x[1])
                translate([0, x[0], 0])
                rotate([90, 0, 0])
                plank_wall(width, front_height);
            
            corner_pos = [(width-column_thickness)/2, (length-column_thickness)/2];
            for(p=[[-1,-1], [-1,1], [1,-1], [1,1]])
                translate([p[0]*corner_pos[0], p[1]*corner_pos[1], front_height/2])
                cube([column_thickness, column_thickness, front_height], center=true);
        }
    }
}

module _seat() {
    translate([0,seat_length-length/2+m_plank_thickness, 0])
    rotate([-90, 0, 0])
    rotate(-90)
    translate([seat_height/2, (m_plank_thickness-width)/2])
    plank_wall(seat_height, width-m_plank_thickness, plank_width=0.8*plank_width, plank_cleft=0.5*plank_cleft);
    
    difference() {
        translate([0,seat_length-length/2+m_plank_thickness, seat_height-plank_thickness])
        rotate(-90)
        translate([(seat_length-m_plank_thickness)/2, (plank_thickness-width)/2])
        plank_wall(seat_length+m_plank_thickness, width-m_plank_thickness, plank_width=0.8*plank_width, plank_cleft=0.5*plank_cleft);
        
        translate([0, seat_length-(length)/2+m_plank_thickness-0.3*seat_length, seat_height])
        cylinder(d=0.6*seat_length, h=3*m_plank_thickness, center=true, $fn=30);
    }
}

module _whole_building() {
    _building();
    _seat();

    translate([0, -length/2+m_plank_thickness+seat_length, 0])
    rotate(90)
    translate([(length-2*m_plank_thickness-seat_length)/2, -(width-m_plank_thickness)/2, 0])
    plank_wall(length-2*m_plank_thickness-seat_length, width-m_plank_thickness);
}

module __heart_half(r, h) {
    hull() {
        translate([r/2.5,r/2,0])
        cylinder(d=r, h=h, $fn=30);
        translate([0,-r/2,0])
        cylinder(d=0.01, h=h, $fn=4);
    }
}

module _heart(r, h) {
    __heart_half(r, h);
    mirror()
    __heart_half(r, h);
}

module _door(simple=false) {
    difference() {
        plank_wall(door_width, door_height);
        translate([0, 0.75*door_height, -m_plank_thickness])
        _heart(door_width/5.5, 3*m_plank_thickness);
    }
    if(!simple) {
        intersection() {
            translate([-door_width/2, 0, 0])
            cube([door_width, door_height, 3*m_plank_thickness]);
            
            union() {
                for(j=[0.1, 0.9])
                    hull() {
                        for(i=[-1,1])
                            translate([i*door_width/2,
                                       j*door_height,
                                       0.6*m_plank_thickness])
                            cylinder(d=plank_width/3, h=m_plank_thickness, $fn=20);
                    }
                hull() {
                    translate([-door_width/2,
                               0.1*door_height,
                               0.6*m_plank_thickness])
                    cylinder(d=plank_width/3, h=m_plank_thickness, $fn=20);
                    translate([door_width/2,
                               0.9*door_height,
                               0.6*m_plank_thickness])
                    cylinder(d=plank_width/3, h=m_plank_thickness, $fn=20);
                }
            }
        }
    }
}

module _roof() {
    linear_extrude(roof_thickness)
    offset(delta=roof_offset)
    square([width, sqrt(length*length+(front_height-back_height)*(front_height-back_height))], center=true);
}

module arranged() {
    _whole_building();
    translate([door_width/2, length/2, 0])
    rotate(-105)
    translate([-door_width/2, 0, 0])
    rotate([90,0,0])
    _door();
    translate([0, 0, (front_height+back_height)/2])
    rotate([atan((front_height-back_height)/length),0,0])
    _roof();
}

module parts() {
    _whole_building();
    
    translate([width, -door_height/2, 0])
    _door();
    
    translate([-width-2*roof_offset, 0, 0])
    _roof();
}

if(view == "arranged")
    rotate(90)
    arranged();
else
    parts();