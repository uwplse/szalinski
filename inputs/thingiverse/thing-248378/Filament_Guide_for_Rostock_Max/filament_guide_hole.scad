tolerance = .25;
input_holesize = [15,6.75,7];
flangewidth = 3;
flangeheight = 1.25;
holesize = [input_holesize[0]-tolerance,input_holesize[1]-tolerance,input_holesize[2]];
tolerance = .25;
flange = [input_holesize[0]+flangewidth, input_holesize[1]+flangewidth, flangeheight];
filamentdiameter = 2.2;

difference(){
	union(){
		translate([-flangewidth/2,-flangewidth/2,0])cube(flange);
		translate([0,0,flangeheight-tolerance])cube(holesize);
	}
	translate([holesize[0]/2, holesize[1]/2, 0])cylinder(r=filamentdiameter/2+tolerance, h=holesize[2]+flangeheight*3, $fa=1, $fs=1);
}