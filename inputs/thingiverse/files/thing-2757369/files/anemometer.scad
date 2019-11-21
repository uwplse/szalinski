/**
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 */

$fs=1;
$fa=1;

radius=20;
thickness=1.5;
arm=35;
arm_thickness=3.6;
support_id=3.175;
support_od=8;
N_palette=3;
square_bolt_lock=4;
body_h=65;
mounting_bar=12.75;

mounting_pipe_l = 30;
//A standard 3/4" PVC pipe inside diameter is 0.824 in or 20.93 mm, so I made this 
//slightly smaller so it would fit inside the 3/4" pipe
mounting_pipe_od = 20.25; 
//This will give us a 6.25 mm or ~1/4 in wall thickness for the attachment nipple
//which will give it good strength.
mounting_pipe_id = 14;


// allowed values: 
// all,scoop,support,body_bottom,body_top,speed_rotor,direction_vane,direction_rotor,vane_cap,vane_arms,
// vane_arm_right,vane_arm_left,fin,cone,pcb_mount,top,bottom,IR_direction_shield,IR_rotor,AS5047_mount,
// magnet_rotor

render="vane_cap";
//pcb_mount_raised_adapter();
//pcb_mount_reed_switch_board();
//direction_rotor();
//crossbar();

/*
 This will create a mounting plate for an AS5047 breakout board.  The module that I used was one from mouser 
 electronics.  The manufacturers part number is AS5047D-EK-AB and the mouser part number is 985-AS5047D-EK-AB.
 The AS5047 board is mounted so that the 5047 chip is in the center as the mounted magnet has to sit directly 
 above it for rotation detection.  The outer edges of the top and bottom sides of the plate have a rounded
 channel to hold rubber O-rings to seal the case from water.  I had to have the O-rings custom made at my 
 local hardware store.
 */ 
module AS5047_mount() {
    difference() {
        cylinder(arm_thickness+2,r=arm+arm_thickness);
        translate([0,27,-1]) {
            cylinder(arm_thickness+3.1,r=arm_thickness);
        }
        for(i=[1:N_palette]) {
            rotate(a=i*360/N_palette, v=[0,0,1]) {
                translate([arm-arm_thickness+1,0,-0.1]) {
                    cylinder(d=3.75,h=50);
                }
            }
        }
        
        echo("Seal circumference");
        echo((2*3.14159265)*(arm+arm_thickness-2));
        
        for(z=[0, arm_thickness+2]) {
            translate([0, 0, z]) {
                rotate_extrude(convexity = 10)
                translate([arm+arm_thickness-2.25, 0, 0])
                circle(r = 1.75, $fn = 50);
            }
        }
        translate([-11.875, -20.5, arm_thickness+1]) {
            cube([23.75, 28.75, 2]);
        }
        translate([-11.875, -19.75, -arm_thickness+1]) {
            cube([23.75, 7, arm_thickness*2+1]);
        }
        translate([-5.5, -11.5, arm_thickness-1]) {
            cube([9, 3, 3]);
        }
        for(x=[-1, 1], y=[-1, 1]) {
            translate([x*9, y*5.5, -0.1]) {
                cylinder(arm_thickness+3.1, d=1.5);
            }
        }
        rotate([0, 0, 45]) {
            translate([23, 0, ((arm_thickness+1)/2)]) {
                cube([12, 25, arm_thickness*2+1], center=true);
            }
            translate([23, 0, arm_thickness+1.6]) {
                cube([16, 29, 1.5], center=true);
            }
        }
    }
}

/*
 This will create the short peg that holds the direction rotor magnet.  This peg gets screwed on to the screw
 shaft of the direction rotor and is held directly above the AS5047 chip.  You will need to screw this on so 
 that the magnet is held at it's detection distance which is between 0.5mm and 3mm from the top of the chip
 according to the datasheet.
 */
module magnet_rotor() {
    translate([0, 0, 47]) {
        difference() {
            cylinder(15, r=6);
            translate([0, 0, 6.5]) {
                english_thread (diameter=1/4, threads_per_inch=20, length=1);
            }
            translate([0, 0, -0.1]) {
                cylinder(2.5, d=6);
            }
        }
    }
}

/*
 This was one of the ideas that I had tried, but didn't get it to work well enough.  I am leaving it here for
 others that may want to experiment with this idea instead of going with the AS5047 sensor.

 The IR direction shield is used with a board that has 8 IR sensors mounted in a round configuration giving
 you 8 detection points 45 degrees apart.  In the center of the board, an IR LED is used as the emitter for
 the sensors, and the IR rotor is used to direct the IR light to one of the 8 channels.  The idea was also to
 get half step detection when the IR rotor was between 2 chambers giving you detection on both chambers.
 */
module IR_direction_shield() {
    //translate([0, 0, 47]) {
    translate([0, 0, 15]) {
        difference() {
            union() {
                difference() {
                    cylinder(15, r=arm-8.5);
                    
                    translate([0, 0, -0.1]) {
                        cylinder(13, r=arm-10.5);
                    }
                }
                translate([0, 0, 6.5]) {
                    cube([1.5, (arm-9.5)*2, 13], center=true);
                    rotate([0, 0, 90]) {
                        cube([1.5, (arm-9.5)*2, 13], center=true);
                    }
                    rotate([0, 0, 135]) {
                        cube([1.5, (arm-9.5)*2, 13], center=true);
                    }
                    rotate([0, 0, 45]) {
                        cube([1.5, (arm-9.5)*2, 13], center=true);
                    }
                }
                for(i=[1:4]) {
                    rotate(a=(i*360/4)-22.5, v=[0,0,1]) {
                        translate([arm-8.5,0,0]) {
                            difference() {
                                cylinder(d=6,h=15);
                                translate([0,0,-0.1]) {
                                    cylinder(d=2,h=10);
                                }
                            }
                        }
                    }
            }
            }
            translate([0, 0, -0.1]) {
                cylinder(16, r=arm_thickness*2.5);
            }
        }
    }
}

/*
 This is the rotor that gets used with the IR direction shield.  The rotor has a hole in the bottom to 
 fit directly over an IR LED.  The rotor has an open window at 65 degrees to direct the light into one 
 or two of the chambers as the direction vane rotates.
 */
module IR_rotor() {
    translate([0, 0, 47]) {
        difference() {
            cylinder(15, r=arm_thickness*2.5-0.5);
            translate([0, 0, 6.5]) {
                english_thread (diameter=1/4, threads_per_inch=20, length=1);
            }
            translate([0, 0, -0.1]) {
                cylinder(7, d=6);
            }
            translate([0, -11, 1]) {
                Trapezoid(
                        b=14, angle=65, H=11, height=6, heights=undef,
                        center=undef, centerXYZ=[true,false,false]);
            }
        }
    }
}

/*
 This is the PCB mount used for the IR direction shield and IR rotor.  The PCB holds the 8 IR sensors
 and the IR LED in the center for the rotor.
 */
module pcb_mount() {
    difference() {
        cylinder(arm_thickness,r=arm+arm_thickness);
        translate([0,0,-1]) {
            cylinder(arm_thickness+2,r=23);
        }
        translate([0,29,-1]) {
            cylinder(arm_thickness+2,r=arm_thickness);
        }
        for(i=[1:N_palette]) {
            rotate(a=i*360/N_palette, v=[0,0,1]) {
                translate([arm-arm_thickness+1,0,-0.1]) {
                    cylinder(d=3.75,h=50);
                }
            }
        }
    
        for(i=[1:4]) {
            rotate(a=(i*90)-45, v=[0,0,1]) {
                translate([26.5,0,-0.1]) {
                    cylinder(3.76,d=4);
                }
            }
        }
    }
    
    for(i=[1:4]) {
        rotate(a=(i*90)-45, v=[0,0,1]) {
            difference() {
                translate([26.5,0,arm_thickness]) {
                    cylinder(2,d=6.5);
                }
                translate([26.5,0,-0.1]) {
                    cylinder(arm_thickness+1.1,d=4);
                    cylinder(6.5,d=2.3);
                }
            }
        }
    }
    translate([0, 0, arm_thickness]) {
        pcb_mount_raised_adapter();
    }
}

/*
 This is an adapter plate that I used to make the PCB mount a bit thicker.  This is optional depending
 how you build your IR sensor board.  It needs to be commented out of the PCB mount module if you are 
 not going to use it.
 */
module pcb_mount_raised_adapter() {
    difference() {
        cylinder(arm_thickness,r=arm+arm_thickness);
        translate([0,0,-1]) {
            cylinder(arm_thickness+2,r=arm-(arm_thickness));
        }
        translate([0,29,-1]) {
            cylinder(arm_thickness+2,r=arm_thickness);
        }
        for(i=[1:N_palette]) {
            rotate(a=i*360/N_palette, v=[0,0,1]) {
                translate([arm-arm_thickness+1,0,-0.1]) {
                    cylinder(d=3.75,h=50);
                }
            }
        }
    }
}

/*
 This was another direction sensor option that I tried that I couldn't get to work well.  The idea was
 to mount 8 micro reed switches in a round configuration and have a magnet arm mouned on the rotor that 
 would pass over the top of the reed switches to inidicate wind direction.
 */
module pcb_mount_reed_switch_board() {
    difference() {
        cylinder(arm_thickness,r=arm+arm_thickness);
        translate([0,0,-1]) {
            cylinder(arm_thickness+2,r=arm_thickness*2);
        }
        translate([-29,0,-1]) {
            cylinder(arm_thickness+2,r=arm_thickness);
        }
        for(i=[1:N_palette]) {
            rotate(a=i*360/N_palette, v=[0,0,1]) {
                translate([arm-arm_thickness+1,0,0]) {
                    cylinder(d=3.75,h=50);
                }
            }
        }
    }
    
    for(i=[1:4]) {
        rotate(a=(i*90)-22.5, v=[0,0,1]) {
            difference() {
                translate([22,0,arm_thickness]) {
                    cylinder(8.5,d=6);
                }
                translate([22,0,arm_thickness+5]) {
                    cylinder(6,d=1.5);
                }
            }
        }
    }
}

/*
 This is the rotor that would get mounted on the wind vane shaft screw to work with the reed switch 
 board. It is a small arm that holds a 4.25mm round magnet to activate the reed switches as the rotor
 spins.
 */
module direction_rotor() {
    difference() {
        cylinder(2, r=25);
        translate([17.25,0,0]) {
            cylinder(1, d=4.5);
        }
        translate([0,0,-1]) {
            cylinder(d=6.3,h=4);
        }
        translate([0,0,-1]) {
            cylinder(r=5.9,h=1.6);
        }
        translate([-30,-36,-1]) {
            cube([60, 30, 4]);
        }
        translate([-30,6,-1]) {
            cube([60, 30, 4]);
        }
        
    }
}

/*
 This is the cone that goes on the tip of the wind direction vane.  It is designed to give the tip 
 weight to balance out the rear fin.
 */
module cone() {
    translate([10,0,0]) {
        difference() {
            union() {
                scale([3,1,1]) {
                    sphere(12);
                }
                rotate([0,-90,0]) {
                    cylinder(10,r=12);
                }
            }
            translate([-10,0,0]) {
                rotate([0,-90,0]) {
                    cylinder(50,r=13);
                }
            }
            translate([-11,0,0]) {
                rotate([0,90,0]) {
                    cylinder(25, r=3);
                }
            }
        }
    }
}

/*
 This module will render all parts of the wind direction vane.
 */
module direction_vane() {
    
    translate([0,0,-((arm_thickness*4)+(body_h)-1)]) {
        vane_cap();
    }
    translate([-111,0,-118]) {
        fin(2);
    }
    translate([0,0,-93.25]) {
        vane_arms();
    }
    translate([112,0,-93]) {
        cone();
    }
}

/*
 This creates the wind vane cap that the two arms will mount into.  The cap is designed to use a 1/4x20
 carriage bolt.  The length of the carriage bolt used will depend on the direction sensor design that 
 you use. 
 */
module vane_cap() {
    difference() {
        union() {
            difference() {
                union() {
                    difference() {
                        sphere(arm+arm_thickness-6);
                        translate([0,0,-6]) {
                            cylinder(r=arm+arm_thickness+7,h=arm+arm_thickness+7);
                        }
                    }
                }
                sphere(arm-6);
                translate([0,0,-arm+arm_thickness+1]) {
                    cylinder(4,r=support_od,center=true);
                }
            }
            translate([-33.605,-7.5,-22.5]) {
                difference() {
                    cube([67,15,15]);
                    translate([96, -1, 0]) {
                        rotate([0,40,0]) {
                            cube([17,17,17]);
                        }
                    }
                    translate([10, 16, 0]) {
                        rotate([0,40,180]) {
                            cube([17,17,17]);
                        }
                    }
                    translate([0,3.25,3.25]) {
                        cube([82,8.25,8.25]);
                    }
                }
            }
            translate([0,0,-arm+arm_thickness+15.8]) {
                cylinder(29,r=support_od,center=true);
            }
        }
        translate([0, 0, (arm_thickness+(arm_thickness/2)-30)-square_bolt_lock]) { 
            cube([support_id*2,support_id*2,square_bolt_lock+3],center=true); 
        }
        translate([0,0,-arm+arm_thickness+13.8]) {
            cylinder(arm+arm_thickness+10,r=support_id,center=true);
        }
        translate([-36,-7.5,-22.5]) {
            translate([59.6, -1, 0]) {
                rotate([0,40,0]) {
                    cube([17,17,20]);
                }
            }
            translate([10, 16, 0]) {
                rotate([0,40,180]) {
                    cube([17,17,17]);
                }
            }
            translate([0,3.25,3.25]) {
                cube([82,8.25,8.25]);
            }
        }
    }
}

/*
 This will render the lef and right vane arms.
 */
module vane_arms() {
    vane_arm_left();
    vane_arm_right();
}

/*
 This is to create the right vane arm that will hold the cone tip.  It has a rounded tip that is
 designed to mount the front cone.
 */
module vane_arm_right() {
    translate([11,-4,-4]) {
        cube([100,8,8]);
        translate([0,4,4]) {
            rotate([0,90,0]) {
                cylinder(120, r=3);
            }
        }
    }
}

/*
 This is to create the left vane arm that will hold the rear tail fin.  There is a slot at one end 
 with 2 3mm screw holes for mounting the tail fin.  There is also recesed spots to hold the nuts 
 for mounting.
 */
module vane_arm_left() {
    difference() {
        translate([-141,-4,-4]) {
            cube([130,8,8]);
        }
        translate([-111,0,-24.75]) {
            fin(2);
        }
        translate([-131,5,0]) {
            rotate([90,0,0]) {
                cylinder(10,d=3.2);
                cylinder(2.5,d=6,$fn=6);
            }
        }
        translate([-91,5,0]) {
            rotate([90,0,0]) {
                cylinder(10,d=3.2);
                cylinder(2.5,d=6,$fn=6);
            }
        }
    }
}

/*
 This creates a simple 2mm thick washer that can be used as a spacer on the 1/4x20 bolts if needed.
 */
module washer() {
    difference() {
        cylinder(d=16,h=1.75);
        cylinder(d=6.25,h=2);
    }
}

/*
 This creates the rotor use for the wind speed sensor.  The rotor is designed to hold a small 
 rectangular 6mm x 2mm x ~12mm magnet that will pass by the reed switch mounted on the side of the
 base use dto detect rotation pulses.
 */
module speed_rotor() {
    difference() {
        cylinder(r=22,h=18);
        cylinder(d=6.25,h=45);
        translate([18,0,0]) {
            cube([24,36,45], center=true);
        }
        translate([-18,0,0]) {
            cube([24,36,45], center=true);
        }
        
        translate([-20,-18,-1]) {
            cube([40,50,7]);
        }
        translate([-20,-18,12]) {
            cube([40,50,7]);
        }
        
        translate([-3.125,11,7.6]) {
            cube([6.25,13,2.4]);
        }
    }
}

/*
 This creates a half round cup used for the wind speed sensor.
 */
module cup(){
	difference(){
		sphere(r = radius, $fn=100);
		sphere(r = radius-thickness, $fn=100);
		translate([-radius,0,-radius]) { 
            cube(size = radius*2, center = false); 
        }
	}
}

/*
 This creates the angled arms used to hold the wind cups.  The end of the bar is designed to give more 
 surface area to support the arms and hopefully prevent them from breaking.  The arms are then glued 
 into the support peg with superglue.
 */
module crossbar(arm=arm,arm_thickness=arm_thickness) {
    translate([0, 0, 5.6]) {
        rotate([0, 30, 0]) {
            cube([arm-(arm/3),arm_thickness,arm_thickness], center = true);
        }
    }
    translate([-15.0, 0, 11.2]) {
        cube([(arm/3),arm_thickness,arm_thickness], center = true);
        difference() {
            translate([-((arm/2)/1.5),-support_od,-(arm_thickness/2)]) {
                cube([(arm/2),support_od,arm_thickness]);
            }
            translate([-2,-support_od-9,-((arm_thickness+0.1)/2)]) {
                rotate([0, 0, 35]) {
                    cube([(arm/2),support_od,arm_thickness+0.1]);
                }
            }
            translate([-support_od-4, 0, -((arm_thickness+0.1)/2)]) {
                cylinder(h=arm_thickness+0.1, r=support_od);
            }
        }
    }
    translate([13.45, 0, 0]) {
        cube([(arm/4),arm_thickness,arm_thickness], center = true);
    }
}

/*
 This is the support peg that holds the wind speed rotor arms.  The arms fit in the slots and are
 glued in with superglue.
 */
module support_peg() {
	difference() {
        union() {
            cylinder(h=arm_thickness*2,r=support_od,center=true);
            translate([0,0,-(arm_thickness*4)]) {
                cylinder(h=arm_thickness*3,r=support_od);
            }
        }
		cylinder(h=arm_thickness*2+1,r=support_id,center=true);
		translate([0,0,-(arm_thickness*3+5)]) {
                cylinder(h=arm_thickness*3+2,r=support_id);
        }
        translate([0, 0, (arm_thickness+(arm_thickness/2)+1)-square_bolt_lock]) { 
            cube([support_id*2,support_id*2,square_bolt_lock],center=true); 
        }
    }
}

/*
 This just rotates the cup for a different view.
 */
module scoop() {
	rotate(a=270,v=[1,0,0]){
		translate([arm+radius-thickness+support_id,arm_thickness/2,0]) { 
            cup(); 
        }
	}
}

/*
 This creates the main top body that holds the wind direction vane.  For the holes to mount the bottom
 body and the center circuit board plates, put nuts on the end of the screws and heat them up with a 
 torch.  Don't get them glowing hot, but just enough that you can push them into the plastic.
 */
module body_top() {
    difference() {
        union() {
            translate([0,0,-((arm_thickness*4)+(body_h/2)-1)]) {
                difference() {
                    union() {
                        minkowski() {
                            cylinder(r=arm,h=body_h/2);
                            sphere(arm_thickness);
                        }
                        translate([0, 65, 15]) {
                            rotate([90, 0, 0]) {
                                cylinder(h=mounting_pipe_l, d=mounting_pipe_od);
                            }
                        }
                    }
                    translate([0, 66, 15]){
                        rotate([90, 0, 0]) {
                            cylinder(h=mounting_pipe_l+15, d=mounting_pipe_id);
                        }
                    }
                    
                    translate([0,0,-arm_thickness]) {
                        cylinder(r=arm+arm_thickness,h=arm_thickness);
                    }
                    translate([0,0,-arm_thickness]) {
                        cylinder(r=arm-(arm_thickness),h=body_h+arm_thickness*2);
                    }
                }
            }
            
            for(i=[1:N_palette]) {
                rotate(a=i*360/N_palette, v=[0,0,1]) {
                    translate([arm-arm_thickness+1,0,-((arm_thickness*4)+(body_h/2)-1)]) {
                        cylinder(r=arm_thickness+(arm_thickness/2),h=20);
                    }
                }
            }
            
            translate([0,0,-((arm_thickness*4)-1)]) {
                difference() {
                    cylinder(r=arm,h=arm_thickness);
                    cylinder(r=support_od+2,h=arm_thickness);
                }
            }
            translate([0,0,-((arm_thickness*5)+8)]) {
                difference() {
                    cylinder(r=12.75+(arm_thickness),h=arm_thickness+9);
                    cylinder(r=12.75,h=arm_thickness+9);
                }
            }
        }
    
        for(i=[1:N_palette]) {
            rotate(a=i*360/N_palette, v=[0,0,1]) {
                translate([arm-arm_thickness+1,0,-((arm_thickness*4)+(body_h/2))]) {
                    cylinder(r=3,h=10);
                }
            }
        }
    }
}

/*
 This creates the bottom body section that holds the wind direction sensor.  There is a slot in one
 side that will hold a small piece of PCB to hold the magnetic reed switch sensor.
 */
module body_bottom() {
    translate([0, 0, -0.1]) {
        difference() {
            union() {
                difference() {
                    minkowski() {
                        cylinder(r=arm,h=body_h/2);
                        sphere(arm_thickness);
                    }
                    translate([0,0,-(arm_thickness-body_h/1.8)]) {
                        cylinder(r=arm+arm_thickness,h=arm_thickness);
                    }
                    translate([0,0,-arm_thickness]) {
                        cylinder(r=arm-(arm_thickness),h=body_h);
                    }
                    
                    for(i=[1:N_palette]) {
                        rotate(a=i*360/N_palette, v=[0,0,1]) {
                            translate([arm-arm_thickness-1,-5.5,-4.6]) {
                                cube([((arm_thickness*2)-1)*2,((arm_thickness*2)-1)*1.7,28]);
                            }
                        }
                    }
                }
                
                translate([0,0,-3.6]) {
                    difference() {
                        cylinder(r=arm,h=arm_thickness);
                        cylinder(r=support_od+2,h=arm_thickness);
                    
                        for(i=[1:N_palette]) {
                            rotate(a=i*360/N_palette, v=[0,0,1]) {
                                translate([arm-arm_thickness+1,0,-3.6]) {
                                    cylinder(r=(arm_thickness*2)+1,h=(body_h/2)+3.6);
                                }
                                translate([arm-arm_thickness-1,-5.5,-4.6]) {
                                    cube([((arm_thickness*2)-1)*2,((arm_thickness*2)-1)*1.7,28]);
                                }
                            }
                        }
                    }
                }
                translate([0,0,-3.6]) {
                    difference() {
                        cylinder(r=12.75+(arm_thickness),h=arm_thickness+9);
                        cylinder(r=12.75,h=arm_thickness+9);
                    }
                }
                    
                for(i=[1:N_palette]) {
                    rotate(a=i*360/N_palette, v=[0,0,1]) {
                        difference() {
                            translate([arm-arm_thickness+1,0,-3.6]) {
                                difference() {
                                    cylinder(r=(arm_thickness*2)+1,h=(body_h/2)+3.6);
                                    translate([0, -(arm_thickness*2)-1,-1]) {
                                        cube([((arm_thickness*2)+1)*2,((arm_thickness*2)+1)*2,(body_h/2)+5.6]);
                                    }
                                }
                            }
                            translate([arm-arm_thickness+1,0,-arm_thickness-1]) {
                                cylinder(r=(arm_thickness*2)-(arm_thickness/2),h=28);
                            }
                            translate([arm-arm_thickness+1,-4.6,-4.6]) {
                                cube([((arm_thickness*2)-1)*2,((arm_thickness*2)-1)*1.5,22]);
                            }
                        }
                    }
                }
            }
        
            for(i=[1:N_palette]) {
                rotate(a=i*360/N_palette, v=[0,0,1]) {
                    translate([arm-arm_thickness+1,0,0]) {
                        cylinder(d=3.75,h=50);
                    }
                }
            }
        }
        //slot for the reed switch board
        difference() {
            translate([0, 30, (body_h/2)/2]) {
                cube([10, 5, (body_h/2)], center=true);
            }
            translate([0, 28.9, ((body_h/2)/2)+1]) {
                cube([6.4, 1.85, (body_h/2)], center=true);
            }
            translate([0.75, 27.9, ((body_h/2)/2)+1]) {
                cube([4, 1, (body_h/2)], center=true);
            }
        }
    }
}

/*
 This creates thev rear fin used for the wind direction sensor.
 */
module fin(h) {
    difference() {
        rotate([-90,0,0]) {
            translate([0,0,-h/2]) {
                scale([20.4/90, -20.4/90, 1]) {
                    linear_extrude(height=h)
                    polygon([[-134.769840,124.255395],
                           [-134.769840,119.746905],
                           [-135.952830,119.190455],
                           [-172.261510,103.986705],
                           [-190.684220,96.171565],
                           [-194.883035,93.384491],
                           [-198.534935,89.599716],
                           [-201.452360,85.055050],
                           [-203.447750,79.988305],
                           [-203.818906,76.643059],
                           [-204.017260,64.861604],
                           [-204.111240,-14.832875],
                           [-204.017279,-94.527354],
                           [-203.818927,-106.308809],
                           [-203.447750,-109.654055],
                           [-202.293993,-112.966546],
                           [-200.769558,-116.032935],
                           [-198.895205,-118.832458],
                           [-196.691700,-121.344354],
                           [-194.179804,-123.547858],
                           [-191.380280,-125.422208],
                           [-188.313891,-126.946642],
                           [-185.001400,-128.100395],
                           [-182.555917,-128.468501],
                           [-175.925019,-128.667194],
                           [-134.223840,-128.763885],
                           [-103.506427,-128.750044],
                           [-88.225354,-128.513362],
                           [-84.385952,-128.219977],
                           [-82.020644,-127.761105],
                           [-78.532320,-126.200535],
                           [-76.458503,-125.102377],
                           [-73.397045,-122.786330],
                           [-54.445510,-106.383865],
                           [-21.020820,-77.289655],
                           [99.189150,27.852155],
                           [204.111240,119.727835],
                           [204.111240,124.245865],
                           [204.111240,128.763885],
                           [34.670700,128.763885],
                           [-134.769840,128.763885],
                           [-134.769840,124.255395]]);
                }
            }
        }
        translate([-20,2,24.75]) {
            rotate([90,0,0]) {
                cylinder(10,d=3);
            }
        }
        translate([20,2,24.75]) {
            rotate([90,0,0]) {
                cylinder(10,d=3);
            }
        }
        translate([-31,.7,21]) {
            cube([100,1,8.75]);
        }
    }
}

/*
 This combines the cup and arm together into their final assembly for mounting.  
 */
module scoop() {
	rotate(a=270,v=[1,0,0]){
		translate([arm+radius-thickness+support_id,arm_thickness/2,0]) { 
            cup(); 
        }
        translate([arm/2+support_id,0,0]) { 
            crossbar(); 
        }
	}
}

/*
 This creates the small peg that the wind speed arms get attached to. It has a square hole in the 
 top that is made to fit the square part of the bolt head.  Using this design prevents the rotor
 from slipping when it is spinning.
 */
module support() {
	difference(){
		support_peg();

		for(i=[1:N_palette]){
			rotate(a=i*360/N_palette, v=[0,0,1]) {
				translate([arm+radius-thickness+support_id+(support_od-1),arm_thickness/2,12]) { 
                    cup(); 
                } 
                translate([arm/2+support_id+support_od-3.6,0,11]) { 
                    rotate([180, 0, 0]) {
                        crossbar(arm,arm_thickness+0.2); 
                    }
                }
			}
		}
	}
}

if (render=="all") {
	rotate([180,0,0]) {
        support();
        
        for(i=[1:N_palette]){
            rotate(a=i*360/N_palette, v=[0,0,1]) { 
                translate([arm_thickness+(arm_thickness/2), 0, arm_thickness*3+0.2]) {
                    rotate([270, 0, 0]) {
                        scoop();
                    }
                }
            }
        }
        translate([0,0,-5]) {
            direction_vane();
        }
    }
    translate([0, 0, body_h/2+arm_thickness*4]) {
        AS5047_mount();
    }
    
    translate([0,0,15]) {
        body_bottom();
    }
    
    translate([0,0,((body_h*1.5)-1)]) {
        body_top();
    }
}

if (render=="bottom") {
	rotate([180,0,0]) {
        support();
        for(i=[1:N_palette]){
            rotate(a=i*360/N_palette, v=[0,0,1]) { 
                translate([arm+radius-thickness+support_id+(support_od-1),arm_thickness/2,-22]) { 
                    cup(); 
                }
                translate([arm/2+support_id+(support_od-1),0,-22]) { 
                    crossbar(); 
                }
            }
        }
        
        body_bottom();
    }
}

if (render=="top") {
        translate([0,0,((arm_thickness*8)+(body_h)-1)]) {
            body_top();
        }
	rotate([180,0,0]) {
        
        direction_vane();
    }
}

if (render=="support") {
	support();
}

if (render=="scoop") {
	scoop();
}

if (render=="body_bottom") {
    body_bottom();
}

if (render=="body_top") {
    body_top();
}

if (render=="speed_rotor") {
    speed_rotor();
}

if (render=="direction_vane") {
    direction_vane();
}

if (render=="vane_cap") {
    vane_cap();
}

if (render=="vane_arms") {
    vane_arms();
}

if (render=="vane_arm_left") {
    vane_arm_left();
}

if (render=="vane_arm_right") {
    vane_arm_right();
}

if (render=="fin") {
    fin(1.5);
}

if (render=="cone") {
    cone();
}

if (render=="direction_rotor") {
    direction_rotor();
}

if (render=="pcb_mount") {
    pcb_mount();
}

if (render=="extension") {
    extension();
}

if (render=="IR_direction_shield") {
    IR_direction_shield();
}

if (render=="IR_rotor") {
    IR_rotor();
} 

if (render=="AS5047_mount") {
    AS5047_mount();
}

if (render=="magnet_rotor") {
    magnet_rotor();
} 


//------------------------------------------------------------------------------------------
//--------Below this line are modules for making screw threads and different shapes---------
//------------------------------------------------------------------------------------------

/*
 * ISO-standard metric threads, following this specification:
 *          http://en.wikipedia.org/wiki/ISO_metric_screw_thread
 *
 * Copyright 2016 Dan Kirshner - dan_kirshner@yahoo.com
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * See <http://www.gnu.org/licenses/>.
 *
 * Version 2.2.  2017-01-01  Correction for angle; leadfac option.  (Thanks to
 *                           Andrew Allen <a2intl@gmail.com>.)
 * Version 2.1.  2016-12-04  Chamfer bottom end (low-z); leadin option.
 * Version 2.0.  2016-11-05  Backwards compatibility (earlier OpenSCAD) fixes.
 * Version 1.9.  2016-07-03  Option: tapered.
 * Version 1.8.  2016-01-08  Option: (non-standard) angle.
 * Version 1.7.  2015-11-28  Larger x-increment - for small-diameters.
 * Version 1.6.  2015-09-01  Options: square threads, rectangular threads.
 * Version 1.5.  2015-06-12  Options: thread_size, groove.
 * Version 1.4.  2014-10-17  Use "faces" instead of "triangles" for polyhedron
 * Version 1.3.  2013-12-01  Correct loop over turns -- don't have early cut-off
 * Version 1.2.  2012-09-09  Use discrete polyhedra rather than linear_extrude ()
 * Version 1.1.  2012-09-07  Corrected to right-hand threads!
 */

// Examples.
//
// Standard M8 x 1.
// metric_thread (diameter=8, pitch=1, length=4);

// Square thread.
// metric_thread (diameter=8, pitch=1, length=4, square=true);

// Non-standard: long pitch, same thread size.
//metric_thread (diameter=8, pitch=4, length=4, thread_size=1, groove=true);

// Non-standard: 20 mm diameter, long pitch, square "trough" width 3 mm,
// depth 1 mm.
//metric_thread (diameter=20, pitch=8, length=16, square=true, thread_size=6,
//               groove=true, rectangle=0.333);

// English: 1/4 x 20.
//english_thread (diameter=1/4, threads_per_inch=20, length=1);

// Tapered.  Example -- pipe size 3/4" -- per:
// http://www.engineeringtoolbox.com/npt-national-pipe-taper-threads-d_750.html
// english_thread (diameter=1.05, threads_per_inch=14, length=3/4, taper=1/16);

// Thread for mounting on Rohloff hub.
//difference () {
//   cylinder (r=20, h=10, $fn=100);
//
//   metric_thread (diameter=34, pitch=1, length=10, internal=true, n_starts=6);
//}


// ----------------------------------------------------------------------------
function segments (diameter) = min (50, ceil (diameter*6));


// ----------------------------------------------------------------------------
// diameter -    outside diameter of threads in mm. Default: 8.
// pitch    -    thread axial "travel" per turn in mm.  Default: 1.
// length   -    overall axial length of thread in mm.  Default: 1.
// internal -    true = clearances for internal thread (e.g., a nut).
//               false = clearances for external thread (e.g., a bolt).
//               (Internal threads should be "cut out" from a solid using
//               difference ()).
// n_starts -    Number of thread starts (e.g., DNA, a "double helix," has
//               n_starts=2).  See wikipedia Screw_thread.
// thread_size - (non-standard) axial width of a single thread "V" - independent
//               of pitch.  Default: same as pitch.
// groove      - (non-standard) subtract inverted "V" from cylinder (rather than
//               add protruding "V" to cylinder).
// square      - Square threads (per
//               https://en.wikipedia.org/wiki/Square_thread_form).
// rectangle   - (non-standard) "Rectangular" thread - ratio depth/(axial) width
//               Default: 1 (square).
// angle       - (non-standard) angle (deg) of thread side from perpendicular to
//               axis (default = standard = 30 degrees).
// taper       - diameter change per length (National Pipe Thread/ANSI B1.20.1
//               is 1" diameter per 16" length). Taper decreases from 'diameter'
//               as z increases.
// leadin      - 1 (default): chamfer (45 degree) at max-z end; 0: no chamfer;
//               2: chamfer at both ends, 3: chamfer at z=0 end.
// leadfac     - scale of leadin chamfer (default: 1.0 = 1/2 thread).
module metric_thread (diameter=8, pitch=1, length=1, internal=false, n_starts=1,
                      thread_size=-1, groove=false, square=false, rectangle=0,
                      angle=30, taper=0, leadin=1, leadfac=1.0)
{
   // thread_size: size of thread "V" different than travel per turn (pitch).
   // Default: same as pitch.
   local_thread_size = thread_size == -1 ? pitch : thread_size;
   local_rectangle = rectangle ? rectangle : 1;

   n_segments = segments (diameter);
   h = (square || rectangle) ? local_thread_size*local_rectangle/2 : local_thread_size / (2 * tan(angle));

   h_fac1 = (square || rectangle) ? 0.90 : 0.625;

   // External thread includes additional relief.
   h_fac2 = (square || rectangle) ? 0.95 : 5.3/8;

   tapered_diameter = diameter - length*taper;

   difference () {
      union () {
         if (! groove) {
            metric_thread_turns (diameter, pitch, length, internal, n_starts,
                                 local_thread_size, groove, square, rectangle, angle,
                                 taper);
         }

         difference () {

            // Solid center, including Dmin truncation.
            if (groove) {
               cylinder (r1=diameter/2, r2=tapered_diameter/2,
                         h=length, $fn=n_segments);
            } else if (internal) {
               cylinder (r1=diameter/2 - h*h_fac1, r2=tapered_diameter/2 - h*h_fac1,
                         h=length, $fn=n_segments);
            } else {

               // External thread.
               cylinder (r1=diameter/2 - h*h_fac2, r2=tapered_diameter/2 - h*h_fac2,
                         h=length, $fn=n_segments);
            }

            if (groove) {
               metric_thread_turns (diameter, pitch, length, internal, n_starts,
                                    local_thread_size, groove, square, rectangle,
                                    angle, taper);
            }
         }
      }

      // chamfer z=0 end if leadin is 2 or 3
      if (leadin == 2 || leadin == 3) {
         difference () {
            cylinder (r=diameter/2 + 1, h=h*h_fac1*leadfac, $fn=n_segments);

            cylinder (r2=diameter/2, r1=diameter/2 - h*h_fac1*leadfac, h=h*h_fac1*leadfac,
                      $fn=n_segments);
         }
      }

      // chamfer z-max end if leadin is 1 or 2.
      if (leadin == 1 || leadin == 2) {
         translate ([0, 0, length + 0.05 - h*h_fac1*leadfac]) {
            difference () {
               cylinder (r=diameter/2 + 1, h=h*h_fac1*leadfac, $fn=n_segments);
               cylinder (r1=tapered_diameter/2, r2=tapered_diameter/2 - h*h_fac1*leadfac, h=h*h_fac1*leadfac,
                         $fn=n_segments);
            }
         }
      }
   }
}


// ----------------------------------------------------------------------------
// Input units in inches.
// Note: units of measure in drawing are mm!
module english_thread (diameter=0.25, threads_per_inch=20, length=1,
                      internal=false, n_starts=1, thread_size=-1, groove=false,
                      square=false, rectangle=0, angle=30, taper=0, leadin=1)
{
   // Convert to mm.
   mm_diameter = diameter*25.4;
   mm_pitch = (1.0/threads_per_inch)*25.4;
   mm_length = length*25.4;

   echo (str ("mm_diameter: ", mm_diameter));
   echo (str ("mm_pitch: ", mm_pitch));
   echo (str ("mm_length: ", mm_length));
   metric_thread (mm_diameter, mm_pitch, mm_length, internal, n_starts,
                  thread_size, groove, square, rectangle, angle, taper, leadin);
}

// ----------------------------------------------------------------------------
module metric_thread_turns (diameter, pitch, length, internal, n_starts,
                            thread_size, groove, square, rectangle, angle,
                            taper)
{
   // Number of turns needed.
   n_turns = floor (length/pitch);

   intersection () {

      // Start one below z = 0.  Gives an extra turn at each end.
      for (i=[-1*n_starts : n_turns+1]) {
         translate ([0, 0, i*pitch]) {
            metric_thread_turn (diameter, pitch, internal, n_starts,
                                thread_size, groove, square, rectangle, angle,
                                taper, i*pitch);
         }
      }

      // Cut to length.
      translate ([0, 0, length/2]) {
         cube ([diameter*3, diameter*3, length], center=true);
      }
   }
}


// ----------------------------------------------------------------------------
module metric_thread_turn (diameter, pitch, internal, n_starts, thread_size,
                           groove, square, rectangle, angle, taper, z)
{
   n_segments = segments (diameter);
   fraction_circle = 1.0/n_segments;
   for (i=[0 : n_segments-1]) {
      rotate ([0, 0, i*360*fraction_circle]) {
         translate ([0, 0, i*n_starts*pitch*fraction_circle]) {
            //current_diameter = diameter - taper*(z + i*n_starts*pitch*fraction_circle);
            thread_polyhedron ((diameter - taper*(z + i*n_starts*pitch*fraction_circle))/2,
                               pitch, internal, n_starts, thread_size, groove,
                               square, rectangle, angle);
         }
      }
   }
}


// ----------------------------------------------------------------------------
module thread_polyhedron (radius, pitch, internal, n_starts, thread_size,
                          groove, square, rectangle, angle)
{
   n_segments = segments (radius*2);
   fraction_circle = 1.0/n_segments;

   local_rectangle = rectangle ? rectangle : 1;

   h = (square || rectangle) ? thread_size*local_rectangle/2 : thread_size / (2 * tan(angle));
   outer_r = radius + (internal ? h/20 : 0); // Adds internal relief.
   //echo (str ("outer_r: ", outer_r));

   // A little extra on square thread -- make sure overlaps cylinder.
   h_fac1 = (square || rectangle) ? 1.1 : 0.875;
   inner_r = radius - h*h_fac1; // Does NOT do Dmin_truncation - do later with
                                // cylinder.

   translate_y = groove ? outer_r + inner_r : 0;
   reflect_x   = groove ? 1 : 0;

   // Make these just slightly bigger (keep in proportion) so polyhedra will
   // overlap.
   x_incr_outer = (! groove ? outer_r : inner_r) * fraction_circle * 2 * PI * 1.02;
   x_incr_inner = (! groove ? inner_r : outer_r) * fraction_circle * 2 * PI * 1.02;
   z_incr = n_starts * pitch * fraction_circle * 1.005;

   /*
    (angles x0 and x3 inner are actually 60 deg)

                          /\  (x2_inner, z2_inner) [2]
                         /  \
   (x3_inner, z3_inner) /    \
                  [3]   \     \
                        |\     \ (x2_outer, z2_outer) [6]
                        | \    /
                        |  \  /|
             z          |[7]\/ / (x1_outer, z1_outer) [5]
             |          |   | /
             |   x      |   |/
             |  /       |   / (x0_outer, z0_outer) [4]
             | /        |  /     (behind: (x1_inner, z1_inner) [1]
             |/         | /
    y________|          |/
   (r)                  / (x0_inner, z0_inner) [0]

   */

   x1_outer = outer_r * fraction_circle * 2 * PI;

   z0_outer = (outer_r - inner_r) * tan(angle);
   //echo (str ("z0_outer: ", z0_outer));

   //polygon ([[inner_r, 0], [outer_r, z0_outer],
   //        [outer_r, 0.5*pitch], [inner_r, 0.5*pitch]]);
   z1_outer = z0_outer + z_incr;

   // Give internal square threads some clearance in the z direction, too.
   bottom = internal ? 0.235 : 0.25;
   top    = internal ? 0.765 : 0.75;

   translate ([0, translate_y, 0]) {
      mirror ([reflect_x, 0, 0]) {

         if (square || rectangle) {

            // Rule for face ordering: look at polyhedron from outside: points must
            // be in clockwise order.
            polyhedron (
               points = [
                         [-x_incr_inner/2, -inner_r, bottom*thread_size],         // [0]
                         [x_incr_inner/2, -inner_r, bottom*thread_size + z_incr], // [1]
                         [x_incr_inner/2, -inner_r, top*thread_size + z_incr],    // [2]
                         [-x_incr_inner/2, -inner_r, top*thread_size],            // [3]

                         [-x_incr_outer/2, -outer_r, bottom*thread_size],         // [4]
                         [x_incr_outer/2, -outer_r, bottom*thread_size + z_incr], // [5]
                         [x_incr_outer/2, -outer_r, top*thread_size + z_incr],    // [6]
                         [-x_incr_outer/2, -outer_r, top*thread_size]             // [7]
                        ],

               faces = [
                         [0, 3, 7, 4],  // This-side trapezoid

                         [1, 5, 6, 2],  // Back-side trapezoid

                         [0, 1, 2, 3],  // Inner rectangle

                         [4, 7, 6, 5],  // Outer rectangle

                         // These are not planar, so do with separate triangles.
                         [7, 2, 6],     // Upper rectangle, bottom
                         [7, 3, 2],     // Upper rectangle, top

                         [0, 5, 1],     // Lower rectangle, bottom
                         [0, 4, 5]      // Lower rectangle, top
                        ]
            );
         } else {

            // Rule for face ordering: look at polyhedron from outside: points must
            // be in clockwise order.
            polyhedron (
               points = [
                         [-x_incr_inner/2, -inner_r, 0],                        // [0]
                         [x_incr_inner/2, -inner_r, z_incr],                    // [1]
                         [x_incr_inner/2, -inner_r, thread_size + z_incr],      // [2]
                         [-x_incr_inner/2, -inner_r, thread_size],              // [3]

                         [-x_incr_outer/2, -outer_r, z0_outer],                 // [4]
                         [x_incr_outer/2, -outer_r, z0_outer + z_incr],         // [5]
                         [x_incr_outer/2, -outer_r, thread_size - z0_outer + z_incr], // [6]
                         [-x_incr_outer/2, -outer_r, thread_size - z0_outer]    // [7]
                        ],

               faces = [
                         [0, 3, 7, 4],  // This-side trapezoid

                         [1, 5, 6, 2],  // Back-side trapezoid

                         [0, 1, 2, 3],  // Inner rectangle

                         [4, 7, 6, 5],  // Outer rectangle

                         // These are not planar, so do with separate triangles.
                         [7, 2, 6],     // Upper rectangle, bottom
                         [7, 3, 2],     // Upper rectangle, top

                         [0, 5, 1],     // Lower rectangle, bottom
                         [0, 4, 5]      // Lower rectangle, top
                        ]
            );
         }
      }
   }
}
/*
Trapezoid
	Create a Basic Trapezoid (Based on Isosceles_Triangle)

            d
          /----\
         /  |   \
     a  /   H    \ c
       /    |     \
 angle ------------ angle
            b

	b: Length of side b
	angle: Angle at points angleAB & angleBC
	H: The 2D height at which the triangle should be cut to create the trapezoid
	heights: If vector of size 3 (Standard for triangles) both cd & da will be the same height, if vector have 4 values [ab,bc,cd,da] than each point can have different heights.
*/
module Trapezoid(
			b, angle=60, H, height=1, heights=undef,
			center=undef, centerXYZ=[true,false,false])
{
	validAngle = (angle < 90);
	adX = H / tan(angle);

	// Calculate Heights at each point
	heightAB = ((heights==undef) ? height : heights[0])/2;
	heightBC = ((heights==undef) ? height : heights[1])/2;
	heightCD = ((heights==undef) ? height : heights[2])/2;
	heightDA = ((heights==undef) ? height : ((len(heights) > 3)?heights[3]:heights[2]))/2;

	// Centers
	centerX = (center || (center==undef && centerXYZ[0]))?0:b/2;
	centerY = (center || (center==undef && centerXYZ[1]))?0:H/2;
	centerZ = (center || (center==undef && centerXYZ[2]))?0:max(heightAB,heightBC,heightCD,heightDA);

	// Points
	y = H/2;
	bx = b/2;
	dx = (b-(adX*2))/2;

	pointAB1 = [centerX-bx, centerY-y, centerZ-heightAB];
	pointAB2 = [centerX-bx, centerY-y, centerZ+heightAB];
	pointBC1 = [centerX+bx, centerY-y, centerZ-heightBC];
	pointBC2 = [centerX+bx, centerY-y, centerZ+heightBC];
	pointCD1 = [centerX+dx, centerY+y, centerZ-heightCD];
	pointCD2 = [centerX+dx, centerY+y, centerZ+heightCD];
	pointDA1 = [centerX-dx, centerY+y, centerZ-heightDA];
	pointDA2 = [centerX-dx, centerY+y, centerZ+heightDA];

	validH = (adX < b/2);

	if (validAngle && validH)
	{
		polyhedron(
			points=[	pointAB1, pointBC1, pointCD1, pointDA1,
						pointAB2, pointBC2, pointCD2, pointDA2 ],
			triangles=[	
				[0, 1, 2],
				[0, 2, 3],
				[4, 6, 5],
				[4, 7, 6],
				[0, 4, 1],
				[1, 4, 5],
				[1, 5, 2],
				[2, 5, 6],
				[2, 6, 3],
				[3, 6, 7],
				[3, 7, 0],
				[0, 7, 4]	] );
	} else {
		if (!validAngle) echo("Trapezoid invalid, angle must be less than 90");
		else echo("Trapezoid invalid, H is larger than triangle");
	}
}
