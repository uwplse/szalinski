//Rohloff SpeedHub shifter
//Needs 1 M4 nut, and 1 M4x4mm cup end (flatish, not pointy) set screw.

$fn=120;

/* [Global] */

// The spacing between parts that should fit together
allowance = 0.3;

//line width, 0.4mm by default
line = 0.4;

//Handle bar diameter
//Road bars: 23.8mm in the grip area, 31.8mm at the stem clamp
//Straight bars: 22.2mm grip area, 25.4mm clamp
bar_diameter = 23.8;

/* [Rotor/Grip/Cable] */

//Length of the handle along the bar axis
handle_length = 25;
//Amount that the handle should be thicker than the rotor
handle_thickness = 6;

//Thickness of the rotor ring
rotor_thickness = 5;
//Length (along the handlebar axis) of the rotor
rotor_length = 17;

//Cable should be a shift cable; 1.1mm diameter
cable_diameter = 1.1;

//The diameter of the cable end stopper. TODO: find good default
cable_end_diameter = 4;

//The length of the cable guide inserts
cable_guide_length = 12;

//The diameter of the cable housing ferrule, usually 5mm
cable_ferrule_diameter = 5;

//The distance between the handle end and the first pulley cut
pulley_1_offset = 6;
//The distance between the two pulley cuts' right edges
pulley_spacing = 7;


/* [Stator] */

//Metric bolt size for the clamp. M4=4
clamp_hardware_size=4;

//Length of bolt, so M4x8 is 8. 
bolt_len = 8;

//Thickness of the clamp plug, which affects how much it can travel and remain seated
clamp_thickness = 5;

//Amount that center of stator extends below housing
stator_extension = 10;

//Thickness of the outer housing wall for the stator
housing_thickness = 4;

/* [Hidden] */

wall=2*line; //0.8mm default
w2 = 2*wall; //1.6mm
w4 = 4*wall; //3.2mm

//Thickness of the cable socket walls
socket_thickness = w2;

//For an allen socket head machine screw
bolt_head = clamp_hardware_size;

//Clamp stack: bar, clamp plug, adjustment gap, 1.6mm spacing, nut, 1.6mm, screw head

//Thickness of the stator ring
stator_thickness = bolt_len + bolt_head + 1 + clamp_thickness;


//Minimum adjustment range for clamp in mm
nut_thickness = nut_z(clamp_hardware_size);

//Clamp width
clamp_width = clamp_hardware_size * 1.8;

//The allowance for the cable end cut in the pulley. Much longer than the stopper.
cable_end_length = 20;

pulley_depth = cable_diameter + allowance/2;

//Rohloff gear changes require 7.4mm of cable travel
INDEX_SPACING = 7.4;
NUM_STOPS = 14;
total_cable_pull = (NUM_STOPS-1) * INDEX_SPACING;

inner_diameter = bar_diameter + allowance;

stator_diameter = inner_diameter + stator_thickness*2;
rotor_diameter = stator_diameter + (allowance + rotor_thickness)*2;
rotor_inner_diameter = stator_diameter + allowance*2;

pulley_diameter = rotor_diameter;

echo(pulley_diameter=pulley_diameter);
echo(clamp_thickness=clamp_thickness);
echo(actual_clamp_range=bolt_len-w4-nut_thickness);
echo(index_spacing_degrees = 360*(total_cable_pull/(PI*pulley_diameter)));

echo(overall_length = stator_length + handle_length + allowance);

housing_inner_diameter = rotor_diameter + 2*allowance;
housing_diameter = housing_thickness*2 + housing_inner_diameter;
stator_length = rotor_length + housing_thickness + allowance;

//Length of the cable socket, from the 
socket_length = 0.9*housing_diameter/2;

//A metric nut outline
module nut(m=4) {
    cylinder(d=2.1*m, h=0.667*m, $fn=6);
}

function nut_z(m) = 0.667*m;

//A sunken slot for slipping a nut into a part
module nut_slot(m=4, l=20) {
    nut(m=m);
    y=1.81*m;
    z=nut_z(m);
    translate([0, -y/2, 0]) cube([l, y, z]);
}

//Outline of a metric screw, optionally countersunk. 
//Screw is at origin, with head above, and shaft below.
module screw(m=4, l=10, sink=0) {
    head = max(sink, m);
    rotate([180, 0,0]) {
        translate([0,0,-0.05]) cylinder(d=m, h=l+0.1, $fn=32);
        translate([0, 0, -head]) cylinder(d=1.81*m, h=head, $fn=32);
    }
}

module torus(major_diameter = 10, minor_diameter = 2) {
    rotate_extrude()
        translate([major_diameter/2,0,0])
            circle(d=minor_diameter, $fn=12);
}

//First approximation of handlebar to mount on.
module bars() {
    translate([0,0,-50]) {
        cylinder(100, d=inner_diameter);
    }
}

//Cable holes, for stator housing.
module cable_socket() {
    translate([pulley_diameter/2, 0, pulley_1_offset-socket_thickness/2]) {
        rotate([90,0,0]) {
            hull() {
                cylinder(socket_length, d=cable_end_diameter+2*socket_thickness + allowance);
                translate([0,pulley_spacing+socket_thickness,0]) 
                    cylinder(socket_length, d=cable_end_diameter+2*socket_thickness + allowance);
            }
        }
    }
}

//Cable holes, for stator housing.
module cable_hole() {
    cable_hole_length = housing_diameter/2;
    translate([pulley_diameter/2, 0, pulley_1_offset]) {
        rotate([90,0,0]) {
            hull() {
                cylinder(cable_hole_length, d=cable_end_diameter + allowance);
                translate([0,pulley_spacing,0]) 
                    cylinder(cable_hole_length, d=cable_end_diameter + allowance);
            }
        }
    }
}

//Cable hole inserts, to close the hole around the cable
module cable_guide() {
    difference() {
        union() {
            //The plug part
            hull() {
                cylinder(cable_guide_length, d=cable_end_diameter-allowance);
                translate([0,pulley_spacing,0]) 
                    cylinder(cable_guide_length, d=cable_end_diameter-allowance);
            }
            //The cap part
            hull() {
                cylinder(cable_guide_length/2, d=cable_end_diameter+2*socket_thickness);
                translate([0,pulley_spacing,0]) 
                    cylinder(cable_guide_length/2, d=cable_end_diameter+2*socket_thickness);
            }
        }
        //The cable run itself
        cylinder(cable_guide_length+1, d=cable_diameter + allowance);
        //the cable housing ferrule socket
        translate([0,0,-0.01])
            cylinder(cable_guide_length/4, d=cable_ferrule_diameter + allowance);
    }
}

//The outer bit of the stator; includes cable holes
module housing() {
    difference() {
        union() {
            cylinder(rotor_length + allowance, d=housing_diameter);
            cable_socket();
            mirror([1,0,0]) cable_socket();
        }
        
        translate([0,0,-0.01])
            cylinder(rotor_length + allowance + 0.01, d=housing_inner_diameter);

        cable_hole();
        mirror([1,0,0]) cable_hole();
    }
}

//The part mounted on the bar, which does not move.
module stator() {
    cap_length = stator_length - rotor_length - allowance;
    chamfer = cap_length / 2;
    difference() {
        union() {
            //Stator core
            translate([0,0,-stator_extension])
                cylinder(stator_length + stator_extension, d = stator_diameter);
            //Cap
            translate([0,0,rotor_length + allowance]) {
                hull() {
                    translate([0,0,cap_length/2])
                        cylinder(cap_length/2, d1=housing_diameter, d2=housing_diameter - chamfer);
                    cylinder(cap_length/2, d=housing_diameter);
                }
            }
            housing();
        }
        
        bars();
        
        //Clamp plug hole
        translate([0,-clamp_thickness,-stator_extension/2])
            rotate([0,90,-90])
                cylinder(d=clamp_width+2*allowance, h=inner_diameter, center=true, $fn=6);
        //We'll clamp to the bars using a captive M4 nut, with a captive M4 grub screw (a.k.a. set screw) of 4mm length
        //screw hole
        translate([0,-inner_diameter/2-clamp_thickness-w4-nut_thickness,-stator_extension/2])
            rotate([90,0,0])
                screw(m=clamp_hardware_size, l=bolt_len, sink=20);
        //nut slot
        translate([0,-inner_diameter/2-clamp_thickness-w2,-stator_extension/2])
            rotate([0,90,-90])
                nut_slot(m=clamp_hardware_size);
        
        
        //pulley 1 clearance groove
        translate([0,0,pulley_1_offset])
            torus(pulley_diameter, cable_end_diameter);
        //pulley 2 clearance groove
        translate([0,0,pulley_1_offset + pulley_spacing])
            torus(pulley_diameter, cable_end_diameter);
    }
}

//The plug for the clamp
module clamp_plug() {
    difference() {
        intersection() {
            difference() {
                translate([0,0,-clamp_width-1])
                    cylinder(stator_length + stator_extension, d = stator_diameter);
                bars();
            }
            translate([0,-clamp_thickness,0])
                rotate([0,90,-90])
                    cylinder(d=clamp_width, h=inner_diameter, center=true, $fn=6);
        }
        //Hole, which should force solid walls around it, improving strength under compression
        translate([0,-inner_diameter/2-0.1,0])
            rotate([0,90,-90])
                cylinder(d=wall/2, h=inner_diameter/2, center=true);
    }
}

//The cut in the rotor; holds the cable
module pulley_groove() {
    torus(pulley_diameter, pulley_depth);
}

//Cutout for cable end stoppers
module cable_end() {
    translate([pulley_diameter/2, 0, 0]) {
        rotate([90,0,0]) {
            cylinder(cable_end_length, d = cable_end_diameter);
            translate([0,0,-10])
                cylinder(10.01, d = cable_diameter);
        }
    }
}

//What you twist with your hand
module handle() {
    handle_spacing = 2;
    transition = handle_thickness;
    grip_length = handle_length - handle_spacing - 2*transition;
    translate([0,0,-handle_length+0.01]) {
        translate([0,0,handle_length-handle_spacing])
            cylinder(handle_spacing, d=rotor_diameter);
        hull() {
            translate([0,0,transition+grip_length])
                cylinder(transition, d=rotor_diameter);
            translate([0,0,transition])
                cylinder(grip_length, d=rotor_diameter + handle_thickness, $fn=6);
            cylinder(transition, d=rotor_diameter);
        }
    }
}

//The part that twists; includes handle
module rotor() {
    chamfer = 1.2;
    pulley_2_offset = pulley_1_offset + pulley_spacing;
    difference() {
        union() {
            hull() {
                cylinder(rotor_length-chamfer, d = rotor_diameter);
                translate([0,0,rotor_length-chamfer])
                    cylinder(chamfer, d = rotor_diameter-chamfer*2);
            }
            handle();
        }
        translate([0,0,-stator_extension-allowance+0.01])
            cylinder(rotor_length+stator_extension+allowance, d = rotor_inner_diameter);
        translate([0,0,-handle_length+w2+0.02])
            cylinder(handle_length-stator_extension-w2-allowance, d1 = inner_diameter, d2=rotor_inner_diameter);
        translate([0,0,-handle_length-0.02])
            cylinder(handle_length, d=inner_diameter);
        
        translate([0,0,pulley_1_offset]) {
            pulley_groove();
            cable_end();
        }
        translate([0,0,pulley_2_offset]) {
            //TODO: decide how much to rotate pulley 2 relative to 1
            pulley_rotation = 60;
            rotate([0,0,pulley_rotation]) {
                mirror([1,0,0]) {
                    pulley_groove();
                    cable_end();
                }
            }
        }
    }
}

rotor_color = [0.7,0.2,0.3];

//The whole thing, assembled
module assembly() {
    stator();
    color(rotor_color)
        rotor();
    
}

//The whole thing, as print tray
module print() {
    translate([0,0,stator_length])
        rotate([0,180,0])
            stator();
    
    translate([housing_diameter+10,0,rotor_length])
        rotate([180,0,0])
            color(rotor_color)
                rotor();
    
    translate([-housing_diameter*0.6,-20,0])
        cable_guide();
    translate([-housing_diameter*0.6,20,0])
        cable_guide();
    
    translate([-housing_diameter*0.6,0,0])
        rotate([90,0,0])
            translate([0,inner_diameter/2+clamp_thickness,0])
                clamp_plug();
}

//translate([0,100,0]) assembly();

print();

