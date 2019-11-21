

//////////////////////////
// Customizable settings
//////////////////////////

// Debug or Relase (Make sure in release mode when done previewing!)
BuildMode=0;			//[0:Debug,1:Release]

// Ring type
HookType = 2;		//[0:Hook, 1:Vertical Ring, 2:Horizontal Ring]

// Diameter of base of round part of knob (in mm).  (Knurled ridges are not included in this measurement.)
WallHookWidth = 7;	// [7:13]

// Number of wall hooks.  This is the part attaching to the cube wall.
WallHookCount = 2;	// [1:Single, 2:Double (recommended), 3:Triple]

// The size of the hook, the distance between the wall and the inner side of the hook;
HookDiameter = 10;	// [7:30]

// The Hook Overhang is used if you want to make the hook extend up from the normal semi-circle hook.
HookOverhang = 0;		// [0:20]



//Hook innerDiameter
//Hook overHang (part that protrudes up from normal curve of hook)
//Hook Width (part that hangs on the wall and the diameter of the hook)
//how many rows of the SteelWall are hung by the chimney with care?
module wallHook (innerDiameter = 10,hookOverhang = 5,hookWidth=7,hangerCount=2, fnn=50)
{
	//scary stuff, don't look at this!	
	translate([-(innerDiameter+ 11/2),-(innerDiameter+11/2)/2-(9.25+(hangerCount-1)*25.5)/2,hookWidth/2])
	union()
	{
		hangers(count=hangerCount,wid=hookWidth);	
		translate([innerDiameter + 11,9.25+(hangerCount-1)*25.5,0])
		rotate([0,0,180])
		hook(innerRad=innerDiameter/2, dia=hookWidth, ovrhang=hookOverhang, tall=9.25+(hangerCount-1)*25.5, fn=fnn);
	}
}

module wallRing (innerDiameter = 10, hookWidth=7, hangerCount=2,horizontal=1, fnn=50)
{
	//scary stuff, don't look at this!	
	translate([-(innerDiameter+ 11/2),-(innerDiameter+11/2)/2-(9.25+(hangerCount-1)*25.5)/2,hookWidth/2])
	union()
	{
		hangers(count=hangerCount,wid=hookWidth);	
		translate([innerDiameter + 11,9.25+(hangerCount-1)*25.5,0])
		rotate([0,0,180])
		loop(innerRad=innerDiameter/2, dia=hookWidth, tall=9.25+(hangerCount-1)*25.5,horiz=horizontal, fn=fnn);
	}
}

module hangers(count=1, wid=5)
{
	topSection=[[0,0],[11,0],[11,9.25],[6.75,9.25],[6.75,5],[4.5,5],[4.5,9.25],[0,9.25]];
	midSection=[[6.75,0],[11,0],[11,16.25],[6.75,16.25]];

	linear_extrude(height=wid,center=true)
	union()
	{
		for(i = [0:count-1])
		{
			translate([0,25.5*i,0])
			polygon(points=topSection,paths=[[0,1,2,3,4,5,6,7]]);
			if(i>0)
			{
				translate([0,9.25+(i-1)*25.5,0])
				polygon(points=midSection,paths=[[0,1,2,3]]);
			}
		}
	}
}

module hook(dia=5,innerRad=6, fn=50, tall=34.75, ovrhang=0)
{
	render()
	union()
	{
		difference()
		{
			rotate_extrude(convexity = fn/2, $fn=fn)
			translate([innerRad*2, 0, 0])
			circle(r = dia/2, $fn=fn);	
			translate([0,innerRad+dia/4,0])
			cube([innerRad*4+dia,innerRad*2+dia/2,dia],center=true);
		}

		translate([innerRad*2,tall/2,0])
		rotate([90,0,0])
		cylinder(r=dia/2,h=tall,$fn=fn,center=true);
	
		translate([-(innerRad*2),ovrhang/2,0])
		rotate([90,0,0])
		cylinder(r=dia/2,h=ovrhang,center=true,$fn=fn);
		
		translate([-(innerRad*2),ovrhang,0])
		sphere(r=dia/2,center=true, $fn=fn);
	}
}

module loop(dia=5,innerRad=6, fn=50, tall=34.75, horiz=1)
{
	render()
	union()
	{
		translate([0,innerRad,0])
		rotate([horiz*90,0,0])
		difference()
		{
			rotate_extrude(convexity = fn/2, $fn=fn)
			translate([innerRad*2, 0, 0])
			circle(r = dia/2, $fn=fn);	
			//translate([0,innerRad+dia/4,0])
			//#cube([innerRad*4+dia,innerRad*2+dia/2,dia],center=true);
		}

//		translate([innerRad*2,tall/2,0])
//		rotate([90,0,0])
//		#cylinder(r=dia/2,h=tall,$fn=fn,center=true);
	}
}

if(HookType==0)
	wallHook (innerDiameter=HookDiameter,hookOverhang=HookOverhang,hookWidth=WallHookWidth,hangerCount=WallHookCount, fnn=BuildMode*40 + 10);
if(HookType==1)
	wallRing (innerDiameter=HookDiameter,hookWidth=WallHookWidth,hangerCount=WallHookCount,horizontal=1, fnn=BuildMode*40 + 10);
if(HookType==2)
	wallRing (innerDiameter=HookDiameter,hookWidth=WallHookWidth,hangerCount=WallHookCount,horizontal=0, fnn=BuildMode*40 + 10);