$fn=40; //[10,15,20,25,30,35,40,45,50]
bottomplate_thickness=2;	//[0:10]
bottomcircle_thickness=1.5; //[0.5:5]
firstlevel_hight=20;		//[5:40]
firstlevel_radius=5;		//[1:50]
secondlevel_hight=3;	//[0:10]
secondlevel_radius_top=firstlevel_radius+secondlevel_hight;
secondlevel_limit_hight=4;	//[0:10]
secondlevel_limit_thickness=secondlevel_limit_hight/3;
thirdlevel_hight=20;	//[0:50]
thirdlevel_radius=3;	//[0:50]
thirdlevel_top_hight=5;	//[0:50]

//bottom plate
translate(v=[0,0,-bottomplate_thickness/2])
	{
		cube(size=[20,20,bottomplate_thickness], center=true);
	}

//bottom circle plate
translate(v=[0,0,bottomcircle_thickness/2])
	{
		cylinder(h=bottomcircle_thickness, r=9.5, center=true);
	}

//first cylindrical level
translate(v=[0,0,firstlevel_hight/2+bottomcircle_thickness])
	{
		cylinder(h=firstlevel_hight, r=firstlevel_radius, center=true);
	}

//second level, angled cylinder
translate(v=[0,0,secondlevel_hight/2+firstlevel_hight+bottomcircle_thickness])
	{
		cylinder(h=secondlevel_hight, r1=firstlevel_radius, r2=secondlevel_radius_top, center=true);
	}

//second level limit
		translate(v=[0,0,secondlevel_limit_hight/2+secondlevel_hight+firstlevel_hight+bottomcircle_thickness])
	{	
		difference()
			{
				cylinder(h=secondlevel_limit_hight, r=secondlevel_radius_top, center=true);
		
				cylinder(h=secondlevel_limit_hight+0.1, r=secondlevel_radius_top-secondlevel_limit_thickness, center=true);
			}
	}
//third level
translate(v=[0,0,thirdlevel_hight/2+secondlevel_hight+firstlevel_hight+bottomcircle_thickness])
	{
		cylinder(h=thirdlevel_hight, r=thirdlevel_radius, center=true);
	}

//third level top
	translate(v=[0,0,thirdlevel_top_hight/2+thirdlevel_hight+secondlevel_hight+firstlevel_hight+bottomcircle_thickness])
	{
		cylinder(h=thirdlevel_top_hight, r1=thirdlevel_radius, r2=0, center=true);
	}





//union()
//{
//	translate(v=[0,0,-15])
		//{
			//cube(size = [15,15,30], center =true);
		//	cylinder(h=20, r=7.5);
	//	}	
//	sphere(r=7.5);
//}

