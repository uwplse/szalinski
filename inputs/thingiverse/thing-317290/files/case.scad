$fn=30;

width=40;
length=60;

height=20;
radius=2;
thickness=1.5;
rhole=1.5;

boardw=25;
boardl=40;

boardh=5;




module roundbox(w,l,h,r)
{
	hull()
	{
		for(z=[r,h-r])
			for(y=[r,l-r])
				for(x=[r,w-r])
					translate([x,y,z])
						sphere(r=r);
	
	}
}
module case()
{
	difference()
	{
		union()
		{
			difference()
			{
				roundbox(width,length,height,radius);
				translate([thickness,thickness,thickness])
					roundbox(width-2*thickness,length-2*thickness,height-2*thickness,radius);
			}
			for(y=[thickness+rhole,length-(thickness+rhole)])
			{
				for(x=[thickness+rhole,width-(thickness+rhole)])
				{
					translate([x,y,radius])
					{
						cylinder(r=rhole+1.5,h=height-radius);
					}		
				}
			}

			for(y=[(width-boardw)/2,(width+boardw)/2])
			{
				for(x=[(length-boardl)/2,(length+boardl)/2])
				{
					translate([y,x,radius])
					{
						difference()
						{
							cylinder(r=rhole+1.5,h=boardh);
							cylinder(r=rhole,h=boardh);
						}
					}		
				}
			}

		}
		union()
		{
			for(y=[thickness+rhole,length-(thickness+rhole)])
			{
				for(x=[thickness+rhole,width-(thickness+rhole)])
				{
					translate([x,y,radius])
					{
						cylinder(r=rhole,h=height-radius);
					}		
				}
			}

		}
	}

}
		

module cut()
{
	translate([0,0,height-thickness-1])
		cube([width,length,height]);
}

difference()
{
	case();
	cut();
}


translate([-10,0,thickness+1])
rotate(a=180,v=[0,1,0])
translate([0,0,-(height-thickness-1)])
intersection()
{
	case();
	cut();
}