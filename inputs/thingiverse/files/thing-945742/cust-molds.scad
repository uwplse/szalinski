scale = 100; // [50:10:250]
pyramid(scale=scale);
translate([(scale*0.4)*(scale*0.04),(scale*0.4)*(scale*0.04),0])
mirrored_stairs_mold(scale=scale);

//*****All modules that were used for this******

//************************************************
// Stairs.scad: Produces 1 set of stairs
//
//			   <--->xdelta
//			   |   |
//			---	   |  |
//	zheight|	   |  |
//		---		   | / <ywidth
//	   |		   |/ 
//		<--xlength->

//************************************************

module stairs(xlength=20, xdelta=2, ywidth=5, zheight=2)
{
	for(x=[xlength:-xdelta:0])
	{
		translate([0,-ywidth/2,zheight*x/xdelta]) 
		color([sin(x*xdelta),sin(x*ywidth),sin(x*zheight)]) //use sin(x) function to make sure the value is between 0 and 1
		cube([xlength-x,ywidth,zheight]);
	}
}
//************************************************
module pyramid_side(ywidth=5,xlength=20,zheight=20,ystep=10){
	union()
	{
		translate([0,ystep*(ystep+1.3),0]) //figuring out the right factor for smooth pyramid-style
		{
			for(z=[0:zheight:ystep*zheight])
			{
				for(x=[-xlength*ystep+z:2*xlength:xlength*ystep-z]) //this one ensures that we get a triangular side of a pyramid
				{
					
					translate([x,-(z/zheight)*ystep,z])
					{
						translate([0,-((ystep-ywidth)/2)-ywidth,zheight/2])
						color([sin(x),cos(z),0])
						cube([2*xlength,ystep,zheight],center=true);
					}
				}
			}
		}
	}
}
//************************************************
module pyramid(scale=200)
{
	ywidth = scale/200*15;
	ystep = scale/10;
	xlength=scale/10;
	zheight=scale/10;
	for(r=[0:90:359])
	{
		rotate([0,0,r])
		pyramid_side(ystep=ystep,ywidth=ywidth,xlength=xlength,zheight=zheight);
	}
}
//************************************************
module mirrored_stairs(scale=200)
{
	ywidth = scale/200*15;
	xlength=scale/10;
	stairs(ywidth=ywidth,xlength=xlength);
	mirror([1,0,0])				//mirror the stairs for double stair-pair awesomeness
	stairs(ywidth=ywidth,xlength=xlength);
}
//************************************************
module mirrored_stairs_mold(scale=200)
{
	difference()
	{
		mirrored_stairs(scale=scale);
		scale([0.9,0.9,1])
		translate([0,0,-0.5])
		mirrored_stairs(scale=scale);
	}
}