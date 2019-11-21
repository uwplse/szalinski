// case for FG085 signal generator
//
// design origin is center inside of front panel

part = "shell";  // [ shell, demo ]
with_tubes = 0; // [ 1:true, 0:false ]
with_u5p = 0; // [ 1:true, 0:false ]
with_u6p = 1; // [ 1:true, 0:false ]
with_pwm = 1; // [ 1:true, 0:false ]
with_usb = 1; // [ 1:true, 0:false ]

/* [Hidden] */
function in2mm(a) = a * 25.4;

panel_width = 157.5; // at base BUG: accurate?
panel_height = 62.0; 
panel_wall = 2.0;
panel_delta_w = 1.0; // extra width at middle of sides
pcb_thickness = 1.6;
pcb_width = in2mm(6.100); 
pcb_height = in2mm(2.200); 
spacer_front = 12.0; // the spacer with the threads, placed behind front panel and pcb
spacer_rear = 13.2; // placed on rear of pcb
panel_dist = spacer_front + pcb_thickness + spacer_rear; // between panels
screw_thread = 3.0;
nut_af = 4.65; // across flats
nut_dia = 5.3; // to clear
screw_dx = 144.3 + 3.6; // mounting hole distances
screw_dy = 44.8 + 3.6;

power_dia = 10.0; // dia of plug body  
power_pos_z = pcb_height/2 - in2mm(0.500); // offset from middle of PCB
power_pos_y = 6.2; // height from PCB surface
usb_width = 11.0; // plug body
usb_height = 9.0; // plug body
usb_pos_z = -(pcb_height/2 - in2mm(0.500)); // offset from middle of PCB
usb_pos_y = 2.0; // height from PCB surface

pwm_pos_z = -(pcb_height/2 - in2mm(0.800)); // offset from middle of PCB
pwm_pos_x = -(pcb_width/2 - in2mm(0.210)); 
u6p_pos_z = pcb_height/2 - in2mm(0.075) - in2mm(0.100);
u6p_pos_x = pcb_width/2 - in2mm(2.675) + in2mm(0.500)/2;
u5p_pos_z = u6p_pos_z;
u5p_pos_x = pcb_width/2 - in2mm(3.500) + in2mm(0.500)/2;

// tunable
support = 0.4; // needs to be wider than nozzle
wall = 1.5;
chamfer = wall*0.67;
tol = 0.3;
d = 0.01;

if (part == "demo") {
    if (false) color([0, 0.5, 0, 0.3]) {
        panel(0); // front
        translate([0, panel_wall+panel_dist, 0]) panel(0); // rear
    }
    shell();
}  

if (part == "shell") {
    rotate([-90, 0, 0]) shell();
}  

module shell() {
    module power(is_tube) {
        translate([-(pcb_width/2+tol)+(is_tube?0:10), spacer_front + pcb_thickness + power_pos_y, power_pos_z]) rotate([0, -90, 0]) 
            cylinder(r=power_dia/2 + tol + (is_tube?wall : 0), h=panel_delta_w+wall+(panel_width-pcb_width)/2+(is_tube?0:10+d), $fn=32);
    }
    module usb(is_tube) {
        if (with_usb) translate([-(pcb_width/2+tol)+(is_tube?0:10), spacer_front + pcb_thickness + usb_pos_y, usb_pos_z]) rotate([0, -90, 0]) 
            cr_cube(usb_width+tol+(is_tube?2*wall:0), 
                    usb_height+tol+(is_tube?2*wall : 0), 
                    panel_delta_w+wall+(panel_width-pcb_width)/2+(is_tube?0:10+d), 
                    (is_tube?wall:wall*0.6));
    }
    module rearconn(is_tube, dx, dz, nx, nz) {
        translate([dx, panel_dist + wall + (is_tube?0:d), dz]) rotate([90, 0, 0]) 
            cr_cube(nx*in2mm(0.1)+2*tol+(is_tube?2*wall:0), 
                    nz*in2mm(0.1)+2*tol+(is_tube?2*wall:0), 
                    wall+spacer_rear-2.0-tol+(is_tube?0:d+d), 
                    (is_tube?wall:d));
    }
    module conns(is_tube) {
        usb(is_tube);
        power(is_tube);
        if (with_pwm) rearconn(is_tube, pwm_pos_x, pwm_pos_z, 3, 1);
        if (with_u5p) rearconn(is_tube, u5p_pos_x, u5p_pos_z, 5, 2);
        if (with_u6p) rearconn(is_tube, u6p_pos_x, u6p_pos_z, 5, 2);
    }

    difference () {
        union ( ){
            halfshell();
            rotate([0, 180, 0]) halfshell();
            conns(true);
        }
        union ( ){
            conns(false);
        }
    } 
}

module halfshell() { // half shell

    // inner frame around PCB
    translate([0, panel_dist, 0]) rotate([90, 0, 0]) {
        linear_extrude(panel_dist) polygon([       
        [-(pcb_width/2+tol), 0],
        [-(pcb_width/2+tol), -(pcb_height/2+tol)],
        [pcb_width/2+tol, -(pcb_height/2+tol)], 
        [pcb_width/2+tol, 0],
        [panel_width/2+panel_delta_w+tol, 0],
        [panel_width/2+tol, -(panel_height/2+tol)],
        [-(panel_width/2+tol), -(panel_height/2+tol)],        
        [-(panel_width/2+panel_delta_w+tol), 0]]);
    }
    // support under pcb, 1.1 mm thick
    translate([0, panel_dist, 0]) rotate([90, 0, 0]) {
        linear_extrude(spacer_rear) polygon([       
            [-panel_width/2-tol, -pcb_height/2 + 1.1],
            [-panel_width/2-tol, -panel_height/2+wall],
            [panel_width/2+tol, -panel_height/2+wall],
            [panel_width/2+tol, -pcb_height/2 + 1.1]]);
    }
    // side walls
    translate([0, panel_dist+wall, 0]) rotate([90, 0, 0]) {
       linear_extrude(2*wall+panel_wall+panel_dist) polygon([       
       [-panel_width/2-panel_delta_w-tol, 0],
       [-panel_width/2-tol, -(panel_height/2+tol)],
       [panel_width/2+tol, -(panel_height/2+tol)], 
       [panel_width/2+panel_delta_w+tol, 0],
       [panel_width/2+panel_delta_w+tol+wall, 0],
       [panel_width/2+tol+wall, -panel_height/2-tol-wall+chamfer],
       [panel_width/2+tol+wall-chamfer, -panel_height/2-tol-wall],
       [-panel_width/2-tol-wall+chamfer, -panel_height/2-tol-wall],  
       [-panel_width/2-tol-wall, -panel_height/2-tol-wall+chamfer],      
       [-panel_width/2-panel_delta_w-tol-wall, 0]]);
    }
    // bottom
    difference () {
        translate([0, panel_dist+wall, 0]) rotate([90, 0, 0]) {
           linear_extrude(wall) polygon([       
           [panel_width/2+panel_delta_w+tol+wall, 0],
           [panel_width/2+tol+wall, -panel_height/2-tol-wall+chamfer],
           [panel_width/2+tol+wall-chamfer, -panel_height/2-tol-wall],
           [-panel_width/2-tol-wall+chamfer, -panel_height/2-tol-wall],  
           [-panel_width/2-tol-wall, -panel_height/2-tol-wall+chamfer],      
           [-panel_width/2-panel_delta_w-tol-wall, 0]]);
        }
        translate([0, panel_dist+wall+d, 0]) for (dx = [1, -1]) rotate([90, 0, 0])         translate([dx*screw_dx/2, -screw_dy/2, 0]) cylinder(r=screw_thread/2+tol, h=wall+2*d, $fn=24);
   }
        

   // tubes for screws
   dz = -panel_dist; 
   if (with_tubes) for (dx = [1, -1]) rotate([90, 0, 0]) translate([dx*screw_dx/2, -screw_dy/2, dz]) {
       difference () {
           union () {
               cylinder(r=nut_dia/2+tol/2+wall, h=spacer_rear, $fn=24);
               translate([0, -(panel_height-screw_dy)/4, 0]) c_cube(nut_dia+tol+2*wall, (panel_height-screw_dy)/2, spacer_rear);
               translate([dx*(panel_width-screw_dx)/4, 0, 0]) c_cube((panel_width-screw_dx)/2, nut_dia+tol+2*wall, spacer_rear);
           }
           rotate([0, 0, 30]) translate([0, 0, -d]) cylinder(r=nut_dia/2 + tol/2, h=spacer_rear+2*d, $fn=66);
       }
   }
 
} 
    
module panel(air)
{
   difference() {
        rotate([90, 0, 0]) {
            translate([0, 0, -air]) linear_extrude(panel_wall+2*air) polygon([
            [-panel_width/2-panel_delta_w-air, 0], 
            [-panel_width/2-air, panel_height/2+air], 
            [panel_width/2+air, panel_height/2+air],  
            [panel_width/2+panel_delta_w+air, 0], 
            [panel_width/2+air, -panel_height/2-air],
            [-panel_width/2-air, -panel_height/2-air]]);
       }
       union() {
           for (dx = [1, -1]) for (dy = [1, -1]) rotate([90, 0, 0]) translate([dx*screw_dx/2, dy*screw_dy/2, -d]) cylinder(r=3.0/2, h=2*d+panel_wall, $fn=12);
       }
   }
}    
    
    module c_cube(x, y, z) {
	translate([-x/2, -y/2, 0]) cube([x, y, z]);
}

module cr_cube(x, y, z, r) {
	hull() {
		for (dx=[-1,1]) for (dy=[-1,1]) translate([dx*(x/2-r), dy*(y/2-r), 0]) cylinder(r=r, h=z, $fn=20);
	}
}

module cr2_cube(x, y, z, r1, r2) {
	hull() {
		for (dx=[-1,1]) for (dy=[-1,1]) translate([dx*(x/2-r1), dy*(y/2-r1), 0]) cylinder(r1=r1, r2=r2, h=z, $fn=20);
	}
}
