//preview[view:south, tilt:top]

/* [Main] */
//Number of chains
chains = 25; 

//Number of Links per chain
links = 17;
//Chain Curvature
curvature = 45; //[0:180]

/* [Link] */
//Link thickness
thickness = 1;
height = 16;
width = 8;

/* [Hidden] */
smooth = 15;
pi = 3.145926535;

//Handle
color([0,0,0])
translate([0,0,-200])
cylinder(200,20,20);

for (i = [1 : chains]){
	rotate(rands(0,360,1)[0],[0,0,1])
	chain(links,curvature);
//	chain(rands(20,30,1)[0],rands(0,180,1)[0]);
}


module chain(links,curvature){
	length = (links + 1) * ((height + width)/2 + thickness);
	radius = length / d2r(curvature);

	lc = curvature/links;

	link(smooth,thickness,height,width);
	if(links > 1){
		for(i = [1 : links-1]){
		if( curvature > 0){
			translate([radius *(1 - cos( i * lc)),0, radius * sin ( i * lc)])
			rotate(lc*i,[0,1,0])
			if ( i%2 == 1)
			{
				rotate(90*i,[0,0,1])
				link(smooth,thickness,height,width);
			} else{
				link(smooth,thickness,height,width);
			}
		}else{
			translate([0,0,i*(height/2 + width/2 + thickness)])
			if ( i%2 == 1)
			{
				rotate(90*i,[0,0,1])
				link(smooth,thickness,height,width);
			} else{
				link(smooth,thickness,height,width);
			}
		}
		}
	}
}

module link(smooth,thickness,height,width){
	color("Gray"){
	translate([-width/2, 0, -height/2]){
		cylinder(height,thickness,thickness);	
		translate([width,0,0]){
			cylinder(height,thickness,thickness);
		}
		for( i = [0 : smooth])
		{
			translate([(width/2) - (width/2) * cos(i*180/smooth),
						0, 
						-(width/2) * sin(i*180/smooth)])
			sphere(thickness);
		}

		for( i = [0 : smooth])
		{
			translate([(width/2) - (width/2) * cos(i*180/smooth),
						0, 
						height + (width/2) * sin(i*180/smooth)])	
			sphere(thickness);
		}
	}
	}
}

function d2r(theta) = theta*pi/180;