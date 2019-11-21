/*
 * flexibleTube_v0.scad
 *
 * Written by aubenc @ Thingiverse
 *
 * This script is licensed under the Public Domain license.
 *
 * http://www.thingiverse.com/thing:44198
 *
 * This is an unfinished POC.
 */

/* *************** Parameters ***************************************************** */

// Number of Folding Sections
Bellows_No = 3;

// Tube Outer Diameter
Tube_Diameter = 47;

// Bellows Part of the Tube
Profile_Width = 3;

// Bellows Edge Radius
Profile_Edge_Radius = 0.5;

// Bellows Slope Degrees
Slope_Degrees = 40;

// Tube Faceting
Tube_Circle_Resolution = 0.75;

// Bellows Edges Faceting
Edges_Layer_Height = 0.15;


function bt4h(h,r) = asin(h/r);
function fn4r(r,s) = fn4d(2*r,s);
function fn4d(d,s) = 4*round(d*PI/4/s);



/* *************** Modules ******************************************************** */

flexible_tube();



/* *************** Code *********************************************************** */

module flexible_tube()
{
	ft_od =Tube_Diameter;
	pr_wd =Profile_Width;
	pr_rd =Profile_Edge_Radius;
	pr_lf =Slope_Degrees;
	ft_rs =Tube_Circle_Resolution;
	ed_rs =Edges_Layer_Height;
	od = ft_od;
	or = od/2;
	rd = pr_rd;
	wd = pr_wd;
	lf = pr_lf;
	bs = ft_rs;
	es = ed_rs;
	bt = 90-lf;
	c1 = or-wd+rd;
	c2 = or-rd;
	ex1 = c1-rd*cos(bt);
	ex2 = c2+rd*cos(bt);
	eh1 = rd*sin(bt);
	eh2 = (ex2-ex1)*tan(lf);
	ey0 = 0;
	ey1 = eh1;
	ey2 = ey1+eh2;
	ey3 = ey2+eh1;
	ey4 = ey3+eh1;
	ey5 = ey4+eh2;
	ey6 = ey5+eh1;
	btn = round(eh1/es);
	bth = eh1/btn;

	union()
	{
		for(i=[0:Bellows_No-1])
		{
			translate([0,0,ey6*i])
			rotate_extrude(convexity=10, $fn=fn4d(od,bs))
			{
				for(i=[0:btn-1])
				assign(	y01 = i*bth,	y23 = (i+1)*bth	)
				assign(	bt1 = bt4h(y01,rd),	bt2 = bt4h(y23,rd)	)
				assign(	x1 = c1-rd*cos(bt1),	x2 = c1-rd*cos(bt2)	)
				{
					polygon(points=[	[0,y01],[x1,y01],[x2,y23],[0,y23]	],
								paths=[	[0,1,2,3]	]);
				}

				polygon(points=[	[0,ey1],[ex1,ey1],[ex2,ey2],[0,ey2]	],
							paths=[	[0,1,2,3,4]	]);

				for(i=[0:btn-1])
				assign(	y01 = i*bth,	y23 = (i+1)*bth	)
				assign(	bt1 = bt4h(eh1-y01,rd),	bt2 = bt4h(eh1-y23,rd)	)
				assign(	x1 = c2+rd*cos(bt1),	x2 = c2+rd*cos(bt2)	)
				assign(	y1 = ey2+y01,	y2 = ey2+y23	)
				{
					polygon(points=[	[0,y1],[x1,y1],[x2,y2],[0,y2]	],
								paths=[	[0,1,2,3]	]);
				}

				for(i=[0:btn-1])
				assign(	y01 = i*bth,	y23 = (i+1)*bth	)
				assign(	bt1 = bt4h(y01,rd),	bt2 = bt4h(y23,rd)	)
				assign(	x1 = c2+rd*cos(bt1),	x2 = c2+rd*cos(bt2)	)
				assign(	y1 = ey3+y01,	y2 = ey3+y23	)
				{
					polygon(points=[	[0,y1],[x1,y1],[x2,y2],[0,y2]	],
								paths=[	[0,1,2,3]	]);
				}

				polygon(points=[	[0,ey2],[ex2,ey4],[ex1,ey5],[0,ey5]	],
							paths=[	[0,1,2,3,4]	]);

				for(i=[0:btn-1])
				assign(	y01 = i*bth,	y23 = (i+1)*bth	)
				assign(	bt1 = bt4h(eh1-y01,rd),	bt2 = bt4h(eh1-y23,rd)	)
				assign(	x1 = c1-rd*cos(bt1),	x2 = c1-rd*cos(bt2)	)
				assign(	y1 = ey5+y01,	y2 = ey5+y23	)
				{
					polygon(points=[	[0,y1],[x1,y1],[x2,y2],[0,y2]	],
								paths=[	[0,1,2,3]	]);
				}
			}
		}

		cylinder(h=Bellows_No*ey6, r=or-wd, $fn=fn4d(od,bs), center=false);
	}
}

