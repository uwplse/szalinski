$fa = 0.5; // default minimum facet angle is now 0.5
$fs = 0.5; // default minimum facet size is now 0.5 
tilt = 15;

motor_height = 20;
motor_width = 8.5;
motor_radius = motor_width/2;
wall_thickness = 2.5;
wall_height = 5;
motor_distance=80;

plate_width = 31;
plate_height = 68;

plate_thickness = 3;

hole_cutout_width = 5;
hole_cutout_camera = 4;

recession = 1.5;

camera_length = 22;
camera_width = 10.5;
camera_height = 14.1;
camera_wall = 2;

rubber_hole_inside = 4.5;
rubber_hole_thickness = 2.5;

chip_width = 21;
chip_height = 36;

chip_offset = 9;
camera_cutout_offset = 50;

rubber_offset = 28; // center of hole

t_width=6;
t_height=5.1;
t_cross=2;


module motor_mount(h,r,d,a,solid=false) {
    
    h2 = solid ? h+2 : h;

    difference() {
        {
            rotate([a,0,0])
            difference() {
                cylinder(h=4*h2,r=r, center=true);
                if (!solid) cylinder(h=4*h2+2,r=d, center=true);
            }
        }
        translate([0,0,h2+r+h2/2]) cube(size=2*(r+h2), center=true);
        translate([0,0,-(h2+r+h2/2)]) cube(size=2*(r+h2), center=true);
    }
}

module motor_mount_actual(solid=false) {
    motor_mount(wall_height,motor_radius+wall_thickness,motor_radius,tilt,solid);
}

module strut(h,w,l,a=0) {
    scale_outer_x = 0.3;
    // l*scale_outer - l*scale_inner = 2*w
    scale_inner_x = 2*w/l - scale_outer_x;
    
    scale_outer_y = 1;
    scale_inner_y = 2*w/l - scale_outer_y;
    difference() {
        scale([scale_outer_x, scale_outer_y, 1]) cylinder(h=h, r=l/2);
        scale([scale_inner_x, scale_inner_y, 1.1]) 
            translate([0,0,-1]) cylinder(h=h+2, r=l/2);
        translate([0,-motor_distance/2, wall_height/2]) 
            rotate([0,0,a]) 
                motor_mount_actual(solid=true);
        translate([0,+motor_distance/2, wall_height/2]) 
            rotate([0,0,a]) 
                motor_mount_actual(solid=true);
        translate([0,-motor_distance/2,-1]) cube(motor_distance);
    }
}

module frame()
{
    translate([motor_distance/2,0,0]) strut(wall_height, wall_thickness, motor_distance);
    translate([-motor_distance/2,0,wall_height]) 
        rotate([0,180,0]) 
            strut(wall_height, wall_thickness, motor_distance, 180);
    translate([0,motor_distance/2,0]) 
        rotate([0,0,90]) 
            strut(wall_height, wall_thickness, motor_distance, -90);
    
    translate([motor_distance/2, motor_distance/2, wall_height/2]) 
        motor_mount_actual();
    translate([-motor_distance/2, motor_distance/2, wall_height/2]) 
        motor_mount_actual();
    translate([motor_distance/2, -motor_distance/2, wall_height/2]) 
        motor_mount_actual();
    translate([-motor_distance/2, -motor_distance/2, wall_height/2]) 
        motor_mount_actual();
}

module stand(h,w,l,s) {
    scale_outer_x = 2*s/l;
    // l*scale_outer - l*scale_inner = 2*w
    scale_inner_x = 2*w/l - scale_outer_x;
    
    scale_outer_y = 0.91;
    scale_inner_y = 2*w/l - scale_outer_y;
    
    difference() {
        translate([0,-l/2+motor_width-1,s])
        rotate([0,-90,90])
        difference() {
            scale([scale_outer_x, scale_outer_y, 1]) cylinder(h=h, r=l/2);
            scale([scale_inner_x, scale_inner_y, 1.1]) 
                translate([0,0,-1]) cylinder(h=h+2, r=l/2);
            translate([0,-motor_distance/2,-1]) cube(motor_distance);
        }
        translate([0,0,sin(tilt)*(motor_distance/2)])
            rotate([-tilt,0,0])
                frame();
        rotate([-tilt,0,0]) 
            translate([0,0,motor_distance+sin(tilt)*(motor_distance/2)+wall_height-0.4])
                cube(2*motor_distance, center=true);
    }
}

s = (sin(tilt)*(motor_distance/2))*2+wall_height;
translate([-s/2 - 50,-motor_distance/2,s+2*wall_height-0.5])
    rotate([90,0,90])
        stand(wall_thickness, wall_height, motor_distance, s);

//translate([0,0,sin(tilt)*(motor_distance/2)])
//    rotate([-tilt,0,0])
translate([-50,0,0]) frame();

module t() {
    translate([0,t_height-t_cross,0]) cube([t_width,t_cross,plate_thickness]);
    translate([(t_width-t_cross)/2,0,0]) cube([t_cross,t_height-t_cross,plate_thickness]);
}

module rubber_hole(solid=false) {
    
    height = solid ? plate_thickness+2 : plate_thickness;
    z = solid ? -1 : 0;
    difference() {
        translate([0,0,z]) cylinder(h=height, r=(rubber_hole_inside/2)+rubber_hole_thickness);
        if (!solid) {
        translate([0,0,-1]) 
            cylinder(h=plate_thickness+2, r=rubber_hole_inside/2);
        }
    }
}

module cc() {
    translate([0,1,0]) rotate([90,0,0]) 
        cylinder(h=camera_wall+2, r=hole_cutout_camera/2, center=true, $fn=6);
}

module ccc() {
    translate([0,0,-1])
        cylinder(h=plate_thickness+2, r=hole_cutout_width/2, center=true, $fn=6);
}

module cut_xy(x,y,z,l,w,sx,sy,xs,ys) {
    // l = xs*sx + (xs+1)*space_x
    space_x = (l - xs*sx)/(xs+1);
    space_y = (w - ys*sy)/(ys+1);
    
    for (i = [1:xs]) {
        for (j = [1:ys]) {
            translate([x+i*(space_x+sx)-sx/2,
                       y+j*(space_y+sy)-sy/2,
                       z]) ccc();
        }
    }
}

module cut_xz(x,y,z,l,w,sx,sz,xs,zs) {
    // l = xs*sx + (xs+1)*space_x
    space_x = (l - xs*sx)/(xs+1);
    space_z = (w - zs*sz)/(zs+1);
    
    for (i = [1:xs]) {
        for (j = [1:zs]) {
            translate([x+i*(space_x+sx)-sx/2,
                       y,
                       z+j*(space_z+sz)-sz/2]) cc();
        }
    }
}

translate([10,-50,0])
difference() {
    union() {
        difference() {
            space_y = (camera_height - 2 * hole_cutout_camera)/3;
            space_x = (camera_length - 2 * hole_cutout_camera)/3;
            
            union() {
                cube([plate_width, plate_height, plate_thickness]);
                difference() {
                    translate([(plate_width-camera_length)/2, camera_cutout_offset-camera_wall, plate_thickness-0.1]) 
                        cube([camera_length, camera_wall, camera_height]);
                    
                    cut_xz((plate_width-camera_length)/2, 
                            camera_cutout_offset-camera_wall, 
                            plate_thickness,
                            camera_length, camera_height,
                            hole_cutout_camera, hole_cutout_camera,
                            3, 2);
                }
            }
            
            translate([(plate_width-camera_length)/2, camera_cutout_offset, plate_thickness-recession]) 
                cube([camera_length, camera_width, recession+1]);
            translate([(plate_width-chip_width)/2, chip_offset, plate_thickness-recession]) 
                cube([chip_width,chip_height,recession+1]);
            translate([0,rubber_hole_inside/2+rubber_hole_thickness,0]) 
                rubber_hole(true);
            translate([plate_width,rubber_hole_inside/2+rubber_hole_thickness])         
                rubber_hole(true);
            translate([0, rubber_offset, 0])         
                rubber_hole(true);
            translate([0,plate_height-(rubber_hole_inside/2+rubber_hole_thickness),0]) 
                rubber_hole(true);
            translate([plate_width,plate_height-(rubber_hole_inside/2+rubber_hole_thickness),0])         
                rubber_hole(true);
        
        
        }
        translate([0,rubber_hole_inside/2+rubber_hole_thickness,0]) rubber_hole();
        translate([plate_width,rubber_hole_inside/2+rubber_hole_thickness]) rubber_hole();
        translate([0, rubber_offset, 0]) rubber_hole(false);
        translate([0,plate_height-(rubber_hole_inside/2+rubber_hole_thickness),0]) 
            rubber_hole(false);
        translate([plate_width,plate_height-(rubber_hole_inside/2+rubber_hole_thickness),0]) 
            rubber_hole(false);
        translate([plate_width-0.1, rubber_offset+t_width/2, 0]) rotate([0,0,-90]) t();
    }
    
    cut_xy((plate_width-chip_width)/2, chip_offset, plate_thickness/2+1, chip_width, chip_height, hole_cutout_width, hole_cutout_width, 3, 5);
    
    cut_xy((plate_width-camera_length)/2, camera_cutout_offset, plate_thickness/2+1, camera_length, camera_width, hole_cutout_width, hole_cutout_width, 3, 1);
    
    cut_xy(rubber_hole_inside/2,0,plate_thickness/2+1,plate_width-rubber_hole_inside,chip_offset,hole_cutout_width,hole_cutout_width,3,1);
    
        cut_xy(rubber_hole_inside/2,camera_cutout_offset+camera_width,plate_thickness/2+1,plate_width-rubber_hole_inside,plate_height-(camera_cutout_offset+camera_width),hole_cutout_width,hole_cutout_width,3,1);
}

