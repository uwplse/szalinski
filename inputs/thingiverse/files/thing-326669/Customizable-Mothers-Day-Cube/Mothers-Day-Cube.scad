M_Slit_Width = 150; //[0:300]
M_Slit_Height = 70; //[0:100]
O_Width = 40; //[0:100]
O_Height = 40; //[0:100]
//width in centimeters
size = 5;
Clip_O_To_Match_M_Slits = 0; //[1:yes,0:no]
Upside_Down = 0; //[1:yes,0:no]

if(Upside_Down==0)
{
	scale(size*10) object();
}
else
{
	scale(size*10) translate([0,0,1]) scale([1,1,-1]) object();
}


module object()
{
difference()
{
	translate([0,0,0.5]) cube(size=1, center=true);
	union()
	{
		difference()
		{
			translate([0,0,(mSepH/2)-0.1]) cube(size=[0.333+(4*mSepW/3),2,mSepH+0.2], center=true);
			translate([0,0,0.5]) cube(size=[0.333-(2*mSepW/3),2,1], center=true);
		}
		difference()
		{
			translate([0,0,0.5]) cube(size=[2,ow,oh], center=true);
			if(co==1)
			{
				translate([-0.5,-0.5,mSepH]) cube(size=[1,1,1-mSepH]);
			}
		}
	}
}
}

mSepW = M_Slit_Width/1000;
mSepH = M_Slit_Height/100;
ow = O_Width/100;
oh = O_Height/100;
co = Clip_O_To_Match_M_Slits;