/*Parametric belting section generator 
By - The kilothing
Derived from https://www.thingiverse.com/thing:19758 by doommeister
Which was derived from http://www.thingiverse.com/thing:16627 by Droftarts 
Also derived from https://www.thingiverse.com/thing:357024 by Jaap
*/


//Variables
tooth_profile = "T5"; // [GT2 2mm pitch,T2.5,T5,T10,MXL]
belt_width_in_mm = 4;
num_teeth = 20;
backing_thickness_override_in_mm = 0;

//Draw
color("gray")belt_length(profile=tooth_profile, belt_width=belt_width_in_mm, n=num_teeth, backing=backing_thickness_override_in_mm);

//Outer Module
module belt_length(profile = "T2.5", belt_width = 6, n = 10, backing = 0)
{
  if ( profile == "T2.5" ) 
    { 
      _belt_length(
        profile=profile, 
        n = n, 
        belt_width = belt_width,
        tooth_pitch = 2.5,
        backing_thickness = backing == 0 ? 0.6 : backing
        );
    }
  if ( profile == "T5" ) 
    { 
      _belt_length(
        profile=profile, 
        n = n, 
        belt_width = belt_width,
        tooth_pitch = 5,
        backing_thickness = backing == 0 ? 1 : backing
        );
    }
  if ( profile == "T10" ) 
    { 
      _belt_length(
        profile=profile, 
        n = n, 
        belt_width = belt_width,
        tooth_pitch = 10,
        backing_thickness = backing == 0 ? 2 : backing
        );
    }
  if ( profile == "MXL" ) 
    { 
      _belt_length(
        profile=profile, 
        n = n, 
        belt_width = belt_width,
        tooth_pitch = 2.032,
        backing_thickness = backing == 0 ? 0.64 : backing
        );
    }
  if ( profile == "GT2 2mm pitch" ) 
    { 
      _belt_length(
        profile=profile, 
        n = n, 
        belt_width = belt_width,
        tooth_pitch = 2,
        backing_thickness = backing == 0 ? 0.63 : backing
        );
    }
}



//inner module
module _belt_length(profile = "T2.5", n = 10, belt_width = 5, tooth_pitch = 2.5, backing_thickness = 0.6)
{

for( i = [0:n])
	{
		union(){

			if ( profile == "T2.5" ) { translate([tooth_pitch*i,0,0])T2_5(width = belt_width);}
			if ( profile == "T5" ) { translate([tooth_pitch*i,0,0])T5(width = belt_width);}
			if ( profile == "T10" ) { translate([tooth_pitch*i,0,0])T10(width = belt_width);}
			if ( profile == "MXL" ) { translate([tooth_pitch*i,0,0])MXL(width = belt_width);}
			if ( profile == "GT2 2mm pitch" ) { translate([tooth_pitch*i,0,0])GT2_2mm(width = belt_width);}
      // color([0,0,0])
			translate([(tooth_pitch*i)-(tooth_pitch/2),-backing_thickness,0])cube([tooth_pitch,backing_thickness,belt_width]);
		}
	}
}



//Tooth Form modules - Taken from http://www.thingiverse.com/thing:1662
module T2_5(width = 2)
	{
	linear_extrude(height=width) polygon([[-0.839258,-0.5],[-0.839258,0],[-0.770246,0.021652],[-0.726369,0.079022],[-0.529167,0.620889],[-0.485025,0.67826],[-0.416278,0.699911],[0.416278,0.699911],[0.484849,0.67826],[0.528814,0.620889],[0.726369,0.079022],[0.770114,0.021652],[0.839258,0],[0.839258,-0.5]]);
	}

module T5(width = 2)
	{
	linear_extrude(height=width) polygon([[-1.632126,-0.5],[-1.632126,0],[-1.568549,0.004939],[-1.507539,0.019367],[-1.450023,0.042686],[-1.396912,0.074224],[-1.349125,0.113379],[-1.307581,0.159508],[-1.273186,0.211991],[-1.246868,0.270192],[-1.009802,0.920362],[-0.983414,0.978433],[-0.949018,1.030788],[-0.907524,1.076798],[-0.859829,1.115847],[-0.80682,1.147314],[-0.749402,1.170562],[-0.688471,1.184956],[-0.624921,1.189895],[0.624971,1.189895],[0.688622,1.184956],[0.749607,1.170562],[0.807043,1.147314],[0.860055,1.115847],[0.907754,1.076798],[0.949269,1.030788],[0.9837,0.978433],[1.010193,0.920362],[1.246907,0.270192],[1.273295,0.211991],[1.307726,0.159508],[1.349276,0.113379],[1.397039,0.074224],[1.450111,0.042686],[1.507589,0.019367],[1.568563,0.004939],[1.632126,0],[1.632126,-0.5]]);
	}

module T10(width = 2)
	{
	linear_extrude(height=width) polygon([[-3.06511,-1],[-3.06511,0],[-2.971998,0.007239],[-2.882718,0.028344],[-2.79859,0.062396],[-2.720931,0.108479],[-2.651061,0.165675],[-2.590298,0.233065],[-2.539962,0.309732],[-2.501371,0.394759],[-1.879071,2.105025],[-1.840363,2.190052],[-1.789939,2.266719],[-1.729114,2.334109],[-1.659202,2.391304],[-1.581518,2.437387],[-1.497376,2.47144],[-1.408092,2.492545],[-1.314979,2.499784],[1.314979,2.499784],[1.408091,2.492545],[1.497371,2.47144],[1.581499,2.437387],[1.659158,2.391304],[1.729028,2.334109],[1.789791,2.266719],[1.840127,2.190052],[1.878718,2.105025],[2.501018,0.394759],[2.539726,0.309732],[2.59015,0.233065],[2.650975,0.165675],[2.720887,0.108479],[2.798571,0.062396],[2.882713,0.028344],[2.971997,0.007239],[3.06511,0],[3.06511,-1]]);
	}

module MXL(width = 2)
	{
	linear_extrude(height=width) polygon([[-0.660421,-0.5],[-0.660421,0],[-0.621898,0.006033],[-0.587714,0.023037],[-0.560056,0.049424],[-0.541182,0.083609],[-0.417357,0.424392],[-0.398413,0.458752],[-0.370649,0.48514],[-0.336324,0.502074],[-0.297744,0.508035],[0.297744,0.508035],[0.336268,0.502074],[0.370452,0.48514],[0.39811,0.458752],[0.416983,0.424392],[0.540808,0.083609],[0.559752,0.049424],[0.587516,0.023037],[0.621841,0.006033],[0.660421,0],[0.660421,-0.5]]);
	}

module GT2_2mm(width = 2) {
  pf_GT2_2=[[ 0.747183,-0.5     ],[ 0.747183, 0       ],[ 0.647876, 0.037218],
				[ 0.598311, 0.130528],[ 0.578556, 0.238423],[ 0.547158, 0.343077],
				[ 0.504649, 0.443762],[ 0.451556, 0.53975 ],[ 0.358229, 0.636924],
				[ 0.2484  , 0.707276],[ 0.127259, 0.750044],[ 0       , 0.76447 ],
				[-0.127259, 0.750044],[-0.2484  , 0.707276],[-0.358229, 0.636924],
				[-0.451556, 0.53975 ],[-0.504797, 0.443762],[-0.547291, 0.343077],
				[-0.578605, 0.238423],[-0.598311, 0.130528],[-0.648009, 0.037218],
				[-0.747183, 0       ],[-0.747183,-0.5]];
  linear_extrude(height=width) polygon(pf_GT2_2);
}
