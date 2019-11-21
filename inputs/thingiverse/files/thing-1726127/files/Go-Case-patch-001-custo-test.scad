

///////////////////
///   GO CASE   ///
///
/// Designed by Chris Caswell
///  3D Central 
///  info@3dcentralva.com
/// 
/// Intention is for this project to be Open Hardware
///  http://www.oshwa.org/definition/


// This is where you put the length of your phone, in millimeters
phone_l = 139.1;
// This is where you put the width of your phone, in millimeters
phone_w = 68.5; // Add ~3mm tolerance to your measurements to account for buttons
// This is where you put the thickness of your phone, in millimeters
phone_d = 7.8;
// This measures where the camera window starts, from left to right, in millimeters
camera_x = 10.2; // Measuring from the top left of phone, to the top left corner of where camera hole should be
// This measures where the camera window starts, from top to bottom, in millimeters
camera_y = 2.6; // "X" measuring left to right, "Y" measuring up and down
// This measures the width of the camera window from left to right, in millimeters
camera_w = 22; // Width and Length of camera hole
// This measures the length of the camera window from top to bottom, in millimeters
camera_l = 8;
// This determines the width of the aimer! It will also change the cutout in the cover. Cool, right?
aimer_w = 15; // width of finger aimer
// You can put your custom text here, and it will appear on the bottom interior of the case
custom_text = "iPhone 6";


part = "button"; // [case_top:Case Top,case_bottom:Case Bottom,case_lid:Case Lid,lock_pin:Latching slide switch,button:Button,aimer_hinge:Aimer Hinge,hinge_pin:Hinge Pin]

if(part == "assembly") {
    assembly();
}
else if(part == "aimer_hinge") {
    aimer_hinge(is_open = true);
}
else if(part == "case_top") {
    translate([0,0,phone_l/2+rounding+wall_th/2]) rotate([-90,0,0]) case_top();
}
else if(part == "case_bottom") {
    translate([0,0,phone_l/2+rounding+wall_th/2]) rotate([90,0,0]) case_bottom();
}
else if(part == "case_lid") {
    translate([0,0,13]) rotate([0,180,0]) case_lid();
}
else if(part == "hinge_pin") {
    hinge_pin();
}
else if(part == "lock_pin") {
    translate([0,0,1]) rotate([0,-90,0]) lock_pin();
}
else if(part == "button") {
    button();
}


/* [Hidden] */

// General Parameters
wall_th = 3;
rounding = 2; // minkowski rounding
phone_tol = 0.3; // extra spacing around phone
$fn = 30; // smoothness
volume_l = 30; // Originally location of slot for volume controls
volume_y = 10; // Now 
button_d = 15;
throw_dist = 10; // distance slide switch moves

// Hinge Parameters
pin_l = 30;
pin_d = 8;
tol = 0.35; // tolerance on hinge

// Global constants
sqrt2 = 1.41421356237;
magnet_d = 7;
magnet_h = 2.5;


// All components, in the right place relative to one another
module assembly() {
    //translate([0,-throw_dist,0]) 
    union() {
    translate([-phone_w/2+2-1,phone_l/2-button_d-wall_th+throw_dist-3.5-2,phone_d/2+wall_th*3-5.5])  lock_pin();
    translate([-phone_w/2+2-1+3,phone_l/2-button_d-wall_th+throw_dist+1-2,phone_d/2+wall_th*3-5.5+5])  button();
    }
    //intersection() {
    case_top();
  // translate([-phone_w/2+2-1,phone_l/2-15+4,phone_d/2+wall_th*3-5.5+4]) cube([30,30,80], center=true);
    //}
    //translate([0,-5,0]) 
    case_bottom();
    translate([phone_w+pin_l+pin_d+wall_th,0,15]) rotate([0,180,0]) translate([-1,0,0]) 
    translate([0,0,-1+10]) case_lid();
    translate([phone_w/2+pin_l*3/4-1.5,pin_d*4.5,-pin_d/2]) rotate([0,0,0]) hinge_pin();
    translate([phone_w/2+pin_l*3/4-1.5,-pin_d*6,-pin_d/2]) rotate([0,0,0]) hinge_pin();
    translate([phone_w/2+pin_l*3/4-1.5,-pin_d*0,-pin_d/2]) rotate([0,0,180]) 
    aimer_hinge(is_open = true);
    //lock_pin();
    //translate([10,0,0])  lock_pin_hole();
}


// Main phone case module, where the phone sits
module phone_case() {
    echo (custom_text);
    difference() {
        minkowski() {
            translate([pin_l/6-magnet_d/2,0,wall_th/2-wall_th/2]) 
                cube([phone_w+wall_th+pin_l/3+magnet_d/2, phone_l+wall_th, phone_d+wall_th*4], center=true);
            sphere(r=rounding);
        }
        // main phone cavity
        translate([0,0,0]) cube([phone_w+phone_tol, phone_l+phone_tol, phone_d+phone_tol*2+1], center=true);
        // lock pin hole
        //translate([-phone_w/2+2-1,phone_l/2-throw_dist*2,phone_d/2+wall_th*3-5.5]) lock_pin_hole();
        translate([-phone_w/2+2-1+3,phone_l/2-volume_l/2+throw_dist/2-4,phone_d/2+wall_th*3-5.5+0.25]) lock_pin_hole();
        // camera hole
        translate([phone_w/2-camera_x-camera_w/2,phone_l/2-camera_y-camera_l/2,-phone_d*4]) 
            cube([camera_w,camera_l,phone_d*8],center=true);
        difference() {
            translate([phone_w/2-camera_x-camera_w/2,phone_l/2-camera_y-camera_l,-phone_d*4]) // taper
                rotate([0,0,45]) cube([camera_w*sqrt2/2,camera_w*sqrt2/2,phone_d*8],center=true);
            translate([phone_w/2-camera_x-camera_w/2,phone_l/2-camera_y,-phone_d*4]) 
                cube([camera_w,camera_l*2,phone_d*10],center=true);
        }
        // power plug
        translate([0,-phone_l/2,phone_d-wall_th*0.5]) cube([20,20,phone_d*2.5], center=true);
        // volume buttons
        translate([-phone_w/2-20/2,phone_l/2-volume_y-volume_l,phone_d-wall_th*2]) 
            cube([20,volume_l,phone_d*4], center=true) ;
        // hinge pin holes
        translate([phone_w/2+pin_l*3/4-2,pin_d*4.5,-pin_d/2]) hinge_pin_holes();
        translate([phone_w/2+pin_l*3/4-2,-pin_d*0,-pin_d/2]) rotate([0,0,180])  hinge_pin_holes();
        translate([phone_w/2+pin_l*3/4-2,-pin_d*6,-pin_d/2]) hinge_pin_holes();
        // magnet holes
        translate([-phone_w/2-magnet_d*0.66,0,2]) cylinder(r=magnet_d/2,h=magnet_h,center=true);
        translate([-phone_w/2-magnet_d*0.66,-phone_l/3,2]) cylinder(r=magnet_d/2,h=magnet_h,center=true);
        // code for 45 degree angle cutaway at top of phone, and top
        translate([0,0,1]) 
        union() {
            translate([0,-phone_l/2-volume_y-volume_l/2,(10+wall_th)/2]) 
                cube([phone_w*2,phone_l*2,phone_d+2], center=true);
            translate([-phone_w/2+button_d*1.5+2.5,phone_l/2-button_d*1.5-wall_th+3,(10+wall_th*3)/2]) 
                rotate([0,0,55])
                cube([button_d*sqrt2+2,button_d*sqrt2+2,phone_d*2+3], center=true);
            translate([button_d*2,phone_l/2-26.5,(10+wall_th)/2]) 
                cube([phone_w+wall_th*4+rounding*2,40,phone_d+2], center=true);
        }
        translate([0,-phone_l/2+10,-phone_d])  linear_extrude(4) text(custom_text,halign="center",valign="center");
    }       
}


// Magnetic latching lid which clamshells over phone
module case_lid() {
    intersection () {
        difference() {
            // main outer case
            minkowski() {
                translate([pin_l/6-magnet_d/2,0,0]) 
                    cube([phone_w+wall_th+pin_l/3+magnet_d/2, phone_l+wall_th, 12+wall_th*3], center=true); // 12 from 13
                sphere(r=rounding);
            }
            // main phone cavity
            cube([phone_w+phone_tol, phone_l+phone_tol, phone_d], center=true);
            // hinge pin holes
           translate([phone_w/2+pin_l*3/4-2,pin_d*4.5,13/2+3])  rotate([0,180,0]) hinge_pin_holes();
           translate([phone_w/2+pin_l*3/4-2,-pin_d*6,13/2+3]) rotate([0,180,0]) hinge_pin_holes();
            // magnet holes
            translate([-phone_w/2-magnet_d*0.66,0,4.5]) cylinder(r=magnet_d/2,h=magnet_h,center=true);
            translate([-phone_w/2-magnet_d*0.66,-phone_l/3,4.5]) cylinder(r=magnet_d/2,h=magnet_h,center=true);
            // aimer shape
            translate([0,0,6]) aimer_hole(4);
            // lock pin
            translate([-phone_w/2+2-1+3,phone_l/2-volume_l/2+throw_dist/2-4,(13+wall_th*3)*3/8]) lock_pin_hole();
            //translate([-phone_w/2+2-1,phone_l/2-throw_dist*2+3,(13+wall_th*3)*3/8]) lock_pin_hole();
        }
        
        // intersect for only lid
        translate([0,0,2]) 
        union() {
            translate([0,-phone_l/2-volume_y-volume_l/2,(10+wall_th)/2]) 
                cube([phone_w*2,phone_l*2,phone_d+2], center=true);
            translate([-phone_w/2+button_d*1.5+2.5,phone_l/2-button_d*1.5-wall_th+3,(10+wall_th*3)/2]) 
                rotate([0,0,55])
                cube([button_d*sqrt2+2,button_d*sqrt2+2,phone_d*sqrt2+4.2], center=true);
            translate([button_d*2,phone_l/2-26.5,(10+wall_th)/2]) 
                cube([phone_w+wall_th*4+rounding*2,40,phone_d+2], center=true);
        }
    }   
}

// Split phone case into two parts for printing vertically
module phone_case_lid_top() {
    intersection() {
        phone_case_lid();
        phone_cut();
    }
}
module phone_case_lid_bottom() {
    difference() {
        phone_case_lid();
        phone_cut();
    }
}

// Still a work in progress, but to do the same for the lid
module case_top() {
    intersection() {
        phone_case();
        phone_cut();
    }
}
module case_bottom() {
    difference() {
        phone_case();
        phone_cut();
    }
}
// Geometry to cut phone case in half for easier printing - using intersection and difference
module phone_cut() {
    anglecut_w = phone_l/4*sqrt2;
    difference() {
        union() {
            translate([0,phone_l/4+phone_l/2-volume_y-volume_l/2-volume_l,0]) 
                cube([phone_w*2,phone_l/2,phone_d*4], center=true);
            translate([phone_w,phone_l/4,0])
                cube([phone_w*2,phone_l/2,phone_d*4], center=true);   
            translate([0,phone_l/4,0]) rotate([0,0,45])  
                cube([anglecut_w,anglecut_w,phone_d*4], center=true);   
        }
        translate([0,0,-4-wall_th/3-4]) difference() {
            union() {
                translate([0,phone_l/4+phone_l/2-volume_y-volume_l/2-volume_l,0]) 
                    cube([phone_w*2,phone_l/2,wall_th/3], center=true);
                translate([phone_w,phone_l/4,0])
                    cube([phone_w*2,phone_l/2,wall_th/3], center=true);   
                translate([0,phone_l/4,0]) rotate([0,0,45])  
                    cube([anglecut_w,anglecut_w,wall_th/3], center=true);   
            }
            translate([0,wall_th,-2]) union() {
                translate([0,phone_l/4+phone_l/2-volume_y-volume_l/2-volume_l,0]) 
                    cube([phone_w*2,phone_l/2,phone_d*3], center=true);
                translate([phone_w,phone_l/4,0])
                    cube([phone_w*2,phone_l/2,phone_d*3], center=true);   
                translate([0,phone_l/4,0]) rotate([0,0,45]) 
                    cube([anglecut_w,anglecut_w,phone_d*4], center=true);   
            }
        }
    }
}



// Slide in pin for latching lid shut
module lock_pin() {
    $fn=50;
    pin_d = 5;
    pin_l = 15;
    lock_pin_w = 3-0.4;
    lock_pin_l = throw_dist+lock_pin_w;
    
    difference() {
        union() {
            translate([0,3/2,0]) cube([lock_pin_w,lock_pin_l+3,4], center=true);
            translate([0,throw_dist/2-0.5,pin_l/4]) cube([lock_pin_w,4,pin_l/2], center=true);
            difference() { // sphere latch
                translate([0,-throw_dist/2+1,0]) scale([0.85,1,1]) sphere(r=2,center=true);
                translate([-pin_d*2,0,0]) cube([pin_d*4,pin_d*4,pin_d*4], center=true);
            }
        }
        
        // angular cuts
        translate([0,throw_dist/2+2+3,-2]) rotate([45,0,0]) cube([10,3,3], center=true);
        translate([0,-throw_dist/2-2,-2]) rotate([-45,0,0]) cube([10,3,3], center=true);
    }
}

module button() {
    $fn=50;
    lock_pin_l = 18;
    lock_pin_w = 3;
    difference() {
        sphere(r=button_d/2, center=true);
        translate([0,0,-button_d*2]) cube([button_d*4,button_d*4,button_d*4], center=true);
        translate([0,0,-pin_l/4+3]) cube([lock_pin_w,4,pin_l/2+6], center=true);
    }
}

// slightly different from lock_pin, to adjust for tolerance in the hole
module lock_pin_hole() {
    $fn=50;
    pin_d = 5;
    pin_l = 15;
    lock_pin_l = 18+0.3;
    lock_pin_w = 3+0.05;
    translate([0,2-throw_dist/2,0]) cube([lock_pin_w,lock_pin_l+throw_dist*1.2,4.2], center=true);
    translate([0,pin_l/2-4/2-throw_dist/2,pin_l/4]) cube([lock_pin_w,4+throw_dist,pin_l/2], center=true);
    translate([0,-pin_l/3+1.5,0]) sphere(r=2,center=true);
    translate([0,-pin_l/3-throw_dist+1.5,0]) sphere(r=2,center=true);
}

// Print in place hinge 
module hinge_pin() {
    assembled_hinge_pin_out();
    translate([0,pin_l/3,0]) rotate([0,0,180]) assembled_hinge_pin_in();
}

// rotated to display hinge in closed form
module full_hinge_closed() {
    translate([0,0,pin_d*3/2]) rotate([0,180,0]) assembled_hinge_pin_out();
    translate([0,pin_l/3,0]) rotate([0,0,180]) assembled_hinge_pin_in();
}

// Hinge with additional aimer component
module aimer_hinge(pin_d=8, length=30, is_open = false) {
     difference() {
        union() {
            translate([0,-pin_l/3,pin_d/2+2]) rotate([90,0,0]) cylinder(r=pin_d/2+2, h=pin_l/3-tol, center=true);
            translate([0,pin_l/3,pin_d/2+2]) rotate([90,0,0]) cylinder(r=pin_d/2+2, h=pin_l/3-tol, center=true);
            translate([pin_l/3/2,0,pin_d/4]) cube([pin_l/3-2,pin_l*3/3-tol,pin_d/2], center=true);
            translate([pin_l/8,pin_l/3,pin_d/4]) scale([1,1,0.69]) rotate([0,90,0]) rotate([0,0,90]) 
                pin(h=pin_l/2,r=pin_d/2);
            translate([pin_l/8,-pin_l/3,pin_d/4]) scale([1,1,0.69]) rotate([0,90,0]) rotate([0,0,90]) 
                pin(h=pin_l/2,r=pin_d/2);
        }
            translate([0,0,pin_d/2+1]) rotate([90,0,0]) cylinder(r=pin_d/2+2, h=pin_l/3+tol, center=true);    
            translate([pin_d/4,0,pin_d/2]) cube([pin_d/2, pin_l/3+tol, 20], center=true);
    }
    // hinge part
    translate([0,pin_l/8+tol/2,pin_d/2+2]) rotate([90,0,0]) cylinder(r1=pin_d/2+2, r2=0, h=pin_l/12, center=true);
    translate([0,-pin_l/8-tol/2,pin_d/2+2]) rotate([0,0,180]) rotate([90,0,0]) 
        cylinder(r1=pin_d/2+2, r2=0, h=pin_l/12, center=true);
    
    //translate([0,0,pin_d+4]) rotate([0,180,0]) // is_open
    translate([0,pin_l/3,0])rotate([0,0,180]) 
    difference() {
        union() { // hinge code
            translate([0,pin_l/3,pin_d/2+2]) rotate([90,0,0]) cylinder(r=pin_d/2+2, h=pin_l/3-tol, center=true);
            // aimer arm
            translate([pin_l/4+phone_w/4+pin_d/4+1.5-aimer_w/2,pin_l/3,4/2]) 
                cube([pin_l/2+phone_w/2+pin_d/2+3-aimer_w*0.5,pin_l/3-tol*4,4], center=true);
            // plus aimer shape
            translate([phone_w/2+pin_l/2+pin_d/2+1.5,pin_l/3,4/2]) aimer_shape(4); 
        }
            translate([0,0,pin_d/2+2]) rotate([90,0,0]) cylinder(r=pin_d/2+2, h=length/3+tol, center=true);      
            translate([pin_d/4,0,pin_d/2+2]) cube([pin_d/2+2, length/3+tol, 20], center=true);   
            // hinge part
            translate([0,length/8+length/12+tol/2,pin_d/2+2]) rotate([0,0,180]) rotate([90,0,0])
                cylinder(r1=pin_d/2+2, r2=0, h=length/12, center=true);
            translate([0,-length/8-length/12-tol/2,pin_d/2+2])  rotate([90,0,0]) 
                cylinder(r1=pin_d/2+2, r2=0, h=length/12, center=true);
            translate([0,length/2-length/24-tol/2,pin_d/2+2]) rotate([90,0,0]) 
                cylinder(r1=pin_d/2+2, r2=0, h=length/12, center=true);   
    } 
}


// Oval shape of aimer, added to a hinge
module aimer_shape(th=4) {
    aimer_offset = 7; // lower number will have aimer extend beyond bottom further
    difference() {
        union() {
            translate([0,phone_l/4+aimer_offset,0]) cylinder(r=aimer_w*3/4, h=th, center=true);
            translate([0,-phone_l/2+aimer_offset,0]) cylinder(r=aimer_w*3/4, h=th, center=true);
            translate([0,-phone_l/8+aimer_offset,0]) cube([aimer_w*3/4*2,phone_l*3/4,th], center=true);
        }
            translate([0,phone_l/4+aimer_offset,0]) cylinder(r=aimer_w/2, h=th*2, center=true);
            translate([0,-phone_l/2+aimer_offset,0]) cylinder(r=aimer_w/2, h=th*2, center=true);
            translate([0,-phone_l/8+aimer_offset,0]) cube([aimer_w,phone_l/4+phone_l/2,th*2], center=true);
    }
}

// Outline of aimer component, to be subtracted from lid
module aimer_hole(th=4) {
    aimer_offset = 7; // lower number will have aimer extend beyond bottom further
    union() {
        translate([0.5,phone_l/4+aimer_offset,0]) cylinder(r=aimer_w*3/4+1, h=th*2, center=true);
        translate([0.5,-phone_l/2+aimer_offset,0]) cylinder(r=aimer_w*3/4+1, h=th*2, center=true);
        translate([0.5,-phone_l/8+aimer_offset,0]) cube([aimer_w*3/4*2+2,phone_l/4+phone_l/2+2,th*2], center=true);
        //attachment peg
        translate([phone_l/2/2,0,0]) cube([phone_l/2+2,11,th*2], center=true);
    }
}

// Hole
module hinge_pin_holes(pin_d=8, length=30)  {
    union() {
        translate([length/8,length/3,pin_d/4]) scale([1,1,0.69]) rotate([0,90,0]) rotate([0,0,90]) 
            pinhole(h=length/2,r=pin_d/2, fixed=true);
        translate([length/8,-length/3,pin_d/4]) scale([1,1,0.69]) rotate([0,90,0]) rotate([0,0,90]) 
            pinhole(h=length/2,r=pin_d/2, fixed=true);
    }
    translate([0,length/3,0]) 
    rotate([0,0,180]) 
    union() {
        translate([length/8,length/3,pin_d/4]) scale([1,1,0.69]) rotate([0,90,0]) rotate([0,0,90]) 
            pinhole(h=length/2,r=pin_d/2, fixed=true);
        translate([length/8,-length/3,pin_d/4]) scale([1,1,0.69]) rotate([0,90,0]) rotate([0,0,90]) 
            pinhole(h=length/2,r=pin_d/2, fixed=true);
    }
}

// Hinge helper functions
module assembled_hinge_pin_out(pin_d=8, length=30) {
    difference() {
        union() {
            translate([0,-length/3,pin_d/2+2]) rotate([90,0,0]) cylinder(r=pin_d/2+2, h=length/3-tol, center=true);
            translate([0,length/3,pin_d/2+2]) rotate([90,0,0]) cylinder(r=pin_d/2+2, h=length/3-tol, center=true);
            translate([length/3/2,0,pin_d/4]) cube([length/3-2,length*3/3-tol,pin_d/2], center=true);
            translate([length/8,length/3,pin_d/4]) scale([1,1,0.69]) rotate([0,90,0]) rotate([0,0,90]) 
                pin(h=length/2,r=pin_d/2);
            translate([length/8,-length/3,pin_d/4]) scale([1,1,0.69]) rotate([0,90,0]) rotate([0,0,90]) 
                pin(h=length/2,r=pin_d/2);
        }
            translate([0,0,pin_d/2+1]) rotate([90,0,0]) cylinder(r=pin_d/2+2.3, h=length/3+tol, center=true);    
            translate([pin_d/4,0,pin_d/2]) cube([pin_d/2, length/3+tol, 20], center=true);
    }
    // hinge part
    translate([0,length/8+tol/2,pin_d/2+2]) rotate([90,0,0]) cylinder(r1=pin_d/2+2, r2=0, h=length/12, center=true);
    translate([0,-length/8-tol/2,pin_d/2+2]) rotate([0,0,180]) rotate([90,0,0]) 
        cylinder(r1=pin_d/2+2, r2=0, h=length/12, center=true);
    translate([0,length/2+length/24-tol/2,pin_d/2+2])  rotate([0,0,180]) rotate([90,0,0]) 
        cylinder(r1=pin_d/2+2, r2=0, h=length/12, center=true);
}

module assembled_hinge_pin_in(pin_d=8, length=30) {
    difference() {
        union() {
            translate([0,-length/3,pin_d/2+2]) rotate([90,0,0]) cylinder(r=pin_d/2+2, h=length/3-tol, center=true);
            translate([0,length/3,pin_d/2+2]) rotate([90,0,0]) cylinder(r=pin_d/2+2, h=length/3-tol, center=true);
            translate([length/3/2,0,pin_d/4]) cube([length/3-2,length*3/3-tol,pin_d/2], center=true);
            translate([length/8,length/3,pin_d/4]) scale([1,1,0.69]) rotate([0,90,0]) rotate([0,0,90]) 
                pin(h=length/2,r=pin_d/2);
            translate([length/8,-length/3,pin_d/4]) scale([1,1,0.69]) rotate([0,90,0]) rotate([0,0,90]) 
                pin(h=length/2,r=pin_d/2);
        }
            translate([0,0,pin_d/2+2]) rotate([90,0,0]) cylinder(r=pin_d/2+2.3, h=length/3+tol, center=true);      
            translate([pin_d/4,0,pin_d/2+2]) cube([pin_d/2+2, length/3+tol, 20], center=true);   
        // hinge part

        translate([0,length/8+length/12+tol/2,pin_d/2+2]) rotate([0,0,180]) rotate([90,0,0])
            cylinder(r1=pin_d/2+2, r2=0, h=length/12, center=true);
        translate([0,-length/8-length/12-tol/2,pin_d/2+2])  rotate([90,0,0]) 
            cylinder(r1=pin_d/2+2, r2=0, h=length/12, center=true);
        translate([0,length/2-length/24-tol/2,pin_d/2+2]) rotate([90,0,0]) 
            cylinder(r1=pin_d/2+2, r2=0, h=length/12, center=true);   
    } 
}

module hinge_hole(){
    translate([0,pin_l/2,pin_d/2]) 
    union() {
        rotate([90,0,0]) pinhole(h=pin_l,r=pin_d/2);
        rotate([90,0,0]) translate([0,0,pin_l]) rotate([0,180,0]) pinhole(h=pin_l,r=pin_d/2);
    }
    scale([1,1.3,1]) 
    translate([0,0,pin_d/2]) rotate([0,90,0]) pinhole(h=pin_l/2,r=pin_d/2);
}



////////////////////// PINS imbedded here ///////////////////////////

// Pin Connectors V3
// Tony Buser <tbuser@gmail.com>
// Modified by Emmett Lalish

length=20;
diameter=8;
//Only affects pinhole
hole_twist=0;//[0:free,1:fixed]
//Only affects pinhole
hole_friction=0;//[0:loose,1:tight]
//Radial gap to help pins fit into tight holes
pin_tolerance=0.2;
//Extra gap to make loose hole
loose=0.3;
lip_height=3;
lip_thickness=1;
hf=hole_friction==0 ? false : true;
ht=hole_twist==0 ? false : true;


module pinhole(h=10, r=4, lh=3, lt=1, t=0.3, tight=true, fixed=false) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // t = extra tolerance for loose fit
  // tight = set to false if you want a joint that spins easily
  // fixed = set to true so pins can't spin
  
intersection(){
  union() {
	if (tight == true || fixed == true) {
      pin_solid(h, r, lh, lt);
	  translate([0,0,-t/2])cylinder(h=h+t, r=r, $fn=30);
	} else {
	  pin_solid(h, r+t/2, lh, lt);
	  translate([0,0,-t/2])cylinder(h=h+t, r=r+t/2, $fn=30);
	}
    
    
    // widen the entrance hole to make insertion easier
    //translate([0, 0, -0.1]) cylinder(h=lh/3, r2=r, r1=r+(t/2)+(lt/2),$fn=30);
  }
  if (fixed == true) {
	translate([-r*2, -r*0.75, -1])cube([r*4, r*1.5, h+2]);
  }
}}

module pin(h=10, r=4, lh=3, lt=1, t=0.2, side=false) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // side = set to true if you want it printed horizontally

  if (side) {
    pin_horizontal(h, r, lh, lt, t);
  } else {
    pin_vertical(h, r, lh, lt, t);
  }
}

module pintack(h=10, r=4, lh=3, lt=1, t=0.2, bh=3, br=8.75) {
  // bh = base_height
  // br = base_radius
  
  union() {
    cylinder(h=bh, r=br);
    translate([0, 0, bh]) pin(h, r, lh, lt, t);
  }
}

module pinpeg(h=20, r=4, lh=3, lt=1, t=0.2) {
  union() {
    translate([0,-0.05, 0]) pin(h/2+0.1, r, lh, lt, t, side=true);
    translate([0,0.05, 0]) rotate([0, 0, 180]) pin(h/2+0.1, r, lh, lt, t, side=true);
  }
}

// just call pin instead, I made this module because it was easier to do the rotation option this way
// since openscad complains of recursion if I did it all in one module
module pin_vertical(h=10, r=4, lh=3, lt=1, t=0.2) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness

  difference() {
    pin_solid(h, r-t/2, lh, lt);
    
    // center cut
    translate([-lt*3/2, -(r*2+lt*2)/2, h/2+lt*3/2]) cube([lt*3, r*2+lt*2, h]);
    //translate([0, 0, h/4]) cylinder(h=h+lh, r=r/2.5, $fn=20);
    // center curve
    translate([0, 0, h/2+lt*3/2]) rotate([90, 0, 0]) cylinder(h=r*2, r=lt*3/2, center=true, $fn=20);
  
    // side cuts
    translate([-r*2, -r-r*0.75+t/2, -1]) cube([r*4, r, h+2]);
    translate([-r*2, r*0.75-t/2, -1]) cube([r*4, r, h+2]);
  }
}

// call pin with side=true instead of this
module pin_horizontal(h=10, r=4, lh=3, lt=1, t=0.2) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  translate([0, 0, r*0.75-t/2]) rotate([-90, 0, 0]) pin_vertical(h, r, lh, lt, t);
}

// this is mainly to make the pinhole module easier
module pin_solid(h=10, r=4, lh=3, lt=1) {
  union() {
    // shaft
    cylinder(h=h-lh, r=r, $fn=30);
    // lip
    // translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r2=r, r1=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r, r2=r-(lt/2), $fn=30);

    // translate([0, 0, h-lh]) cylinder(h=lh*0.50, r1=r, r2=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/3), $fn=30);    

    translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r=r+(lt/2), $fn=30);    
    translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/2), $fn=30);    

    // translate([0, 0, h-lh]) cylinder(h=lh, r1=r+(lt/2), r2=1, $fn=30);
    // translate([0, 0, h-lh-lt/2]) cylinder(h=lt/2, r1=r, r2=r+(lt/2), $fn=30);
  }
}

module pinshaft(h=10, r=4, t=0.2, side=false){
flip=side ? 1 : 0;
translate(flip*[0,h/2,r*0.75-t/2])rotate(flip*[90,0,0])
intersection(){
	cylinder(h=h, r=r-t/2, $fn=30);
	translate([-r*2, -r*0.75+t/2, -1])cube([r*4, r*1.5-t, h+2]);
}
}

