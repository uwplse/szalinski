//Code is derived from Nut_Job.scad from mike_mattala
//Design for product based on Montessori Phonetic Reading Blocks
//Customizable block added as an output of the code 
//Bolt and Nut codes updated to be compatible with the blocks size
//Inputs were suppressed other than letter options and block amount options for ease of use in customizer


type = "nut"; //[Nut,Bolt,Block]
number_of_blocks=3;

First_Letter="A";
Second_Letter="B";
Third_Letter="C";
Fourth_Letter="D";

font = "Liberation Sans";
block_size= 30*1;
letter_size = 20*1;
letter_height = 3*1;

o = block_size / 2 - letter_height / 2;

head_diameter= 30*1;	
head_height= 10*1;	
drive_diameter= 5*1;	
slot_width= 1*1;
slot_depth= 2*1;
thread_outer_diameter= 20*1;		
thread_step= 2*1;
step_shape_degrees= 45*1;	
thread_length= 10*1;	
countersink= 2*1;
non_thread_length= number_of_blocks*block_size;	
non_thread_diameter= 20*1;	
nut_diameter= 30*1;	
nut_height= 10*1;	
nut_thread_outer_diameter     	= 20*1;		
nut_thread_step= 2*1;
nut_step_shape_degrees= 45*1;	
wing_ratio= 1*1;
wing_radius=wing_ratio * nut_height;
inner_diameter= 8*1;
outer_diameter= 14*1;
thickness= 2*1;
facets= 6*1;
socket_facets= 6*1;
socket_depth= 3.5*1;
resolution= 0.5*1;	
nut_resolution= resolution*1;

if (type=="bolt")
{
	hex_screw(thread_outer_diameter,thread_step,step_shape_degrees,thread_length,resolution,countersink,head_diameter,head_height,non_thread_length,non_thread_diameter);
}



if (type=="nut")
{
	hex_nut(nut_diameter,nut_height,nut_thread_step,nut_step_shape_degrees,nut_thread_outer_diameter,nut_resolution);
}






module socket_head(hg,df)
{
	texture_points=2*PI*(head_diameter/2);
	texture_offset=head_diameter/18;
	texture_radius=head_diameter/24;

	rd0=df/2/sin(60);
	x0=0;	x1=df/2;	x2=x1+hg/2;
	y0=0;	y1=hg/2;	y2=hg;

	intersection()
	{
	   	cylinder(h=hg, r=rd0, $fn=60, center=false);
		rotate_extrude(convexity=10, $fn=6*round(df*PI/6/0.5))
		polygon([ [x0,y0],[x1,y0],[x2,y1],[x1,y2],[x0,y2] ]);
	}
}

module button_head(hg,df)
{
	rd0=df/2/sin(60);
	x0=0;	x1=df/2;	x2=x1+hg/2;
	y0=0;	y1=hg/2;	y2=hg;

	intersection()
	{
	   	cylinder(h=hg, r1=drive_diameter/2 + 1, r2=rd0, $fn=60, center=false);
		rotate_extrude(convexity=10, $fn=6*round(df*PI/6/0.5))
		polygon([ [x0,y0],[x1,y0],[x2,y1],[x1,y2],[x0,y2] ]);
	}
}

module countersunk_head(hg,df)
{
	rd0=df/2/sin(60);
	x0=0;	x1=df/2;	x2=x1+hg/2;
	y0=0;	y1=hg/2;	y2=hg;

	intersection()
	{
	   cylinder(h=hg, r1=rd0, r2=thread_outer_diameter/2-0.5, $fn=60, center=false);

		rotate_extrude(convexity=10, $fn=6*round(df*PI/6/0.5))
		polygon([ [x0,y0],[x1,y0],[x2,y1],[x1,y2],[x0,y2] ]);
	}
}


module screw_thread(od,st,lf0,lt,rs,cs)
{
    or=od/2;
    ir=or-st/2*cos(lf0)/sin(lf0);
    pf=2*PI*or;
    sn=floor(pf/rs);
    lfxy=360/sn;
    ttn=round(lt/st+1);
    zt=st/sn;

    intersection()
    {
        if (cs >= -1)
        {
           thread_shape(cs,lt,or,ir,sn,st);
        }

        full_thread(ttn,st,sn,zt,lfxy,or,ir);
    }
}

module hex_nut(df,hg,sth,clf,cod,crs)
{

    difference()
    {
        hex_head(hg,df);

        hex_countersink_ends(sth/2,cod,clf,crs,hg);

        screw_thread(cod,sth,clf,hg,crs,-2);
    }
}


module hex_screw(od,st,lf0,lt,rs,cs,df,hg,ntl,ntd)
{
    ntr=od/2-(st/2)*cos(lf0)/sin(lf0);

    union()
    {
        hex_head(hg,df);

        translate([0,0,hg])
        if ( ntl == 0 )
        {
            cylinder(h=0.01, r=ntr, center=true);
        }
        else
        {
            if ( ntd == -1 )
            {
                cylinder(h=ntl+0.01, r=ntr, $fn=floor(od*PI/rs), center=false);
            }
            else if ( ntd == 0 )
            {
                union()
                {
                    cylinder(h=ntl-st/2,
                             r=od/2, $fn=floor(od*PI/rs), center=false);

                    translate([0,0,ntl-st/2])
                    cylinder(h=st/2,
                             r1=od/2, r2=ntr, 
                             $fn=floor(od*PI/rs), center=false);
                }
            }
            else
            {
                cylinder(h=ntl, r=ntd/2, $fn=ntd*PI/rs, center=false);
            }
        }

        translate([0,0,ntl+hg]) screw_thread(od,st,lf0,lt,rs,cs);
    }
}

module hex_screw_0(od,st,lf0,lt,rs,cs,df,hg,ntl,ntd)
{
    ntr=od/2-(st/2)*cos(lf0)/sin(lf0);

    union()
    {
        hex_head_0(hg,df);

        translate([0,0,hg])
        if ( ntl == 0 )
        {
            cylinder(h=0.01, r=ntr, center=true);
        }
        else
        {
            if ( ntd == -1 )
            {
                cylinder(h=ntl+0.01, r=ntr, $fn=floor(od*PI/rs), center=false);
            }
            else if ( ntd == 0 )
            {
                union()
                {
                    cylinder(h=ntl-st/2,
                             r=od/2, $fn=floor(od*PI/rs), center=false);

                    translate([0,0,ntl-st/2])
                    cylinder(h=st/2,
                             r1=od/2, r2=ntr, 
                             $fn=floor(od*PI/rs), center=false);
                }
            }
            else
            {
                cylinder(h=ntl, r=ntd/2, $fn=ntd*PI/rs, center=false);
            }
        }

        translate([0,0,ntl+hg]) screw_thread(od,st,lf0,lt,rs,cs);
    }
}

module thread_shape(cs,lt,or,ir,sn,st)
{
    if ( cs == 0 )
    {
        cylinder(h=lt, r=or, $fn=sn, center=false);
    }
    else
    {
        union()
        {
            translate([0,0,st/2])
              cylinder(h=lt-st+0.005, r=or, $fn=sn, center=false);

            if ( cs == -1 || cs == 2 )
            {
                cylinder(h=st/2, r1=ir, r2=or, $fn=sn, center=false);
            }
            else
            {
                cylinder(h=st/2, r=or, $fn=sn, center=false);
            }

            translate([0,0,lt-st/2])
            if ( cs == 1 || cs == 2 )
            {
                  cylinder(h=st/2, r1=or, r2=ir, $fn=sn, center=false);
            }
            else
            {
                cylinder(h=st/2, r=or, $fn=sn, center=false);
            }
        }
    }
}

module full_thread(ttn,st,sn,zt,lfxy,or,ir)
{
  if(ir >= 0.2)
  {
    for(i=[0:ttn-1])
    {
        for(j=[0:sn-1])
        {
			pt = [[0,0,i*st-st],
                 [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
                 [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
				 [0,0,i*st],
                 [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
                 [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
                 [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ],
                 [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
                 [0,0,i*st+st]];
               
            polyhedron(points=pt,faces=[[1,0,3],[1,3,6],[6,3,8],[1,6,4], //changed triangles to faces (to be deprecated)
										[0,1,2],[1,4,2],[2,4,5],[5,4,6],[5,6,7],[7,6,8],
										[7,8,3],[0,2,3],[3,2,7],[7,2,5]	]);
        }
    }
  }
  else
  {
    echo("Step Degrees too agresive, the thread will not be made!!");
    echo("Try to increase de value for the degrees and/or...");
    echo(" decrease the pitch value and/or...");
    echo(" increase the outer diameter value.");
  }
}

module hex_head(hg,df)
{
	rd0=df/2/sin(60);
	x0=0;	x1=df/2;	x2=x1+hg/2;
	y0=0;	y1=hg/2;	y2=hg;

	intersection()
	{
	   cylinder(h=hg, r=rd0, $fn=facets, center=false);

		rotate_extrude(convexity=10, $fn=6*round(df*PI/6/0.5))
		polygon([ [x0,y0],[x1,y0],[x2,y1],[x1,y2],[x0,y2] ]);
	}
}

module hex_head_0(hg,df)
{
    cylinder(h=hg, r=df/2/sin(60), $fn=6, center=false);
}

module hex_countersink_ends(chg,cod,clf,crs,hg)
{
    translate([0,0,-0.1])
    cylinder(h=chg+0.01, 
             r1=cod/2, 
             r2=cod/2-(chg+0.1)*cos(clf)/sin(clf),
             $fn=floor(cod*PI/crs), center=false);

    translate([0,0,hg-chg+0.1])
    cylinder(h=chg+0.01, 
             r1=cod/2-(chg+0.1)*cos(clf)/sin(clf),
             r2=cod/2, 
             $fn=floor(cod*PI/crs), center=false);
}
if (type=="Block")
rotate([90,0,0]) {    
difference() {
    color("gray") cube(block_size, center = true);
//Input First Letter
		translate([0, 0, -o-letter_height]) rotate([0, 0, -90]) letter1(First_Letter);
//Input Second Letter
		translate([o, 0, 0]) rotate([90, 0, 90]) letter2(Second_Letter);
//Input Third Letter
		translate([0, 0, o]) rotate([0, 0, 90]) letter3(Third_Letter);
//Input Fourth Letter
		translate([-o, 0, 0]) rotate([90, 180, -90]) letter4(Fourth_Letter);
        rotate([90, 0, 0]) cylinder(h=100,r=10.5,center=true);
}
}
module letter1(letter1) 
    {
	linear_extrude(height = letter_height) {
		text(letter1, size = letter_size, font = font, halign = "center", valign = "center", $fn = 20);
	}
}
module letter2(letter2) {
	linear_extrude(height = letter_height) {
		text(letter2, size = letter_size, font = font, halign = "center", valign = "center", $fn = 20);
	}
}
module letter3(letter3) {
	linear_extrude(height = letter_height) {
		text(letter3, size = letter_size, font = font, halign = "center", valign = "center", $fn = 20);
	}
}
module letter4(letter4) {
	linear_extrude(height = letter_height) {
		text(letter4, size= letter_size, font = font, halign = "center", valign = "center", $fn = 20);
	}
}