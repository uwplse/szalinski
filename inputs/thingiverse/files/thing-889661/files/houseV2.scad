//House generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike

// preview[view:north east, tilt:top diagonal]
// settings
/* [House] */
//dimensions in cm
housex = 600; //[100:2000]
housey = 500; //[100:2000]
housez = 280; //[100:500]
//roof height
roofz = 200; //[30:3000]
//export as plate
asplate =0; //[1,0]
//0=everything
part=0;//[0,1,2,3,4,5,6,7,8]
roofh = sqrt((housey / 2) * (housey / 2) + (roofz * roofz));
roofang = 90 - atan2(roofz, housey / 2);
/* [Windows and Doors] */
winh = 100; //[10:500]
winw = 80; //[10:500]
wind = 20; //[10:30]
winz = 82; //[0:500]
doorh = 220; //[10:500]
doorw = 100; //[10:500]
doord = 16; //[10:30]
doorz = 0; //[0:500]
//distance from corner to first window
vanpadding =120; //[0:500]
//spaceing
spacew = 100; //[0:500]
//windows and doors order win=1 door=2
WD1 = [1, 1, 1, 1, 1, 1, 2, 1, 2, 2, 2];
WD2 = [1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 2, 2];
WD3 = [1, 1, 2, 1, 1, 1, 2, 1, 2, 2, 2];
WD4 = [1, 1, 1, 1, 1, 1, 2, 1, 2, 2, 2];
/* [Walls] */
//wood/brick sizes
stoneh = 320; //[10:500]
stonew = 30; //[10:500]
stoned = 31; //[5:50]

md=0.7;//[0.01:1]
hd=0.8;//[0.01:1]
hp=0.2;//[00:1]
vd=0.8;//[0.01:1]
vp=0.041;//[0:1]
corners=0;//[0,1] 
//round wall tiles
stonetypewall = 0; 

/* [Roof] */
// roof over shoot [10:200]
overhang = 70;
overhang2 = 50;
//rooftile size
roofstoneh = 40; //[10:1000]
roofstonew = 30; //[10:1000]
roofstoned = 10; //[5:50]
// roof tiles
stonetype = 0; //[0,1] 

/* [Chimney] */
//dimensions in cm 
chimney=0;//[1,0]

chimx = 100; //[20:3000]
chimy = 100; //[20:3000]
chimz = 600; //[20:3000]
chimofx = -30; //[-1000:3000]
chimofy = -180; //[-3000:1000]
// end of settings

fudge=0.001;
fr=0;
fr2=0;

// main
if (asplate == 1)
{
    if (part==0){
	//[2,1,2,1,1,1,1]= [door,win door,win,win,win,win]
	translate([0, 0, 0]) wall(housex, wind, housez, WD1);
	translate([0, 0, housez * 1.1]) wall(housey, wind, housez, WD2);
	translate([0, 0, housez * 2.2]) wall(housex, wind, housez, WD3);
	translate([0, 0, housez * 3.3]) wall(housey, wind, housez, WD4);
	translate([max(housey, housex) * 1.2, stoned, roofh * 2.2 + overhang * 2]) roofside(housey, roofz);
	translate([max(housey, housex) * 1.2, stoned, roofh * 2.2 + overhang * 2 + housez * 1.1]) roofside(housey, roofz);
	translate([max(housey, housex) * 1.2, 0, overhang]) roofblock(housex, roofh);
	translate([max(housey, housex) * 1.2, 0, roofh * 1.1 + overhang * 2]) roofblock(housex, roofh);}
    
    if (part==1){ wall(housex, wind, housez, WD1);}
	if (part==2){ wall(housey, wind, housez, WD2);}
	if (part==3){ wall(housex, wind, housez, WD3);}
	if (part==4){ wall(housey, wind, housez, WD4);}
	if (part==5){ roofside(housey, roofz);}
	if (part==6){ roofside(housey, roofz);}
	if (part==7){ roofblock(housex, roofh);}
	if (part==8){roofblock(housex, roofh);}
    
    
}
else
{
	union()
	{
        //chimney
 if (chimney==1){
        translate([chimofx+0, +chimofy, 0]) wall(chimx, wind, chimz, WD1);
		translate([chimofx+chimx, +chimofy, 0]) rotate([0, 0, -90]) wall(chimy, wind, chimz, WD2);
		translate([chimofx+chimx, -chimy+chimofy, 0]) rotate([0, 0, -180]) wall(chimx, wind, chimz, WD3);
		translate([chimofx+0, -chimy +chimofy, 0]) rotate([0, 0, -270]) wall(chimy, wind, chimz, WD4);}
        //house
		translate([0, 0, 0]) wall(housex, wind, housez, WD1);
		translate([housex, 0, 0]) rotate([0, 0, -90]) wall(housey, wind, housez, WD2);
		translate([housex, -housey, 0]) rotate([0, 0, -180]) wall(housex, wind, housez, WD3);
		translate([0, -housey, 0]) rotate([0, 0, -270]) wall(housey, wind, housez, WD4);
		translate([0, 0, housez]) rotate([roofang, 0, 0]) roofblock(housex, roofh);
		translate([housex, 0, housez]) rotate([0, 0, -90]) roofside(housey, roofz);
		translate([housex, -housey, housez]) rotate([0, 0, -180]) rotate([roofang, 0, 0]) roofblock(housex, roofh);
		translate([0, -housey, housez]) rotate([0, 0, 90]) roofside(housey, roofz);
	}
}
//House generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
//modules below
colors = [color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0])
];
n_colors = 5;
module stone()
{
	  rotate([-90,0,0])
union(){
			 translate ([0,0,0])cube([1-hp+fudge, 1-vp+fudge, md]);
			translate ([1-hp,0,0])cube([hp+fudge, 1, hd]);
		translate ([0,1-vp,0])cube([1, vp+fudge, vd]);
    }
	
}
module basestone()
{
	rotate([rands(0, 360, 1)[0], rands(0, 360, 1)[0], rands(0, 360, 1)[0]])
	resize([rands(3, 10, 1)[0], rands(3, 10, 1)[0], rands(3, 10, 1)[0]])
		//import("rock.stl", convexity=3);
	sphere(1, $fa = 15, $fs = 1);
}
module roofstone()
{
	if (stonetype == 1)
	{
		///////pannor
	}
	else
	{
		 translate ([0,0,-1])rotate([180, 0, 0]) translate ([0,0,1]){
			 
             
		 intersection(){translate([0,-1,0])cube([3,2,1]);
             rotate([25,0,0])difference(){
    union(){
    color([1,0,0])translate([0,0,-1])cube([2,2,3]);
   translate([0.5,0,-.5])cylinder(2,0.5,0.5,$fn=7);
    }
    translate([1.5,0,-.5])cylinder(2,0.5,0.5,$fn=7);
}}
             
             }}
		}
	
module wallblock(length, height)
{
	union()
	{
		intersection()
			{
				
				 color([rands(0.6,0.9,1)[0],0.3,0]) translate([0,  -stoned*0.2-fudge, 0]) cube([length -fudge, stoned*2 +fudge, height+fudge]);
				union()
				{
					 color([rands(0.6,0.9,1)[0],0.3,0]) translate([0, -wind, 0]) cube([length, wind * 2, height]);
					// Wall
					for (i = [0: height*2 / stoneh])
					{
						for (j = [0: length / stonew])
						{
		                        color([rands(0.6,0.9,1)[0],0.3,0]) translate([j * stonew - (i % 2) * stonew / 2,-stoned*0.2 , i * stoneh ]) 
                            resize([stonew+fudge, stoned+fudge, stoneh+fudge ])   stone();
						
						}
					}
				}
			}
        }}
module roofside(length, height)
{
	difference()
	{
		
		translate([0, 0 - stoned*0.5]) union()
		{
		union()
	{
		intersection()
			{
				
						color([rands(0.5,1,1)[0],0.3,0])
translate([0+fudge,  -stoned*0.2-fudge, -fudge]) cube([length +fudge, stoned*2 +fudge, height+fudge]);
				union()
				{
					//translate([0, -wind, 0]) cube([length, wind * 2, height]);
					// Wall
					for (i = [1: height / stoneh])
					{
						for (j = [0: length / stonew])
						{
									color([rands(0.5,1,1)[0],0.3,0])

	translate([j * stonew - (i % 2) * stonew / 2,-stoned*0.2 , i * stoneh ]) 
                            resize([stonew+fudge, stoned+fudge, stoneh +fudge]) stone();
						
						}
					}
				}
			}
        }}
		
		translate([housey / 2, -50, roofz]) rotate([0, 90 - roofang, 0]) cube([max(roofh * 20, roofz * 20), 100, max(roofh * 20, roofz * 20)]);
		translate([housey / 2, -50, roofz]) rotate([0, 180 + roofang, 0]) cube([max(roofh * 20, roofz * 20), 100, max(roofh * 20, roofz * 20)]);
	}
}
module roofblock(l, h)
{
	height = h + overhang;
	length = l + overhang2 * 2;
	translate([-overhang2, roofstoned*0.5, -overhang]) union()
	{
		intersection()
		{
			
			color([1,1,1])translate([fudge,-fudge,fudge])cube([length+fudge, roofstoned * 4, height + roofstoned * 1.6]);
			union()
			{
				
			color([1,1,1]){
                translate([-1, 0 ,0 ]) cube([6, roofstoned*1.5+fudge, height+ roofstoned * 1.6]);
                translate([length-5, 0 ,0 ]) cube([6, roofstoned*1.5+fudge, height+ roofstoned * 1.6]);
            }
              color([rands(0.6,0.9,1)[0],0.3,0])  translate([0,0, height-roofstoned*2]) cube([length, roofstoned*1.5, roofstoned*3.5+fudge]);
                
				for (i = [-1: roofstoneh + height / roofstoneh])
				{
					for (j = [0: length / roofstonew])
					{
						
                        color([rands(0.6,0.9,1)[0],0.3,0])
						translate([j * roofstonew, roofstoned*0.5, i * roofstoneh])  resize([roofstonew+fudge, roofstoned+fudge, roofstoneh +fudge]) roofstone();
					}
				}
			}
		}
	}
}
module centerblock()
{
	color(colors[rands(0, n_colors - 1, 1)[0]])
	translate([0, -0.5, 0.5]) cube(1, center = true);
}
module cutter(w, d, h)
{
	color(colors[rands(0, n_colors - 1, 1)[0]])
	resize([w, d, h]) centerblock();
}
module window(w, d, h)
{
	color([1,1,1])
	union()
	{
		resize([w, d, h])
		difference()
		{
			color(colors[rands(0, n_colors - 1, 1)[0]])
			centerblock();
			color(colors[rands(0, n_colors - 1, 1)[0]])
			translate([0, 0, 0]) resize([0.95, 0.2, 0.97]) centerblock();
			color(colors[rands(0, n_colors - 1, 1)[0]])
			translate([-0.25, 0, 0.1]) resize([0.4, 0.5, 0.4]) centerblock();
			color(colors[rands(0, n_colors - 1, 1)[0]])
			translate([0.25, 0, 0.1]) resize([0.4, 0.5, 0.4]) centerblock();
			color(colors[rands(0, n_colors - 1, 1)[0]])
			translate([-0.25, 0, 0.55]) resize([0.4, 0.5, 0.4]) centerblock();
			color(colors[rands(0, n_colors - 1, 1)[0]])
			translate([0.25, 0, 0.55]) resize([0.4, 0.5, 0.4]) centerblock();
		}
		color(colors[rands(0, n_colors - 1, 1)[0]])
		translate([0, wind * 0.3, 0]) resize([w * 1.2, d, h * 0.05]) centerblock();
		color(colors[rands(0, n_colors - 1, 1)[0]])
		translate([0, wind * 0.3, h * 0.97]) resize([w * 1.2, d, h * 0.05]) centerblock();
	}
}
module door(w, d, h)
{
	color([1,1,1])	union()
	{
		resize([w, d, h])
		difference()
		{
			color(colors[rands(0, n_colors - 1, 1)[0]])
			centerblock();
			translate([0, 0, 0]) resize([0.85, 0.5, 0.92]) centerblock();
		}
		color(colors[rands(0, n_colors - 1, 1)[0]])
		translate([0, wind * 1.5, 0]) resize([w * 1.2, d * 3, h * 0.05]) centerblock();
		color(colors[rands(0, n_colors - 1, 1)[0]])
		translate([0, wind * 0.5, h * 0.97]) resize([w * 1.2, d, h * 0.05]) centerblock();
	}
}
module wall(w, d, h, order)
	{
		union()
		{
            corn=stoned*0.7;
            if (corners==0){color([1,1,1])
                translate([0,-stoned+5,-fudge]) cube([corn+fudge,stoned+fudge,h+fudge+fudge]);
               color([1,1,1]) translate([w-corn+fudge,-stoned+5,-fudge]) cube([corn+fudge+5,stoned+fudge,h+fudge+fudge]);
                }
			difference()
			{
				translate([0, -d, 0])
					wallblock(w, h);
				//cube([w,d,h]);
				union()
				{
					fw = w - vanpadding * 2;
					numw = floor(fw / (winw + spacew));
					step = fw / numw;
					for (i = [vanpadding: step: w - vanpadding])
					{
						if (order[i / step] == 1)
						{
							translate([i, wind * 2, winz]) color([1,1,1])cutter(winw, wind * 2.9, winh);
						}
						else
						{
							translate([i, doord * 3, doorz - 1]) color([1,1,1])cutter(doorw, doord * 3.9, doorh + 1);
						}
					}
				}
			}
			fw = w - vanpadding * 2;
			numw = floor(fw / (winw + spacew));
			step = fw / numw;
			for (i = [vanpadding: step: w - vanpadding])
			{
				if (order[i / step] == 1)
				{
					translate([i, wind * 0.5, winz]) color([1,1,1])window(winw, wind, winh);
				}
				else
				{
					translate([i, doord * 0.5, doorz])color([1,1,1]) door(doorw, doord, doorh);
				}
			}
		}
	}
	//rotate([-5,0,0])roofstone();,
	//House generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike