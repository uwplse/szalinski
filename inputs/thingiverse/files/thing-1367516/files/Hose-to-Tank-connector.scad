/*
This Open SCAD file generates hose connectors that can be bolted in to a tank.

It gives the option to print a break-away tool attached to the bolt head inorder to aid fitting in to a tight space.

It also gives the choice for the hose connector to be an inlet or an outlet, For a different designof connector.

You can also choose which tool to use either a spanner or a coin / flat screwdriver

The bolt threads are borrowed from: NUT JOB | Nut, Bolt, Washer and Threaded Rod Factory by mike_linus www.thingiverse.com/thing:193647
The Barbed hose connector are borrowed from:  Hose barb adapter and manifold by papergeek  www.thingiverse.com/thing:158717
*/

Part = "port"; //[ port, nut]

/*[Hose Details]*/
// Hose inside diameter or bore
In_Side_Diameter = 4;
// Hose Outside diameter
Out_Side_Diameter = 6;

/*[Port Details]*/
// Wall_Thickness must be less than inside diameter
Wall_Thickness = 1;
// Number of barbs on output - try 3 for larger tubing to reduce overall print height try 4 for smaller tubing
Barb_count = 4;
// The shoulder can be hexagional to fit a spanner or slot to fit a coin or screwdriver
Connector = "slot"; // [slot, hex]
Port = "outlet"; // [outlet, inlet]
// Size across the flats of the Hex suggest minimum 2mm bigger than the thread outer diameter
Hex_Size = 12; 
// How much shoulder overhanging the largest port on round inline connectors.
Shoulder = 2;

/*[Thread Details]*/
//Outer diameter of the thread needs to ne minimum 2mm bigger than the pipe's outside diameter
thread_outer_diameter = 10;		
//Thread step or Pitch (2mm works well for most applications ref. ISO262: M3=0.5,M4=0.7,M5=0.8,M6=1,M8=1.25,M10=1.5)
thread_step = 2;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
step_shape_degrees = 45;	
//Length of the threaded section
thread_length  = 5;	
//Resolution (lower values for higher resolution, but may slow rendering)
resolution   = 0.5;	
//Countersink in both ends
countersink  = 2 ;



Tank_Wall = 1;
/*[Breakaway Tool]*/
// Add a breakaway tool to aid fitting? only with "hex" style heads
Add_Tool = "no"; // [yes, no]
Tool_Handle_Length = 30;

/*[Hidden]*/
Bore = In_Side_Diameter - (Wall_Thickness * 2);
//change manifold to hex shaped
Edges = Connector == "hex" ? 6 : 100 ; 
HYP = (Hex_Size / 2) / cos(30);
Size_1 = Connector == "hex" ? (HYP * 2) : (thread_outer_diameter + 2*Shoulder) ; // size of manifols 
Barb_Position = (In_Side_Diameter / 2)+Tank_Wall+0.5+thread_length;
nut_thread_outer_diameter     	                = thread_outer_diameter+1;	//Outer diameter of the bolt thread to match (usually set about 1mm larger than bolt diameter to allow easy fit - adjust to personal preferences) 


if (Part == "port")
{
    Port();
}

if (Part == "nut")
{
    Nut();
}

module Port()
{
union()
{
// Body
    difference()
    {
        cylinder( h = In_Side_Diameter , d = Size_1, center = true, $fa = 0.5, $fs = 0.5, $fn = Edges )  ;
        cylinder(h = In_Side_Diameter + 1, d = Bore, center = true, $fa = 0.5, $fs = 0.5 );
        if (Connector == "slot")
        {
            translate([-Size_1 , -0.5, -In_Side_Diameter / 2]) cube ([Size_1*2, 1, 1.5]);
        }
    }
    translate ([0,0,In_Side_Diameter/2])
    {
// Gap for tank wall
        difference()
        {
            
            cylinder(h = Tank_Wall + 0.5, d = thread_outer_diameter, center = false, $fa = 0.5, $fs = 0.5 );
            cylinder(h = Tank_Wall + 1, d = Bore, center = false, $fa = 0.5, $fs = 0.5 );
        }
    }
// Thread   
    translate ([0,0,In_Side_Diameter/2 +Tank_Wall + 0.5])
    {
        difference ()
        {
            or=thread_outer_diameter/2;
            ir=or-thread_step/2*cos(step_shape_degrees)/sin(step_shape_degrees);
            pf=2*PI*or;
            sn=floor(pf/resolution);
            lfxy=360/sn;
            ttn=round(thread_length/thread_step+1);
            zt=thread_step/sn;

            intersection()
            {
                thread_shape(countersink,thread_length,or,ir,sn,thread_step);
                full_thread(ttn,thread_step,sn,zt,lfxy,or,ir);
            }
            cylinder(h = thread_length + 1, d = Bore, center = false, $fa = 0.5, $fs = 0.5 );
        }
    }

        
// Top port
    if (Port == "outlet")
    {
        
        Outlet_port();
    }
    else
    {
        Inlet_port();
    }
    
    if (Add_Tool == "yes")
    {
        Tool();
    }
}
}
module Nut()
{
        difference()
    {
            intersection()
        {
            cylinder( h = thread_length , d = 2*((Hex_Size / 2) / cos(30)),$fn=6, center=false);

            union()
            {
                translate([0,0,thread_length/2])cylinder (h= thread_length/2, r1= (Hex_Size+thread_length)/2, r2 = Hex_Size/2,$fn=6*round(Hex_Size*PI/6/0.5));
                cylinder (h= thread_length/2, r2= (Hex_Size+thread_length)/2, r1 = Hex_Size/2,$fn=6*round(Hex_Size*PI/6/0.5));
            }
        }
        InnerD = nut_thread_outer_diameter/2-(thread_step/2+0.1)*cos(step_shape_degrees)/sin(step_shape_degrees);
        D= floor(nut_thread_outer_diameter*PI/resolution);
        translate([0,0,-0.1])
        cylinder(h=thread_step/2+0.01, 
             r1=nut_thread_outer_diameter/2, 
             r2=InnerD,
             $fn=D, center=false);

        translate([0,0,thread_length-thread_step/2+0.1])  cylinder(h=thread_step/2+0.01, 
             r1=InnerD,
             r2=nut_thread_outer_diameter/2, 
             $fn=D, center=false);

        or=nut_thread_outer_diameter/2;
        ir=or-thread_step/2*cos(    step_shape_degrees)/sin(step_shape_degrees);
        pf=2*PI*or;
        sn=floor(pf/resolution);
        lfxy=360/sn;
        ttn=round(thread_length/thread_step+1);
        zt=thread_step/sn;

        intersection()
        {
            if (-2 >= -1)
            {
            thread_shape(-2,thread_length,or,ir,sn,thread_step);
            }

            full_thread(ttn,thread_step,sn,zt,lfxy,or,ir);
        }
    }
}

module Tool()
{ 
    if (Connector != "slot")
        {
        difference()
    {
        union()
        {
    
            translate ([0,0,-In_Side_Diameter/2]) cylinder(h = In_Side_Diameter/2, d=Size_1+5,$fa = 0.5, $fs = 0.5, $fn = 50 )  ;
            translate ([0,-(Size_1/2 +2.5),-In_Side_Diameter/2]) cube([Tool_Handle_Length,Size_1+5,In_Side_Diameter/2]);
            translate ([Tool_Handle_Length,0,-In_Side_Diameter/2]) cylinder(h = In_Side_Diameter/2, d=Size_1+5,$fa = 0.5, $fs = 0.5, $fn = 50 )  ;
        }     
        cylinder( h = In_Side_Diameter , d = Size_1+0.5, center = true, $fa = 0.5, $fs = 0.5, $fn = Edges )  ;
    }
    translate([-0.5, -(Size_1/2 +2.5),-In_Side_Diameter/2]) cube ([1,Size_1 /2,1]);
    translate([-0.5, 2.5,-In_Side_Diameter/2]) cube ([1,Size_1 /2,1]);
}
}

module Inlet_port()
{ 
    translate([0, 0,Barb_Position ])
    {
        difference()
        {
            cylinder(h = Out_Side_Diameter + 1, d = Out_Side_Diameter + 2, center = false, $fa = 0.5, $fs = 0.5 );
            cylinder(h = Out_Side_Diameter + 1.5, d = Bore, center = false, $fa = 0.5, $fs = 0.5 );
            translate([0,0,1.5])
            {
                difference()
                {
                    cylinder(h = Out_Side_Diameter + 3, d = Out_Side_Diameter, center = false, $fa = 0.5, $fs = 0.5 );
                    cylinder(h = Out_Side_Diameter + 3, d = In_Side_Diameter-0.2, center = false, $fa = 0.5, $fs = 0.5 );
                    
                }
            }
        }
    }
}

module Outlet_port()
{    
    translate([0, 0,Barb_Position ])
    {
        difference()
        {
            union()
            {
            for ( i = [1:Barb_count])
                {
                    translate([0, 0, (i - 1) * In_Side_Diameter * 0.9]) cylinder( h = In_Side_Diameter , r2 = In_Side_Diameter * 0.85 / 2, r1 = In_Side_Diameter * 1.16 / 2, $fa = 0.5, $fs = 0.5 );

                }
            }
            translate([0, 0, -0.1]) cylinder( h = In_Side_Diameter * Barb_count , d = Bore , $fa = 0.5, $fs = 0.5 );
        }
    }
}
module thread_shape(cs,lt,or,ir,sn,st)
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
module full_thread(ttn,st,sn,zt,lfxy,or,ir)
{
  if(ir >= 0.2)
  {
    for(i=[0:ttn-1])
    {
        for(j=[0:sn-1])
			assign( pt = [	[0,                  0,                  i*st-st            ],
                        [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
                        [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
								[0,0,i*st],
                        [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
                        [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
                        [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ],
                        [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
                        [0,                  0,                  i*st+st            ]	])
        {
            polyhedron(points=pt,
              		  triangles=[	[1,0,3],[1,3,6],[6,3,8],[1,6,4],
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
