// CSG.scad - Basic example of CSG usage
//$fn=8; // draft
//$fn=50; // activate once happy with the design

// GENERATION OPTIONS

// set to 1 will generate upper box, 0 will skip it
generate_upper=0;
// set to 1 will generate lower box, 0 will skip it
generate_lower=1;

// DIMENSIONS //

// pcb dimensions, height with components
pcb = [45,68,15]; 
// just the PCB height, for the claming
pcb_height = 2; 

// WALLS //

// outer wall thickness
owt = 3; 
// inner wall thickness
iwt = 2; 

// Sidewall DRILLS //

// radius (!) of the drills
cable_drills = 3; 
// positions list on the bottom 
y_drills_bot = [10-22.25,30-22.25]; // position
// positions list on the top
y_drills_top = []; 
// positions list on the left side
x_drills_left = []; 
// positions list on the right side
x_drills_right = []; 

//////// LOWER box settings //////// 

// set to 1 if you want four claming blocks
with_clamping= 1;
// size of the clamping block
clamp_size = 4;
// radius(!) of the drill in the clamping block
clamp_size_drill = 1;

// free space under the PCB, e.g. for bottom side components
space_below = 3;

// number of extra standoffs under the pcb, increase for large pcb's
extra_standups = 0;

// set to 1 to add flanges to the box, e.g. to screw it on to something
with_flange = 1;

// flange drill size, radius(!) of the drill size
flange_drill = 2.5; // M5

/////// UPPER box settings //////

// radius (!) of the drills in the top, set to 0 for no drills 
lid_drill=0; 

// compensate shrinkage, positiv value will make the lid smaller, keep this small e.g. 0.25
shrinkage = 0;


// total height of both boxes musst be: top+pcb.z+space below+bottom=2*owt+pcb.z+space_below
// lower box out wall height is owt+(pcb.z/2+space_below)/2
// so upper box must be: otw+3/4*pcb.z+space_below/2

// total inner height is simply, pcb.z+space_below+2xowt
// lower box inner wall is: pcb.z/2+space_below+owt
// so upper box inner wall height is pcb.z/2+owt
// don't change
lower_box = [pcb.x+with_clamping*2*clamp_size+2*iwt+2*owt,pcb.y+with_clamping*2*clamp_size+2*iwt+2*owt,pcb.z/2+space_below+owt];

upper_box = [lower_box.x,lower_box.y,owt+pcb.z -(pcb_height+cable_drills)];

if(generate_upper){
    translate([lower_box.x+upper_box.x/2,0,0]) {  // comment this to flip the box on top of each other for testing
    //translate([0,0,upper_box.z+owt+iwt+space_below+cable_drills]) {  // uncomment this to flip the box on top of each other for testing
    //rotate([0,180,0]){// uncomment this to flip the box on top of each other for testing
        union(){
            difference(){
                // base cube
                translate([-upper_box.x/2,-upper_box.y/2,0]) {
                    cube(upper_box);
                }
                union(){
					// remove main inside
                    translate([-upper_box.x/2+owt,-upper_box.y/2+owt,owt]) {
                        cube([upper_box.x-2*owt,upper_box.y-2*owt,upper_box.z-owt]);
                    }
					// remove upper, smaller part
                    translate([-upper_box.x/2+1/2*owt-shrinkage,-upper_box.y/2+1/2*owt-shrinkage,owt+1/2*pcb.z]) {
                        cube([upper_box.x-owt+2*shrinkage,upper_box.y-owt+2*shrinkage,1/4*pcb.z+space_below/2]);
                    }
                    
                    if(lid_drill>0){
                        step_x=floor((upper_box.x-2*owt-2*lid_drill)/(lid_drill*3));
                        start_x=step_x/2*3*lid_drill;
                        
                        step_y=floor((upper_box.y-2*owt-2*lid_drill)/(lid_drill*3));
                        start_y=step_y/2*3*lid_drill;
                        
                        for(y = [0:1:step_y]){
                            for(x = [0:1:step_x]){
                                translate([-start_x+x*lid_drill*3,-start_y+y*lid_drill*3,0]){
                                    cylinder(h=owt, r=lid_drill);
                                }
                            }
                        }
                    }
                                    
                    // drills in the sizes
                    for(a = y_drills_bot){
                        translate([-a,-upper_box.y/2+owt,pcb.z-pcb_height]){
                            rotate([90,0,0]){
                                cylinder(h=owt, r=cable_drills);
                            }
                        }
                    }
                    for(b = y_drills_top){
                        translate([-b,+upper_box.y/2,pcb.z-pcb_height]){
                            rotate([90,0,0]){
                                cylinder(h=owt, r=cable_drills);
                            }
                        }
                    }
                    for(b = x_drills_left){
                        translate([upper_box.x/2-owt,b,pcb.z-pcb_height]){
                            rotate([0,90,0]){
                                cylinder(h=owt, r=cable_drills);
                            }
                        }
                    }
                    for(b = x_drills_right){
                        translate([-upper_box.x/2,b,pcb.z-pcb_height]){
                            rotate([0,90,0]){
                                cylinder(h=owt, r=cable_drills);
                            }
                        }
                    }
                }
            }
        }
    //}// uncomment this to flip the box on top of each other for testing
    //}// uncomment this to flip the box on top of each other for testing
    }
}

if(generate_lower){
    // lower box
    union(){
        difference(){ // base box - (inner cube - walls around)
            union(){
                // base cube
                translate([-lower_box.x/2,-lower_box.y/2,0]) {
                    cube(lower_box);
                }
            }
            
            union(){
                // inner cube
                translate([-(lower_box.x/2-owt),-(lower_box.y/2-owt),owt]) {
                    cube([lower_box.x-owt*2,lower_box.y-owt*2,lower_box.z-owt]);
                }
                // remove 4 half - walls
                translate([-lower_box.x/2,-lower_box.y/2,space_below+pcb_height+owt+cable_drills]) {
                    cube([lower_box.x,owt/2,pcb.z/2-(pcb_height+cable_drills)]);
                }
                translate([-lower_box.x/2,lower_box.y/2-owt/2,space_below+pcb_height+owt+cable_drills]) {
                    cube([lower_box.x,owt/2,pcb.z/2-(pcb_height+cable_drills)]);
                }
                translate([-lower_box.x/2,-lower_box.y/2-owt/2,space_below+pcb_height+owt+cable_drills]) {
                    cube([owt/2,lower_box.y,pcb.z/2-(pcb_height+cable_drills)]);
                }
                translate([lower_box.x/2-owt/2,-lower_box.y/2-owt/2,space_below+pcb_height+owt+cable_drills]) {
                    cube([owt/2,lower_box.y,pcb.z/2-(pcb_height+cable_drills)]);
                }
                
                // drills for cable
                for(a = y_drills_bot){
                    translate([a,-lower_box.y/2+owt,cable_drills+space_below+pcb_height+owt]){
                        rotate([90,0,0]){
                            cylinder(h=owt, r=cable_drills);
                        }
                    }
                }
                for(b = y_drills_top){
                    translate([b,+lower_box.y/2,cable_drills+space_below+pcb_height+owt]){
                        rotate([90,0,0]){
                            cylinder(h=owt, r=cable_drills);
                        }
                    }
                }
                for(b = x_drills_left){
                    translate([-lower_box.x/2,b,cable_drills+space_below+pcb_height+owt]){
                        rotate([0,90,0]){
                            cylinder(h=owt, r=cable_drills);
                        }
                    }
                }
                for(b = x_drills_right){
                    translate([lower_box.x/2-owt,b,cable_drills+space_below+pcb_height+owt]){
                        rotate([0,90,0]){
                            cylinder(h=owt, r=cable_drills);
                        }
                    }
                }
                // end if drills for cable
            } // end of union
        } // end of difference, outer box done.
        
        // inner parts // 
        
        // stand off 
        translate([-pcb.x/2,-pcb.y/2,owt]){
            // outer frame, directly under the border of the PCB
            difference(){
                cube([pcb.x,pcb.y,space_below]);
                translate([iwt,iwt,0]){
                    cube([pcb.x-2*iwt,pcb.y-2*iwt,space_below]);
                }
            }
            // add support standoffs if extra_standoffs > 0
            for(a = [0:1:extra_standups]){
                translate([a*pcb.x/(extra_standups+1)-iwt/2,0,0]){
                    cube([iwt,pcb.y,space_below]);
                }
                translate([0,a*pcb.y/(extra_standups+1)-iwt/2,0]){
                    cube([pcb.x,iwt,space_below]);
                }
            }
            
        }

        // (frame around stand off + clamping) - drills
        difference(){ 
            union(){
                // frame around standoff
                translate([-pcb.x/2-iwt,-pcb.y/2-iwt,owt]){
                    difference(){
                        cube([pcb.x+2*iwt,pcb.y+2*iwt,space_below+pcb_height]);
                        translate([iwt,iwt,0]){
                            cube([pcb.x,pcb.y,space_below+pcb_height]);
                        }
                    }
                }
                // blocks for claming
                if(with_clamping){
                    // bottom
                    translate([-clamp_size/2,-pcb.y/2-clamp_size-iwt,owt]){
                        cube([clamp_size,clamp_size,space_below+pcb_height]);
                    }
                    // top
                    translate([-clamp_size/2,+pcb.y/2+iwt,owt]){
                        cube([clamp_size,clamp_size,space_below+pcb_height]);
                    }
                    // right
                    translate([+pcb.x/2+iwt,-clamp_size/2,owt]){
                        cube([clamp_size,clamp_size,space_below+pcb_height]);
                    }
                    // left
                    translate([-pcb.x/2-iwt-clamp_size,-clamp_size/2,owt]){
                        cube([clamp_size,clamp_size,space_below+pcb_height]);
                    }
                } // end of blocks 
            }
            // drills in claming blocks
            if(with_clamping && clamp_size_drill>0){
                union(){
                    // bottom
                    translate([0,-pcb.y/2-iwt,owt]){
                        cylinder(h=space_below+pcb_height, r=clamp_size_drill);
                    }
                    // top
                    translate([0,+pcb.y/2+iwt,owt]){
                        cylinder(h=space_below+pcb_height, r=clamp_size_drill);
                    }
                    // right
                    translate([+pcb.x/2+iwt,0,owt]){
                        cylinder(h=space_below+pcb_height, r=clamp_size_drill);
                    }
                    // left
                    translate([-pcb.x/2-iwt,0,owt]){
                        cylinder(h=space_below+pcb_height, r=clamp_size_drill);
                    }
                } // drill union
            } // end of drills
        } // difference
        
        // add falge
        // radius of screw = flange_drill. Screw head radius is ~1.8x screw radius. lets say 2.5 to give some space
        if(with_flange){
            union(){
                flange_pos_x = [-lower_box.x/2-2*2.5*flange_drill,+lower_box.x/2];
                for(p=flange_pos_x){
                    translate([p,-lower_box.y/2,0]){
                        difference(){
                            cube([2*2.5*flange_drill,lower_box.y,owt]);
                            // upper screw
                            translate([2.5*flange_drill,lower_box.y/5,0]){
                                // head sink
                                translate([0,0,owt/3*2]){
                                    cylinder(h=owt/3, r=flange_drill*1.8);
                                }
                                // throughhole
                                cylinder(h=owt, r=flange_drill);
                            }
                            // lower screw
                            translate([2.5*flange_drill,lower_box.y*4/5,0]){
                                // head sink
                                translate([0,0,owt/3*2]){
                                    cylinder(h=owt/3, r=flange_drill*1.8);
                                }
                                // throughhole
                                cylinder(h=owt, r=flange_drill);
                            }
                        } // remove screw holes from flange
                    } // left and right
                } // for the two positions
            } // union, needed?
        } // if with flange
        
    }
}