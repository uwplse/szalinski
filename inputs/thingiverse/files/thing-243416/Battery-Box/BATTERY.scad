
height=31;		//box height
diam=11.5;		//battery diameter 
rows=4;
spacing=1;
width=(diam+spacing)*rows+4;


   difference()
  {
			 intersection()
      {
			cube([width,width,height], center = true);
		}

for ( j = [(-width/2)+(width-rows*(diam+spacing))/2+(diam+spacing)/2: diam+spacing : ((width/2))] )
	{
		for ( i = [(-width/2)+(width-rows*(diam+spacing))/2+(diam+spacing)/2 : diam+spacing : ((width/2))] )
		{
			translate([i , j, 2]) cylinder(h = height, r = diam/2, center = true, $fn=20 );
		}
	}
		for ( k = [0 : 3] )
		{
			 rotate([0, 0, k * 90])
				translate([width/2 , width/2, height/2-8/2.1])cube([width*2,1.5,8], center = true);
		}
}