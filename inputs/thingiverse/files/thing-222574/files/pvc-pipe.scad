// This generates geometry for creating PVC pipe fittings
// Licenced under Creative Commons: Attribution, Share-Alike
//		http://creativecommons.org/licenses/by-sa/3.0/
// For attribution you can direct people to the original file on thingiverse:
// 		http://www.thingiverse.com/thing:222574

// ================ variables

//CUSTOMIZER VARIABLES

/* [Main] */

// Rated strength
schedule=40; // [40:schedule_40,1:schedule_80]

// Nominal size ("inch")
nom_idx=0; // [0:1/2,1:3/4,2:1,3:1 1/4,4:1 1/2,5:2,6:2 1/2,7:3,8:4,9:5,10:6,11:8,12:10,13:12,14:14,15:16]

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
nom_data=["1/2","3/4","1","1 1/4","1 1/2","2","2 1/2","3","4","5","6","8","10","12","14","16"];
sch40id_data=[0.622,0.824,1.049,1.38,1.61,2.067,2.469,3.068,4.026,5.047,6.065,7.981,10.02,11.938,13.124,15];
sch40od_data=[0.84,1.05,1.315,1.66,1.9,2.375,2.875,3.5,4.5,5.563,6.625,8.625,10.75,12.75,14,16];
sch40pvcweight_data=[0.16,0.21,0.32,0.43,0.51,0.68,1.07,1.41,2.01,2.73,3.53,5.39,7.55,10.01,11.8,15.43];
sch40cpvcweight_data=[0.17,0.23,0.34,0.46,0.55,0.74,1.18,1.54,2.2,-1,3.86,5.81,8.24,10.89,-1,-1];
sch80id_data=[0.546,0.742,0.957,1.278,1.5,1.939,2.323,2.9,3.826,4.813,5.761,7.625,9.564,11.376,12.5,14.314];
sch80od_data=[0.84,1.05,1.315,1.66,1.9,2.375,2.875,3.5,4.5,5.563,6.625,8.625,10.75,12.75,14,16];
sch80pvcweight_data=[0.2,0.27,0.41,0.52,0.67,0.95,1.45,1.94,2.75,3.87,5.42,8.05,12,16.5,19.3,25.44];
sch80cpvcweight_data=[0.22,0.3,0.44,0.61,0.74,1.02,1.56,2.09,3.05,-1,5.82,8.83,13.09,18,-1,-1];
thou2mm=25.4;

//---- Functions

/////////////////////////////////////////////////////////
// module create_pvc_component()
// This generates geometry for creating PVC pipe fittings.
// In general, you should use create_pvc() instead because it gives more options.
// schedule = Rated strength (40 or 80)
// nom_idx = Nominal size index as described by nom_data[] 
// length - Length in mm
// generate - What to generate:
//		0="outside fitting"
//		1="outside fitting - boolean diff"
//		2="inside fitting"
//		3="inside fitting - boolean diff"
// tightness - Tightness of fit, in mm (0=tight 0.3=snug 0.6=loose)
module create_pvc_component(schedule=40,nom_idx=0,generate=0,tightness=0.02,length=35) {
	dia=
	(thou2mm*(schedule==80 ?
		(generate==0||generate==1?sch80od_data[nom_idx]:sch80id_data[nom_idx])
		:
		(generate==0||generate==1?sch40od_data[nom_idx]:sch40id_data[nom_idx])
	))
	+(generate==2||generate==3?-tightness:tightness);
	echo("========== INFO ==========");
	echo(str("for ",nom_data[nom_idx],"in (nom) pipe"));
	echo(str("created ",dia,"mm dia part"));
	echo(str("including ",(generate==2||generate==3?-tightness:tightness),"mm for fit"));
	echo("==========================");
	// now draw it
	rotate([90,0,0]) if(generate==1||generate==3){
		cylinder(r=dia/2,h=length,center=true);
	}else{
		difference() {
			cube([dia+10,dia+10,length],center=true);
			cylinder(r=dia/2,h=length,center=true);
		}
	}
};

/////////////////////////////////////////////////////////
// module create_pvc()
// This generates geometry for creating PVC pipe fittings.
// Just like create_pvc_component() only adds generate options 4 and 5
// schedule = Rated strength (40 or 80)
// nom_idx = Nominal size index as described by nom_data[] 
// length - Length in mm
// generate - What to generate:
//		0="outside fitting"
//		1="outside fitting - boolean diff"
//		2="inside fitting"
//		3="inside fitting - boolean diff"
//		4="inside outside"
//		5="inside outside - boolean diff"
// tightness - Tightness of fit, in mm (0=tight 0.3=snug 0.6=loose)
module create_pvc(schedule=40,nom_idx=0,generate=0,tightness=0.02,length=35) {
	if(generate<=3){
		create_pvc_component(schedule,nom_idx,generate,tightness,length);
	}
	else if(generate==4){
		difference() {
			create_pvc_component(schedule,nom_idx,1,tightness,length);
			create_pvc_component(schedule,nom_idx,3,tightness,length*2);
		}
	}
	else{
		union() {
			create_pvc_component(schedule,nom_idx,0,tightness,length);
			create_pvc_component(schedule,nom_idx,3,tightness,length);
		}
	}
};

//---- The program
create_pvc(schedule,nom_idx,generate,tightness,length);
