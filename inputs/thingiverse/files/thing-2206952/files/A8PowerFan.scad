fan_size = 50;
vent_thickness = 10;
wall = 1.5;
screws_metric = 5;
hanger = true;
//decoration = true;

fanSupport(fan_size=fan_size,vent_thick=vent_thickness, wall=wall, screws_d=screws_metric, hanger=hanger);

//MODULES
module fanSupport(fan_size=50,vent_thick = 10, wall=1.5,height=82,screws_d=5,hanger=false, decoration=false){
    width=112;
    thick=51;
    fan_hole_margin = wall;
    min_fan_hole = width/2;
    max_fan_hole = width;
    fan_size_margin = 5;
    front_support_width = 30;
    //max_fan_hole = height < width ? height-fan_hole_margin : width-fan_hole_margin;
    fan_hole_inc = 10;
    fan_attach_size = fan_size+fan_size_margin;
    ideal_fan_hole = fan_attach_size+fan_hole_inc*2;
    //ideal_max_fan_hole = ideal_fan_hole > max_fan_hole ? max_fan_hole : ideal_fan_hole;
    real_height = height < ideal_fan_hole+wall*3 ? ideal_fan_hole+wall*3 : height;
    
    check_min_fan_hole = ideal_fan_hole > min_fan_hole ? ideal_fan_hole : min_fan_hole;
    fan_hole = check_min_fan_hole > max_fan_hole ? max_fan_hole : check_min_fan_hole;

    support_hole = fan_hole > width-front_support_width ? fan_hole-front_support_width : fan_hole;
    
    difference(){
        cover_base(wall=wall, width=width, thick=thick,height=real_height,hanger=hanger);
        translate([0,-fan_hole/2,fan_hole/2+wall*2])
        cube([support_hole, fan_hole, fan_hole], center=true);
    }
    
    translate([0,-(thick+wall)/2,0]){
        //Different front by fan size
        echo(fan_hole);
        if(fan_size > width){
            fan_bigger(fan_size=fan_attach_size,vent_thick=vent_thick, fan_hole=fan_hole,width=width, thick=thick,height=real_height, wall=wall,screws_d=screws_d,decoration=decoration);
        }else{
            fan_smaller(fan_size=fan_attach_size,vent_thick=vent_thick, fan_hole=fan_hole, width=width, thick=thick,height=real_height, wall=wall,screws_d=screws_d,decoration=decoration);
        }
    }
}

module cover_front(wall=1.5, width=112, thick=51,height=82,decoration=false){
    extension_h = 20;
    lat_top_h = height-thick;
    front_height=lat_top_h+thick;
    //Front
    translate([0,0,(front_height-wall)/2])
    cube([width+wall*2, wall, front_height], center=true);
    translate([0,0,front_height+extension_h/2-wall/2])
    difference(){
        cube([width+wall*2,wall,extension_h], center=true);
        
        translate([width/2+wall*3,0,0])
        rotate([0,32,0])
        cube([width*4,wall*2,extension_h], center=true);
        translate([-width/2-wall*3,0,0])
        rotate([0,-32,0])
        cube([width*4,wall*2,extension_h], center=true);
    }
}

module cover_base(wall=1.5, width=112, thick=51,height=82,hanger=false,decoration=false){
    //lat_top_h = 30+wall/3;
    lat_top_h = height-thick;
    big_vent_size = 3.5;
    vent_space_x = 1;
    vent_rotated_width = sqrt(pow(big_vent_size,2)*2);
    back_support_height = 14;
    back_support_width = 65;
    back_support_thick = 1;
    back_support_deviation =4.5;
    back_support_foot_thick = 4;
    front_support_wall=4.5;
    front_support_height=10;
    front_support_width_diff=5;
    hanger_r1 = 2;
    hanger_r2 = 3.5;
    
    //TOP
    cube([width,thick,wall],center=true);
    //Latterals
    difference(){
        union(){
            //Right lat
            translate([-(width+wall)/2,0,lat_top_h/2-wall/2]){
                //Lat top
                cube([wall, thick, lat_top_h], center=true);
                translate([0,0,lat_top_h/2+thick/2])
                difference(){
                    cube([wall,thick,thick],center=true);
                    rotate([-45,0,0])
                    translate([0,0,thick])
                    cube([wall*2,thick*2,thick*2],center=true);
                }
            }
            //Left lat
            translate([(width+wall)/2,0,lat_top_h/2-wall/2]){
                //Lat top
                cube([wall, thick, lat_top_h], center=true);
                translate([0,0,lat_top_h/2+thick/2])
                difference(){
                    cube([wall,thick,thick],center=true);
                    rotate([-45,0,0])
                    translate([0,0,thick])
                    cube([wall*2,thick*2,thick*2],center=true);
                }
            }
        }
        for(i = [-thick/5:vent_space_x+vent_rotated_width:thick/3]){
            translate([0,i,big_vent_size])
                rotate([45,0,0])
                cube([width*2,big_vent_size,big_vent_size], center=true);
            translate([0,i,big_vent_size+vent_rotated_width+vent_space_x])
                rotate([45,0,0])
                cube([width*2,big_vent_size,big_vent_size], center=true);
            translate([0,i-vent_rotated_width/2-vent_space_x/2,big_vent_size+vent_rotated_width/2+vent_space_x/2])
                rotate([45,0,0])
                cube([width*2,big_vent_size,big_vent_size], center=true);
        }
    }
    //Back support
    translate([back_support_deviation,thick/2+back_support_thick/2,0]){
        translate([0,0,back_support_height/2-wall/2])
            cube([back_support_width,back_support_thick,back_support_height], center=true);
        
        translate([0,-back_support_foot_thick/2-back_support_thick/2,back_support_height/4-wall/2])
           cube([back_support_width,back_support_foot_thick,back_support_height/2], center=true);
    }
    //Front Supports
    translate([front_support_width_diff/2,wall-(thick+wall)/2,front_support_height/2+wall/2])
    cube([width-front_support_width_diff,front_support_wall,front_support_height], center=true);
    // Hanger
    if(hanger){
        translate([-width/2-wall,-thick/2+wall,height-hanger_r2*2-hanger_r2])
        hanger(hanger_r1, hanger_r2);
    }
}

module fan_space(base=70, top=50, space=15,base_wall=1.5,screws_d=4, air_hole_margin=10,vertical_fan_hole=-1) {
    vertical_size = vertical_fan_hole >= 0 ? vertical_fan_hole : base;
    diff_base = base-base_wall*2;
    diff_base_v = vertical_size-base_wall;
    diff_top = top-base_wall*2;
    //diff_trans = base > top ? base_wall : -base_wall;
    difference() {
        hull() {
            // Base
            translate([0, -base_wall, (vertical_size)/2])
            cube([base,base_wall,vertical_size+base_wall*2], center = true);
            
            //Attachment
            translate([0, -space, (top+base_wall+vertical_size-top)/2])
            cube([top, base_wall, top], center = true);
        }

        //translate([0, diff_trans, 0])
        hull() {
            // Base
            translate([0, -base_wall, (vertical_size)/2])
            cube([diff_base,base_wall,diff_base_v], center = true);
            //Attachment
            translate([0, -space+base_wall, (base_wall+vertical_size)/2])
            cube([diff_top, base_wall*2, diff_top], center = true);
        }
        translate([0, 1, (vertical_size)/2+base_wall/2])
        cube([base-base_wall*2,base_wall*4+base_wall,vertical_size], center = true);
    }
    translate([0, -space, (base_wall+vertical_size)/2])
            cube([top, base_wall, top], center = true);
}

module fan_bigger(fan_size=120, vent_thick=10,fan_hole=70, wall=1.5, thick=51 ,screws_d=5,decoration=false){
    screw_margin = 5;
    hole_margin = 7;
    thick_margin = 2;
    vertical_fan_hole = fan_hole+(fan_size-fan_hole)*2;
    //Front
    difference() {
        cover_front(wall=wall, width=width, thick=thick,height=height,decoration=decoration);
        translate([0, 0,  vertical_fan_hole/2+wall])
        cube([fan_hole-wall*2,fan_hole,vertical_fan_hole],center = true);
    }
    // Hole
    translate([0, 0, wall/2])
    difference() {
        fan_space(base=fan_hole+wall*2, top=fan_size, screws_d=screws_d, base_wall=wall, space=vent_thick+thick_margin,vertical_fan_hole=vertical_fan_hole);
        
        translate([0, -vent_thick-thick_margin, (wall+vertical_fan_hole)/2])
        rotate([90, 0, 0]){
            translate([fan_size/2-screw_margin-screws_d/2, fan_size/2-screw_margin-screws_d/2, 0])
            cylinder(d=screws_d, h=wall+2, $fn=20, center=true);
            translate([-(fan_size/2-screw_margin-screws_d/2), fan_size/2-screw_margin-screws_d/2, 0])
            cylinder(d=screws_d, h=wall+2, $fn=20, center=true);
            translate([-(fan_size/2-screw_margin-screws_d/2), -(fan_size/2-screw_margin-screws_d/2), 0])
            cylinder(d=screws_d, h=wall+2, $fn=20, center=true);
            translate([fan_size/2-screw_margin-screws_d/2, -(fan_size/2-screw_margin-screws_d/2), 0])
            cylinder(d=screws_d, h=wall+2, $fn=20, center=true);

            cylinder(d=fan_size-hole_margin, h=wall+2, $fn=60, center=true);
        }
        
    }
}

module fan_smaller(fan_size=50, vent_thick=10, fan_hole=70, wall=1.5, thick=51 ,screws_d=5,decoration=false){
    screw_margin = 5;
    hole_margin = 7;
    thick_margin = 2;
    //Front
    difference() {
        cover_front(wall=wall, width=width, thick=thick,height=height,decoration=decoration);
        translate([0, 0,  fan_hole/2+wall])
        cube([fan_hole-wall*2,fan_hole,fan_hole],center = true);
    }
    // Hole
    translate([0, wall, wall/2])
    difference() {
        fan_space(base=fan_hole, top=fan_size, screws_d=screws_d, base_wall=wall, space=vent_thick+thick_margin);
        
        translate([0, 0, (fan_hole+wall)/2])
        rotate([90, 0, 0]){
            translate([fan_size/2-screw_margin-screws_d/2, fan_size/2-screw_margin-screws_d/2, 0])
            cylinder(d=screws_d, h=fan_hole*4, $fn=20, center=true);
            translate([-(fan_size/2-screw_margin-screws_d/2), fan_size/2-screw_margin-screws_d/2, 0])
            cylinder(d=screws_d, h=fan_hole*4, $fn=20, center=true);
            translate([-(fan_size/2-screw_margin-screws_d/2), -(fan_size/2-screw_margin-screws_d/2), 0])
            cylinder(d=screws_d, h=fan_hole*4, $fn=20, center=true);
            translate([fan_size/2-screw_margin-screws_d/2, -(fan_size/2-screw_margin-screws_d/2), 0])
            cylinder(d=screws_d, h=fan_hole*4, $fn=20, center=true);

            cylinder(d=fan_size-hole_margin, h=fan_hole*4, $fn=60, center=true);
        }
        
    }
}

module hanger (r1=2,r2=4){
    thick = r2-r1;
    rotate([90,0,0])
    rotate_extrude(convexity = 10, $fn = 15)
    translate([r2, 0, 0])
    circle(r = thick, $fn = 15);
}