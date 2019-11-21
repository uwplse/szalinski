/*********************************************************************
 *                                                                   *
 *                     Auto-Electrical Modules                       *
 *                     =======================                       *
 *                                                                   *
 * Author: Steve Morgan                                              *
 * Project Source: https://github.com/smorgo/Auto-Electrical-Modules *
 *                                                                   *
 * License: Creative Commons - Attribution - Non Commercial          *
 *                                                                   *
 * 3D printable designs for a suite of modular components to create  *
 * auto-electrical installations.                                    *
 *                                                                   *
 * The printable components in this project are intended to be       *
 * compatible with the MTA Modular Fuse Holder System                *
* (http://www.mta.it/en/frames-modules). The MTA Modular Fuse Holder *
* System is available in the UK from such vendors as 12VoltPlanet    *
* and Polevolt.                                                      *
*                                                                    *
* For more detailed information, see the GitHub project (link above).*
*                                                                    *
**********************************************************************

// Quality setting. You might want to temporarily reduce this for testing
$fn = 30; 

/* This file can be used to generate a number of different components.
 * Set the switches to true or false to control which are generated 
 * and which are not. I recommend that, for generating an STL, you
 * only have one set to true at a time, as they aren't guaranteed
 * to lie in the same vertical plane, making printing difficult,
 * if not impossible. */
 
 /* [Select Demo mode or Printable Parts] */
 // Set to true to see an 'assembly' of parts
demo = 0; // [0:false, 1:true]

/* [Parts to Generate] */
// Set to true to generate an enclosure lid
make_lid = 0; // [0:false, 1:true]             
// Set to true to generate an enclosure (without the lid)
make_body = 1; // [0:false, 1:true]
// Set to true to generate a mounting bracket (set number_of_ways, too)
make_mount = 0; // [0:false, 1:true]           
// Number of 'modules' wide to make the mounting bracket (when make_mount=true)
number_of_ways = 3;           
// Set to true to generate a locking piece for the mounting brackets
make_lock = 0; // [0:false, 1:true]            
// Set to true to generate a spacer that fits under an MTA 2-way bracket to allow surface mounting. Note that brackets made using make_mount=true don't need this spacer
make_standoff = 0; // [0:false, 1:true]
// Set to true to generate a PCB holder. Note that this is specific to my application. You'll want to modify the pcb_insert() module to make your own
make_insert = 0; // [0:false, 1:true]
// Puts a row of four holes in an enclosure. Specific to my application
include_wire_holes = 0; // [0:false, 1:true]

// Some commonly used settings
// Sets the overall height of the enclosure (when make_body=true)
module_height = 40;           
// How much space to allow under the enclosure (with the generated brackets. Adjust for the MTA ones)
module_under_clearance = 2;   
// Depth of the enclosure lid (when make_body=true or make_lid=true)
lid_depth = 9;                
// Overall height of the standoff (when make_standoff=true). Add 2mm to the amount you want to raise the MTA bracket
standoff_height = 12;         

/*===============================================================*/

/*************************************************************
 *                                                           *
 * Some useful notes                                         *
 *                                                           *
 * The enclosure and lid are designed to use M2 countersunk  *
 * machine screws for fixing and M2 heat inserts in the body *
 * of the enclosure, inserted with a hot soldering iron.     *
 * If you want to do something different, you may need to    *
 * change some of the screw-related settings.                *
 *                                                           *
 *************************************************************/
body_screw_diameter = 2.6; // Hole in the enclosure for the heat insert. This should probably be a bit bigger, but it's worked for me.
lid_screw_diameter = 2.2; // Allow a little clearance.
lid_screw_head_diameter = 3.6;
lid_screw_head_depth = 2;
lid_screw_recess = 0.5;

/* You probably don't need to change these settings, as they're tested for compatibility with
 * the MTA modular system. */
/* [Hidden] */
module_width = 34.9;
module_inner_length = 84.1;
module_outer_length = 91.9;
module_radius = 2;
slide_depth = 16.8;
slide_notch_thickness = 2.2;
slide_notch_wall_width = 1.8;
slide_radius = 2;
slide_width = 4;
lock_channel_width = 8;
lock_height = 8.4; // relative to slide
lock_thickness = 1.4;
lock_depth = 2.2;
lid_clearance = 1;
lid_wall_thickness = 2;
lid_inner_radius = 2;
internal_width = 30;
internal_length = 78;
mount_width = 39.6;
mount_height = 32;
mount_length = 10;
mount_radius = 3;
mount_wall_thickness = 2;
mount_clip_body_width = 24.4;
mount_clip_body_thickness = 2.1;
mount_clip_front_width = 30.8;
mount_clip_front_thickness = 1.6;
mount_slot_width = 10.4;
fixing_outer_diameter = 10;
fixing_inner_diameter = 4;
fixing_depth = 4;

module_z_offset = (mount_height - module_height)/-2 + (slide_depth - mount_height)/2 + module_under_clearance;
lid_z_offset = (module_z_offset + module_height/2 - lid_depth);

if(demo) {
    demo(2);
} else {
    main();
}

module demo(num=3) {
    make_boxes(num);
    make_mounts(num);
    make_locks(num);
    make_standoffs();
    translate([0,(num-1) * (mount_width - mount_wall_thickness),0]) {
        rotate([0,0,180]) {
            make_mounts(num);
            make_locks(num);
        }
        translate([0,0,-10]) {
            pcb_insert(true);
        }
    }
}

module main() {

    if(make_body) {
        body();
    }
    
    if(make_lid) {
        translate([0,80,0]) {
            difference() {
                lid();
                lid_screws();
            }
        }
    }

    if(make_mount) {
        translate([80,0,0]) {
            difference() {
                for(i=[0:number_of_ways -1]) {
                    translate([0,i * (mount_width - mount_wall_thickness),0]) {
                        mount();
                    }
                }
                if(number_of_ways > 1) {
                    for(i=[1:number_of_ways -1]) {
                        translate([-6,(i - 0.5) * (mount_width - mount_wall_thickness),0]) {
                            cube([4,mount_wall_thickness + 1,mount_height +1], center=true);
                        }
                    }
                }
            }
            mount_fixings();
        }
    }

    if(make_lock) {
        translate([-50,-100,0]) {
            rotate([90,0,0]) slide_lock();
        }
    }
    
    if(make_insert) {
        translate([20,-50,-20]) {
            pcb_insert();
        }
    }
    
    if(make_standoff) {
        translate([120,0,0]) {
            standoff();
        }
    }
}

/************************************************
 *                                              *
 * The implementations. In general, don't mess  *
 * with these (with the exception of pcb_insert *
 * and wire_holes, if you need to).             *
 *                                              *
 ************************************************/
module body() {

    difference() {
        union() {
            roundedcube([module_outer_length, module_width, slide_depth], center=true, radius=slide_radius, apply_to="z");
            translate([0,0,module_z_offset]) {
                roundedcube([module_inner_length, module_width, module_height], center=true, radius=module_radius);
            }
        }
        slots();
        locks();
        translate([0,0,module_height/2 + module_z_offset]) rotate([180,0,0]) lid(depth = lid_depth-lid_clearance,clearance = 0.2);
        translate([0,0,lid_wall_thickness + module_z_offset]) {
            cube([internal_length, internal_width - 10, module_height], center=true);
            cube([internal_length - 10, internal_width, module_height], center=true);
        }
        body_screws();
        if(include_wire_holes) {
            wire_holes();
        }
    }
}

module body_screw() {
    translate([module_inner_length/2 - 4, module_width/2 - 4,(lid_depth+lid_clearance)/2+module_z_offset]) {
        cylinder(h = module_height, d = body_screw_diameter, center=true);
    }
}

module body_screws() {
    body_screw();
    rotate([0,0,180]) body_screw();
    mirror([1,0,0]) body_screw();
    mirror([1,0,0]) rotate([0,0,180]) body_screw();
}

module lid(depth = lid_depth, clearance = 0) {
    
    mirror([0,0,1]) {
        translate([0,0,-module_height/2]) {
            difference() {
                translate([0,0,clearance/2]) {
                    roundedcube([module_inner_length + clearance, module_width + clearance, module_height + clearance], center=true, radius=slide_radius);
                }
                translate([0,0,-depth]) {
                    cube([module_inner_length+1, module_width+1, module_height], center=true);
                }
                translate([0,0,-lid_wall_thickness]) {
                    roundedcube([module_inner_length - 2 * lid_wall_thickness, module_width - 2 * lid_wall_thickness, module_height], center=true, radius=lid_inner_radius, apply_to="z");
                }
            }
        }
        lid_posts(depth,clearance);
    }
}

module lid_post(depth,clearance) {
    translate([module_inner_length/2 - 4, module_width/2 - 4,-depth/2]) {
        cylinder(h = depth, d = 6 - clearance, center=true);
    }
}

module lid_posts(depth,clearance) {
    lid_post(depth,clearance);
    rotate([0,0,180]) lid_post(depth,clearance);
    mirror([1,0,0]) lid_post(depth,clearance);
    mirror([1,0,0]) rotate([0,0,180]) lid_post(depth,clearance);
}

module lid_screw() {
    translate([module_inner_length/2 - 4, module_width/2 - 4, -0.6]) {
        mirror([0,0,1]) {
            screw_countersunk(l = lid_depth+0.2,dh=lid_screw_head_diameter,lh=lid_screw_head_depth,ds=lid_screw_diameter,recess=lid_screw_recess);
        }
    }
}

module lid_screws() {
    lid_screw();
    rotate([0,0,180]) lid_screw();
    mirror([1,0,0]) lid_screw();
    mirror([1,0,0]) rotate([0,0,180]) lid_screw();
}

module lock() {
    translate([(module_inner_length - lock_depth)/2,0,0]) {
        difference() {
            translate([0,0,module_z_offset]) cube([lock_depth + 0.1,lock_channel_width, module_height+1], center=true);
            cube([lock_depth + 0.1, lock_channel_width + 0.1, lock_thickness], center=true);
        }
    }
}

module locks() {
    lock();
    rotate([0,0,180]) {
        lock();
    }
}

module make_box() {
    body();
    
    difference() {
        lid(depth = lid_depth-lid_clearance, clearance = 0.2);
        lid_screws();
    }
}

module make_boxes(num) {

    translate([0,0,(mount_height-slide_depth)/2]) {
        for(i=[0:num -1]) {
            translate([0,i * (mount_width - mount_wall_thickness),0]) {
                make_box();
            }
        }

        for(i=[0:num -1]) {
            translate([0,i * (mount_width - mount_wall_thickness),0]) {
                lid_offset = (i == num-1) ? 15:0;
                translate([0,0,lid_z_offset+lid_offset+lid_depth/2+3.2]) {
                    rotate([180,0,0]) {
                        difference() {
                            lid();
                            lid_screws();
                        }
                    }
                }
            }
        }
    }
}

module make_locks(num) {

    translate([module_inner_length/2,0,0]) {
        for(i=[0:num -1]) {
            translate([0,i * (mount_width - mount_wall_thickness),0]) {
                slide_lock();
            }
        }
    }
}

module make_mounts(num) {

    translate([module_inner_length/2 + 1,0,0]) {
        difference() {
            union() {
                for(i=[0:num -1]) {
                    translate([0,i * (mount_width - mount_wall_thickness),0]) {
                        mount();
                    }
                }   
                mount_fixings(num);
            }
        
            if(number_of_ways > 1) {
                for(i=[1:num -1]) {
                    translate([-6,(i - 0.5) * (mount_width - mount_wall_thickness),0]) {
                        cube([4,mount_wall_thickness + 1,mount_height +1], center=true);
                    }
                }
            }
        }
    }
}
    
module make_standoffs() {
    translate([0,-60,-10]) {
        rotate([0,0,90]) standoff(2);
        translate([-20,0,0]) rotate([0,0,-90]) standoff(2);
    }
}

module mount() {
    
    difference() {
        union() {
            difference() {
                roundedcube([mount_length, mount_width, mount_height], center=true, radius=mount_radius, apply_to="z");
                translate([-mount_wall_thickness,0,mount_height-slide_depth]) {
                    roundedcube([mount_length, mount_width - 2 * mount_wall_thickness, mount_height+1], center=true, radius=slide_radius, apply_to="z");
                }
                translate([-mount_wall_thickness-mount_clip_body_thickness-mount_clip_front_thickness,0,0]) {
                    cube([mount_length, mount_width - 2 * mount_wall_thickness, mount_height+1], center=true);
                }
            }

            translate([(mount_length-mount_clip_body_thickness)/2-mount_wall_thickness,0,0]) {
                cube([mount_clip_body_thickness + 0.6,mount_clip_body_width,mount_height], center=true);
                translate([-mount_clip_body_thickness,0,0]) {
                    cube([mount_clip_front_thickness,mount_clip_front_width,mount_height], center=true);
                }
            }
        }
        
        slide_lock(0.4);

        translate([mount_length/2-mount_wall_thickness-2,0,0]) {
            cube([2,6.4,mount_height - 4 * mount_wall_thickness], center=true);
        }

    }
}

module mount_fixing() {
    difference() {
        hull() {
            translate([4,0,5-mount_height/2]) {
                cube([0.5,20,10],center=true);
            }
            translate([12,0,(fixing_depth-mount_height)/2]) {
                cylinder(d = fixing_outer_diameter, h = fixing_depth, center=true);
            }
        }
        // `This cutout prevents the foot from overlapping the lock recess
        translate([4,0,-mount_height/2]) cube([4,6.4,4], center=true);
        translate([12,0,(fixing_depth-mount_height)/2]) {
            translate([0,0,fixing_depth+10]) {
                cylinder(d = fixing_outer_diameter, h = fixing_depth+20, center=true);
            }
                cylinder(d = fixing_inner_diameter, h = fixing_depth+0.1, center=true);
        }
    }
}

module mount_fixings(num = number_of_ways) {
    mount_fixing();
    if(num > 2) {
        offset = (num -1) * (mount_width - mount_wall_thickness);
        translate([0,offset,0]) {
            mount_fixing();
        }
    }
}

module pcb_insert(show_pcb = false) {
    clearance = 0.4;
    l = internal_length - clearance;
    w = internal_width - clearance;
    h = 2;
    pcb_l = 41.3;
    pcb_w = 19.3;
    pcb_h = 32.1;
    rla_l = 13.2;
    rla_w = 14.2;
    rla_h = 7;
    
    ox = 27.6;
    oy = 31.3;
    
    difference() {
        union() {
            cube([l, w - 10 - clearance, h], center=true);
            cube([l - 10, w, h], center=true);
        }
        cube([l - 6, w - 16 , h * 1.1], center=true);
        cube([l - 16, w - 6, h * 1.1], center=true);
    }
    cube([3,w,h], center=true);
    translate([-l/4,0,0]) cube([3,w,h], center=true);
    translate([l/4,0,0]) cube([3,w,h], center=true);
    translate([-l/8,-pcb_w/2+3,0]) cube([l/4,6,h], center=true);
    translate([-l/2+pcb_l+1,0,h/2]) cube([2,w,4], center=true);
    translate([-l/2+5,-pcb_w/2-3,-1]) {
        difference() {
            cube([pcb_l-5,3,pcb_h+h]);
            translate([pcb_l-ox,0,oy+h/2]) {
                rotate([90,0,0]) {              
                    cylinder(d=2,h=10, center=true);
                }
            }
        }
    }
    
    translate([-l/2+24,-pcb_w/2+3,0]) {
        cube([9,3,h+5]);
    }
    
    translate([-l/2+pcb_l+rla_l/2+2,0,rla_h/2]) {
        difference() {
            cube([rla_l+4,rla_w+4,rla_h+2], center=true);
            translate([0,0,2]) {
                cube([rla_l, rla_w, rla_h], center=true);
            }
        }
    }
    
    if(show_pcb) {
        /* PCB Placeholder */
        color("green",0.5) {
            translate([-l/2,-pcb_w/2,h/2]) {
                cube([pcb_l,pcb_w,pcb_h]);
            }
        }
    }
}

module slide_lock(clearance=0) {
    cube([2,6 + clearance,mount_height+0.02], center=true);
    translate([2.1,0,mount_height/2-1+0.04]) {
        cube([6,6 + clearance,2.08 + clearance/2], center=true);
    }
    translate([2.1,0,-mount_height/2+1-0.04]) { 
        cube([6,6 + clearance,2.08 + clearance/2], center=true);
    }
    translate([-1,-3,(mount_height - slide_depth)/2+3.5]) {
        rotate([-90,0,90]) {
            prism(6,2.5,1.4);
        }
    }
    translate([-1,3,(mount_height - slide_depth)/2-3.5]) {
        rotate([-90,180,90]) {
            prism(6,2.5,1.4);
        }
    }
}

module slot() {
    translate([module_inner_length/2 + slide_notch_thickness/2,0]) {
        cube([slide_notch_thickness, module_width - 2 * slide_notch_wall_width, slide_depth + 0.2], center=true);
        translate([(module_outer_length - module_inner_length)/2+0.1,0,0]) {
            cube([module_outer_length - module_inner_length,module_width - 2 * slide_width,slide_depth + 0.2], center=true);
        }
    }
}

module slots() {
    slot();
    rotate([0,0,180]) {
        slot();
    }
}

module standoff(ways = number_of_ways, h = standoff_height) {
    l1 = ways * mount_width - mount_wall_thickness + 0.5;
    l2 = l1 + 2 * mount_wall_thickness;
    w = 12 + 2 * mount_wall_thickness;

    difference() {
        lozenge([l2,w,h]);
        translate([0,-1,h-2]) {
            lozenge([l1,10,h]);
            cube([25,w+1,h], center=true);
            translate([23.3,0,0]) cube([6,w+1,h], center=true);
            translate([-23.3,0,0]) cube([6,w+1,h], center=true);
        }
        translate([0,w/2,0]) {
            cube([l2+1,w,h+1], center=true);
        }
    }
    
    translate([0,0,-1]) {
        difference() {
            hull() {
                translate([5,-12 - w/2,0]) {
                    cylinder(r=5,h=h-2,center=true);
                }
                translate([-5, -12 - w/2,0]) {
                    cylinder(r=5,h=h-2,center=true);
                }
                translate([0,-w/2,0]) {
                    cube([25,1,h-2], center=true);
                }
            }
            translate([0,-8 - w/2,0]) {
                cylinder(d=7,h=h,center=true);
            }
        }
    }
}

module wire_holes() {
    translate([-3,20,-15]) {
        rotate([90,0,0]) {
            cylinder(d=4,h=50,center=true);
        }
    }
    translate([-9,20,-15]) {
        rotate([90,0,0]) {
            cylinder(d=4,h=50,center=true);
        }
    }
    translate([-15,20,-15]) {
        rotate([90,0,0]) {
            cylinder(d=4,h=50,center=true);
        }
    }
    translate([-21,20,-15]) {
        rotate([90,0,0]) {
            cylinder(d=4,h=50,center=true);
        }
    }
    
}

/************************************************
 *                                              *
 * Utility functions                            *
 *                                              *
 ************************************************/

module lozenge(size=[0,0,0]) {
	size = (size[0] == undef) ? [size, size, size] : size;

    l = size[0];
    w = size[1];
    h = size[2];
    
    translate([-(l-w)/2,0,0]) {
        cylinder(d=w,h=h,center=true);
    }
    translate([(l-w)/2,0,0]) {
        cylinder(d=w,h=h,center=true);
    }
    cube([l-w,w,h], center=true);
}

module prism(l, w, h){
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}

// The roundedcube function, shamelessy lifted from:
// https://danielupshaw.com/openscad-rounded-corners/
module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}

// Initially taken from:
// https://gist.github.com/Stemer114/af8ef63b8d10287c825f
// However, I tweaked it slightly to allow for a counterbore.
module screw_countersunk(
        l=20,   //length
        dh = 6,   //head dia
        lh = 3,   //head length
        ds = 3.2,  //shaft dia
        recess = 0
        )
{
    rotate([180,0,0])
    union() {
        if(recess > 0) {
            cylinder(h=recess, d=dh);
        }
        translate([0,0,recess]) {
            cylinder(h=lh, r1=dh/2, r2=ds/2);
            cylinder(h=l, d=ds);
        }
    }
}


