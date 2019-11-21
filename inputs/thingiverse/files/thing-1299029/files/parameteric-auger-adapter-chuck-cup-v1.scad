// Parameteric Ice Auger Drill Adapter v1.0
// http://www.thingiverse.com/thing:1299029
//
// by infinigrove Squirrel Master 2016 (http://www.thingiverse.com/infinigrove)
//

view_part = "all"; //[all,top_screw,bottom_cup,adapter_center]

// Bottom section
aLngth = 25; 
aDia = 18;

// Next section up
bLngth = 12; 
bDia = 23;

// Third section going up from bottom
cLngth = 6;  
cDia = 29;

// bolt connector on auger diameter
boltHoleDia = 8; 

// bolt connector on auger height
boltHoleHght = 12; 

/* [adapter_center] */

// This gets insered into the drill chuck
ChuckStudTriCircleLngth = 24; //[10:48]

/* [top_screw] */

TopCLR = 2.2;
TopDia = 27;
TopTaper = 1;
HexNutHght = 9;
HexNutDia = 85;
ThreadLngth = 32;

// inside diameter of screw - slightly larger than diameter of chuck
ChuckDia = 41.5;  

/* [bottom_cup] */

// Length of threads
dLngth = 35;

// The outside diameter of the auger shaft
ShaftOutDia = 29.4;

ShaftWallThk = 8; //[3:0.5:30]

// Extra length on shaft for support
ShaftExtension = 5;  //[0:0.5:50]

ThreadDia = 60;

ThreadWallThk = 7;//[3:0.5:30]

// Amount of tapper between top and bottom section
TapperAmt = 1.6;  //[1:0.1:2]

/* [detail setting and gap adjustment] */

// Distance between threaded parts and center part
XYgap = .5; //[0:0.1:1]

adapter_detail = 40; //[40:360]

thread_detail = 1; //[1:8]

/* [Hidden] */

// Hidden Vars bellow here
//

PI=3.141592;
OutShaftOutDia = ShaftOutDia+(2*ShaftWallThk);
OutThreadDia = ThreadDia+(2*ThreadWallThk);
OutTaper = (OutThreadDia - OutShaftOutDia)/TapperAmt;

//screw thread modules library from
// Poor man's openscad screw library
// polyScrewThread_r1.scad    by aubenc @ Thingiverse
// http://www.thingiverse.com/thing:8796
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
              		  faces=[	[1,0,3],[1,3,6],[6,3,8],[1,6,4],
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

module Auger_Adapter_center(){
    difference(){
    union(){
        cylinder(d=aDia,h=aLngth,$fn=adapter_detail); // a section
        translate([0,0,aLngth-.6]) cylinder(d1=aDia,d2=bDia,h=.6,$fn=6);
        translate([0,0,aLngth]) cylinder(d=bDia,h=bLngth,$fn=6); // b section
        translate([0,0,(aLngth+bLngth-.6)]) cylinder(d1=bDia,d2=cDia,h=.6,$fn=6);
        translate([0,0,(aLngth+bLngth)]) cylinder(d=cDia,h=cLngth,$fn=6); // c section
        
        intersection() {
        translate([0,0,(aLngth+bLngth+cLngth)]) cylinder(d=12,h=ChuckStudTriCircleLngth,$fn=adapter_detail);
        
        polyhedron(
      points=[ [5,-8,(aLngth+bLngth+cLngth)],[5,8,(aLngth+bLngth+cLngth)],[-10,0,(aLngth+bLngth+cLngth)], // the three points at base
               [5,-8,(aLngth+bLngth+cLngth+ChuckStudTriCircleLngth)],[5,8,(aLngth+bLngth+cLngth+ChuckStudTriCircleLngth)],[-10,0,(aLngth+bLngth+cLngth+ChuckStudTriCircleLngth)] ],   // the three points top 
        
        faces=[ [0,1,2],[4,3,5],  //top and bottom face
                [1,0,3],[3,4,1],  //side
                [2,1,4],[4,5,2],  //side
                [0,2,3],[5,3,2],  //side
        ]        
     );
        }
    }

        rotate([0,90,0]) translate([-(boltHoleHght),0,0]) cylinder(d=boltHoleDia,h=18,center=true,$fn=adapter_detail); //bolt hole

    }
}


module Auger_Adapter_top_screw(){
    difference(){
    union(){
        cylinder(d=HexNutDia,h=HexNutHght,$fn=6); // hex nut
        translate([0,0,HexNutHght]) screw_thread(ThreadDia-XYgap,4,55,ThreadLngth,PI/thread_detail,2);
        
    }

    cylinder(d=TopDia,h=TopCLR,$fn=adapter_detail);  //little hole
    
    translate([0,0,TopCLR]) cylinder(d1=ChuckDia-TopTaper,d2=ChuckDia,h=TopTaper,$fn=adapter_detail);  // taper

    translate([0,0,TopCLR+TopTaper]) cylinder(d=ChuckDia,h=ThreadLngth+HexNutHght,$fn=adapter_detail);  // big hole

    translate([0,-(HexNutDia/2),0]) cube([.2,HexNutDia,ThreadLngth+HexNutHght]);  //slice part in half

    }
}

module Auger_Adapter_bottom_cup(){
    difference(){
    union(){
        translate([0,0,aLngth+bLngth+ShaftExtension]) cylinder(d=OutThreadDia,h=cLngth+dLngth,$fn=adapter_detail); // top section chuck cup
        translate([0,0,aLngth+bLngth+ShaftExtension-OutTaper]) cylinder(d1=OutShaftOutDia,d2=OutThreadDia,h=OutTaper,$fn=adapter_detail); // taper
        cylinder(d=OutShaftOutDia,h=aLngth+bLngth+ShaftExtension,$fn=adapter_detail); // bottom shaft support
        
        }

    translate([0,0,aLngth+bLngth+cLngth+ShaftExtension]) screw_thread(ThreadDia,4,55,dLngth+5,PI/thread_detail,0); // threads on top
    cylinder(d=ShaftOutDia,h=aLngth+ShaftExtension,$fn=adapter_detail); // outside dia of auger shaft - bottom hole
    rotate([0,90,0]) translate([-(boltHoleHght+ShaftExtension),0,0]) cylinder(d=boltHoleDia,h=OutShaftOutDia+2,center=true,$fn=adapter_detail); // bolt hole for shaft
    translate([0,0,aLngth+ShaftExtension]) cylinder(d1=ShaftOutDia,d2=bDia+XYgap,h=4,$fn=adapter_detail); // taper into bSection
    translate([0,0,aLngth+ShaftExtension]) cylinder(d=bDia+XYgap,h=bLngth,$fn=6); // bSection
    translate([0,0,(aLngth+bLngth+ShaftExtension-1)]) cylinder(d1=bDia+XYgap,d2=cDia+XYgap,h=1,$fn=6); // taper into cSection
    translate([0,0,(aLngth+bLngth+ShaftExtension)]) cylinder(d=cDia+XYgap,h=cLngth,$fn=6); // cSection

    //translate([0,0,aLngth+bLngth+cLngth]) cylinder(d=ThreadDia,h=dLngth,$fn=100);

    }
}

 if (view_part == "all") 
{
translate([0,cDia,0]) Auger_Adapter_center();
translate([0,-ThreadDia,0]) Auger_Adapter_top_screw();
translate([-OutThreadDia,0,0]) Auger_Adapter_bottom_cup();
}

 if (view_part == "top_screw") Auger_Adapter_top_screw();
 
 if (view_part == "bottom_cup") Auger_Adapter_bottom_cup();

 if (view_part == "adapter_center") Auger_Adapter_center();
