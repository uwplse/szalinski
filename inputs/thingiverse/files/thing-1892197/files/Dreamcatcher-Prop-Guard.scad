// motor clip internal diameter
motor_d = 8.5; 
// motor clip height
motor_h = 3;    
// motor clip thickness
motor_t = 2.5; 
// motor clip pin height
pin_h = 5;      
// motor clip pin width
pin_w = 7;      
// motor clip pin rotation around Z
pin_r = 0;
// motor clip cut width
cut_w = 2;      
// motor clip cut solid base
cut_b = 0.4;
// motor clip cut rotation around Z
cut_r = 0;
// guard height
guard_h = 2;  
// guard width
guard_w = 2;    
// arm length from motor center
arm_l = 37;     
// arm base height
arm_base_h = 3; 
// arm base width
arm_base_w = 3; 
// angle between the two arms
arm_a = 120;   
// add center arm
center_arm = 0; //[0:False, 1:True]
// fillet radius
fillet_r = 3;

module prop_guard() {
    $fn=40;
    third_arm_a = center_arm?0:arm_a/2;

     difference() {
        
        //union base/arm/guard assembly, with motor pin
        union() {
            //fillet joints between motor base cylinder, arms, and guard
            fillet(r=(fillet_r < 0.1?0.1:fillet_r), steps=5) { //fillet doesn't work for fillet radius <= 0
                arm(-arm_a/2);
                arm(third_arm_a);
                arm(arm_a/2);
                cylinder(r=motor_d/2 + motor_t, h=motor_h);
                difference() {
                    cylinder(r=arm_l, h=guard_h);
                    cylinder(r=arm_l-guard_w, h=guard_h);
                }
            }
            
            //motor pin, at specified width, height and rotation around Z
            motor_pin();

        }
        
        //version of OpenSCAD used doesn't have rotate_extrude for a limited angle - only does 360 degrees
        // so need to hack away the rear part of the guard
        remove_back_guard();
        
        //remove motor inner diameter
        cylinder(r=motor_d/2, h=motor_h);
        
        //hollow out motor clip cut, at specified width, with specified base web
        motor_clip_cut();
    }
}

module arm(angle) {
    rotate([0, 0, angle]) {
        hull() {
            cylinder(r=arm_base_w/2, h=arm_base_h);
            translate([arm_l-guard_w/2, 0, 0])cylinder(r=guard_w/2, h=guard_h);
        }
    }
}

module motor_pin() {
    //rotate resulting pin around to desired rotation around Z
    rotate([0, 0, pin_r]) {
        translate([0, 0, motor_h]) {
            //hollow motor base inner diameter out of block making up pin
            difference() {
                //intersection of cylinder sitting on top of motor base, and a cube of the pin width
                intersection() {
                    cylinder(r=motor_d/2 + motor_t, h=pin_h);
                    
                    translate([-(motor_d/2 + motor_t), -pin_w/2, 0])
                        cube([motor_d/2 + motor_t, pin_w, pin_h]);
                }
                
                //inner motor cylinder
                cylinder(r=motor_d/2, h=pin_h);
            }
        }
    }
}

//cut out the motor clip cutout, so that the base will expand to clip around motor body
// leave a thin web of material at the base (optional), to allow reaming out hole to precise
// desired diameter with a drill bit (so clip isn't expanding as trying to ream hole out),
// then manually cut the thin web out with a knife
module motor_clip_cut() {
    rotate([0, 0, cut_r])
        translate([motor_d/2 - motor_t/3, -cut_w/2, cut_b])
            cube([motor_t * 3, cut_w, motor_h]);

}

//version of OpenSCAD used to create this doesn't support rotate_extrude in a limited arc
// - only does full 360 degree extrusion - so need to remove the unused rear portion of the
// outer guard - just blocking it out a bit at a time (1 degree increments), then this resulting block will be diff'd out
module remove_back_guard() {
    block_deg_step = 1;
    partial_block_w = 2 * arm_l * sin(block_deg_step);   //block width needed to cover a 1 degree increment
    
        for(a=[-arm_a/2:-block_deg_step:-180]) {
            rotate([0, 0, a])                                                                  //rotate to arm angle
                translate([0, -(arm_base_w/2 + partial_block_w) , 0])                          //move so adjacent to base of arm
                    rotate([0, 0, -sign(arm_a) * atan(( guard_w/2 - arm_base_w/2)/arm_l)])     //rotate rectangle to make parallel to side of arm (taking into account angle of side of arm due to diff in arm_base_w and guard_w)
                        translate([arm_l - (guard_w + fillet_r), 0, 0])                        //move it out to the guard
                            cube([2*guard_w + fillet_r, partial_block_w, guard_h*2]);          //thin rectangle along X axis - make long enough to potentailly cover from very rear of guard to very front of guard
        }
    
        for(a=[arm_a/2:block_deg_step:180]) {
            rotate([0, 0, a])                                                                  //rotate to arm angle
                translate([0, arm_base_w/2, 0])                                                //move so adjacent to base of arm
                    rotate([0, 0, sign(arm_a) * atan(( guard_w/2 - arm_base_w/2)/arm_l)])      //rotate rectangle to make parallel to side of arm (taking into account angle of side of arm due to diff in arm_base_w and guard_w)
                        translate([arm_l - (guard_w + fillet_r), 0, 0])                        //move it out to the guard
                            cube([2*guard_w + fillet_r + arm_l, partial_block_w, guard_h*2]);  //thin rectangle along X axis - make long enough to potentailly cover from very rear of guard to very front of guard
        }
    
}
    
//this is the awesome ClothBotCreations fillet utility, distributed under the GNU General Public License
// see: https://github.com/clothbot/ClothBotCreations/blob/master/utilities/fillet.scad
// vvvvvvv start of ClothBotCreations fillet utililty vvvvvvv

module fillet(r=1.0,steps=3,include=true) {
  if(include) for (k=[0:$children-1]) {
	children(k);
  }
  for (i=[0:$children-2] ) {
    for(j=[i+1:$children-1] ) {
	fillet_two(r=r,steps=steps) {
	  children(i);
	  children(j);
	  intersection() {
		children(i);
		children(j);
	  }
	}
    }
  }
}

module fillet_two(r=1.0,steps=3) {
  for(step=[1:steps]) {
	hull() {
	  render() intersection() {
		children(0);
		offset_3d(r=r*step/steps) children(2);
	  }
	  render() intersection() {
		children(1);
		offset_3d(r=r*(steps-step+1)/steps) children(2);
	  }
	}
  }
}

module offset_3d(r=1.0) {
  for(k=[0:$children-1]) minkowski() {
	children(k);
	sphere(r=r,$fn=8);
  }
}


//actually generate the prop guard
prop_guard();