// This generates geometry for creating copper pipe fittings
// Licensed under Creative Commons: Attribution, Share-Alike
//		http://creativecommons.org/licenses/by-sa/3.0/
// For attribution you can direct people to the original file on thingiverse:
// 		http://www.thingiverse.com/thing:283551

// ================ variables

//CUSTOMIZER VARIABLES

/* [Main] */

// Rated strength
copper_pipe_class="K"; // [K,L,M,DWV]

// copper_nominal size ("inch") NOTE: All sizes may not be available for all classes,(M is missing a few smaller sizes and DWV only has a few large sizes)
copper_nom_idx=0; // [0:1/4,1:3/8,2:1/2,3:5/8,4:3/4,5:1,6:1 1/4,7:1 1/2,8:2 ,9:2 1/2,10:3]
  
// Length in mm
length=35;

// What to generate
generate=1; // [0:outside fitting,1:outside fitting - boolean diff,2:inside fitting,3:inside fitting - boolean diff,4:inside outside,5:inside outside - boolean diff]

// Tightness of fit, in mm (0=tight 0.3=snug 0.6=loose)
tightness=0.3; // 0.0,1.0

// In points per cylinder
resolution=64;

//CUSTOMIZER VARIABLES END
/* [Hidden] */

// =============== calculated variables
$fn=resolution;

// =============== program

// ---- Data
copper_nom_data=["1/4","3/8","1/2","5/8","3/4","1","1 1/4","1 1/2","2","2 1/2","3"];
copper_class_k_id_data  =[0.305,0.402,0.527,0.652,0.745,0.995,1.245,1.481,1.959,2.435,2.907];
copper_class_k_od_data  =[0.375,0.500,1.000,0.750,0.875,1.125,1.375,1.625,2.125,2.625,3.125];
copper_class_l_id_data  =[0.315,0.430,0.545,0.666,0.785,1.025,1.265,1.505,1.985,2.465,2.945];
copper_class_l_od_data  =[0.375,0.500,1.000,0.750,0.875,1.125,1.375,1.625,2.125,2.625,3.125];
copper_class_m_id_data  =[0.000,0.450,0.569,0.000,0.811,1.055,1.291,1.527,2.009,2.495,2.981];
copper_class_m_od_data  =[0.000,0.500,1.000,0.000,0.875,1.125,1.375,1.625,2.125,2.625,3.125];
copper_class_dwv_id_data=[0.000,0.000,0.000,0.000,0.000,0.000,1.295,1.541,2.041,0.000,3.030];
copper_class_dwv_od_data=[0.000,0.000,0.000,0.000,0.000,0.000,1.375,1.625,2.125,0.000,3.125];
in2mm=25.4;


//---- Functions

/////////////////////////////////////////////////////////
// module create_copper_component()
// This generates geometry for creating copper pipe fittings.
// In general, you should use create_copper() instead because it gives more options.
// copper_pipe_class = Copper pipe class ("K","L","M",or "DWV")
// copper_nom_idx = copper_nominal size index as described by copper_nom_data[] 
// length - Length in mm
// generate - What to generate:
//		0="outside fitting"
//		1="outside fitting - boolean diff"
//		2="inside fitting"
//		3="inside fitting - boolean diff"
// tightness - Tightness of fit, in mm (0=tight 0.3=snug 0.6=loose)
module create_copper_component(copper_pipe_class="K",copper_nom_idx=0,generate=0,tightness=0.02,length=35) {
	dia=
	(in2mm*(copper_pipe_class=="K" ?
		(generate==0||generate==1?copper_class_k_od_data[copper_nom_idx]:copper_class_k_id_data[copper_nom_idx])
		:
		copper_pipe_class=="L" ?
		(generate==0||generate==1?copper_class_l_od_data[copper_nom_idx]:copper_class_l_id_data[copper_nom_idx])
		:
		copper_pipe_class=="M" ?
		(generate==0||generate==1?copper_class_m_od_data[copper_nom_idx]:copper_class_m_id_data[copper_nom_idx])
		:
		(generate==0||generate==1?copper_class_dwv_od_data[copper_nom_idx]:copper_class_dwv_id_data[copper_nom_idx])
	))
	+(generate==2||generate==3?-tightness:tightness);
	echo("========== INFO ==========");
	echo(str("for ",copper_nom_data[copper_nom_idx],"in (copper_nom) pipe"));
	echo(str("created ",dia,"mm dia part"));
	echo(str("including ",(generate==2||generate==3?-tightness:tightness),"mm for fit"));
	echo("==========================");
	// now draw it
	rotate([90,0,0]) if(generate==1||generate==3){
		cylinder(r=dia/2,h=length,center=true);
	}else{
		difference() {
			cube([dia+10,dia+10,length],center=true);
			cylinder(r=dia/2,h=length*2,center=true);
		}
	}
};

/////////////////////////////////////////////////////////
// module create_copper()
// This generates geometry for creating copper pipe fittings.
// Just like create_copper_component() only adds generate options 4 and 5
// copper_pipe_class = Copper pipe class ("K","L","M",or "DWV")
// copper_nom_idx = copper_nominal size index as described by copper_nom_data[] 
// length - Length in mm
// generate - What to generate:
//		0="outside fitting"
//		1="outside fitting - boolean diff"
//		2="inside fitting"
//		3="inside fitting - boolean diff"
//		4="inside outside"
//		5="inside outside - boolean diff"
// tightness - Tightness of fit, in mm (0=tight 0.3=snug 0.6=loose)
module create_copper(copper_pipe_class="K",copper_nom_idx=0,generate=0,tightness=0.02,length=35) {
	if(generate<=3){
		create_copper_component(copper_pipe_class,copper_nom_idx,generate,tightness,length);
	}
	else if(generate==4){
		difference() {
			create_copper_component(copper_pipe_class,copper_nom_idx,1,tightness,length);
			create_copper_component(copper_pipe_class,copper_nom_idx,3,tightness,length*2);
		}
	}
	else{
		union() {
			create_copper_component(copper_pipe_class,copper_nom_idx,0,tightness,length);
			create_copper_component(copper_pipe_class,copper_nom_idx,3,tightness,length);
		}
	}
};

//---- The program
create_copper(copper_pipe_class,copper_nom_idx,generate,tightness,length);
