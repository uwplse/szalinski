/*Parametric belting section generator 
 * types GT2 2mm T2.5 T5 T10 MXL
 *
 * (c) ALJ_rprp
 *
 * Derived from http://www.thingiverse.com/
 * thing:19758 By The DoomMeister
 * thing:16627 by Droftarts
 *
 * licence GPL 2.1 or later
 *
 * deal properly with ends
 * allow circular segments
 * length is given in mm not nb of teeth
 * belt is centered at z=0 and extend along x
 * 
 * TODO : add ofset for cosmetic teeth liaisons between segments
 *
 * usage :
 * belt_angle(prf = tT2_5, rad=25, bwdth = 6, angle=90,fn=128)
 * belt_len  (prf = tT2_5, belt_width = 6, len = 10)
 */


// profiles
tGT2_2=0;
tT2_5	=1;
tT5	=2;
tT10	=3;
tMXL	=4;

test_belt();

module test_belt() {
	translate([-00.5,0,5.5])cube([1,40,1]);
	
	belt_len(profile = tT10, belt_width = 10, len = 100);
	translate([0,0,-20])color("red")belt_len(profile = tT5, belt_width = 10, len = 100);
	translate([0,0,-40])color("green")belt_len(profile = tT2_5, belt_width = 10, len = 80);
	translate([0,0,-60])color("blue")belt_len(profile = tGT2_2, belt_width = 10, len = 100);
	translate([0,0,-80])color("orange")belt_len(profile = tMXL, belt_width = 10, len = 100);
	
	translate([0,0,-0])  belt_angle(tT10,20,10,180);
	translate([0,0,-20]) belt_angle(tT5,15,10,90);
	translate([0,0,-40]) belt_angle(tT2_5,25,10,120);
	translate([0,0,-60]) belt_angle(tGT2_2,30,10,40);
	translate([0,0,-80]) belt_angle(tMXL,30,10,40);

	
	translate([0,0,-100])color("aquamarine") {
		belt_len(tT2_5,10, 50);
		translate([50,30,0]) rotate([0,0,180]) belt_len(tT2_5,10,50);
		translate([ 0,30,0]) rotate([0,0,180]) belt_angle(tT2_5,15,10,180);
		translate([50,0,0]) rotate([0,0,0]) belt_angle(tT2_5,15,10,180);
	}
}

/* there is no partial rotate extrude in scad, hence the workaround
 * note that the pie slice will silently drop angles > 360 */
module p_slice(radius, angle,height,back_t=0.6) {
	pt_slc = [[0,radius],
		 		 [0 ,-back_t],
		 		 [radius,-back_t],
		 		 [radius+back_t,radius],
		 		 [radius+back_t,radius*2],
				 [0,radius*2+back_t],
				 [-radius-back_t,radius*2+back_t],
				 [-radius-back_t,radius],
				 [-radius-back_t,-back_t],
		 		 [(radius+back_t)*sin(angle),(radius+back_t)*(1-cos(angle))-back_t]];

	if (angle<=90) {
		linear_extrude(height = height+0.2, center=true)
			polygon( points = pt_slc, 
						paths=[[0,1,2,9]]);
	}else if (angle<=180){
		linear_extrude(height = height+0.2, center=true)
			polygon( points = pt_slc,  
						paths=[[0,1,2,3,4,9]]);
	}else if (angle<=270){
		linear_extrude(height = height+0.2, center=true)
			polygon( points = pt_slc,  
						paths=[[0,1,2,3,4,5,6,9]]);
	}else if (angle<360) {
		linear_extrude(height = height+0.2, center=true)
			polygon( points = pt_slc,  
						paths=[[0,1,2,3,4,5,6,7,8,9]]);
	}
}

dp=5;

module belt_angle(prf = tT2_5, rad=25, bwdth = 6, angle=90,fn=128) {
	av=360/2/rad/3.14159*tpitch[prf];
	bk=bk_thick[prf];

	nn=ceil(angle/av);
	ang=av*nn;
	intersection(){
	p_slice(rad,angle,bwdth,bk_thick[prf]);
		union () {
			for( i = [0:nn]){
				translate ([0,rad,-bwdth/2])rotate ([0,0,av*i])translate ([0,-rad,0])
						draw_tooth(prf,0,bwdth);
		}
		translate ([0,rad,-bwdth/2]) rotate_extrude(angle = 90, $fn=fn)
												polygon([[rad,0],[rad+bk,0],[rad+bk,bwdth],[rad,bwdth]]);
		}
	}
}

//Outer Module
module belt_len(profile = tT2_5, belt_width = 6, len = 10){
	if ( profile == tT2_5 ) { _belt_len(prf=profile,len = len,bwdth = belt_width);}
	if ( profile == tT5 )   { _belt_len(prf=profile,len = len,bwdth = belt_width);}
	if ( profile == tT10 )  { _belt_len(prf=profile,len = len,bwdth = belt_width);}
	if ( profile == tMXL )	{ _belt_len(prf=profile,len = len,bwdth = belt_width);}
	if ( profile == tGT2_2 ){ _belt_len(prf=profile,len = len,bwdth = belt_width);}
}

//inner module
module _belt_len(prf = -1, len = 10, bwdth = 5) {

	n=ceil(len/tpitch[prf]);

	translate ([0,0,-bwdth/2]) intersection() {
		union(){
			for( i = [0:n]) {
				draw_tooth(prf,i,bwdth);
			}
		translate([-1,-bk_thick[prf],0])cube([len+1,bk_thick[prf],bwdth]);
		}
	translate([0,-bk_thick[prf],0])cube([len,max_h[prf]+bk_thick[prf],bwdth]);
	}
}

module draw_tooth(prf,i,bwdth) {
				if ( prf == tT2_5 ) { translate([tpitch[prf]*i,0,0])
													linear_extrude(height=bwdth) polygon(pf_T2_5);}
				if ( prf == tT5 ) { translate([tpitch[prf]*i,0,0])
													linear_extrude(height=bwdth) polygon(pf_T5);}
				if ( prf == tT10 ) { translate([tpitch[prf]*i,0,0])
													linear_extrude(height=bwdth) polygon(pf_T10);}
				if ( prf == tMXL ) { translate([tpitch[prf]*i,0,0])
													linear_extrude(height=bwdth) polygon(pf_MXL);}
				if ( prf == tGT2_2 ) { translate([tpitch[prf]*i,0,0])
													linear_extrude(height=bwdth) polygon(pf_GT2_2);}
}

/************************************
 *				DATA TABLES					*
 ************************************/
tpitch = [2,2.5,5,10,2.032];
bk_thick=[0.6,0.6,1,2,0.64];
max_h=[0.76447, 0.699911, 1.189895, 2.499784, 0.508035];

pf_GT2_2=  [[ 0.747183,-0.5     ],[ 0.747183, 0       ],[ 0.647876, 0.037218],
				[ 0.598311, 0.130528],[ 0.578556, 0.238423],[ 0.547158, 0.343077],
				[ 0.504649, 0.443762],[ 0.451556, 0.53975 ],[ 0.358229, 0.636924],
				[ 0.2484  , 0.707276],[ 0.127259, 0.750044],[ 0       , 0.76447 ],
				[-0.127259, 0.750044],[-0.2484  , 0.707276],[-0.358229, 0.636924],
				[-0.451556, 0.53975 ],[-0.504797, 0.443762],[-0.547291, 0.343077],
				[-0.578605, 0.238423],[-0.598311, 0.130528],[-0.648009, 0.037218],
				[-0.747183, 0       ],[-0.747183,-0.5]];
pf_T2_5=   [[-0.839258,-0.5     ],[-0.839258, 0       ],[-0.770246, 0.021652],
				[-0.726369, 0.079022],[-0.529167, 0.620889],[-0.485025, 0.67826 ],
				[-0.416278, 0.699911],[ 0.416278, 0.699911],[ 0.484849, 0.67826 ],
				[ 0.528814, 0.620889],[ 0.726369, 0.079022],[ 0.770114, 0.021652],
				[ 0.839258, 0       ],[ 0.839258,-0.5]];
pf_T5= 	  [[-1.632126,-0.5     ],[-1.632126, 0       ],[-1.568549, 0.004939],
				[-1.507539, 0.019367],[-1.450023, 0.042686],[-1.396912, 0.074224],
				[-1.349125, 0.113379],[-1.307581, 0.159508],[-1.273186, 0.211991],
				[-1.246868, 0.270192],[-1.009802, 0.920362],[-0.983414, 0.978433],
				[-0.949018, 1.030788],[-0.907524, 1.076798],[-0.859829, 1.115847],
				[-0.80682 , 1.147314],[-0.749402, 1.170562],[-0.688471, 1.184956],
				[-0.624921, 1.189895],[ 0.624971, 1.189895],[ 0.688622, 1.184956],
				[ 0.749607, 1.170562],[ 0.807043, 1.147314],[ 0.860055, 1.115847],
				[ 0.907754, 1.076798],[ 0.949269, 1.030788],[ 0.9837  , 0.978433],
				[ 1.010193, 0.920362],[ 1.246907, 0.270192],[ 1.273295, 0.211991],
				[ 1.307726, 0.159508],[ 1.349276, 0.113379],[ 1.397039, 0.074224],
				[ 1.450111, 0.042686],[ 1.507589, 0.019367],[ 1.568563, 0.004939],
				[ 1.632126, 0       ],[ 1.632126,-0.5]];
pf_T10=    [[-3.06511 ,-1       ],[-3.06511 , 0       ],[-2.971998, 0.007239],
				[-2.882718, 0.028344],[-2.79859 , 0.062396],[-2.720931, 0.108479],
				[-2.651061, 0.165675],[-2.590298, 0.233065],[-2.539962, 0.309732],
				[-2.501371, 0.394759],[-1.879071, 2.105025],[-1.840363, 2.190052],
				[-1.789939, 2.266719],[-1.729114, 2.334109],[-1.659202, 2.391304],
				[-1.581518, 2.437387],[-1.497376, 2.47144 ],[-1.408092, 2.492545],
				[-1.314979, 2.499784],[ 1.314979, 2.499784],[ 1.408091, 2.492545],
				[ 1.497371, 2.47144 ],[ 1.581499, 2.437387],[ 1.659158, 2.391304],
				[ 1.729028, 2.334109],[ 1.789791, 2.266719],[ 1.840127, 2.190052],
				[ 1.878718, 2.105025],[ 2.501018, 0.394759],[ 2.539726, 0.309732],
				[ 2.59015 , 0.233065],[ 2.650975, 0.165675],[ 2.720887, 0.108479],
				[ 2.798571, 0.062396],[ 2.882713, 0.028344],[ 2.971997, 0.007239],
				[ 3.06511 , 0       ],[ 3.06511 ,-1]];
pf_MXL=    [[-0.660421,-0.5     ],[-0.660421, 0       ],[-0.621898, 0.006033],
				[-0.587714, 0.023037],[-0.560056, 0.049424],[-0.541182, 0.083609],
				[-0.417357, 0.424392],[-0.398413, 0.458752],[-0.370649, 0.48514 ],
				[-0.336324, 0.502074],[-0.297744, 0.508035],[ 0.297744, 0.508035],
				[ 0.336268, 0.502074],[ 0.370452, 0.48514 ],[ 0.39811 , 0.458752],
				[ 0.416983, 0.424392],[ 0.540808, 0.083609],[ 0.559752, 0.049424],
				[ 0.587516, 0.023037],[ 0.621841, 0.006033],[ 0.660421, 0       ],
				[ 0.660421,-0.5]];
