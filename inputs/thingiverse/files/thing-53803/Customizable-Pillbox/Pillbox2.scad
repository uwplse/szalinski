include<write/Write.scad>

// Number of Days
Number_of_days=1; //[1,2,3,4,5,6,7]

// Extra?
Extra=2; //[1:Yes,2:No]

// Text on Lid?
Text=1; //[1:Yes,2:No

// Number of Weeks
Number_of_weeks=1; //[1,2,3,4]


//////////////////////////////////////////////////////////////////////////////////////////////

module clasp()
{
	cube([1,5,1]);
}
module pill()
{
	union()
	{
		difference()
		{
			cube(20,20,20);
			translate([1,1,3])cube(18,18,18);
		}
		translate([19,7.5,20])clasp();
		translate([0,7.5,20])clasp();
	}
}
module pillbox()
{
	union()
	{
		pill();
		
	}
}
module pillcontaineroneweek()
{
	if(Extra==1)
	{
		union()
		{
			for(i=[0:Number_of_days])
			{
				translate([0,i*19,0])pillbox();
			}
		}
	}
	else
	{
		union()
		{
			for(i=[0:Number_of_days-1])
			{
				translate([0,i*19,0])pillbox();
			}
		}
	}
}

module pillcontainer()
{
	if(Number_of_weeks==1)
	{
		pillcontaineroneweek();
	}
	else
	{
		union()
		{
			for(i=[0:Number_of_weeks-1])
			{
				translate([i*20,0,0])pillcontaineroneweek();
				
			}
		}
	}
}

module lid()
{
	union()
	{
		difference()
		{
			translate([-25,0,0])cube([20,19,1]);
			translate([-6,7.5,-.1])cube([1,5,1]);
			translate([-25,7.5,-.1])cube([1,5,1]);
		}
	}
}

module lidoneweek()
{
	if(Extra==1)
	{
		union()
		{
			for(i=[0:Number_of_days])
			{
				translate([0,i*21,0])lid();
			}
		}
	}
	else
	{
		union()
		{
			for(i=[0:Number_of_days-1])
			{
					translate([0,i*21,0])lid();
			}
			
		}
	}
}


module textonlid()
{
	if(Text==1)
	{
		if(Extra==1&&Number_of_days==7)
		{
			union()
			{
				for(i=[0:Number_of_days])
				{
					rotate([0,0,90])translate([7,10,1])write("SMTWTFSE",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("SMTWTFSE",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==2&&Number_of_days==7)
		{
			union()
			{
				for(i=[0:Number_of_days-1])
				{
					rotate([0,0,90])translate([7,10,1])write("SMTWTFS",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("SMTWTFS",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==1&&Number_of_days==6)
		{
			union()
			{
				for(i=[0:Number_of_days])
				{
					rotate([0,0,90])translate([7,10,1])write("123456E",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("123456E",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==2&&Number_of_days==6)
		{
			union()
			{
				for(i=[0:Number_of_days-1])
				{
					rotate([0,0,90])translate([7,10,1])write("123456",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("123456",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==1&&Number_of_days==5)
		{
			union()
			{
				for(i=[0:Number_of_days])
				{
					rotate([0,0,90])translate([7,10,1])write("12345E",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("12345E",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==2&&Number_of_days==5)
		{
			union()
			{
				for(i=[0:Number_of_days-1])
				{
					rotate([0,0,90])translate([7,10,1])write("12345",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("12345",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==1&&Number_of_days==4)
		{
			union()
			{
				for(i=[0:Number_of_days])
				{
					rotate([0,0,90])translate([7,10,1])write("1234E",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("1234E",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==2&&Number_of_days==4)
		{
			union()
			{
				for(i=[0:Number_of_days-1])
				{
					rotate([0,0,90])translate([7,10,1])write("1234",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("1234",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==1&&Number_of_days==3)
		{
			union()
			{
				for(i=[0:Number_of_days])
				{
					rotate([0,0,90])translate([7,10,1])write("123E",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("123E",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==2&&Number_of_days==3)
		{
			union()
			{
				for(i=[0:Number_of_days-1])
				{
					rotate([0,0,90])translate([7,10,1])write("123",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("123",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==1&&Number_of_days==2)
		{
			union()
			{
				for(i=[0:Number_of_days])
				{
					rotate([0,0,90])translate([7,10,1])write("12E",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("12E",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==2&&Number_of_days==2)
		{
			union()
			{
				for(i=[0:Number_of_days-1])
				{
					rotate([0,0,90])translate([7,10,1])write("12",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("12",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==1&&Number_of_days==1)
		{
			union()
			{
				for(i=[0:Number_of_days])
				{
					rotate([0,0,90])translate([7,10,1])write("1E",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("1E",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
		if(Extra==2&&Number_of_days==1)
		{
			union()
			{
				for(i=[0:Number_of_days-1])
				{
					rotate([0,0,90])translate([7,10,1])write("1",h=10,t=2,space=3.05);
					rotate([0,0,90])translate([9,5,1])write("1",h=5,t=2,font="braille.dxf",space=6.1);
					lidoneweek();
				}
			}
		}
	}
	else
	{
	lidoneweek();
	}
}

module fulllid()
{
	if(Number_of_weeks==1)
	{
		textonlid();
	}
	if(Number_of_weeks==2)
	{
		textonlid();
		translate([-25,0,0])textonlid();
	}
	if(Number_of_weeks==3)
	{
		textonlid();
		translate([-25,0,0])textonlid();
		translate([-50,0,0])textonlid();
	}
	if(Number_of_weeks==4)
	{
		textonlid();
		translate([-25,0,0])textonlid();
		translate([-50,0,0])textonlid();
		translate([-75,0,0])textonlid();
	}
}
fulllid();
pillcontainer();

			
		










	