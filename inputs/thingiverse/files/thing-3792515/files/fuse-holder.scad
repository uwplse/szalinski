count = 16;
/*[Advanced]*/
step = 3;
fuseThin=0.65;
flapWidth=5.2;
fuseWidth = 19.1;
gap=0.1;
flapsSpace=4.1;
holderHeight=7;
angleGap = -2;

corner = 2;

xMax = fuseWidth;
yMax = (count+1)*step;
zMax = holderHeight;

difference(){
  roundedCube(xMax,yMax,zMax);

  translate([(fuseWidth - 2*flapWidth - flapsSpace)/2 - gap, step - gap - fuseThin/2, 0])
  union()
    for(i = [0,flapWidth + flapsSpace]) 
			for(j = [0 : count-1])
        translate([i,j*step,0])					
          rotate([0,0,(i>0)?angleGap:-angleGap]) union(){
						cube([flapWidth + 2*gap, fuseThin + 2*gap, holderHeight ]);
						for(k = [0, holderHeight])
							translate([0,fuseThin-gap,k])
								rotate([0,90,0])
									cylinder(d = fuseThin*4, h = flapWidth + 2*gap, $fn=4);
					}
}

module roundedCube(x,y,z){
	translate([corner, corner, corner])
	hull(){
		for(a=[0,x-2*corner])
			for(b=[0,y-2*corner])
				for(c=[0,z-2*corner])
					translate([a,b,c]) sphere(r=corner, $fn=8);
	}
}