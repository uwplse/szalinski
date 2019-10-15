include <write/Write.scad>

//Channel Ring Fidget by AmazingSpanoMan
//Updated by AmazingSpanoMan
//v1.1 11-20-13 Parametric Design and Customizer Coded
//v1.2 11-27-13 Added Knurl Library for spinner and bands. 1 band = rounded spinner
//v1.3 12-02-13 Added ability to manually input ring size measurements and additional ring sizes. 
//v1.4 12-11-13 Add ability to choose what to view and seperated .STL files for download (Module).Took out Size "0". Bug Fixes.
//v1.5 12-16-13 Add custom message ring option

/* [General] */

//Select US Ring Size - Need Help?http://www.onlineconversion.com/ring_size.htm
Ring_Size_Selector = 16.51; // [0:Manual,11.84:0.25,12.04:0.5,12.24:0.75,12.45:1,12.65:1.25,12.85:1.5,13.06:1.75,13.26:2,13.46:2.25,13.67:2.5,13.87:2.75,14.07:3,14.27:3.25,14.48:3.5,14.68:3.75,14.88:4,15.09:4.25,15.29:4.5,15.49:4.75,2215.9:5.25,16.1:5.5,16.31:5.75,16.51:6,16.71:6.25,16.92:6.5,17.12:6.75,17.32:7,17.53:7.25,17.73:7.5,17.93:7.75,18.14:8,18.34:8.25,18.54:8.5,18.75:8.75,18.95:9,19.15:9.25,19.35:9.5,19.56:9.75,19.76:10,19.96:10.25,20.17:10.5,20.37:10.75,20.57:11,20.78:11.25,20.98:11.5,21.18:11.75,21.39:12,21.59:12.25,21.79:12.5,22:12.75,22.2:13,22.4:13.25,22.61:13.5,22.81:13.75,23.01:14,23.22:14.25,23.42:14.5,23.62:14.75,23.83:15,24.03:15.25,24.23:15.5,24.43:15.75,24.64:16]

//If manual is selected above, measure and input DIAMETER required for ring in mm.
Manual_Ring_Size = 18.35;
Ring_Size=Ring_Size_Selector;

Ring_Thickness = 9; //[6:Small(6mm),9:Medium(9mm),11:Large(11mm)]
//Total thickness of ring

//Select Spinner Type
Type=1;//[1:Smooth(1),2:Banded(2),3:Knurled(3),4:Message(4)]

/* [Print] */

//Which one would you like to see? (All parts will generate .STL file individually)
part = "All"; //[Inner:Inner Ring Only,Outer: Outer Ring Only,Spinner:Spinner Only,Ring:Ring Parts Only,All:All Three Parts]

/* [Knurled] */

//Input the smoothness percentage for your knurled spinner.
Knurl_Smoothness=50;//[0:100]
ks=Knurl_Smoothness*1;

//Input the height of the diamond shape.
Knurl_Height=2;//[2:15]
kh=Knurl_Height*1;

//Input the width of the diamond shape.
Knurl_Width=3;//[2:15]
kw=Knurl_Width*1;

//How much do you want the diamonds to stick out?
Knurl_Depth=1.5; //[.5:.5mm,1:1mm,1.5:1.5mm,2:2mm,2.5:2.5mm,3:3mm,3.5:3.5mm,4:4mm,4.5:4.5mm,5:5mm]
kd=Knurl_Depth*1;

/* [Banded] */

//How many bands would you like on your spinner? 1=rounded spinner
Bands=2;//[1,2,3,4,5]

/* [Message] */

//What would you like it to say? All CAPS works best.
Message = "FIDGET THIS!";

Font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]

Font_Spacing = 0; //[-100:100]

Font_Size = 9.5; //[3.5:Extra Small,5.5:Small,9.5:Medium,13.5:Large,15:Extra Large]

//Use to align font in ring
Font_Height = 0; //[-5:25]

//Emboss or cut through. Remember... Letters with holes may not print correctly with cut through.
Font_Cut = 1; //[1:Emboss,6:Cut Through]

/////////////////////////////////PRE-SET PROGRAM VARIABLES//////////////////////////////

ring_radius = (Ring_Size/2);
//radius for coding purposes
ring_outer = (ring_radius) + 1;
//Creates actual ring based on ring size, 1.5 thickness
ring_lip = ring_outer + 2;
//Provides the lip for the spinner channel
sw=Ring_Thickness-2.5;
//thickness of spinner cylinder
sr=ring_outer+3;
//radius for spinner
kod=(ring_outer+3)*2;
//knurled outer diameter
hsc=sw/(Bands*3);
//scale of horizontal bands
font_scale = Font_Size/10;
//for message ring option
font_factor = Font_Spacing/100;
//font spacing


////////////////////////////////Manual Program Variables////////////////////////////////

man_ring_radius = (Manual_Ring_Size/2);
//radius for coding purposes
man_ring_outer = (man_ring_radius) + 1;
//Creates actual ring based on ring size, 1.5 thickness
man_ring_lip = man_ring_outer + 2;
//Provides the lip for the spinner channel
man_sr=man_ring_outer + 3;
//manual spinner radius
man_kod=(man_ring_outer+3)*2;
//knurled outer diameter


/////////////////////////////////Print Module///////////////////////////////////////////

print_part();

module print_part()
{
	if (part == "Inner")
	{
		inner();
	}
	else if (part == "Outer")
	{
		outer();
	}
	else if (part == "Spinner")
	{
		spinner();
	}
	else if (part == "Ring")
	{
		inner();
		outer();
	}
	else if (part == "All")
	{
		inner();
		outer();
		spinner();
	}
}

/////////////////////////////////Inner ring creation////////////////////////////////////

module inner()
{
if(Ring_Size_Selector > 0) //any preset selected
	{
	difference()
		{
		union()
			{
			cylinder(h=(Ring_Thickness),r=(ring_outer),$fn=200);//ring
			cylinder(h=1.5,r=(ring_lip),$fn=200);//channel 1mm thick
			}
		translate([0,0,-1])cylinder(h=(Ring_Thickness+2),r=(ring_radius),$fn=200);
		}
	}

if(Ring_Size_Selector==0) //Manual selected
	{
	difference()
		{
		union()
			{
			cylinder(h=(Ring_Thickness),r=(man_ring_outer),$fn=200);//ring
			cylinder(h=1.5,r=(man_ring_lip),$fn=200);//channel 1mm thick
			}
		translate([0,0,-1])cylinder(h=(Ring_Thickness+2),r=(man_ring_radius),$fn=200);
		}
	}
}
//////////////////////////////Outer ring creation////////////////////////////////

module outer()
{
if(Ring_Size_Selector > 0) //Any preset selected
{
	translate([(ring_lip*2) + 5,(ring_lip) + 5,0])
		{
			difference()
			{
				union()
				{
				cylinder(h=(Ring_Thickness),r=(ring_outer+1),$fn=200);//ring
				cylinder(h=1.5,r=(ring_lip),$fn=200);//channel 1.5mm thick
				}
				union()
				{
				translate([0,0,1.5])cylinder(h=(Ring_Thickness),r=(ring_outer+0.1),$fn=200);
				translate([0,0,-1])cylinder(h=(Ring_Thickness),r=(ring_radius),$fn=200);
				}
			}
		}
}

if(Ring_Size_Selector==0) //Manual selected
{
	translate([(man_ring_lip*2) + 5,(man_ring_lip) + 5,0])
		{
			difference()
			{
				union()
				{
				cylinder(h=(Ring_Thickness),r=(man_ring_outer+1),$fn=200);//ring
				cylinder(h=1.5,r=(man_ring_lip),$fn=200);//channel 1.5mm thick
				}
				union()
				{
				translate([0,0,1.5])cylinder(h=(Ring_Thickness),r=(man_ring_outer+0.1),$fn=200);
				translate([0,0,-1])cylinder(h=(Ring_Thickness),r=(man_ring_radius),$fn=200);
				}
			}
		}
}
}
//////////////////////////////Spinner creation/////////////////////////////////////

module spinner()
{
if(Ring_Size_Selector > 0) //Any preset selected
{
	translate([(ring_lip*2) + 5,-(ring_lip) - 5,0])
	{
	difference()
		{
		if (Type==1)
			{
			cylinder(h=sw,r=sr,$fn=200);// flat
	 		}
		if (Type==2)
			{
			union()
				{
				hbanded(sr,sw);// horizontal bands
				}
			}
		if (Type==3)
			{
			knurled_cyl(sw,kod,kw,kh,kd,kd,ks);
			}
		if (Type==4)
			{
			difference()
				{
				cylinder(h=sw,r=sr,$fn=200);// flat
				color([1,0,0])
				scale(font_scale)
				writecylinder(Message,[0,0,0],(sr/font_scale*1.01),sw+Font_Height,space=1.05+font_factor,rotate=0,font=Font,t=Font_Cut);
				}
			}
		translate([0,0,-1])cylinder(h=(Ring_Thickness),r=(ring_outer+1.5),$fn=200);
		}
	}
}

if(Ring_Size_Selector==0) //Any preset selected
{
	translate([(man_ring_lip*2) + 5,-(man_ring_lip) - 5,0])
	{
	difference()
		{
		if (Type==1)
			{
			cylinder(h=sw,r=man_sr,$fn=200);// flat
	 		}
		if (Type==2)
			{
			union()
				{
				hbanded(man_sr,sw);// horizontal bands
				}
			}
		if (Type==3)
			{
			knurled_cyl(sw,man_kod,kw,kh,kd,kd,ks);
			}
		if (Type==4)
			{
			difference()
				{
				cylinder(h=sw,r=man_sr,$fn=200);// flat
				color([1,0,0])
				scale(font_scale)
				writecylinder(Message,[0,0,0],(man_sr/font_scale*1.01),sw+Font_Height,space=1.05+font_factor,rotate=0,font=Font,t=Font_Cut);
				}
			}
		translate([0,0,-1])cylinder(h=(Ring_Thickness),r=(man_ring_outer+1.5),$fn=200);
		}
	}
}
}

//Library MODULES

module hbanded(ro,w){
difference(){
	union(){    
     translate([0,0,-.01])cylinder(r=ro-hsc,h=w+.02,$fn=100);
     for(i=[1:Bands]){
          translate([0,0,(i-1)*3*hsc+1.5*hsc])scale([1,1,1.65])rotate_extrude($fn=100)
               translate([ro-hsc,0,0])circle(r=hsc,$fn=50);
     }
	}
	translate([0,0,-hsc])cylinder(r=ro,h=hsc,$fn=100);
	translate([0,0,w])cylinder(r=ro,h=hsc,$fn=100);
	}
}

/*
 * knurledFinishLib.scad
 * 
 * Written by aubenc @ Thingiverse
 *
 * This script is licensed under the Public Domain license.
 *
 * http://www.thingiverse.com/thing:9095
 *
 * Usage:
 *
 *    knurled_cyl( Knurled cylinder height,
 *                 Knurled cylinder outer diameter,
 *                 Knurl polyhedron width,
 *                 Knurl polyhedron height,
 *                 Knurl polyhedron depth,
 *                 Cylinder ends smoothed height,
 *                 Knurled surface smoothing amount );
 */
module knurled_cyl(chg, cod, cwd, csh, cdp, fsh, smt)
{
    cord=(cod+cdp+cdp*smt/100)/2;
    cird=cord-cdp;
    cfn=round(2*cird*PI/cwd);
    clf=360/cfn;
    crn=ceil(chg/csh);

    intersection()
    {
        shape(fsh, cird, cord-cdp*smt/100, cfn*4, chg);

        translate([0,0,-(crn*csh-chg)/2])
          knurled_finish(cord, cird, clf, csh, cfn, crn);
    }
}

module shape(hsh, ird, ord, fn4, hg)
{
        union()
        {
            cylinder(h=hsh, r1=ird, r2=ord, $fn=fn4, center=false);

            translate([0,0,hsh-0.002])
              cylinder(h=hg-2*hsh+0.004, r=ord, $fn=fn4, center=false);

            translate([0,0,hg-hsh])
              cylinder(h=hsh, r1=ord, r2=ird, $fn=fn4, center=false);
        }

}

module knurled_finish(ord, ird, lf, sh, fn, rn)
{
    for(j=[0:rn-1])
    assign(h0=sh*j, h1=sh*(j+1/2), h2=sh*(j+1))
    {
        for(i=[0:fn-1])
        assign(lf0=lf*i, lf1=lf*(i+1/2), lf2=lf*(i+1))
        {
            polyhedron(
                points=[
                     [ 0,0,h0],
                     [ ord*cos(lf0), ord*sin(lf0), h0],
                     [ ird*cos(lf1), ird*sin(lf1), h0],
                     [ ord*cos(lf2), ord*sin(lf2), h0],

                     [ ird*cos(lf0), ird*sin(lf0), h1],
                     [ ord*cos(lf1), ord*sin(lf1), h1],
                     [ ird*cos(lf2), ird*sin(lf2), h1],

                     [ 0,0,h2],
                     [ ord*cos(lf0), ord*sin(lf0), h2],
                     [ ird*cos(lf1), ird*sin(lf1), h2],
                     [ ord*cos(lf2), ord*sin(lf2), h2]
                    ],
                triangles=[
                     [0,1,2],[2,3,0],
                     [1,0,4],[4,0,7],[7,8,4],
                     [8,7,9],[10,9,7],
                     [10,7,6],[6,7,0],[3,6,0],
                     [2,1,4],[3,2,6],[10,6,9],[8,9,4],
                     [4,5,2],[2,5,6],[6,5,9],[9,5,4]
                    ],
                convexity=5);
         }
    }
}