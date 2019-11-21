/*  Mason Jar fan 40mmx40mm
/* 	Remix of Parametric bean/seed sprouter By schlem  
		and Customizable Fan Mounting Bracket by SasquatchQB
*/

/* [Jar] */
//Inside Diam
ID = 64;        
//Outside Diam
OD = 64;      
//Tube Height
tube_h =0;  
//Mesh Size mm
Mesh = 4;     
//Screening Size
Bar = 1.5;     
//Thickness of Disk and Mesh
height = 2;
//Lid Diam
lid_diam = 68; 

/* [Fan] */
//Enable Fan mount (otherwise just have a blank grid)
enable_fan = 1;
//Fan Size
fan_size = 40;           //[40:40mm, 50:50mm, 60:60mm, 80:80mm]
//Fan Screw Spacing (choose Fan Size here)
screw_spacing = 32;      //[32:40mm, 40:50mm, 50:60mm, 72:80mm]
//Fan Screw Hole Radius (use 2 for #6 (default), 1.7 for M3)
fan_screw = 1.7;

/* [Hidden] */

//Derived Variables
fanscrewmargin=fan_size/2-screw_spacing/2; //margin from edge of fan to center of fan screw hole

$fn=60;

if(enable_fan)
   {
	difference() {
	union() { 
		masonjar(); 
		translate([-ID/PI,-ID/PI,0]) fanplate(); 
		}
		translate([-ID/PI,-ID/PI,0]) fanholes(); 
		}
	}
else { masonjar(); }

// ***************  MODULES ***************   

module masonjar()
	{
	union()
		{
		difference()
			{
			union()
				{
				slats(L=ID, w=Bar, h=height, space=Mesh);
				rotate(a=[0,0,90])
				slats(L=ID, w=Bar, h=height, space=Mesh);
				tube(t_ID=ID, t_OD=OD, t_h=tube_h);
				}
			translate([0,0,-height*.05])
			tube(t_ID=OD, t_OD=OD*1.5, t_h=height*1.1);
			}
		tube(t_ID=OD, t_OD=lid_diam, t_h=height);
		}
	}


module slats(L=50, w=2, h=2, space=2)  //slats(L=ID, w=Bar, h=height, space=Mesh)
	{ 
	translate([0,0,h/2])
	for ( i = [0 : (L/2)/(w+space)] )
		{
	  translate([0, i*(w+space), 0])
		cube([L,w,h], center = true);
		} 	
	
	translate([0,0,h/2])rotate([180,0,0])
	for ( i = [0 : (L/2)/(w+space)] )
		{
	  translate([0, i*(w+space), 0])
		cube([L,w,h], center = true); 	
		}
	}

module tube(t_ID=25, t_OD=30, t_h=10)  //tube(t_ID=ID, t_OD=OD, t_h=height)
	{
	translate([0,0,t_h/2])
	difference()
		{
		cylinder(r=t_OD/2, h=t_h, center = true);
		cylinder(r=t_ID/2, h=t_h*1.1, center = true);
		}
	}



//Fan Bracket
module fanholes()
	{
	//Fan Screw Holes
		translate([fanscrewmargin,fanscrewmargin,-0.1])
		cylinder(r=fan_screw, h=3.2);	
		translate([fan_size-fanscrewmargin,fanscrewmargin,-0.1])
		cylinder(r=fan_screw, h=3.2);
	translate([fanscrewmargin,fan_size-fanscrewmargin,-0.1])
	cylinder(r=fan_screw, h=3.2);
	translate([fan_size-fanscrewmargin,fan_size-fanscrewmargin,-0.1])
	cylinder(r=fan_screw, h=3.2);
	
	//Fan opening
	translate([fan_size/2,fan_size/2,-0.1])
	cylinder(r=fan_size/2*0.875, h=3.2);
	}

module fanplate()
	{
		translate([2,2,0])
		minkowski() { cube([fan_size-4,fan_size-4,1.5]); cylinder(r=2, h=1.5); }
	}

