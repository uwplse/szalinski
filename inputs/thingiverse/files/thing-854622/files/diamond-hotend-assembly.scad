//
// Diamond Hotend Assembly
// 
// This is an OpenSCAD script for generating the parts necessary for proper operation of The Diamond Hotend by RepRap.me
// for further info see http://reprap.org/wiki/Diamond_Hotend
//
// This code is published under Creative Commons CC-BY-SA license 2015 for RepRap.me by Kharar
// In plain english this means that you may download, use and modify this code as you like as long as you make your new version available under the same license
// For further info see http://creativecommons.org/licenses/
//

//Some modifications have been made by Jeffrey Black to add mounting options for rostock printers. (things prefixed with "rostock")
//Uses 6 measurements (rostock_holed1, rostock_holed2, rostock_sup_R rostock_platform_w1, rostock_platform_pivot_r and rostock_platform_pivot_R) reverse engineered from the cad files for the Rostock MAX Delta 3D printer from by SeeMeCNC distributed under GPL.


assembled = false;				// for normal render mode set false - to see assembled with metal parts set true

//allows printing of just hotend without blower mounts.
print_blower=0;

metalPartsOnly = false;			// render hotend and coldend only (for subtractive purposes) NB. All coldend sirfaces are added with the tolerance.

// holes for zip-tie mounting of the coldends
ziptie_enable = 1;

// Experimental: optional 5015S blower fan for cooling extruded material (optimal positioning still untested) 1 is for 1, 2 is for 2.
blower_enable = 2;

//Adds mount for the Mini Differential IR height sensing board.
IR_enable = 0;

//adds holes for m3 nuts for the pivots.
m3_nut_enable=0;

//Makes the mounts for the arms bevelled.
bevel_enable=1;
//bevel wall thickness
bevel_wt=1;
//bevel height
bevel_height=5;

//Experimental: Set's up mounting for a rostock style printer. 1 for V1, 2 for V2, 3 for direct connection to arms, 4 for elevated connection to arms
rostock = 4;


//Cuts out a bit more in the top for the rostock hotends to allow better passage of the bowden tubes.
rostock_extra_cut = 1;

// plastic/metal parts fitting tolerance Note: Does not apply to the arm mounts.
tolerance = 0.1;

//Determines if the base is a full circle ring or just partial; default is 1
fullcircle=1;

//Sets the thickness of the arms joining the circular base to the top of the hotend mount. - default is 2.5
rostock_support_wall=2.5;

//adds an offset (in mm) to move the supports in or out. Default 0.
rostock_extra_support_offset=0;

//sets the radius and height of a circle which is shaved off the top to remove any extruding support bits.
sup_cut_r=30;
sup_cut_h=1;

//radius for the holes for the support arm connectors - default is 1.58753
rostock_platform_pivot_r=1.58753;

//diameter for the holes for the IR mount.
IR_d=2.5;
//vertical offset for the IR mount.
IR_V_off=16;
//The depth of the holes for the IR mount.
IR_hole_depth=5;

//Wire hole for the IR probe.
IR_wire_pos=[-18,0,36.5];
IR_wire_w=6;
IR_wire_d=3;
IR_wire_h=14;

//The width of the nut, flat to flat.
m3_width=5.5;
//the thickness of the nut.
m3_height=3;
//how far in the nut is from the end.
m3_in_off=8.5;
//allows setting the nut deeper if needed.
m3_ed=1;


// internal variables, generally you don't need to change these

$fn = 100;

angle = 28;						// filament entrance bore angle

coldend_offset = (24.5-5)+7;	// total distance from point of origin at center joint chamber to the lower side of cooling fins

flange_offset2 = -1;			// lower air stop

wall = 2.5;						// general wall thickness
wall_thin = 1;					// fine details

fan_pos = 68.5;					// cooling fan distance to origin
fan_plate = 3.5;				// cooling fan mounting bracket thickness
fan_width = 50;					// cooling fan outer dimensions (works with 40 or 50 only!)

flange_h = 24;					// conical funnel part
radius_up = fan_width/2-2;		// funnel radius at upper end
radius_lo = 24/2;				// funnel radius at lower end
radius_lo_center = 3.5;			// hole for wires at lower end

mounting_offset = 10;			// Mounting holes offset (effective nozzle height adjustment)
mounting_distance = 30.5;		// Mounting holes distance
mounting_thickness = 5;			// Mounting plate thickness

retention_amount = 1.2;			// metal parts rest point snap-in amount
retention_width = 10;			// metal parts rest width

blower_screwpos = 40;
blower_screwpos_X1 = -20.15;
blower_screwpos_Y1 = 20.3;
blower_screwpos_X2 = 22;
blower_screwpos_Y2 = -19.5;
blower_X = 51.2;
blower_Y = 51.2;
blower_Z = 15;
blower_output_X = 19;
blower_output_Y = 11;
blower_output_screw_Y = -6.5;
blower_output_screw_X = 9.5;
blower_angle = 150;
blower_offset_R = radius_up;
blower_offset_Z = 26;
blower_mount_dist = 11;
blower_mount_height = fan_pos-coldend_offset-flange_h;
blower_bracket_thickness = 2.2;
blower_bracket_countersunk_d_small = 3.3;
blower_bracket_countersunk_d_large = 7;

rostock_holed1=4.5;
rostock_holed2=3.5;
rostock_support_d=6;
rostock_support_h=fan_pos-10;
rostock_D=62;
rostock_R=25;
rostock_h=7;
rostock_offset_a=60;
rostock_cable_offset_a=15;
rostock_sup_R=25;


rostock_platform_r=3;
rostock_platform_h=8.5;
rostock_platform_w1=37.0566;
rostock_platform_D1=61.5;
rostock_platform_D2=52;
rostock_platform_R1=38;
rostock_platform_supR=30;
rostock_platform_base_offset=50;
rostock_platform_pivot_R=31.2493;


//calculations
pythagoras=sqrt((22/2)*(22/2)+coldend_offset*coldend_offset);
flange_offset = pythagoras-coldend_offset;			// lower air stop
fan_mount_dist = (fan_width == 50) ? 40 : 32;		// cooling fan mounting hole distance (if fan_width=50 then fan_mount_dist=40 and if fan_width=40 then fan_mount_dist=32)

retention_offset = sin(angle)*(coldend_offset+26+7+6)-cos(angle)*(16/2) + retention_amount;
retention_thickness = retention_offset - radius_up;

rostock_platform_theta=asin((rostock_platform_w1/2+rostock_platform_r)/(rostock_platform_D1/2+rostock_platform_r));
rostock_platform_w2=rostock_platform_D1*sin(rostock_platform_theta);
rostock_platform_R2=cos(rostock_platform_theta)*(rostock_platform_D1/2+rostock_platform_r);



if (metalPartsOnly == false) {
	main();
} else {
	hotend();
	coldend();
}


*rotate([0,0,182])translate([-4,12,0])import("C:/Users/Jeffrey/Downloads/DeltaDiamondHeadV6.stl");
*translate([-1.5,1,0])rotate([0,0,177])import("C:/Users/Jeffrey/Downloads/DeltaDiamondHead-BedProbe-V5.stl");
//MAIN
module main() {
	rotate([180, 0, 0])
	translate([0, 0, -fan_pos])
	union() {
		difference() {
			union() {
				retention();
				deflectorsandduct();
                if( !rostock ) mounting();
				if (blower_enable) mirror([0,1,0]) rotate([0,0,-120]) blower_attach();
				if (blower_enable == 2) rotate([0,0,-120]) blower_attach();
                if (rostock && rostock<3) rostock_supports();
                if (rostock == 4) rostock_platform_base();
			}
			
			union() {
				if (assembled == true) {
					coldend();
					hotend();
				} else {
					coldend();
				}
				
				rotate((rostock && rostock<3 ? rostock_cable_offset_a : 0 ))wirehole();
				fan_mount_holes();
				if (blower_enable) mirror([0,1,0]) rotate([0,0,-120])  blower_plate_screws();
				if (blower_enable == 2) rotate([0,0,-120]) blower_plate_screws();
                if (rostock && rostock<3) rostock_holes();
                if (rostock == 3 || rostock == 4 )rostock_platform_pivot_holes();
                if (rostock == 4) rostock_platform_base_hole();
			}
			if (IR_enable) IR_cuts();
		}
		
		if (assembled == true) {
			color([0.5, 0.5, 0.5])
			fan();
			
			color("Silver")
			coldend();
			
			color("DarkGoldenrod")
			hotend();
		}
		difference(){
			if (IR_enable) IR_sups();
			if (IR_enable) IR_cuts();
		}
	}
	
	//the optional blower fan
	if (blower_enable )
	for(i=[0:(blower_enable == 2 ? 1 : 0)])
	multmatrix(m=[
		[cos(-120),sin(-120),0,0],
		[(2*i-1)*sin(-120),(1-2*i)*cos(-120),0,0],
		[0,0,1,0],
		[0,0,0,1]
	]){
		if (assembled ==true) {
			rotate([0, 0, -blower_angle])
			translate([-blower_output_X/2, blower_offset_R+blower_mount_dist, blower_offset_Z+16.5])
			rotate([270, 0, 0]) {
				translate([0, 0, 5])
				blower_bracket();
				
				translate([0, 0, 15])
				rotate([270, 0, 0])
				color([0.5, 0.5, 0.5])
				blower();
			}
			
		} else if(print_blower) {
			translate([30, -20, 0])
			rotate([0,0,-30])
			blower_bracket();
		}
	}
}


//E3D coldends
module coldend() {
	for(i = [0: 120: 270]) {
		rotate([0, 0, i])
		rotate([0, angle, 0])
		union() {
			
			translate([0, 0, coldend_offset-tolerance])
			union() {
				cylinder(r=22/2+tolerance, h=26+2*tolerance);
				
				translate([0, 0, 26])
				union() {
					translate([0, 0, -1])
					cylinder(r=16/2+tolerance, h=7+1+tolerance);
					
					translate([0, 0, 7])
					union() {
						translate([0, 0, -1])
						cylinder(r=12/2+tolerance, h=6+2);
						
						translate([0, 0, 6-tolerance])
						cylinder(r=16/2+tolerance, h=3.75+2*tolerance);
                        
                        if(rostock_extra_cut)
                            translate([0, 0, 6+3.75-tolerance])
                                cylinder(d=13, h=6);
						
						//holes for zip-ties
						if (ziptie_enable == 1)
						for (j=[-1, 1])
						translate([-8, j*6, 6-1.5])
						rotate([0, 0, 0])
						cube([16, 1.5, 3.01], center=true);
					}
				}
				
				rotate([180, 0, 0])
				cylinder(h=4, r=6/2);
			}
		}
	}
}


module hotend() {   // Diamond mock-up
	difference() {
		translate([0, 0, -1.4])
		union() {
			cylinder(r1=1, r2=13.4, h=18.8);
			
			translate([0, 0, 18.8])
			cylinder(r=13.4, h=2.35);
			
			translate([0, 0, 18.8+2.35])
			cylinder(r1=13.4, r2=3, h=5);
		}
	}
}


module retention() {
	for(i = [0: 120: 270]) {
		rotate([0, 0, i])
		translate([radius_up, -retention_width/2, fan_pos-16])
		cube([retention_thickness, retention_width, 16]);
	}
}


//fan_mockup
module fan() {
	difference() {
		union() {
			hull()
			for(x = [-1, 1])
			for(y = [-1, 1])
			translate([x*(fan_width/2-4), y*(fan_width/2-4), fan_pos+15/2])
			cylinder(r=3.5, h=15, center=true);
		}
		
		union() {
			translate([0, 0, fan_pos+15/2])
			cylinder(r=fan_width/2-2, h=15+1, center=true);
		}
	}
}


//fan_mount
module fan_mount() {
	translate([0, 0, fan_pos])
	hull()
	for(i = [1: 4]) {
		rotate([0, 0, i*90])
		translate([fan_mount_dist/2, fan_mount_dist/2, -fan_plate/2])
		union() {
			cylinder(r=4.5, h=fan_plate, center= true);
			
			rotate([0, 0, 45])
			translate([-2*4.5, -4.5, -fan_plate/2])
			cube([2*4.5, 2*4.5, fan_plate]);
		}
	}
}


//fan_mount holes
module fan_mount_holes() {
	translate([0, 0, fan_pos])
	for(i = [1: 4])
		rotate([0, 0, i*90])
		translate([fan_mount_dist/2, fan_mount_dist/2, -(rostock && rostock < 4 ? (rostock < 3 ? rostock_h : rostock_platform_h) : fan_plate)/2])
		rotate([180, 0, 0])
		cylinder(r=3.4/2, h=(rostock && rostock < 4 ? (rostock < 3 ? rostock_h : rostock_platform_h) : fan_plate)+1, center=true);
}


module coldend_reinforcement () {
	union() {
		for(i = [0: 120: 270]) {
			rotate([0, 0, i])
			rotate([0, angle, 0])
			translate([0, 0, coldend_offset-tolerance+26])
			cylinder(r=16/2+wall/2, h=7+6+3.75+wall_thin);
		}
	}
}

module deflectorsandduct(){
	difference() {
		union() {
			//duct
			translate ([0, 0, coldend_offset+flange_h])
            cylinder(r=radius_up+wall, h=fan_pos-coldend_offset-flange_h);
            //The rostock bit
            if(rostock && rostock<3) translate ([0, 0, fan_pos-rostock_h])
                cylinder(d=rostock_D,h=rostock_h);
			if(rostock == 3) rostock_platform_base();
			difference(){
				if(rostock == 4) rostock_platform_supports();
				translate ([0, 0, fan_pos])
				cylinder(r=sup_cut_r, h=sup_cut_h);
			}
			fan_mount();
			
			//deflector
			translate([0, 0, coldend_offset+flange_offset2]){
				cylinder(h=flange_h-flange_offset2, r1=radius_lo+wall, r2=radius_up+wall);
				
				if (blower_enable)
				for(i=[0:(blower_enable == 2 ? 1 : 0)])
				multmatrix(m=[
						[cos(120),sin(120),0,0],
						[(2*i-1)*sin(120),(1-2*i)*cos(120),0,0],
						[0,0,1,0],
						[0,0,0,1]
					])//*/
				//{
					translate([0, 0, -(coldend_offset+flange_offset2)])
					blower_plate_screw_wall();
				//}
			}
		}
		
		//duct
		//make the upper cylinder hollow
		union() {
			difference() {
				union() {
					translate ([0, 0, coldend_offset+flange_h+0.01])
					cylinder(r=radius_up, h=fan_pos-coldend_offset-flange_h);
				}
				
				union() {
					//except coldend mounting reinforcement
					coldend_reinforcement ();
				}
			}
		}
		
		//deflector
		translate([0, 0, coldend_offset+flange_offset2-0.01])
		union() {
			//bottom cut
			translate([0, 0, 0.01-coldend_offset-flange_offset2])
			sphere(r=pythagoras);
			
			//bottom center hole
			translate([0, 0, flange_offset])
			cylinder(h=flange_offset+0.2, r=radius_lo_center);
			
			//hollow
			translate([0, 0, wall_thin])
			difference() {
				union() {
					difference() {
						union() {
							cylinder(h=flange_h-flange_offset2+0.2-wall_thin, r1=radius_lo, r2=radius_up);
						}
						
						union() {
							//additional coldend mounting reinforcement
							translate([0, 0, -wall_thin+0.01-flange_offset2-coldend_offset])
							coldend_reinforcement ();
							
							//bottom air stop
							translate([0, 0, 0.01-coldend_offset-flange_offset2-wall_thin])
							sphere(r=pythagoras+wall_thin);
						}
					}
				}
				
				translate([0, 0, flange_offset+wall_thin])
				union() {
					//bottom air stop support
					for (i= [0, 120, 240]) {
						rotate([0, 0, i])
						translate([-radius_lo_center, 0, 0])
						rotate([0, -49, 0])				// 38 minimum
						union() {
							//primary support
							translate([0, wall_thin/2, 0])
							rotate([0, 0, 180])
							cube([10, wall_thin, 100]);
							
							//secondary support
							rotate([0, 90, 180])
							rotate([0, 0, 135])
							translate([0, 0, wall_thin/2])
							cube([3, 3, wall_thin], center=true);
						}
					}
				}
			}
		}
	}
}


//Hole for wires
module wirehole() {
	translate([-fan_width/2, 0, fan_pos]){
        if(rostock && rostock < 3) translate([fan_width/2-rostock_D/2-0.1,-8/2,-rostock_h-0.1])
            cube([rostock_D/2-fan_width/2,8,rostock_h+0.2]);
        rotate([0, 160, 0])
        union() {
            cylinder(r=8/2, h=2*(fan_pos-coldend_offset-flange_h), center=true);
            
            //zip-tie holes
            translate([0, 0, fan_pos-coldend_offset-flange_h])
            for (j=[-1, 1]) {
                translate([rostock_support_wall/2, j*(8/2-1.5), 6-1.5])
                cube([30+rostock_support_wall, 1.5, 3.01], center=true);
            }
        }
    }
}


//mounting bracket for attaching to the x-carriage
module mounting() {
	translate([-radius_up, 0, fan_pos])
	difference() {
		union() {
			translate([-mounting_thickness, -20, -(fan_pos-coldend_offset-flange_h)])
			cube([mounting_thickness, 40, fan_pos-coldend_offset-flange_h]);
		}
		
		for(i = [-1, 1]) {
			translate([0.1, i*mounting_distance/2, -mounting_offset])
			rotate([0, 270, 0])
			union() {
				cylinder(h=mounting_thickness+1, r=3.3/2);
				cylinder(h=2, r=6.5/2, $fn=6);
			}
		}
	}
}


//optional 5015S blower fan mockup
module blower() {
	rotate([90, 0, 0])
	union() {
		translate([0, -blower_output_Y, 0])
		cube([blower_output_X, blower_output_Y+blower_Y/2, blower_Z]);
		
		translate([blower_X/2, blower_Y/2, 0])
		union() {
			cylinder(r=blower_X/2, h=blower_Z);
			
			hull() {
				translate([blower_screwpos_X1, blower_screwpos_Y1, 0])
				cylinder(r=4, h=blower_Z);
				translate([blower_screwpos_X2, blower_screwpos_Y2, 0])
				cylinder(r=4, h=blower_Z);
			}
		}
	}
}


// blower mounting plate
module blower_bracket() {
	difference() {
		union() {
			intersection() {
				translate([-100, -100, 0])
				cube([200, 200, blower_bracket_thickness]);
				
				rotate([270, 0, 0])
				blower();
			}
		}
		
		union() {
			
			//blower mounting holes
			translate([blower_X/2, blower_Y/2, 0])
			union() {
				translate([blower_screwpos_X1, blower_screwpos_Y1, 0])
				cylinder(r=3.3/2, h=10, center=true);
				translate([blower_screwpos_X2, blower_screwpos_Y2, 0])
				cylinder(r=3.3/2, h=10, center=true);
			}
			
			//bracket mounting holes
			translate([blower_X/2, blower_Y/2, 0])
			for(i = [0, -15])
			translate([-blower_screwpos/2-1, blower_screwpos/2-25+i, 0])
			union() {
				cylinder(r=blower_bracket_countersunk_d_small/2, h=10, center=true);
				
				translate([0, 0, 0.2])
				cylinder(r1=blower_bracket_countersunk_d_small/2, r2=blower_bracket_countersunk_d_large/2, h=blower_bracket_thickness);
			}
			
			//blower nozzle mounting hole
			translate([blower_output_screw_X, blower_output_screw_Y, 0])
			cylinder(r=3.2/2, h=10, center=true);
		}
	}
}


//blower mounting screws
module blower_mount_screws() {
	rotate([90, 0, 0])
	translate([blower_X/2, blower_Y/2, 0])
	union() {
		translate([blower_screwpos_X1, blower_screwpos_Y1, 0])
		cylinder(r=1.6, h=11, center=true);
		translate([blower_screwpos_X2, blower_screwpos_Y2, 0])
		cylinder(r=1.6, h=11, center=true);
	}
}


//blower mounting plate screws and nuts (2 pcs M3X10 countersunk)
module blower_plate_screws() {
	rotate([0, 0, blower_angle])
	translate([0, -blower_offset_R-blower_mount_dist-0.01, blower_offset_Z])
	translate([-blower_output_X/2, 0, 0])
	union() {
		rotate([90, 0, 0])
		translate([blower_X/2, blower_Y/2, 0])
		for(i = [0, -15]) {
			translate([-blower_screwpos/2-1, blower_screwpos/2-25+i, 0])
			rotate([180, 0, 0])
			union() {
				cylinder(r=1.6, h=10);
				
				translate([0, 0, 4])
				cylinder(h=22+i, r=6.45/2, $fn=6);
			}
		}
	}
}


//Add-on pentant for attaching the blower_bracket();
module blower_attach() {
	rotate([0, 0, blower_angle])
	translate([-blower_output_X/2, -blower_offset_R, blower_offset_Z])
	union() {
		translate([0, -blower_mount_dist, 0])
		hull() {
			cube([blower_output_X/2, 4, fan_pos-blower_offset_Z-blower_mount_height+5]);
			translate([0, blower_mount_dist-0.1, blower_mount_height])
			cube([blower_output_X/2, 0.1, fan_pos-blower_offset_Z-blower_mount_height]);
		}
	}
}


//reinforcement of wall due to screw hole cut-away
module blower_plate_screw_wall() {
	rotate([0, 0, blower_angle])
	translate([-blower_output_X/2, -blower_offset_R, blower_offset_Z])

	rotate([90, 0, 0])
	translate([blower_X/2-blower_screwpos/2-1, blower_Y/2+blower_screwpos/2-25, 10])
	rotate([180, 0, 0])
	cylinder(h=20, r=6.45/2+wall_thin, $fn=6);
}


//And the supports for the rostock.
module rostock_supports(){
    for(i=[0:2]){
        translate([rostock_sup_R*cos(i*120+rostock_offset_a),rostock_sup_R*sin(i*120+rostock_offset_a),fan_pos-rostock_support_h])cylinder(d=rostock_support_d,h=rostock_support_h);
    }
}


//And the holes for the rostock.
module rostock_holes(){
    for(i=[0:2]){
        translate([rostock_sup_R*cos(i*120+rostock_offset_a),rostock_sup_R*sin(i*120+rostock_offset_a),0])cylinder(d=(rostock==2 ? rostock_holed2 : rostock_holed1),h=fan_pos+0.1);
    }
}


//Holes for Rostock pivot points.
module rostock_platform_pivot_holes(){
    translate([0,0,fan_pos-rostock_platform_h/2-(rostock == 4 ? rostock_platform_base_offset : 0 )])
    for(i=[0:2])rotate([0,0,120*i+60])translate([rostock_platform_pivot_R,0,0])rotate([90,0,0]){
		if(m3_nut_enable)for(i=[-0.5,0.5])translate([0,0,i*(rostock_platform_w1-m3_in_off*2)])hull(){
			translate([0,m3_ed,0])
			rotate([0,0,30])cylinder(r=m3_width/sqrt(3),h=m3_height,center=true,$fn=6);
			translate([0,-rostock_platform_h/2,0])cube([m3_width,0.1,m3_height],true);
		}
        cylinder(r=rostock_platform_pivot_r,h=rostock_platform_w1+0.2,center=true);
	}
}


//Base platform for rostock
module rostock_platform_base(){
    translate([0,0,fan_pos-rostock_platform_h-(rostock == 4 ? rostock_platform_base_offset : 0 )]){
        for(i=[0:2])rotate(120*i+60)difference(){
            union(){
                hull(){
					if(bevel_enable){
						translate([rostock_platform_pivot_R,0,rostock_platform_h/2])rotate([90,0,0]){
						cylinder(r=rostock_platform_pivot_r+bevel_wt,h=rostock_platform_w1,center=true);
						cylinder(d=rostock_platform_h,h=rostock_platform_w1-bevel_height*2,center=true);
						}
						translate([0,-rostock_platform_w1/2,0])cube([rostock_platform_R2,rostock_platform_w1,rostock_platform_h]);
					}
					else{
						translate([rostock_platform_R1-rostock_platform_r,rostock_platform_w1/2-rostock_platform_r,0])cylinder(r=rostock_platform_r,h=rostock_platform_h);
						translate([rostock_platform_R1-rostock_platform_r,rostock_platform_r-rostock_platform_w1/2,0])cylinder(r=rostock_platform_r,h=rostock_platform_h);
                   		translate([0,-rostock_platform_w1/2,0])cube([1,rostock_platform_w1,rostock_platform_h]);
					}
                }
				if(fullcircle){
                	translate([0,-rostock_platform_w2/2,0])cube([rostock_platform_R2,rostock_platform_w2,rostock_platform_h]);
				}
            }
			if(fullcircle){
				translate([rostock_platform_R2,rostock_platform_w1/2+rostock_platform_r,-0.1])cylinder(r=rostock_platform_r,h=rostock_platform_h+0.2);
				translate([rostock_platform_R2,-rostock_platform_w1/2-rostock_platform_r,-0.1])cylinder(r=rostock_platform_r,h=rostock_platform_h+0.2);
			}
			else{
			for(i=[-1,1])
				rotate([0,0,i*60])
				translate([rostock_platform_R2,0,-0.1])cylinder(r=rostock_platform_R2/2,h=rostock_platform_h+0.2);
			}
        }
		if(fullcircle){
        	cylinder(d=rostock_platform_D1,h=rostock_platform_h);
		}
    }
}


//Hole for the rostock platform.
module rostock_platform_base_hole(){
    translate([0,0,fan_pos-rostock_platform_h-rostock_platform_base_offset-0.1])
        cylinder(d=rostock_platform_D2,h=rostock_platform_h+0.2);
}


//Supports to hold the hotend above the rostock platform.
module rostock_platform_supports(){
    D=radius_up+wall;
    d=sqrt(D*D-rostock_platform_w1*rostock_platform_w1/16);
    a=atan((rostock_platform_supR-d)/rostock_platform_base_offset);
    l=rostock_platform_base_offset/cos(a);
    for(i=[0:2])
    rotate(120*i+60)
        translate([rostock_platform_supR,-rostock_platform_w1*0.25,fan_pos-rostock_platform_base_offset])
            rotate([0,-a,0]) translate([-2.5+rostock_extra_support_offset,0,0])
                cube([rostock_support_wall,rostock_platform_w1*0.5,l]);
}

module IR_sups(){
	for(i=[-9,9])
		translate([-rostock_platform_D2/2+2,i,IR_V_off])
			cube([9,5,5],true);
};

module IR_cuts(){
	for(i=[-9,9])
		translate([-rostock_platform_D2/2-IR_hole_depth+6.5,i,IR_V_off])
			rotate([0,90,0])
			cylinder(d=IR_d,h=IR_hole_depth+0.2);
	translate(IR_wire_pos)
		cube([IR_wire_d,IR_wire_w,IR_wire_h],true);
	translate([-rostock_platform_D2/2+2,0,17+((IR_V_off-14)/2)])
		cube([8,13,15+(IR_V_off-14)],true);
}