include<write/Write.scad>
use<write.scad>

// preview[view:south west, tilt:top diagonal]



////////////////////////////////////
///USER DEFINED VARIABLES
////////////////////////////////////

// Choose your style
Font = "Letters.dxf"; //  ["write/Letters.dxf":Letters,"write/BlackRose.dxf":Black Rose,"write/orbitron.dxf":Orbitron,"write/knewave.dxf":Knewave,"write/braille.dxf":Braille]

//Front text
name_plate = "LOLCOPTER MK1";

//Top text
name_plate_top = "LET THE GOOD TIMES LOL";

// How many propeller blades do you want?
number_of_blades = 4; // [3,4,5,6]

// Distance between the propellers (mm)
engine_centers = 160; // [95:300]

// Propeller Radius (mm)
prop_radius = 75; // [45:145]

// How big do you want the turbine radius? (mm)
turbine_radius = 20; // [20:70]

// Propeller Shaft Height (mm)
prop_shaft_height = 100; // [55:300]

// Propeller Shaft Radius (mm)
prop_shaft_rad = 3; // [2:6]

// Balloon Stem Radius (mm)
balloon_stem_radius = 8; // [5:12]

////////////////////////////////////
///STL Print parts
////////////////////////////////////

// Preview of Parts
part = "assembly"; // [assembly:Assembly, first:Rear_Casing_Bottom Only, second:Rear_Casing_Top Only, third:Front_Casing Only, fourth:Right_Turbine Only, fifth:Left_Turbine Only, sixth:Left_Prop Only, seventh:Right_Prop Only]

print_part();

module print_part() {
	
	if (part == "first") {
		Rear_Casing_Bottom();
	} else if (part == "second") {
		Rear_Casing_Top();
	} else if (part == "third") {
		Front_Casing();
	} else if (part == "fourth") {
		Right_Turbine();
	} else if (part == "fifth") {
		Left_Turbine();
	} else if (part == "sixth") {
		Left_Prop();
	} else if (part == "seventh") {
		Right_Prop();
	} if (part == "assembly") {
		Assembly();
	} 
}


    


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///rear half-bottom of casing//////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module casing_bottom() {
	union () { //puts the airflow dividers in after all the other subtraction booleans
		difference () {
			union () {
				difference () {
				union () {
				translate( [ 0, 0, 0 ] ) cylinder( r = body_cyl_radius, h = body_height, $fn = 50 ); //body cylinder
				translate( [ 0, engine_centers, 0 ] ) cylinder( r = body_cyl_radius, h = body_height, $fn = 50 ); //body cylinder
				translate( [ -body_cyl_radius, 0, 0 ] ) cube( size = [body_cyl_radius+body_thickness, engine_centers, body_height] ); //body cube
				translate( [ 0, -body_cyl_radius, 0 ] ) cube( size = [15, 5.5, body_thickness] ); //front clip cube
				translate( [ 0, engine_centers+body_cyl_radius-5.5, 0 ] ) cube( size = [15, 5.5, body_thickness] ); //front clip cube
				translate( [-body_cyl_radius+13, engine_centers/2, -25] ) cylinder( r = balloon_stem_radius, h = 25, $fn = 50 ); //balloon stem
				translate( [-body_cyl_radius+13, engine_centers/2, -25] ) cylinder( r = balloon_stem_radius+2, h = 1, $fn = 50 ); //ballon stem ridge
				translate( [-body_cyl_radius+13, engine_centers/2, -24] ) cylinder( r1 = balloon_stem_radius+2, r2 = balloon_stem_radius, h = 2, $fn = 50 ); //ballon stem ridge
				} // end union
			union () {
				translate ([ 0, 0, -2 ]) cylinder( r = turbine_radius*0.6, h = body_thickness+4, $fn = 50 ); //turbine exhaust hole
				translate ([ 0, engine_centers, -2 ]) cylinder( r = turbine_radius*0.6, h = body_thickness+4, $fn = 50 ); //turbine exhaust hole
				translate( [ -body_cyl_radius-4, -body_cyl_radius, body_thickness ] ) cube( size = [body_cyl_radius*3, engine_centers+body_cyl_radius*2, body_height+4] ); //body cube inside
				translate( [-body_cyl_radius+13, engine_centers/2, -30] ) cylinder( r = balloon_stem_radius-1.5, h = 34, $fn = 50 ); //balloon stem inside
				translate( [ 0, 0, -2 ] ) cylinder( r = prop_shaft_hole/2, h = body_height+4, $fn = 50 ); //prop shaft hole
				translate( [ 0, engine_centers, -2 ] ) cylinder( r = prop_shaft_hole/2, h = body_height+4, $fn = 50 ); //prop shaft hole
			} // end union
				} // end diff
			difference () {
				union () {
				translate( [ 0, 0, 0 ] ) cylinder( r = (prop_shaft_hole/2) + 2, h = body_thickness, $fn = 50 ); //turbine bearing
				translate( [ -1.75, -body_cyl_radius+1, 0 ] ) cube ( size = [3.5, (body_cyl_radius*2)-2, body_thickness ]); //turbine bearing support beam
				} //end union
				translate( [ 0, 0, -2 ] ) cylinder( r = prop_shaft_hole/2, h = body_thickness+4, $fn = 50 ); //turbine bearing hole
			} // end diff
			difference () {
				union () {
				translate( [ 0, engine_centers, 0 ] ) cylinder( r = (prop_shaft_hole/2) + 2, h = body_thickness, $fn = 50 ); //turbine bearing
				translate( [ -1.75, engine_centers-body_cyl_radius+1, 0 ] ) cube ( size = [3.5, (body_cyl_radius*2)-2, body_thickness ]); //turbine bearing support beam
				} // end union
				translate( [ 0, engine_centers, -2 ] ) cylinder( r = prop_shaft_hole/2, h = body_thickness+4, $fn = 50 ); //turbine bearing hole
			} // end diff
			}
				translate ( [ -body_cyl_radius/2.5-0.25, body_cyl_radius-body_thickness-0.25, -2 ]) cube( size = [ body_cyl_radius/2.5+0.5, body_thickness+0.5, body_height ] ); //airflow restricter
				translate ( [ -body_cyl_radius/2.5-0.25, engine_centers-body_cyl_radius-0.25, -2 ]) cube( size = [ body_cyl_radius/2.5+0.5, body_thickness+0.5, body_height ] ); //airflow restricter
			} // end diff
				//difference () {
				//translate ( [ -body_cyl_radius, body_cyl_radius-body_thickness, body_thickness ]) cube( size = [ body_cyl_radius/1.698, body_thickness, body_height-body_thickness-5 ] ); //airflow restricter
				//translate ( [ -body_cyl_radius, body_cyl_radius-body_thickness-5, body_thickness+7 ]) cube( size = [ body_cyl_radius, body_thickness+10, body_height-body_thickness-5 ] ); //airflow restricter hole
				//translate ( [ -body_cyl_radius/2.5, body_cyl_radius-body_thickness-5, 0 ]) cube( size = [ body_cyl_radius, body_thickness+10, body_height ] ); //airflow restricter
				//}
				//difference () {
				//translate ( [ -body_cyl_radius, engine_centers-body_cyl_radius, body_thickness ]) cube( size = [ body_cyl_radius/1.698, body_thickness, body_height-body_thickness-5 ] ); //airflow restricter
				//translate ( [ -body_cyl_radius, engine_centers-body_cyl_radius-5, body_thickness+7 ]) cube( size = [ body_cyl_radius, body_thickness+10, body_height-body_thickness-5 ] ); //airflow restricter hole
				//translate ( [ -body_cyl_radius/2.5, engine_centers-body_cyl_radius-5, 0 ]) cube( size = [ body_cyl_radius, body_thickness+10, body_height ] ); //airflow restricter
				//}
		} // end union
} // end module



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///rear half-top of casing//////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module casing_top() {
difference () {
	union () { //puts the airflow dividers in after all the other subtraction booleans
		difference () {
			union () {
				difference () {
				union () {
				translate( [ 0, 0, 0 ] ) cylinder( r = body_cyl_radius, h = body_height, $fn = 50 ); //body cylinder
				translate( [ 0, engine_centers, 0 ] ) cylinder( r = body_cyl_radius, h = body_height, $fn = 50 ); //body cylinder
				translate( [ -body_cyl_radius, 0, 0 ] ) cube( size = [body_cyl_radius+body_thickness, engine_centers, body_height] ); //body cube
				translate( [ 0, -body_cyl_radius, 0 ] ) cube( size = [15, 5.5, body_height] ); //front clip cube
				translate( [ 0, engine_centers+body_cyl_radius-5.5, 0 ] ) cube( size = [15, 5.5, body_height] ); //front clip cube
			} //end union
			union () {
				translate ([ 0, 0, -2 ])   cylinder( r = body_cyl_radius - body_thickness, h = body_height - body_thickness+2, $fn = 50  ); //body cyl replace
				translate ([ 0, engine_centers, -2 ])   cylinder( r = body_cyl_radius - body_thickness, h = body_height - body_thickness+2, $fn = 50  ); //body cyl replace
				translate( [ -body_cyl_radius-2, 0, -2 ] ) cube( size = [body_cyl_radius+2, engine_centers, body_height-body_thickness+2] ); //body cube inside
				translate( [ 0, 0, -2 ] ) cylinder( r = prop_shaft_hole/2, h = body_height+4, $fn = 50 ); //prop shaft hole
				translate( [ 0, engine_centers, -2 ] ) cylinder( r = prop_shaft_hole/2, h = body_height+4, $fn = 50 ); //prop shaft hole
			} //end union
				translate( [ -body_cyl_radius-2, -body_cyl_radius-2, -2 ] ) cube( size = [body_cyl_radius*3, engine_centers+body_cyl_radius*2.5, body_thickness+2] ); //body cube inside
				} //end diff
			} // end union
				translate ( [ -body_cyl_radius-2, -prop_shaft_hole/2, -2 ]) cube( size = [ body_cyl_radius+2, prop_shaft_hole, body_height+4 ]); //shaft slot removal
				translate ( [ -body_cyl_radius-2, engine_centers-(prop_shaft_hole/2), -2 ]) cube( size = [ body_cyl_radius+2, prop_shaft_hole, body_height+4 ]); //shaft slot removal
		} // end diff
	translate( [ -body_cyl_radius, engine_centers/2-(body_thickness/2), body_thickness ] ) cube( size = [body_cyl_radius, body_thickness, body_height-body_thickness-0.5] ); //airflow divider
	difference () {
	translate( [-body_cyl_radius+2, engine_centers/2-(body_thickness/2), -25] ) cube( size = [22, 2, body_height] ); //balloon stem airflow divider
		difference () {
	translate( [-body_cyl_radius+13, engine_centers/2, -26] ) cylinder( r = balloon_stem_radius*4, h = 26+body_thickness, $fn = 50 ); //balloon stem
	translate( [-body_cyl_radius+13, engine_centers/2, -26] ) cylinder( r = balloon_stem_radius-1.75, h = 28+body_thickness, $fn = 50 ); //balloon stem inside
		} // end diff
	} // end diff
	translate ( [ -body_cyl_radius/2.5, body_cyl_radius-body_thickness, 0 ]) cube( size = [ body_cyl_radius/2.5, body_thickness, body_height ] ); //airflow restricter
	translate ( [ -body_cyl_radius/2.5, engine_centers-body_cyl_radius, 0 ]) cube( size = [ body_cyl_radius/2.5, body_thickness, body_height ] ); //airflow restricter
		difference () {
		translate( [ 0, 0, 2 ] ) cylinder( r = body_cyl_radius, h = body_height-2, $fn = 50 ); //body cylinder
		translate ([ 0, 0, -2 ])   cylinder( r = body_cyl_radius - body_thickness, h = body_height - body_thickness+2, $fn = 50  ); //body cyl replace
		translate ( [ -body_cyl_radius-5, -body_cyl_radius-2, -5 ] ) cube ( size = [ body_cyl_radius*2+10, body_cyl_radius+prop_shaft_hole-1.5, body_height+10] ); //half off
		} // end diff
		difference () {
		translate( [ 0, engine_centers, 2 ] ) cylinder( r = body_cyl_radius, h = body_height-2, $fn = 50 ); //body cylinder
		translate ([ 0, engine_centers, -2 ])   cylinder( r = body_cyl_radius - body_thickness, h = body_height - body_thickness+2, $fn = 50  ); //body cyl replace
		translate ( [ -body_cyl_radius-5, engine_centers-prop_shaft_hole/2, -5 ] ) cube ( size = [ body_cyl_radius*2+10, body_cyl_radius+prop_shaft_rad*2, body_height+10] ); //half off
		} // end diff
	} //end union
	translate ( [ -body_cyl_radius, 0, 0 ]) cube( size = [ body_cyl_radius/5+1, body_cyl_radius, body_height-body_thickness-6 ] ); //airflow restricter hole
	translate ( [ -body_cyl_radius, engine_centers-body_cyl_radius-5, 0 ]) cube( size = [ body_cyl_radius/5+1, body_cyl_radius+prop_shaft_hole, body_height-body_thickness-6 ] ); //airflow restricter hole
} // end diff
} //end module


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///turbine
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module turbine_ends() {
scale( [ handedness, 1, 1 ] )
	difference() {
scale(v = [1, 1, 1]) {
		union() {
			difference() {
				translate ([ 0, 0, 0 ])   cylinder( r = turbine_radius+0.5, h = 1.5, $fn = 50  ); // bottom face
				translate ([ 0, 0, -2 ])   cylinder( r = turbine_radius*0.6, h = 4, $fn = 50  ); // bottom face hole
			} // end diff
				translate ([ 0, 0, -1 ])   cylinder( r = prop_shaft_rad+2.5, h = 21.5, $fn = 50 ); // axle
				translate ([ 0, 0, turbine_height - 1.5 ])  cylinder( r = turbine_radius+0.5, h = 1.5, $fn = 50  ); // top face
		}
		}
			difference() {
				translate ([ 0, 0, -2 ]) cylinder ( r = prop_shaft_rad+0.5, h = 28, $fn = 50 ); // axle hole
				translate ( [-prop_shaft_rad-1, ((prop_shaft_rad+0.5)/3)*2, -3] ) cube( size = [(prop_shaft_rad+2)*2, prop_shaft_rad, 32] ); // axle hole flat
				translate ( [-prop_shaft_rad-1, -prop_shaft_rad-0.5, -3] ) cube( size = [(prop_shaft_rad+2)*2, prop_shaft_rad/3, 32] ); // axle hole flat
			} // end diff
				}
} // end module

module turbine_blade (){
intersection() {
	difference () {
		difference () {
		cylinder( r = turbine_radius, h = turbine_blade_height, $fn = 50 ); // blade circle
		translate ( [ 0, 0, -2 ]) cylinder( r = turbine_radius*0.6, h = turbine_blade_height+5, $fn = 50 ); // blade circle
		}
	translate ( [ 0, -50, 0 ]) cube( size = [ 50, 50, 20 ] );
	}

	difference () {
		difference () {
		translate ( [turbine_radius*0.85, 0, -2] ) cylinder( r = turbine_radius*0.725, h = turbine_blade_height+5, $fn = 50 ); // blade
		translate ( [turbine_radius*0.85, 0, -2] ) cylinder( r = turbine_radius*0.675, h = turbine_blade_height+5, $fn = 50 ); // blade
			}
		translate ( [ 0, -50, 0 ]) cube( size = [ 50, 50, turbine_blade_height ] );
	}
}
}
	 

module turbine_blade_assembly () {
		for (i = [0 : 16 - 1]) {
		rotate([0, 0, i * (360 / 16) ] ) {
		turbine_blade(); }
		}
}

module turbine() {
	union () {
		turbine_ends();
		turbine_blade_assembly ();
}
}




/////////////////////////////////////////////////////////////////////////////////////////////////////////////
///engine
////////////////////////////////////////////////////////////////////////////////////////////////////////////

module blade() {
	difference() {
		difference() {
			difference() {
			rotate ( [ 0, 270, 0 ] ) cylinder ( r = 36, h = prop_radius, $fn = 100 );
			rotate ( [ -2, 270, 0 ] ) cylinder ( r = 34.5, h = prop_radius+4, $fn = 100 );
			} // end diff
			union() {
				translate ( [-prop_radius-2, -50, -38] ) cube ( size = [ prop_radius*2, 50+7, 110] );
				translate ( [-prop_radius-2, 19, -35] ) cube ( size = [prop_radius*2, 35, 110] );
				translate ( [-prop_radius-2, 0, 0] ) cube ( size = [prop_radius*2, 35, 75] );
			} // end union
		} // end diff
			difference() {
				translate ( [ 0, 13, -35.8 ]) cylinder ( r = prop_radius+3, h = prop_ring_h+1, $fn = 100 );
				translate ( [ 0, 13, -35.8 ]) cylinder ( r = prop_radius, h = prop_ring_h+1, $fn = 100 );
			} // end diff
	}
} // end module	

module prop() {
	union() {
		union() {
			translate ( [ 0, -13, 35.28 ]) blade();
			for (i = [0 : number_of_blades - 1]) {
			rotate([0, 0, i * (360 / number_of_blades) ] ) {
			translate ( [ 0, -13, 35.28 ]) blade(); }
		} // end union
			difference() {
			translate ( [ 0, 0, 0 ]) cylinder ( r = prop_radius, h = prop_ring_h, $fn = 100 );
			translate ( [ 0, 0, -2 ]) cylinder ( r = prop_radius-1.5, h = prop_ring_h+4, $fn = 100 );
			} // end diff
	cylinder ( r = 6, h = prop_ring_h, $fn = 50 );
	} // end union
	} // end union
} // end module

module engine_shaft() {
	difference () {
		union () {
			translate ( [0, 0, 0] ) cylinder ( r = prop_shaft_rad, h = prop_shaft_height, $fn = 50 );
			translate ( [0, 0, 32] ) cylinder ( r1 = prop_shaft_rad+1.5, r2 = prop_shaft_rad, h = 2, $fn = 50 );
			translate ( [0, 0, prop_shaft_height-12] ) cylinder ( r1 = 2.5, r2 = 5.5, h = 6.5, $fn = 50 );
		}
			translate ( [-prop_shaft_rad, (prop_shaft_rad/3)*2, 0] ) cube( size = [prop_shaft_rad*2, prop_shaft_rad/3, 32] );
			translate ( [-prop_shaft_rad, -prop_shaft_rad, 0] ) cube( size = [prop_shaft_rad*2, prop_shaft_rad/3, 32] );
	}
}

module engine () {
	union () {
		translate ( [0, 0, 0] ) engine_shaft ();
		translate ( [0, 0, prop_shaft_height-6.5] ) prop();
}
}





//////////////////////////////////////////////////////////////////////////////////////////////////////
///front casing
//////////////////////////////////////////////////////////////////////////////////////////////////////

module casing_front () {
	difference () {
	union () {
		difference () {
			union () {
				difference () {
					union () {
						union () {
						translate( [ 0, 0, body_height+0.5 ] ) cylinder( r = body_cyl_radius+body_thickness+0.5, h = 2, $fn = 50 ); //turbine cylinder
						translate( [ 0, 0, -body_thickness-0.5 ] ) cylinder( r = body_cyl_radius+body_thickness+0.5, h = 2, $fn = 50 ); //turbine cylinder
						translate( [ 0, engine_centers, body_height+0.5 ] ) cylinder( r = body_cyl_radius+body_thickness+0.5, h = 2, $fn = 50 ); //turbine cylinder
						translate( [ 0, engine_centers, -body_thickness-0.5 ] ) cylinder( r = body_cyl_radius+body_thickness+0.5, h = 2, $fn = 50 ); //turbine cylinder
						translate( [ -body_cyl_radius-body_thickness-0.5, 0, body_height+0.5 ] ) cube( size = [body_cyl_radius+body_thickness+0.5, engine_centers, 2] ); //top flange
						translate( [ -body_cyl_radius-body_thickness-0.5, 0, -body_thickness-0.5 ] ) cube( size = [body_cyl_radius+body_thickness+0.5, engine_centers, 2] ); //bottom flange
						translate ( [ -body_cyl_radius-body_thickness-0.5, 0, -body_thickness-0.5 ]) cube( size = [ 2, engine_centers, body_height+5 ] ); //front face
						translate( [ 0, -body_cyl_radius-body_thickness-0.5, -body_thickness-0.5 ] ) cube( size = [16.5, 2, body_height+5 ] ); //side flange
						translate( [ 0, engine_centers+body_cyl_radius+0.5, -body_thickness-0.5 ] ) cube( size = [16.5, 2, body_height+5 ] ); //side flange
						} // end union
					difference () {
					translate( [ 0, 0, -body_thickness-0.5 ] ) cylinder( r = body_cyl_radius+body_thickness+0.5, h = body_height+5, $fn = 50 ); //turbine cylinder quarter
					translate( [ 0, 0, -0.5 ] ) cylinder( r = body_cyl_radius+0.5, h = body_height+1, $fn = 50 ); //turbine cylinder quarter
					} // end diff
					difference () {
					translate( [ 0, engine_centers, -body_thickness-0.5 ] ) cylinder( r = body_cyl_radius+body_thickness+0.5, h = body_height+5, $fn = 50 ); //turbine cylinder quarter
					translate( [ 0, engine_centers, -0.5 ] ) cylinder( r = body_cyl_radius+0.5, h = body_height+1, $fn = 50 ); //turbine cylinder quarter
					} // end diff
					} // end union
				translate ([ 0, 0, -body_thickness-5 ]) cylinder( r = turbine_radius*0.6, h = body_thickness+10, $fn = 50 ); //turbine exhaust hole
				translate ([ 0, engine_centers, -body_thickness-5 ]) cylinder( r = turbine_radius*0.6, h = body_thickness+10, $fn = 50 ); //turbine exhaust hole
				translate( [ 0, -body_cyl_radius-0.5, -body_thickness-5] ) cube( size = body_cyl_radius, (body_cyl_radius*2)+body_thickness+1, body_height+10);
				translate( [ 0, engine_centers-body_cyl_radius-body_thickness-0.5, -body_thickness-5] ) cube( size = body_cyl_radius, (body_cyl_radius*2)+body_thickness+1, body_height*2);
				translate( [ 0, 0, -body_thickness-5 ] ) cylinder( r = prop_shaft_hole/2, h = body_height+10, $fn = 50 ); //prop shaft hole
				translate( [ 0, engine_centers, -body_thickness-5 ] ) cylinder( r = prop_shaft_hole/2, h = body_height+10, $fn = 50 ); //prop shaft hole
				} // end diff
			
			difference () {
				union () {
				translate( [ 0, 0, -body_thickness-0.5 ] ) cylinder( r = (prop_shaft_hole/2) + 2, h = body_thickness, $fn = 50 ); //turbine bearing
				translate( [ -1.75, -body_cyl_radius-0.5, -body_thickness-0.5 ] ) cube ( size = [3.5, (body_cyl_radius*2), body_thickness ]); //turbine bearing support beam
				} //end union
				translate( [ 0, 0, -body_thickness-5 ] ) cylinder( r = prop_shaft_hole/2, h = body_thickness+10, $fn = 50 ); //turbine bearing hole
				translate( [ 0, -prop_shaft_hole/2, -body_thickness-0.5 ] ) cube ( size = [10, prop_shaft_hole, body_thickness ]); //turbine bearing slot hole
				translate( [ 1.75, -(prop_shaft_hole/2)-2, -body_thickness-5 ] ) cube ( size = [prop_shaft_hole, prop_shaft_hole+4, body_thickness+10 ]); //turbine bearing shave
			} // end diff

			difference () {
				union () {
				translate( [ 0, engine_centers, -body_thickness-0.5 ] ) cylinder( r = (prop_shaft_hole/2) + 2, h = body_thickness, $fn = 50 ); //turbine bearing
				translate( [ -1.75, engine_centers-body_cyl_radius+0.5, -body_thickness-0.5 ] ) cube ( size = [3.5, body_cyl_radius*2, body_thickness ]); //turbine bearing support beam
				} // end union
				translate( [ 0, engine_centers, -body_thickness-5 ] ) cylinder( r = prop_shaft_hole/2, h = body_thickness+10, $fn = 50 ); //turbine bearing hole
				translate( [ 0, engine_centers-(prop_shaft_hole/2), -body_thickness-0.5 ] ) cube ( size = [10, prop_shaft_hole, body_thickness ]); //turbine bearing slot hole
				translate( [ 1.75, engine_centers-(prop_shaft_hole/2)-2, -body_thickness-5 ] ) cube ( size = [prop_shaft_hole, prop_shaft_hole+4, body_thickness+10 ]); //turbine bearing shave
			} // end diff
			translate( [ 15, -body_cyl_radius-0.5, -body_thickness-0.5 ] ) cube( size = [1.5, body_thickness, body_height+5 ] ); //side flange clip
			translate( [ 15, engine_centers+body_cyl_radius-1.5, -body_thickness-0.5 ] ) cube( size = [1.5, body_thickness, body_height+5 ] ); //side flange clip
			} // end union
		translate( [ -body_cyl_radius+12.5, engine_centers/2, -3 ] ) cylinder( r = balloon_stem_radius+1, h = 10, $fn = 50 ); //balloon stem cut out 
		translate( [ -body_cyl_radius+12.5, (engine_centers/2)-balloon_stem_radius-1, -3 ]) cube( size = body_cyl_radius, (balloon_stem_radius+1)*2, 5 ); //balloon stem cut out
		translate( [ -body_cyl_radius-0.5, 0, -0.5 ] ) cube( size = [body_cyl_radius+body_thickness+0.5, engine_centers, body_height+1] ); //bottom flange cut out
		} // end diff
	} // end union
    translate ([-body_cyl_radius-3, engine_centers/2, body_height/2])
		scale ( [1,(engine_centers/len_name_plate)*0.095, 1])
		rotate (90,[1,0,0])
		rotate (90,[0,-1,0])
		write(name_plate, t = 2.75, h = body_height * 0.5, center = true, font=Font);

	translate ([-body_cyl_radius+10, engine_centers/2, body_height+2.5])
		scale ( [1,engine_centers/len_name_plate_top*0.095, 1])
		rotate (270,[0,0,1])
		write(name_plate_top, t = 1.75, h = body_height * 0.5, center = true, font=Font);
} // end diff
} // end module
	



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////VARIABLES
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////
/// over all scale assignments
///////////////////////////////////


////////////////////////////////////
///casing settings
////////////////////////////////////
len_name_plate=len(name_plate);

len_name_plate_top=len(name_plate_top);

body_height = 30.25-1.75;

body_thickness = 2;

prop_shaft_hole = prop_shaft_rad*2 + 1.25;

body_cyl_radius = (turbine_radius+body_thickness+2.5-0.9556);

////////////////////////////////////
///turbine settings
////////////////////////////////////

turbine_blade_height = 20;
turbine_height = 21.5;

handedness = 1; // 1 for right hand (generates lift when rotated counter clockwise, viewed from above)
                // -1 for left hand (generates lift when rotated clockwise, viewed from above)

///////////////////////////////////
///propeller settings
///////////////////////////////////

prop_ring_h = 6.5;

prop_shaft_hole = prop_shaft_rad*2 + 1.25;



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///PRINTING MODULES
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module Rear_Casing_Bottom () {
		rotate ( [ 180, 0, 0] ) translate ( [ 0, 0, -2] ) casing_bottom(); 	
}


module Rear_Casing_Top () {
		rotate ( [ 180, 0, 0] ) translate ( [ 0, 0, -body_height] ) casing_top(); 	
}


module Left_Turbine () {
		rotate ( [ 180, 0, 0] ) translate ( [ 0, engine_centers, -21.5 ] ) turbine();
}


module Right_Turbine () {
		rotate ( [ 180, 0, 0] ) translate ( [ 0, 0, -21.5] ) scale( [ -handedness, 1, 1 ] ) turbine();
}


module Left_Prop () { 
		rotate ( [ 180, 0, 0] ) translate ( [ 0, engine_centers, -prop_shaft_height ] ) engine();
}


module Right_Prop () {
		rotate ( [ 180, 0, 0] ) translate ( [ 0, 0, -prop_shaft_height ] )scale( [ -handedness, 1, 1 ] ) engine();
}


module Front_Casing () {
		rotate ( [ 0, 270, 0] ) translate ( [ 0, 0, 0] ) casing_front();
}




module Assembly() {
		translate ( [ 0, 0, -0.1] ) casing_bottom (); 
	 	translate ( [ 0, 0, 0] ) casing_top ();
		translate ( [ 0, 0, 3] ) turbine ();
		translate ( [ 0, engine_centers, 3] ) scale( [ -handedness, 1, 1 ] ) turbine ();
		translate ( [ 0, 0, -5-2.5 ] ) scale( [ -handedness, 1, 1 ] ) engine ();
		translate ( [ 0, engine_centers, -5-2.5 ] ) engine ();
		translate ( [ 0,0,0] ) casing_front ();
}





