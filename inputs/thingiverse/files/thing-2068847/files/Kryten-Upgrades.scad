/* Thingiverse Customizer Settings */

// Target Printer Type
Printer = "malyan"; // [malyan:Malyan M150,wanhao:Wanhao Di3 or Cocoon Create]
// Print which part?
Part = "front"; // [upper:Upper Deck,lower:Lower Block,front:Hotend/Fan Block,hotend:Hotend Clamp Block,belt:Belt Post Block,fanduct:Cooling Fan Duct,ebowden:Extruder Bowden Adaptor]

/* [E3D V6 Hotend] */
// tolerance for E3D V6 hotend clamp
HotEnd_E3D_mm = 0.3; // [-1:0.01:1.0]
// tolerance for hotend block recess in upper deck
HotEnd_recess_mm = 0.2;  // [0:0.01:1.0]
// tolerance for the slice between hotend and front blocks (on each)
HotEnd_slice_mm = 0.2;  // [0:0.01:1.0]

/* [Probe Holder] */
// Print which part?
Probe_Style = "none"; // [none:None,front:On front block]
// Probe Diameter (usually 18, 16, 12 or 10. 18mm is 'universal')
Probe_Diameter_mm = 18; // [5:0.5:25]
// Probe X offset from hotend centerline
Probe_XOffset_mm = 36;
// Probe Y offset from carriage rails
Probe_YOffset_mm = -33;  // [-40:1:-20]
// Probe Z offset from bottom rail
Probe_ZOffset_mm = -43; // [-40:1:-20]

/* [Cooling Fan Duct] */
// Duct Nozzle X Offset (adjust left-right to center duct on hotend )
Duct_Nozzle_XOffset_mm = 6; // [-10:1:10]
// Duct Nozzle Y Offset (increase to bring duct exit closer to hotend)
Duct_Nozzle_YOffset_mm = 16; // [10:1:20]

/* [Extruder Bowden Adapter] */
// What length M3 bolts attach the block to the extruder? (3mm of engagement assumed)
EBowden_Bolt_Length_mm = 6; // [6:1:18]

/* [General Tolerances] */
// expend vertical holes by this amount
VHole_expand_mm = 0.3;  // [0:0.01:1.0]
// expand horizontal holes by this amount
HHole_expand_mm = 0.3; // [0:0.01:1.0]
// stretch horizontal holes vertically by this amount
HHole_stretch_pc = 120; // [0:1:200]

// shink interlocking horizontal block faces by this amount
HBlock_shrink_mm = 0.2;  // [0:0.01:1.0]

/* [Hidden] */

// development modes
Mode = "customizer";
//Mode = "assembly";
//Mode = "animation";


// animation mode
//animation_mode = "none";
//animation_mode = "components.i3";
//animation_mode = "components.fade";
animation_mode = "components.assemble";
//animation_mode = "duct.scan";


// bearing block style
//bearing_block_style = "wanhao";
//bearing_block_style = "malyan";
bearing_block_style = Printer;

// x-belt vertical positions
upper_belt_z = 26.5;
lower_belt_z = 16.5;
// the x-carriage belt bolt positions 
x_carriage_bolt_z = 19;
x_carriage_bolt_x = 17.0;

// e3d mount point (nozzle point is offset, but matches original Mk10)
e3d_v6_x=0;
e3d_v6_y=-35;
e3d_v6_z=10;

// probe position
probe_x = Probe_XOffset_mm; // 36;
probe_y = Probe_YOffset_mm; // -33;
probe_z = Probe_ZOffset_mm; // -43;
probe_diameter = Probe_Diameter_mm + HHole_expand_mm;

top_block_offset = 18.5;

// blower fan position
cooling_fan_x =  9;
cooling_fan_y = -58;
cooling_fan_z =  4;
// blower fan bolt positions
cooling_fan_bolt_x = 21.5;
cooling_fan_bolt_y = -50;
cooling_fan_bolt_z = 19.5;

if(Mode == "customizer") {
	// printable custom parts
	if(Part == "belt") {
		// plate belt block
		rotate([90,0,0]) xcarriage_belt_block();
	} else if(Part == "upper") {
		// plate upper block
		translate([0,-10,34]) rotate([180,0,0]) xcarriage_upper_block();
	} else if(Part == "lower") {
		// plate lower block
		xcarriage_lower_block();
	} else if(Part == "hotend") {
		// plate hotend block
		translate([0,0,-24]) rotate([-90,0,0]) xcarriage_hotend_block();
	} else if(Part == "front") {
		// plate front block
		rotate([90,0,0]) xcarriage_e3d_block_front();
	} else if(Part == "fanduct") {
		// fan duct
		blower_duct();
	} else if(Part == "ebowden") {
		extruder_bowden_upgrade();
	} else if(Part == "platter-1") {
		// all at once
		upper_z = (bearing_block_style == "malyan") ? 33 : 34;
		lower_z = (bearing_block_style == "malyan") ? -12 : -11;
		//intersection() { translate([0,0,-0.4]) cube([200,200,1],center=true); // floor
			//union() {
				translate([42,10,1.3]) rotate([90,0,90]) xcarriage_belt_block(); // belt block
				translate([30,0,lower_z]) rotate([0,0,90])  xcarriage_lower_block(); // lower block
				translate([0,-10,upper_z])   rotate([180,0,0]) xcarriage_upper_block(); // upper block
				translate([-56,25,50])  rotate([90,0,0])  xcarriage_e3d_block_front(); // front block
				translate([-60,-30,-24.3])  rotate([-90,0,0]) xcarriage_hotend_block(); // hotend block
				translate([15,30,20])  blower_duct();
			//}
		//}    
	}
} else if(Mode == "assembly") {
	// part assembly
    difference() {    
        printer_components();
        // cutaway
        // color("red",0.1) translate([-10,0,0]) cube([20,150,150],center=true);
        // color("red",0.1) translate([-10,0,0]) cube([40,90,30],center=true);
    }
} else if(Mode == "animation") {
	// part animations
	if(animation_mode == "components.i3") {
		// animation fading in the i3 x-carriage style
		i3_mk2_x_carriage();
		xcarriage_i3mk2_extruder();
		translate([9,-55,5]) rotate([90,180,0]) blower_50mm(h=12);
	} else if(animation_mode == "components.assemble") {
		
		beltb_opacity = mix($t, 0.30,0.40, 0,1);
		
		rotate_top    = mix($t, 0.35,0.45, 0,90);
		rotate_bottom = mix($t, 0.40,0.50, 0,-90);
		
		prepare_x     = mix($t, 0.20,0.30, 0,1) * mix($t, 0.50,0.70, 1,0);
		
		/*
		duct_opacity = 0.6; //mix($t,0.3,0.4,1,0);
		probe_opacity = mix($t,0.3,0.4,1,0);
		hotend_opacity = mix($t,0.4,0.5,1,0);
		carriage_opacity = mix($t,0.5,0.6,1,0);
		limit_opacity = mix($t,0.55,0.65,1,0);
		*/
		carriage_opacity = 1;
		upper_opacity  = mix($t, 0.05,0.15, 0,1);
		lower_opacity  = mix($t, 0.10,0.20, 0,1);
		
		
		upper_x        = prepare_x*70; // mix($t, 0.45,0.60, 80,0);
		lower_x        = prepare_x*-60; // mix($t, 0.50,0.65, -80,0);

		clamp_back_opacity = mix($t, 0.70,0.80, 0,1);
		clamp_front_opacity = mix($t, 0.75,0.85, 0,1);
		
		extras_opacity = mix($t, 0.80,0.90, 0,1);
		hotend_opacity = extras_opacity;
		probe_opacity = extras_opacity;
		limit_opacity = extras_opacity;
		duct_opacity = extras_opacity;
		blower_opacity = extras_opacity;
		
		// basic upgrade components
		// show bolts
		if(clamp_back_opacity) {
			xcarriage_belt_bolts(opacity=clamp_back_opacity);
			xcarriage_bearing_bolts(opacity=clamp_back_opacity);
			xcarriage_e3d_bolts(opacity=clamp_back_opacity);
		}
		// carriage blocks
		if(beltb_opacity) xcarriage_belt_block(  opacity=beltb_opacity );
		if(lower_opacity>0) translate([lower_x,0,0]) rotate([rotate_bottom+90,0,0]) xcarriage_lower_block(  opacity=lower_opacity);
		
		if(upper_opacity>0) translate([upper_x,0,0]) 
			translate([0,0,45]) rotate([rotate_top-90,0,0]) translate([0,0,-45])
				color("orange",upper_opacity) render() xcarriage_upper_block( );
		if(clamp_back_opacity) color("orange",clamp_back_opacity) render() xcarriage_hotend_block();
		if(clamp_front_opacity) color("orange",clamp_front_opacity) render() xcarriage_e3d_block_front();
		// i3_x_carriage(rotate_top=rotate_top,rotate_bottom=rotate_bottom);
		// top rod + bearings
		translate([0,0,45]) i3_x_rod(opacity=carriage_opacity);
		translate([upper_x,0,0]) {
			translate([-top_block_offset,0,45]) lm8uu_bearing(opacity=carriage_opacity);
			translate([-top_block_offset,0,45]) rotate([180+rotate_top,0,0]) lm8uu_block(opacity=carriage_opacity);
			translate([+top_block_offset,0,45]) lm8uu_bearing(opacity=carriage_opacity);
			translate([+top_block_offset,0,45]) rotate([180+rotate_top,0,0]) lm8uu_block(opacity=carriage_opacity);
		}
		// lower rod + bearings
		translate([0,0,0]) i3_x_rod(opacity=carriage_opacity);
		translate([lower_x,0,0]) {
			lm8uu_bearing(opacity=carriage_opacity);
			rotate([180+rotate_bottom,0,0]) lm8uu_block(opacity=carriage_opacity);
		}
		// belts
		i3_x_beltthru(h=upper_belt_z,opacity=carriage_opacity);
		i3_x_beltends(h=lower_belt_z,opacity=carriage_opacity);
		
		if(hotend_opacity) e3d_v6_hotend(opacity=hotend_opacity);
		// limit switch
		if(limit_opacity) translate([-45,10,37]) limit_switch(opacity=limit_opacity);
		// proximity sensor
		if(probe_opacity) translate([probe_x,probe_y,probe_z]) proximity_sensor_8mm(opacity=probe_opacity);
		// blower fam
		if(blower_opacity) translate([cooling_fan_x,cooling_fan_y,cooling_fan_z]) rotate([90,180,0]) 
			blower_50mm(h=13,rgba=[0.1,0.1,0.1,blower_opacity]);
		// blower duct
		if(duct_opacity>0) color("orange",duct_opacity) translate([cooling_fan_x-15,cooling_fan_y,cooling_fan_z-27]) blower_duct();

		// show old hotend position
		// mk10_hotend();
	} else if(animation_mode == "components.fade") {
		blower_opacity = mix($t,0.2,0.3,1,0);
		duct_opacity = 0.6; //mix($t,0.3,0.4,1,0);
		probe_opacity = mix($t,0.3,0.4,1,0);
		hotend_opacity = mix($t,0.4,0.5,1,0);
		carriage_opacity = mix($t,0.5,0.6,1,0);
		limit_opacity = mix($t,0.55,0.65,1,0);
		
		front_y = mix($t,0.6,0.8,0,-60);
		hotend_y = mix($t,0.6,0.8,0,-30);
		belt_y = 0;// mix($t,0.7,0.8,0,50);
		
		upper_x = 0; // mix($t,0.75,0.85,0,80);
		lower_x = mix($t,0.7,0.9,0,-80);
		belt_x = mix($t,0.7,0.9,0,-80);
		// basic upgrade components
		// show bolts
		translate([belt_x,belt_y,0]) xcarriage_belt_bolts(opacity=carriage_opacity);
		xcarriage_bearing_bolts(opacity=carriage_opacity);
		translate([0,hotend_y,0]) xcarriage_e3d_bolts(opacity=carriage_opacity);
		// carriage blocks
		translate([belt_x,belt_y,0]) color("yellow",0.8) render() xcarriage_belt_block();
		translate([lower_x,0,0]) color("yellow",0.6) render() xcarriage_lower_block();
		translate([upper_x,0,0]) color("orange",0.7) render() xcarriage_upper_block();
		translate([0,hotend_y,0]) color("orange",0.6) render() xcarriage_hotend_block();
		translate([0,front_y,0]) color("orange",0.7) render() xcarriage_e3d_block_front();
		
		if(carriage_opacity) i3_x_carriage(rotate_top=90,rotate_bottom=-90,opacity=carriage_opacity);
		if(hotend_opacity) e3d_v6_hotend(opacity=hotend_opacity);
		// limit switch
		translate([-45,10,37]) limit_switch(opacity=limit_opacity);
		// proximity sensor
		if(probe_opacity) translate([probe_x,probe_y,probe_z]) proximity_sensor_8mm(opacity=probe_opacity);
		// blower fam
		if(blower_opacity) translate([cooling_fan_x,cooling_fan_y,cooling_fan_z]) rotate([90,180,0]) 
			blower_50mm(h=13,rgba=[0.1,0.1,0.1,blower_opacity]);
		// blower duct
		if(duct_opacity>0) color("orange",duct_opacity) translate([cooling_fan_x-15,cooling_fan_y,cooling_fan_z-27]) blower_duct();

		// show old hotend position
		// mk10_hotend();
	} else if(animation_mode == "duct.scan") {
		// scan slice
		intersection() {
			blower_duct();
			translate([0,0,$t*30 - 22]) cube([100,100,2],center=true);
		}
		// fan duct
		color("orange",0.2) blower_duct();
	}
}

// this is the main assembly view
module printer_components() {
    if(false) {
        i3_mk2_x_carriage();
        xcarriage_i3mk2_extruder();
        translate([9,-55,5]) rotate([90,180,0]) blower_50mm(h=12);
    }
    if(true) {
        i3_x_carriage(rotate_top=90,rotate_bottom=-90);
        // draw bolts
		xcarriage_belt_bolts();
		xcarriage_bearing_bolts();
		xcarriage_e3d_bolts();
		// carriage blocks
		color("yellow",0.7) render() xcarriage_belt_block();
		color("yellow",0.7) render() xcarriage_lower_block();
		color("orange",0.7) render() xcarriage_upper_block();
		color("orange",0.6) render() xcarriage_hotend_block();
		color("orange",0.7) render() xcarriage_e3d_block_front();
        // blower duct
        color("orange",0.7) translate([cooling_fan_x-15,cooling_fan_y+0,cooling_fan_z-27]) render() blower_duct();
		// hotend
        e3d_v6_hotend(opacity=0.2);
        // limit switch
        translate([-42.5,10,37]) limit_switch(opacity=0.2);
        // proximity sensor
        translate([probe_x,probe_y,probe_z]) proximity_sensor_8mm(opacity=0.2);
        // blower fam
        translate([cooling_fan_x,cooling_fan_y,cooling_fan_z]) rotate([90,180,0]) blower_50mm(h=13,opacity=0.2);
    }
    // show old hotend position
    mk10_hotend();
}



/* utility functions */

function mix_linear(v,i1,i2,o1,o2) =
    ( v < i1)
    ? o1
    : (v>i2)
        ? o2
        : (v-i1)/(i2-i1) * (o2-o1) + o1;

function mix(v,i1,i2,o1,o2) =
    ( i1<i2 ) 
    ? mix_linear(v,i1,i2,o1,o2) 
    : mix_linear(v,i2,i1,o2,o1);

function clamp_linear(v,c1,c2) =
    ( v < c1)
    ? c1
    : (v>c2)
        ? c2
        : v;

function clamp(v,c1,c2) =
    ( i1<i2 ) 
    ? clamp_linear(v,c1,c2) 
    : clamp_linear(v,c2,c1);

// bolt holes are oriented with the origin at the base of the head, on the central axis.
module bolt_hole(d=3,h=20,head_d=5.5,nut_d=7,nut_h=3,nut_trap=0,nut_rz=0, e=0.2, relief=50, head_break=-1 ) {
    color("orange") {
        // core 
        translate([0,0,head_break]) cylinder(d=d+e*2,h=h-head_break,$fn=30);
        // head 
        translate([0,0,-relief]) cylinder(d=head_d+e*2,h=relief,$fn=30);
        if(nut_d>0) { 
            if(nut_trap>0) {
                // nut trap
                // how wide must the trap be to be to capture the nut?
                trap_w = 2*e + sin(60)*nut_d;
                // how deep the trap be to stop the corner
                trap_d = nut_d/2 + e;
                // put a slot
                rotate([0,0,nut_rz]) translate([-trap_w/2,-trap_d,nut_trap]) cube([trap_w,trap_d+20,nut_h]);
            } else {
                // nut relief
                translate([0,0,h]) rotate([0,0,nut_rz]) cylinder(d=nut_d+e*2,h=relief,$fn=6);
            }
        }
    }
}

module hex_nut(h=2,d=5,rz=0) {
   color("silver") translate([0,0,0]) rotate([0,0,rz]) cylinder(d=d,h=h,$fn=6);
}

module hex_bolt(h=30,d=3,head_d=5,head_h=5,nut=-1,nut_h=2,nut_d=7,nut_rz=0) {
	color("DimGray") render() {
		// main bolt shaft
		translate([0,0,0]) cylinder(d=d,h=h,$fn=30);
		// bolt head
		difference() {
			translate([0,0,-head_h]) cylinder(d=head_d,h=head_h,$fn=30);
			translate([0,0,-head_h*1.5]) cylinder(d=d,h=head_h,$fn=6);
		}
		// end nut
		if(nut>=0) {
			translate([0,0,nut]) hex_nut(h=nut_h,d=nut_d,rz=nut_rz);
		}
	}
}

module hexcap_bolt(h=30,d=3,head_d=5,head_h=5,nut=-1,nut_h=2,nut_d=7,nut_rz=0) {
	color("DimGray") render() {
		// main bolt shaft
		translate([0,0,0]) cylinder(d=d,h=h,$fn=30);
		// bolt head
		difference() {
			union() {
				// cap sphere
				translate([0,0,0]) scale([1,1,head_h/head_d*2]) sphere(d=head_d,$fn=30);
			}
			// base cylinder
			translate([0,0,0]) cylinder(d=head_d+1,h=head_h+1,$fn=30);
			translate([0,0,-head_h*1.5]) cylinder(d=d,h=head_h,$fn=6);
		}
		// end nut
		if(nut>=0) {
			translate([0,0,nut]) hex_nut(h=nut_h,d=nut_d,rz=nut_rz);
		}
	}
}

// !hexcap_bolt(head_h=2);

module bolt_m3_8mm(nut=5.5,nut_rz=0) {
    hex_bolt(d=3,h=8,head_d=5,head_h=3,nut_d=6.5,nut=nut,nut_rz=nut_rz);
}
module bolt_hole_m3_8mm(nut=5.5,nut_trap=0,nut_rz=0, e=0.3, relief=50, head_break=-1) {
    bolt_hole(d=3,h=8,head_d=5,nut_d=7,nut=nut,nut_trap=nut_trap,nut_rz=nut_rz, e=e, relief=relief, head_break=head_break);
}

module bolt_m3_10mm(nut=7.5,nut_rz=0) {
    hex_bolt(d=3,h=10,head_d=5,head_h=3,nut_d=6.5,nut=nut,nut_rz=nut_rz);
}
module bolt_hole_m3_10mm(nut=7.5,nut_trap=0,nut_rz=0, e=0.3, relief=50, head_break=-1) {
    bolt_hole(d=3,h=10,head_d=5,nut_d=7,nut=nut,nut_trap=nut_trap,nut_rz=nut_rz, e=e, relief=relief, head_break=head_break);
}

module bolt_m3_20mm(nut=17.5,nut_rz=0) {
    hex_bolt(d=3,h=20,head_d=5,head_h=3,nut_d=6.5,nut=nut,nut_rz=nut_rz);
}
module bolt_hole_m3_20mm(nut=17.5,nut_trap=0,nut_rz=0, e=0.3, relief=50, head_break=-1) {
    bolt_hole(d=3,h=20,head_d=5,nut_d=7,nut=nut,nut_trap=nut_trap,nut_rz=nut_rz, e=e, relief=relief, head_break=head_break);
}

module bolt_m3_40mm(nut=37.5,nut_rz=0) {
    hex_bolt(d=3,h=40,head_d=5,head_h=3,nut_d=6.5,nut=nut,nut_rz=nut_rz);
}
module bolt_hole_m3_40mm(nut=37.5,nut_trap=0,nut_rz=0, e=0.3, relief=50, head_break=-1) {
    bolt_hole(d=3,h=40,head_d=5,nut_d=0,nut=nut,nut_trap=nut_trap,nut_rz=nut_rz, e=e, relief=relief, head_break=head_break);
}

module bolt_m4cap_7mm(nut=5,nut_rz=0) {
    hexcap_bolt(d=4,h=7,head_d=7,head_h=2,nut_d=7.5,nut=nut,nut_rz=nut_rz);
}
module bolt_hole_m4_7mm(nut=5,nut_trap=0,nut_rz=0, e=0.3, relief=50, head_break=-1) {
    bolt_hole(d=4,h=7,head_d=7.2,nut_d=7.5,nut=nut,nut_trap=nut_trap,nut_rz=nut_rz, e=e, relief=relief, head_break=head_break);
}

module lm8uu_bearing(opacity=1.0) {
    // low-res proxy
    // rotate([0,90,0]) cylinder(d=15,h=24,center=true);
    // segmented bearing
    // core
    difference() {
        union() {
            color("black",opacity) translate([-10,0,0]) rotate([0,90,0]) cylinder(d=10,h=4.5,center=true);
            color("black",opacity)  translate([-9,0,0]) rotate([0,90,0]) cylinder(d=14.5,h=5,center=true);
            color("silver",opacity) translate([0,0,0]) rotate([0,90,0]) cylinder(d=15,h=14,center=true);
            color("black",opacity)  translate([9,0,0]) rotate([0,90,0]) cylinder(d=14.5,h=5,center=true);
            color("black",opacity) translate([10,0,0]) rotate([0,90,0]) cylinder(d=10,h=4.5,center=true);
        }
        // bearing hole
        color("grey",opacity) rotate([0,90,0]) cylinder(d=8,h=25,center=true);
    }
    // ends
    difference() {
        union() {
            color("silver",opacity) translate([-10,0,0]) rotate([0,90,0]) cylinder(d=15,h=4,center=true);
            color("silver",opacity) translate([10,0,0]) rotate([0,90,0]) cylinder(d=15,h=4,center=true);
        }
        // ring hole
        color("grey",opacity) rotate([0,90,0]) cylinder(d=12,h=25,center=true);
    }
}

module lm8uu_bolt_holes() {
    // bolt holes
    translate([+9,0,+12]) rotate([90,0,0]) cylinder(d=4,h=30,center=true,$fn=60);
    translate([-9,0,+12]) rotate([90,0,0]) cylinder(d=4,h=30,center=true,$fn=60);
    translate([+9,0,-12]) rotate([90,0,0]) cylinder(d=4,h=30,center=true,$fn=60);
    translate([-9,0,-12]) rotate([90,0,0]) cylinder(d=4,h=30,center=true,$fn=60);
}

module lm8uu_wanhao_block(opacity=1.0) {
    difference() {
        union() {
            color("silver",opacity) translate([0,2,0]) cube([30,18,34],center=true);
            difference() {
                color("silver",opacity) translate([0,-2,0]) rotate([45,0,0]) cube([30,20,20],center=true);
                color("silver",opacity) translate([0,-16,0]) cube([40,10,40],center=true);
                color("silver",opacity) translate([0,10,0]) cube([40,10,40],center=true);
            }
        }
        // bearing hole
        color("grey",opacity) rotate([0,90,0]) cylinder(d=15,h=40,center=true);
        // circlip rings
        translate([+13,0,0]) color("black",opacity) rotate([0,90,0]) cylinder(d=16,h=1,center=true);
        translate([-13,0,0]) color("black",opacity) rotate([0,90,0]) cylinder(d=16,h=1,center=true);
        // bolt holes
        color("grey",opacity) lm8uu_bolt_holes();
    }
}

module lm8uu_malyan_block(opacity=1.0) {
	block_length = 26;
    difference() {
        union() {
            color("silver",opacity) translate([0,2,0]) cube([block_length,12,32],center=true);
            color("silver",opacity) translate([0,9,0]) cube([block_length,6,34],center=true);
            difference() {
                color("silver",opacity) rotate([0,90,0]) cylinder(d=22,h=block_length,center=true);
                color("silver",opacity) translate([0,-14.5,0]) cube([40,10,40],center=true);
                color("silver",opacity) translate([0,0,0]) cube([40,40,8],center=true);
            }
        }
        // bearing hole
        color("grey",opacity) rotate([0,90,0]) cylinder(d=15,h=40,center=true);
        // bolt holes
        // color("grey") lm8uu_bolt_holes();
        // upper T-channel
        color("black",opacity) translate([0,10,12]) cube([40,7,4],center=true);
        color("black",opacity) translate([0,9,12]) cube([40,3,7],center=true);
        // lower T-channel
        color("black",opacity) translate([0,10,-12]) cube([40,7,4],center=true);
        color("black",opacity) translate([0,9,-12]) cube([40,3,7 ],center=true);
        // chamfer
        color("silver",opacity) translate([0,-7,-18]) rotate([45,0,0]) cube([40,10,10],center=true);
        color("silver",opacity) translate([0,-7,18]) rotate([45,0,0]) cube([40,10,10],center=true);
    }
}


module lm8uu_block(opacity=0.6) {
    if(bearing_block_style == "wanhao") {
        lm8uu_wanhao_block(opacity=opacity);
    } else if(bearing_block_style == "malyan") {
        lm8uu_malyan_block(opacity=opacity);
    }
}

module limit_switch(opacity=1.0) {
    difference() {
        union() {
            // main body
            color("black",opacity) translate([-2,0,0]) rotate([0,0,0]) cube([4,12,6],center=true);
            color("white",opacity) translate([1.5,0,0]) rotate([0,0,0]) cube([3,12,6],center=true);
        }
        // bolt holes
        translate([1.5,-3,0]) color("grey",opacity) cylinder(d=1.5,h=10,center=true,$fn=12);
        translate([1.5,+3,0]) color("grey",opacity) cylinder(d=1.5,h=10,center=true,$fn=12);
    }
    // switch nub
    color("red",opacity) translate([-4,1,0]) rotate([0,0,0]) cube([2,1,1.8],center=true);
    // switch level
    color("silver",opacity) translate([-6,-2,0]) rotate([0,0,-15]) cube([1,16,2],center=true);
    // pins
    color("silver",opacity) translate([4,+4.5,0]) cube([4,1,2],center=true);
    color("silver",opacity) translate([4, 0,0]) cube([4,1,2],center=true);
    color("silver",opacity) translate([4,-4.5,0]) cube([4,1,2],center=true);
}


module i3_x_rod(opacity=1.0) {
    color("silver",opacity) rotate([0,90,0]) cylinder(d=8,h=300,center=true);
}


module i3_x_beltthru(h=0,opacity=1.0) {
    color("black",opacity) {
        translate([0,5,h]) cube([300,5,1],center=true);
    }
}

module i3_x_beltends(h=0,opacity=1.0) {
    color("black",opacity) {
        translate([-80,5,h]) cube([140,5,1],center=true);
        translate([80,5,h]) cube([140,5,1],center=true);
    }
}


module i3_x_carriage(rotate_top=0,rotate_bottom=0,opacity=1.0) {
    // top rod + bearings
    translate([0,0,45]) i3_x_rod(opacity=opacity);
    translate([-top_block_offset,0,45]) lm8uu_bearing(opacity=opacity);
    translate([-top_block_offset,0,45]) rotate([180+rotate_top,0,0]) lm8uu_block(opacity=opacity);
    translate([+top_block_offset,0,45]) lm8uu_bearing(opacity=opacity);
    translate([+top_block_offset,0,45]) rotate([180+rotate_top,0,0]) lm8uu_block(opacity=opacity);
    // lower rod + bearings
    translate([0,0,0]) i3_x_rod(opacity=opacity);
    lm8uu_bearing(opacity=opacity);
    rotate([180+rotate_bottom,0,0]) lm8uu_block(opacity=opacity);
    // belts
    i3_x_beltthru(h=upper_belt_z,opacity=opacity);
    i3_x_beltends(h=lower_belt_z,opacity=opacity);
}



module xcarriage_bearing_bolt_hole() {
    translate([0,-20,0]) rotate([90,0,0]) cylinder(d=3,h=80,center=true,$fn=60);
}

module xcarriage_bearing_bolt_holes() {
    // bolt holes
    translate([+9,0,+12]) xcarriage_bearing_bolt_hole();
    translate([-9,0,+12]) xcarriage_bearing_bolt_hole();
    translate([+9,0,-12]) xcarriage_bearing_bolt_hole();
    translate([-9,0,-12]) xcarriage_bearing_bolt_hole();
}

/* This block bolts onto the old extruder motor and provides an aligned bowden-connector sized hole,
   for easy upgrade of the old extruder into a "remote bowden" that can be zip-tied to the top of the frame. */
module extruder_bowden_upgrade(bolts=0) {
	// the bolt length determines the position of the bolt holes
	bolt_z = EBowden_Bolt_Length_mm -7.5 - 3;
	// show bolts?
	if(bolts) {
		translate([-15.5,0,bolt_z]) rotate([180,0,0]) hexcap_bolt(d=3,h=EBowden_Bolt_Length_mm,head_d=6,head_h=2,nut_d=6,nut=EBowden_Bolt_Length_mm-3);
		translate([+15.5,0,bolt_z]) rotate([180,0,0]) hexcap_bolt(d=3,h=EBowden_Bolt_Length_mm,head_d=6,head_h=2,nut_d=6,nut=EBowden_Bolt_Length_mm-3);
	}
	difference() {
		color("orange",0.4) union() {
			hull() {
				cube([38,9.5,15], center=true);
				cube([42,5.5,15], center=true);
			}
			hull() {
				translate([-5,4,2]) cube([12,1,10], center=true);
				translate([-5,6,2]) cube([10,1,8], center=true);
			}
		}
		// bolt holes
		translate([-15.5,0,bolt_z]) rotate([180,0,0]) bolt_hole(d=3,h=EBowden_Bolt_Length_mm,head_d=6.2,nut_d=0,nut=EBowden_Bolt_Length_mm-3, e=HHole_expand_mm);
		translate([+15.5,0,bolt_z]) rotate([180,0,0]) bolt_hole(d=3,h=EBowden_Bolt_Length_mm,head_d=6.2,nut_d=0,nut=EBowden_Bolt_Length_mm-3, e=HHole_expand_mm);
		// fillament path
		translate([-5,0,2]) rotate([90,0,0]) cylinder(d=2.2+VHole_expand_mm,h=20,$fn=30, center=true);
		// bowden connector 
		translate([-5,-3,2]) translate([0,0,0]) rotate([90,0,0]) cylinder(d=5.3+VHole_expand_mm,h=6,$fn=30, center=true);
	}
		
}


// this create a 'slice face' block of the given dimensions for doing boolean operations with
module notch_slice(h=50,edge_w=20,edge_off=10) {
    union() {
        // everything on the positive side
        translate([-100,0,-h/2]) cube([200,100,h]);
        // convex hull of front and back edges
        hull() {
            // add the edge flat
            translate([-edge_w/2,-edge_off,-h/2]) cube([edge_w,edge_off,h]);
            // and the back edge
            translate([-edge_w/2-edge_off,0,-h/2]) cube([edge_w+edge_off*2,1,h]);
        }
    }
}


module e3d_v6_mount_space(offy=e3d_v6_y,offz=e3d_v6_z,tolerance=HotEnd_E3D_mm) {
    translate([0,offy,offz]) {
        // bowden connector space
        translate([0,0,6]) cylinder(d=12+tolerance*2,h=30,$fn=60);
        // main mount space
        translate([0,0,3])  cylinder(d=16+tolerance*2,h=3.7+tolerance,$fn=60);
        translate([0,0,-4]) cylinder(d=12+tolerance*2,h=8,$fn=60);
        translate([0,0,-7]) cylinder(d=16+tolerance*2,h=4+tolerance,$fn=60);
        // lower body space
        translate([0,0,-37]) cylinder(d=24,h=30,$fn=60);
        // cube
        color("silver",0.5) translate([0,0,-22]) cube([24,24,30],center=true);
    }
}

module cooling_fan_30mm(opacity=1.0) {
    color([0.1,0.1,0.1,opacity]) {
        difference() {
            cube([8,30,30],center=true);
            // fan hole
            rotate([0,90,0]) cylinder(d=25,h=20,$fn=30,center=true);
            // bolt holes
            translate([0,12,12]) rotate([0,90,0]) cylinder(d=3,h=20,$fn=30,center=true);
            translate([0,-12,12]) rotate([0,90,0]) cylinder(d=3,h=20,$fn=30,center=true);
            translate([0,12,-12]) rotate([0,90,0]) cylinder(d=3,h=20,$fn=30,center=true);
            translate([0,-12,-12]) rotate([0,90,0]) cylinder(d=3,h=20,$fn=30,center=true);
        }
        // fan core
        rotate([0,90,0]) cylinder(d=15,h=8,$fn=30,center=true);
        // fan blades
        for(i=[0:6]) {
            rotate([i*360/7,0,0]) translate([0,0,10]) rotate([0,0,-60]) cube([6,1,8],center=true);
        }
    }
}

module e3d_v6_hotend(offy=e3d_v6_y,offz=e3d_v6_z,opacity=1.0) {
    color("silver",opacity) translate([0,offy,offz-14.5]) rotate([90,0,-90]) import("E3Dv6_HotEnd.stl");
    // color("black") translate([-8-16,offy-15,offz-36]) cube([8,30,30]);
    translate([-4-16,offy,offz-21]) cooling_fan_30mm(opacity=opacity);
}


module mk10_hotend() {
    color("red") translate([0,-35,-45]) linear_extrude(height=3, scale=3) circle(d=1);
}


module proximity_sensor_8mm(top_nut_h=45,bottom_nut_h=37,opacity=1.0) {
    color("blue",opacity) translate([4,0,62]) linear_extrude(height=10, scale=0.8) circle(d=8);
    color("blue",opacity) translate([0,0,0]) cylinder(d=17,h=63.5);
    color("silver",opacity) translate([0,0,11]) cylinder(d=18,h=45);
    // add the 27mm fastener nuts
    color("silver",opacity) translate([0,0,top_nut_h]) cylinder(d=27,h=2,center=true,$fn=6);
    color("silver",opacity) translate([0,0,bottom_nut_h]) cylinder(d=27,h=2,center=true,$fn=6);
}

module i3_mk2_x_carriage() {
    // top rod + bearings
    translate([0,0,45]) i3_x_rod();
    translate([-13,0,45]) lm8uu_bearing();
    translate([+13,0,45]) lm8uu_bearing();
    // lower rod + bearings
    translate([0,0,0]) i3_x_rod();
    lm8uu_bearing();
    // belts
    i3_x_beltthru(h=upper_belt_z);
    i3_x_beltends(h=lower_belt_z);
    // mk2 stl carriage files
    color("yellow",0.5) translate([-16.5,-12,0]) rotate([90,0,180]) import("E:/CAM/prusai3_mk2_stl/x-carriage.stl");
    // color("yellow",0.5) translate([18,-22,23]) rotate([-90,0,180]) import("E:/CAM/prusai3_mk2_stl/extruder-body.stl");
}


module xcarriage_i3mk2_extruder() {
    color("orange") translate([17,-18,30.5]) rotate([90,180,0]) import("E:/CAM/prusai3_mk2_stl/extruder-body.stl");
    color("orange") translate([4.0,-48,0]) rotate([-90,0,0]) import("E:/CAM/prusai3_mk2_stl/extruder-cover.stl");
    color("orange") translate([-1.5,-65.2,-25.2]) rotate([90,0,180]) import("E:/CAM/prusai3_mk2_stl/fan-nozzle.stl");
    translate([-0.5,0,0]) e3d_v6_hotend(offy=-32,offz=23.5);
}


module xcarriage_upper_bearing_bolt_holes(bolt_z = 30) {
    translate([+27,-12,bolt_z]) rotate([0,0,0]) bolt_hole_m4_7mm(); 
    translate([ +9,-12,bolt_z]) rotate([0,0,0]) bolt_hole_m4_7mm(); 
    translate([ -9,-12,bolt_z]) rotate([0,0,0]) bolt_hole_m4_7mm(); 
    translate([-27,-12,bolt_z]) rotate([0,0,0]) bolt_hole_m4_7mm(); 
    translate([+27,+12,bolt_z]) rotate([0,0,0]) bolt_hole_m4_7mm(); 
    translate([ +9,+12,bolt_z]) rotate([0,0,0]) bolt_hole_m4_7mm(); 
    translate([ -9,+12,bolt_z]) rotate([0,0,0]) bolt_hole_m4_7mm(); 
    translate([-27,+12,bolt_z]) rotate([0,0,0]) bolt_hole_m4_7mm(); 
}

module xcarriage_upper_bearing_bolts(bolt_z = 30) {
    translate([+27,-12,bolt_z]) rotate([0,0,0]) bolt_m4cap_7mm();
    translate([ +9,-12,bolt_z]) rotate([0,0,0]) bolt_m4cap_7mm();
    translate([ -9,-12,bolt_z]) rotate([0,0,0]) bolt_m4cap_7mm();    
    translate([-27,-12,bolt_z]) rotate([0,0,0]) bolt_m4cap_7mm();     
    translate([+27,+12,bolt_z]) rotate([0,0,0]) bolt_m4cap_7mm();
    //translate([ +9,+12,bolt_z]) rotate([0,0,0]) bolt_m4cap_7mm();
    //translate([ -9,+12,bolt_z]) rotate([0,0,0]) bolt_m4cap_7mm();      
    translate([-27,+12,bolt_z]) rotate([0,0,0]) bolt_m4cap_7mm(); 
}

module xcarriage_lower_bearing_bolt_holes(bolt_z = 15) {
    // bearing block bolts
    translate([+9,-12,bolt_z]) rotate([0,180,0]) bolt_hole_m4_7mm(); 
    translate([-9,-12,bolt_z]) rotate([0,180,0]) bolt_hole_m4_7mm(); 
    translate([+9,+12,bolt_z]) rotate([0,180,0]) bolt_hole_m4_7mm(); 
    translate([-9,+12,bolt_z]) rotate([0,180,0]) bolt_hole_m4_7mm(); 
}

module xcarriage_lower_bearing_bolts(bolt_z = 15) {
    translate([ +9,-12,bolt_z]) rotate([180,0,0]) bolt_m4cap_7mm(); 
    translate([ -9,-12,bolt_z]) rotate([180,0,0]) bolt_m4cap_7mm(); 
    //translate([ +9,+12,bolt_z]) rotate([180,0,0]) bolt_m4cap_7mm();
    //translate([ -9,+12,bolt_z]) rotate([180,0,0]) bolt_m4cap_7mm();
}

module xcarriage_bearing_bolts() {
    xcarriage_upper_bearing_bolts();
    xcarriage_lower_bearing_bolts();
}

module xcarriage_belt_bolts() {
    translate([+x_carriage_bolt_x,7,x_carriage_bolt_z]) rotate([90,0,0]) 
        bolt_m3_20mm(nut=17,nut_rz=0); 
    translate([-x_carriage_bolt_x,7,x_carriage_bolt_z]) rotate([90,0,0]) 
        bolt_m3_20mm(nut=17,nut_rz=0);        
}

module xcarriage_belt_bolt_holes(nut_d=6,stretch_v=1) {
    translate([+x_carriage_bolt_x,7,x_carriage_bolt_z]) scale([1,1,stretch_v]) rotate([90,0,0]) 
        bolt_hole(d=3,h=22,head_d=6,nut_d=nut_d,nut_trap=17,nut_h=4,nut_rz=-90);
    translate([-x_carriage_bolt_x,7,x_carriage_bolt_z]) scale([1,1,stretch_v]) rotate([90,0,0]) 
        bolt_hole(d=3,h=22,head_d=6,nut_d=nut_d,nut_trap=17,nut_h=4,nut_rz=90);        
}

// the center bolt goes through the whole carriage and clamps it all together
module xcarriage_center_bolt() {
    translate([xcarriage_center_bolt_x,xcarriage_center_bolt_y,xcarriage_center_bolt_z]) rotate([-90,0,0]) 
		bolt_m3_40mm(nut=28);     
}

module xcarriage_center_bolt_hole(h=34,nut_trap=14,nut_d=6,stretch_v=1) {
    translate([xcarriage_center_bolt_x,xcarriage_center_bolt_y,xcarriage_center_bolt_z]) scale([1,1,stretch_v]) rotate([-90,0,0]) 
		bolt_hole_m3_40mm(h=h);
}

xcarriage_e3d_bolt_x = 12;
xcarriage_e3d_bolt_y = -40;
xcarriage_e3d_bolt_z = e3d_v6_z + 0;

xcarriage_center_bolt_x = 0;
xcarriage_center_bolt_y = -26;
xcarriage_center_bolt_z = 20;


module xcarriage_e3d_bolt_holes() {
    // bolts to clamp front to back
    translate([-xcarriage_e3d_bolt_x,xcarriage_e3d_bolt_y,xcarriage_e3d_bolt_z]) rotate([-90,0,0]) 
        bolt_hole(d=3,h=17,head_d=6.5,nut_d=6.5,nut_rz=0, e=VHole_expand_mm, head_break=0.4);
    translate([+xcarriage_e3d_bolt_x,xcarriage_e3d_bolt_y,xcarriage_e3d_bolt_z]) rotate([-90,0,0]) 
        bolt_hole(d=3,h=17,head_d=6.5,nut_d=6.5,nut_rz=0, e=VHole_expand_mm, head_break=0.4);
}

module xcarriage_e3d_bolts() {
    // bolts to clamp front to back
    translate([+xcarriage_e3d_bolt_x,xcarriage_e3d_bolt_y,xcarriage_e3d_bolt_z]) rotate([-90,0,0]) 
        bolt_m3_20mm(nut=17); 
    translate([-xcarriage_e3d_bolt_x,xcarriage_e3d_bolt_y,xcarriage_e3d_bolt_z]) rotate([-90,0,0]) 
        bolt_m3_20mm(nut=17);      
    // bolt to clamp back to bottom
    xcarriage_center_bolt();
    
}

// belt block sub-parts

module xcarriage_belt_peg(d=9,h=10,bolt_d=3,bolt_relief_d=5.6,bolt_relief_h=4,e=VHole_expand_mm) {
    curve_resolution = 40;
    translate([0,+h-2,0]) difference() {
        union() {
            // 
            translate([0,0,0]) rotate([90,0,0]) cylinder(d=d,h=h-2,$fn=curve_resolution);
            translate([0,0,0]) rotate([-90,0,0]) linear_extrude(height=2, scale=(d-1.5)/d) circle(d=d,$fn=curve_resolution);
        }
        // bolt hole
        translate([0,+h+2,0]) rotate([90,0,0]) cylinder(d=bolt_d+e*2,h=h+10,$fn=30);
        // bolt relief
        translate([0,-bolt_relief_h+2,0]) rotate([-90,0,0]) cylinder(d=bolt_relief_d+e*2,h=bolt_relief_h+1,$fn=30);
    }
}


module xcarriage_belt_clamp(w=10,h=9,x=x_carriage_bolt_x+12.0,z=17,belt_z=lower_belt_z,belt_slot=2.5) {
    difference() {
        union() {
            //translate([x,h/2,z+3.0]) cube([w,h,5],center=true);
            //translate([x,h/2,z-4.3]) cube([w,h,5],center=true);
            translate([x,h/2,z]) cube([w,h,10],center=true);
        }
        translate([x-w/2-1.0,h/2,belt_z]) rotate([0,45,0]) cube([5,h+2,5],center=true);
        translate([x+w/2+1.8,h/2,belt_z]) rotate([0,45,0]) cube([5,h+2,5],center=true);
        translate([x,h/2,belt_z]) cube([w+2,h+2,belt_slot],center=true);
    }
}

module xcarriage_belt_bolthole(bolt_d=4,bolt_relief_d=6,bolt_relief_h=4) {
    curve_resolution = 40;
    // bolt hole
    translate([0,0,0]) rotate([90,0,0]) cylinder(d=bolt_d,h=60,$fn=curve_resolution);
    // bolt relief
    translate([0,-bolt_relief_h+2,0]) rotate([-90,0,0]) cylinder(d=bolt_relief_d,h=bolt_relief_h+1,$fn=curve_resolution);
}

// belt block
module xcarriage_belt_block(opacity=1.0,e=0.2) {
    color("yellow",opacity) difference() {
		union() {
			translate([0,1,0]) {
				// pegs for the timing belt
				translate([-x_carriage_bolt_x,0,x_carriage_bolt_z]) xcarriage_belt_peg();
				translate([+x_carriage_bolt_x,0,x_carriage_bolt_z]) xcarriage_belt_peg();
				// mirror the belt clamp
				for(mx=[-1,1]) scale([mx,1,1]) xcarriage_belt_clamp();
			}
			// add a support block to the inner edge
			translate([6,0,16]) rotate([0,180,0]) chamfered_block(size=[12,8,5],cd=2.0,ca=45,center=false);
			// if for the malyan, add 1mm more to the inner edge
			if (bearing_block_style == "malyan") hull() {
				translate([0,4.25+e/2,13]) cube([24,11.5-e,2],center=true);
				translate([0,4.25+e/2,12]) cube([30,11.5-e,1],center=true);
			}

			//
			difference() {
				union() {
					// peg support block
					hull() {
						translate([0,0+e/2,18]) cube([50,3-e,13],center=true);
						translate([0,0+e/2,17]) cube([56,3-e,11],center=true);
					}
					translate([0,0+e/2,17]) cube([68,3-e,10],center=true);
					// bearing plate
					translate([0,4.25+e/2,12]) cube([68,11.5-e,2],center=true);
				}
				// belt bolt holes
				xcarriage_belt_bolt_holes();
				// optional center hole, in case we have a long centre screw
				xcarriage_center_bolt_hole(h=30,nut_trap=0);
			}
		}
		// zip-tie channels
		for(mx=[-1,1]) scale([mx,1,0.9]) translate([29.0,4.5,18.25]) {
			rotate([0,90,0]) difference() {
				cylinder(d=25,h=3,center=true,$fn=30);
				cylinder(d=13,h=5,center=true,$fn=30);
			}
		}
		// if for the malyan, chop out 1mm more space for the bearing
		if (bearing_block_style == "malyan") hull() {
			translate([0,5,11]) cube([26,20,2],center=true);
			translate([0,5,9]) cube([32,20,2],center=true);
		}
    }
}

// main upper block. 
module xcarriage_upper_block(opacity=1.0) {
	symbol_offset = (bearing_block_style == "malyan") ? -0.4 : 0.0;
	upper_face = (bearing_block_style == "malyan") ? 38 : 39;
	cable_post_end = (bearing_block_style == "malyan") ? 14 : 13;
    color("orange",opacity) difference() {
        union() {
            difference() {
                union() {
                    // front edge bulk
                    translate([0,-11,30.5]) cube([68,19,7],center=true);
                    // bearing block plate
                    translate([0,4,32.0]) cube([68,26,4],center=true);
                    // connector tongue
					difference() {
						hull() {
							translate([0,-4,30]) cube([55,5,3],center=true);
							translate([0,-4,14.5]) cube([45,5,3],center=true);
						}
						// belt bolt holes, streched to compensate for overhang "compression" and add extre wiggle room
						xcarriage_belt_bolt_holes(stretch_v=1.4);
					}
                    // inner chamfer fills
                    translate([0,-21,26]) rotate([45,0,0]) cube([68,12,8],center=true);
                    translate([-34,-1.5,27]) rotate([45,0,0]) cube([68,6,3]);
                    // tractor chain plate
                    translate([-25,16,22]) cube([30,4,8]);
                    // chain plate chamfer
                    difference() {
                        translate([-25,17,34]) rotate([225,0,0]) cube([30,5,10]);
                        translate([-26,20,20]) cube([40,10,20]);
                    }
                    // cable post
                    translate([-5,16,cable_post_end]) cube([10,4,16]);
                    // zip-tie post
					hull() {
						translate([-5,16,cable_post_end+3]) cube([10,4,2]);
						translate([-6,14,cable_post_end-1]) cube([12,6,4]);
					}
                }
                // back vertical cable space
                translate([-3,18,0]) cube([6,4,40]);
                // cable space chamfer
                translate([-3,18,30]) rotate([45,0,0]) cube([6,10,14]);
                // bearing block bolts
                xcarriage_upper_bearing_bolt_holes();
                // bolt to clamp back to bottom
                xcarriage_center_bolt_hole(nut_trap=0, nut_d=0, stretch_v=1.2);
                // holes to bolt tractor chain (undersized)
                translate([-12,22,26]) rotate([90,0,0]) bolt_hole(d=2.3,h=10,head_d=0,nut_d=0,relief=0);
                translate([-20,22,26]) rotate([90,0,0]) bolt_hole(d=2.3,h=10,head_d=0,nut_d=0,relief=0);
            }
            xcarriage_e3d_block_back();
            xcarriage_limitswitch_plate();
        }
        // chamfer off front face
        // upper face chamfer
        translate([0,-34,48]) rotate([45,0,0]) cube([80,60,40],center=true);
        // upper face-off
        translate([0,0,upper_face]) cube([120,80,10],center=true);
        // lower under edge chamfer
        translate([0,-20,-20]) rotate([45,0,0]) cube([80,60,40],center=true);
     
        // chamfer off front lower corners
        for(m=[-1,1]) scale([m,1,1]) {
            translate([-35,-25,0]) rotate([0,-20,0]) cube([20,20,100],center=true);
            translate([-30,-30,0]) rotate([0,-20,0]) rotate([0,0,30])cube([20,20,100],center=true);
        }
        // ..actually, remove the whole damn e3d mounting 'ring' and leave a space to put it back later
        xcarriage_hotend_slice(e=-HotEnd_recess_mm);
        // remove excess plastic at the back of the plate with hex pockets
		intersection() {
			for(x=[-36,-18,0,18]) {
				translate([x,7,upper_face-16]) cylinder(d=12,h=10,$fn=6);
			}
			translate([0,7,upper_face-16]) cube([74,20,20],center=true); // near limit switch
		}
        // back corner chamfers
        translate([-50,18,38]) rotate([0,0,45]) cube([10,10,20],center=true); // near limit switch
        translate([+38,18,38]) rotate([0,0,45]) cube([10,10,20],center=true); 
		// emboss room for a logo
		translate([20,-25+symbol_offset,29+symbol_offset]) rotate([-135,0,0]) cylinder(d1=16,d2=11,h=1.2,center=true);
	}
	// stamp the front with the jedi symbol
	translate([20,-23.5+symbol_offset,29+symbol_offset]) rotate([90,0,0]) jedi_stamp();
}


// this juts out the side of the upper carriage block to hold the standard limit switch
module xcarriage_limitswitch_plate() {
    difference() {
        // bearing block plate
        translate([-38,0,32.0]) cube([16,34,4],center=true);
        // chamfer it into the main plate
        translate([-48,-7,32.0]) rotate([0,0,45]) cube([20,40,8],center=true);
        // bolt holes
		bolt_y = 2.75;
        translate([-41,10-bolt_y,32.0]) color("grey") cylinder(d=2.0,h=20,center=true,$fn=12);
        translate([-41,10+bolt_y,32.0]) color("grey") cylinder(d=2.0,h=20,center=true,$fn=12);
    }
}


module xcarriage_lower_block(opacity=1.0,e=HBlock_shrink_mm) {
	height = (bearing_block_style == "malyan") ? 13 : 14;
	base = (bearing_block_style == "malyan") ? 18.5 : 18;
    color("gold",opacity) {
        difference() {
			// bearing plate
			translate([0,-12.75,base]) cube([45,12.5-e*2,height],center=true);

            // edge chamfer
            translate([0,-15,29]) rotate([45,0,0]) cube([60,20,5],center=true);
            // belt bolt holes
            xcarriage_belt_bolt_holes(stretch_v=1.1);     
            // bearing block bolt holes
            xcarriage_lower_bearing_bolt_holes();
            // core bolt to clamp back to lower. Give it a lot of vertical stretch
            xcarriage_center_bolt_hole(stretch_v=1.5);
        }
    }
}

module chamfered_block(size=[10,10,10],cd=1.0,ca=45,center=false) {
    t = (center) ? (size/2) : [0,0,0];
    translate(-t) difference() {
        // main cube
        cube(size,center=false);
        // edge chamfer
        translate([-1,size.y - cd,0]) rotate([-ca,0,0]) cube(size+[2,0,0],center=false);
    }
}


module blower_duct(nozzle_x=Duct_Nozzle_XOffset_mm, nozzle_y=Duct_Nozzle_YOffset_mm) {
    translate([0,0,-10]) {
        difference() {
            union() {
                hull() {
                    // outer wall
                    rotate([0,0,180]) chamfered_block(size=[18,14,20],cd=6.0,ca=30, center=true);
                    // fan connection stub
                    translate([0,0,11]) cube([16.5,12.5,2], center=true);
                }
                // fan connection
                translate([0,0,14]) cube([16.5,12.5,5], center=true);
                // exit duct
                hull() {
                    translate([0,0,0]) cube([16,1,18], center=true);
                    translate([0,0,0]) cube([14,1,20], center=true);
                    translate([nozzle_x,nozzle_y-5,-5]) cube([36,4,8], center=true);
                    translate([nozzle_x,nozzle_y-5,-5]) cube([34,4,10], center=true);
                    translate([nozzle_x,nozzle_y-4,-5]) cube([34,4,8], center=true);
                }

            }
            hull() {
                // inner space wall
                translate([0,0,0]) rotate([0,0,180]) chamfered_block(size=[16,11,16],cd=5.0,ca=30, center=true);
                // fan connection stub
                translate([0,0,19]) cube([14,10,1], center=true);
            }
            // fan connection
            translate([0,-12.5,10]) cube([14,10,20], center=true);
			// exit duct
			hull() {
				translate([0,1,-1]) cube([14,1,14], center=true);
				translate([0,1,-0]) cube([12,1,16], center=true);
				translate([nozzle_x,nozzle_y-5,-5]) cube([32,3,6], center=true);
				translate([nozzle_x,nozzle_y-5,-5]) cube([30,3,8], center=true);
			}
            // blower holes
            intersection() {
                // overall blower exit area
				union() {
					// front face exit
					translate([nozzle_x,nozzle_y-2,-4]) cube([30,4,10], center=true);
					// underside chamfered exit
					translate([nozzle_x,nozzle_y-0.5,-10.5]) rotate([45,0,0]) cube([30,5,10], center=true);
				}
                union() {
                    // translate([exit_offset-17-8,0,3]) rotate([-20,0,0]) cube([30,10,6]); // tmp
                
                    // left hexagonal port
                    translate([nozzle_x+10.5,nozzle_y-2,-9]) rotate([90,30,0]) cylinder(d=12,h=8,$fn=6, center=true);
                    // right hexagonal port
                    translate([nozzle_x-10.5,nozzle_y-2,-9]) rotate([90,30,0]) cylinder(d=12,h=8,$fn=6, center=true);
                }
            }
        }
        // add back a divider to support the chimney
        hull() {
            translate([0,5,0]) cube([2,1,18], center=true);
            translate([nozzle_x,nozzle_y-3,-5]) cube([2,2,8], center=true);
        }
        // add the warning text to the front
        color("orange") intersection() {
            translate([0,0,-6]) rotate([90,0,0]) scale(0.5) hotend_warning_text(height=20);
            // intersect with a thin layer at the interface, so the overhangs are better
            translate([0,-3.2,-6]) rotate([30,0,0]) cube([30,0.8,20],center=true);    
        }
        // add the warning symbol
        color("orange") translate([0,-6.3,4.4]) rotate([90,0,0]) scale([0.58,0.52,0.5]) hotend_warning_symbol(height=2);
    }
}

module hotend_warning_text(height=3) {
    // add the warning text to the front
    linear_extrude(height=height) text("HOT!",size="10",font="Arial:style=Bold",halign="center",valign="center",spacing=1.0);
}

module hotend_warning_symbol(height=3) {
	//minkowski() {
		linear_extrude(height=height) {
			// do the triangle outline
			rotate([0,0,-30]) difference() {
				// outer border
				minkowski() {
					circle(r=11,$fn=3);
					circle(r=1.5,$fn=12);
				}
				// inner triangle
				circle(r=10,$fn=3);
			}
			scale([1.2,0.8])
			for(x=[0,2.4,4.8])
				translate([x,-1,0]) rotate([0,0,90]) scale(1.2) text("~",size="12",font="",halign="center",valign="center");
		}
		//sphere(r=0.5,$fn=8);
	//}
}


module xcarriage_e3d_slice(e=0.0) {
    // offy=e3d_v6_y,offz=e3d_v6_z
    translate([0,e3d_v6_y+5+e,16]) notch_slice(h=60,edge_w=15,edge_off=5);
}

module xcarriage_hotend_slice(e=0.0) {
    translate([0,-34-e,16]) rotate([0,0,180]) notch_slice(h=60,edge_w=14,edge_off=10);
}

module xcarriage_e3d_block_back(e=HotEnd_slice_mm) {
    difference() {
       intersection() {
            // main box
            translate([0,-34,xcarriage_e3d_bolt_z+12]) cube([68,30,36],center=true);
            // with an outward notch
            xcarriage_e3d_slice(e);
        }
        // take away mount space
        e3d_v6_mount_space();
        // bolt holes
        xcarriage_e3d_bolt_holes();
        xcarriage_center_bolt_hole(nut_trap=0);
    }
}

module xcarriage_e3d_block_front(e=HotEnd_slice_mm) {
    difference() {
        difference() {
            union() {
                // clamp block
                translate([0,-36,xcarriage_e3d_bolt_z+2]) difference () {
                    intersection() {
                        // main box
                        cube([40,30,16],center=true);
                        // with an outward notch
                        translate([0,-6,0]) notch_slice(h=50,edge_w=32,edge_off=8);
                    }
                    // chamfer the edges
                    for(sx=[-1,1]) scale([sx,1,1]) {
                        // top edge
                        translate([20,-10,8]) rotate([0,45,0]) cube([40,40,10],center=true);
                        // bottom edge
                        translate([20,-10,-12]) rotate([0,-45,0]) cube([40,40,10],center=true);
                        
                    }
                }
                // upper fan bolt support
                difference(){
                    hull(){
                       translate([cooling_fan_x-18, cooling_fan_bolt_y, cooling_fan_z+10]) 
                            rotate([-90,0,0]) cylinder(r=6,h=3,$fn=30);
                       translate([cooling_fan_x - cooling_fan_bolt_x, cooling_fan_bolt_y, cooling_fan_z + cooling_fan_bolt_z]) 
                            rotate([-90,0,0]) cylinder(r=4,h=3,$fn=30);
                    }
                    // bolt hole
                    translate([cooling_fan_x - cooling_fan_bolt_x, cooling_fan_bolt_y-1, cooling_fan_z + cooling_fan_bolt_z]) 
                            rotate([-90,0,0]) cylinder(d=3.5,h=10,$fn=30);
               }
               // lower fan bolt support
               difference(){
                    hull(){
                       translate([cooling_fan_x+2, cooling_fan_bolt_y, cooling_fan_z+6]) 
                            rotate([-90,0,0]) cylinder(r=6,h=3,$fn=30);
                       translate([cooling_fan_x + cooling_fan_bolt_x, cooling_fan_bolt_y, cooling_fan_z - cooling_fan_bolt_z]) 
                            rotate([-90,0,0]) cylinder(r=4,h=3,$fn=30);
                    }
                    // bolt hole
                    translate([cooling_fan_x + cooling_fan_bolt_x, cooling_fan_bolt_y-1, cooling_fan_z - cooling_fan_bolt_z]) 
                            rotate([-90,0,0]) cylinder(d=3.5,h=10,$fn=30);
               }
            }
            // take away mount space
            e3d_v6_mount_space();
            // bolt holes
            xcarriage_e3d_bolt_holes();            
        }
        xcarriage_e3d_slice(-e);
    }
    // inductive probe support
	if(Probe_Style == "front") difference() {
		union() {
           hull() {
				translate([10,-44,xcarriage_e3d_bolt_z-0]) cube([4,12,6],center=true);
				translate([probe_x-13,-44,xcarriage_e3d_bolt_z-12]) cube([4,12,6],center=true);
           }
           hull() {			   
				translate([probe_x-13,probe_y/2-30,xcarriage_e3d_bolt_z-12]) cube([4,40+probe_y,6],center=true);
				translate([probe_x+Probe_Diameter_mm/2,probe_y/2-30,xcarriage_e3d_bolt_z-12]) cube([4,40+probe_y,6],center=true);
           }
           hull() {			   
				translate([probe_x-13,probe_y/2-30,xcarriage_e3d_bolt_z-12]) cube([4,40+probe_y,6],center=true);
				translate([probe_x+Probe_Diameter_mm/2,probe_y/2-25,xcarriage_e3d_bolt_z-12]) cube([4,40+probe_y,6],center=true);
				translate([probe_x,probe_y,xcarriage_e3d_bolt_z-12]) cylinder(d=Probe_Diameter_mm+12,h=6,$fn=30,center=true);
           }
		}
		// inductive probe hole
		translate([probe_x,probe_y,xcarriage_e3d_bolt_z-12]) cylinder(d=probe_diameter,h=10,$fn=30,center=true);
        // bolt holes
        xcarriage_e3d_bolt_holes();            
   } else difference() {
	   // no probe. Add some support for the fan arm
	   hull() {
			translate([10,-44,xcarriage_e3d_bolt_z-0]) cube([4,8,6],center=true);
			translate([probe_x-16,-48,xcarriage_e3d_bolt_z-12]) cube([4,4,6],center=true);
	   }
       // bolt holes
       xcarriage_e3d_bolt_holes();            
   }
}

// ..actually, remove the whole damn e3d mounting 'ring' and leave a space to put it back later
module xcarriage_hotend_block() {
    intersection() {
        difference() {
            // the sliced-off back half of the e3d collar
            xcarriage_e3d_block_back();
            // upper face chamfer
            translate([0,-34,44]) rotate([30,0,0]) cube([80,60,40],center=true);
        }
        xcarriage_hotend_slice(e=0);
    }
}

module i3_upgrade_x_carriage() {
    // show bolts
    xcarriage_belt_bolts();
    xcarriage_bearing_bolts();
    xcarriage_e3d_bolts();
    // carriage blocks
    xcarriage_belt_block(  opacity=0.8 );
    xcarriage_lower_block(  opacity=0.6 );
    color("orange",0.7) xcarriage_upper_block( opacity=0.6 );
    color("orange",0.6) xcarriage_hotend_block();
    color("orange",0.7) xcarriage_e3d_block_front();
}

module jedi_symbol_polygons() {

	jedi_symbol_path_1 = 
		 [[-3.655488,50.461232],[-4.166450,49.911655],[-4.391801,49.059091],[-4.003627,46.226542],[-2.750836,39.952400],[-2.465032,35.406622],
		 [-2.672078,34.017861],[-3.105664,33.344381],[-3.760721,33.480577],[-4.632181,34.520847],[-5.858143,35.950702],[-7.928546,37.815174],
		 [-10.077507,39.290872],[-11.077794,39.664613],[-10.326737,37.744139],[-7.753446,33.723343],[-6.065036,30.983221],[-5.772058,30.039872],
		 [-5.883560,29.337017],[-6.427288,28.841672],[-7.430990,28.520852],[-10.929299,28.270847],[-14.307101,27.855752],[-15.949773,27.286289],
		 [-14.579311,26.565806],[-11.339502,25.786302],[-4.573784,24.909158],[-4.509845,24.475838],[-4.968177,23.450252],[-7.117760,20.235675],
		 [-11.282291,14.520847],[-11.622933,13.407106],[-10.757297,13.399358],[-8.981648,14.387623],[-6.592251,16.261917],[-3.185611,19.252987],
		 [-2.564099,13.511917],[-0.936587,-14.729153],[0.749068,-44.229153],[1.428724,-51.229153],[2.725220,-46.844475],[3.325650,-43.101406],
		 [3.741136,-36.250202],[4.099094,-11.094475],[4.272318,11.057284],[4.580131,20.270847],[9.277246,16.283313],[13.383159,12.874723],
		 [14.556765,12.242199],[15.126335,12.297616],[15.078517,13.021042],[14.399960,14.392547],[11.097221,19.000072],[8.478993,22.712642],
		 [7.828862,23.988363],[7.763887,24.630700],[9.415470,25.087302],[12.487368,25.286160],[15.814803,25.531552],[17.884566,26.120482],
		 [18.342676,26.488266],[18.360197,26.875325],[16.905236,27.618455],[13.990548,28.063930],[10.261175,28.257192],[5.951650,28.270842],
		 [10.172346,33.276338],[12.996499,36.968183],[13.859548,38.815328],[12.139277,38.166599],[8.752468,35.857726],[4.178883,32.366629],
		 [3.496323,36.918262],[3.462841,41.265006],[3.988537,45.390937],[4.514779,48.447877],[4.557988,50.291407],[3.217554,50.964745],
		 [0.837950,51.229153],[-1.735003,51.067144],[-3.655488,50.461227]];
	jedi_symbol_path_2 = 
		[[3.266121,27.296551],[2.966224,26.562746],[2.221354,25.808405],[0.454849,24.900380],[-0.570882,25.019880],[-1.229300,25.595452],
		[-1.439110,26.512547],[-1.119020,27.656618],[-0.579290,28.342709],[0.122433,28.753529],[0.827805,28.843862],[1.378480,28.568490],
		[2.538310,28.028499],[3.048008,27.790292],[3.266121,27.296551]];
		
	jedi_symbol_path_3 = 
		[[-16.487980,47.829352],[-23.934324,44.436856],[-25.984503,43.389014],[-28.630428,41.636862],[-34.878306,36.725737],[-41.015546,31.115700],
		[-45.379734,26.218973],[-50.009582,18.822307],[-53.377649,11.720261],[-54.407846,8.738771],[-54.905796,6.381796],[-54.799231,4.832956],
		[-54.496672,4.418968],[-54.015883,4.275872],[-52.752228,5.270974],[-51.003802,7.663454],[-48.681172,11.026340],[-47.158053,12.553679],
		[-46.804629,12.570242],[-46.781064,12.057387],[-47.896823,9.349379],[-48.886560,6.934411],[-49.691545,4.020734],[-50.694731,-2.665817],
		[-50.801330,-9.436414],[-50.485581,-12.455149],[-49.906289,-15.017198],[-48.608461,-18.631861],[-47.679454,-20.028884],[-47.353761,-19.895586],
		[-47.120874,-19.207646],[-46.934324,-16.167526],[-46.755981,-12.880846],[-46.232348,-9.691242],[-45.380517,-6.635033],[-44.217580,-3.748537],
		[-42.760628,-1.068074],[-41.026756,1.370037],[-39.033053,3.529478],[-36.796614,5.373930],[-34.009564,7.358485],[-35.117036,4.067178],
		[-37.165506,-0.430323],[-37.653130,-1.568518],[-37.504102,-2.611225],[-37.377197,-3.484120],[-37.918012,-4.214047],[-38.635701,-5.516754],
		[-38.909349,-7.688660],[-38.721671,-9.857075],[-38.055380,-11.149311],[-37.576212,-12.789104],[-37.658431,-15.968769],[-37.679182,-20.175964],
		[-37.052246,-24.286200],[-36.335481,-26.153170],[-35.221930,-28.173660],[-32.412077,-32.037280],[-29.837898,-34.601220],[-29.018940,-34.997108],
		[-28.714603,-34.589635],[-28.485419,-32.902103],[-28.203816,-32.859589],[-27.823479,-33.211729],[-25.503873,-36.474128],[-23.295929,-38.769441],
		[-21.845430,-39.724128],[-21.649477,-39.566316],[-21.789461,-39.136628],[-22.934324,-37.724128],[-24.369299,-35.944441],[-25.010835,-34.474128],
		[-25.617458,-31.224128],[-26.395243,-27.155925],[-26.627191,-23.005233],[-26.338052,-18.867269],[-25.552582,-14.837250],[-24.295533,-11.010393],
		[-22.591659,-7.481915],[-20.465711,-4.347034],[-17.942445,-1.700966],[-15.053303,0.822196],[-19.876808,6.321203],[-22.352840,9.473334],
		[-24.399977,12.766230],[-26.001498,16.137375],[-27.140680,19.524255],[-27.800804,22.864354],[-27.965147,26.095158],[-27.616989,29.154151],
		[-26.739607,31.978819],[-24.611585,35.758706],[-21.601487,39.621866],[-18.233299,42.975435],[-15.031002,45.226551],[-12.072415,46.972472],
		[-10.066584,48.601847],[-9.314096,49.805904],[-9.501788,50.151947],[-10.115535,50.275872],[-12.575707,49.557208],[-16.487980,47.829352]];
	jedi_symbol_path_4 = 
		[[10.065676,49.397192],[11.018209,48.382074],[13.308340,47.175362],[16.917529,45.124804],[20.588737,42.103481],[23.854525,38.554149],
		[26.247450,34.919565],[27.394855,32.234654],[27.831885,29.291989],[27.591373,24.859338],[26.706151,17.704469],[26.076208,15.693005],
		[24.648479,13.189156],[22.401967,10.161312],[19.315676,6.577861],[17.020847,3.869029],[16.067320,2.385993],[17.227905,0.864184],
		[20.015940,-1.937866],[22.085618,-4.348120],[23.814116,-7.265362],[25.203721,-10.545116],[26.256718,-14.042906],[26.975393,-17.614256],
		[27.362034,-21.114690],[27.418924,-24.399731],[27.148352,-27.324905],[26.241962,-31.592844],[25.245010,-35.234982],[24.627493,-37.655868],
		[24.607898,-38.222263],[24.859412,-38.260052],[27.307276,-35.105709],[31.081998,-29.042470],[34.546992,-22.872957],[36.065676,-19.399790],
		[36.526725,-18.006672],[37.635196,-16.666429],[38.599875,-15.181645],[38.700756,-13.436663],[38.607674,-11.384245],[39.091596,-9.155957],
		[39.334518,-6.162654],[38.840575,-2.005972],[37.906500,1.683675],[37.367142,2.843856],[36.829026,3.275872],[36.289911,3.863372],[36.065676,5.275872],
		[36.381279,6.817098],[36.778388,7.125331],[37.337352,7.124751],[38.947795,6.195464],[41.226506,4.025872],[43.638457,1.063852],[45.413696,-2.102652],
		[46.683150,-5.767394],[47.577746,-10.224128],[48.336036,-15.224128],[49.809716,-11.724128],[50.474490,-9.469729],[50.868984,-6.647148],
		[50.895580,-0.028448],[49.986399,6.669952],[49.211172,9.592159],[48.238336,11.986034],[46.552360,15.458252],[46.297834,16.645803],
		[47.532894,15.554388],[50.315676,12.189706],[52.620696,9.368786],[53.944761,8.068458],[54.337042,7.924957],[54.601814,8.085336],[54.905796,9.216038],
		[54.775458,10.782646],[54.109703,13.019250],[51.538614,18.786860],[47.925860,25.087689],[44.004776,30.490556],[39.150510,35.449424],
		[33.468052,40.044709],[27.283214,44.040544],[20.921810,47.201062],[16.107828,49.080544],[12.722444,50.067267],[10.722710,50.169920],
		[10.229040,49.892436],[10.065676,49.397192]];

	// get ranges for when the paths are concatenated
	path_points_1 = [1:len(jedi_symbol_path_1)-1];
	path_points_2 = [len(jedi_symbol_path_1):len(jedi_symbol_path_1)+len(jedi_symbol_path_2)-1];

	// turn the ranges into lists
	path_list_1 = [ for (i = path_points_1) i ];
	path_list_2 = [ for (i = path_points_2) i ];
	// saber with hole
	polygon(points = concat(jedi_symbol_path_1,jedi_symbol_path_2), paths = [path_list_1,path_list_2], convexity=10 );
	// wings
	polygon(jedi_symbol_path_3);
	polygon(jedi_symbol_path_4);
}

module jedi_symbol(height=1) {		
	if(false) {
		// The old super-slow way
		linear_extrude(height=height) scale(0.1) projection(cut=true) { 
			translate([0,0,50]) surface(
				file = "Jedi Knight Symbol.mono.png", 
				center = true, 
				invert=true 
			);
		}
	} else {
		/* the new super-fast way with no external dependancies */
		linear_extrude(height=height) scale(0.1) rotate([0,0,180]) jedi_symbol_polygons();
	}
}

module jedi_stamp() {	
	intersection() {
		translate([0,0,-10]) scale([0.85,1/sqrt(2),1]) jedi_symbol(height=30);
		rotate([-45,0,0]) cube([100,100,2],center=true);
	}
}

// import the blower fan proxy
//use <blower_50mm.scad>
/*
*
* 50mm 12V Blower Proxy Model
*
* Author: R Sutherland
*
* License: CC BY-SA 4.0
* License URL: https://creativecommons.org/licenses/by-sa/4.0/
*
*/

// blower_50mm();

module c_fan(radius, height, opacity=1.0) {
	$fn = 80;
	color([0.1,0.1,0.1,opacity]) {
		cylinder(r=radius,h=1,center=true);

		rotate([0,0,$t*10]) for (theta= [0:10:350]) {
			rotate([0.0,0.0,theta]) {
				translate([radius-(radius*0.15),0.5,0.0]) rotate([0,0,15]) cube([radius*0.3,1.0,height-2.0],center=true);
			}
		}

		cylinder(r=radius*0.6,h=height-1,center=true);
		cylinder(r=radius*0.1,h=height,center=true);
	}
}

module blower_50mm(h=19.0, opacity=1.0){
	$fn = 80;

   c_fan(radius=22.0, height=h,opacity=opacity);

    color([0.1,0.1,0.1,opacity]) difference(){
        hull(){
           translate([21.5,-19.25,0]) cylinder(r=3.25,h=h,center=true);
           translate([-21.5,19.25,0]) cylinder(r=3.25,h=h,center=true);
        }
       translate([21.5,-19.25,0]) cylinder(r=2.25,h=h+2.5,center=true);
       translate([-21.5,19.25,0]) cylinder(r=2.25,h=h+2.5,center=true);
       cylinder(r=24, h=h+4,center=true);
   }

   color([0.1,0.1,0.1,opacity]) difference(){
       translate([12,12.5,0])  cube([26.0,25.0,h],center=true);
       translate([13.0,12.5,0])  cube([20,26.0,h-4],center=true);
       cylinder(r=18.0,0.0, h=h+3,center=true);
   }

   color([0.1,0.1,0.1,opacity]) difference(){
       cube([50.0,50.0,h],center=true);
       cylinder(r=18.0,0.0, h=h+1,center=true);
       cylinder(r=23.5, h=h-4,center=true);
       translate([12,13.5,0.0]) cube([23.0,27.0,h-4],center=true);
       rotate_extrude () {
           translate([25,-11,0]) square(22);
       }
   }
}

