/*

Phyllotaxis Sphere

http://www.thingiverse.com/thing:1995900

Fernando Jerez 2016

*/



// Wich part want to see
part = "all"; // [ all:Sphere, up:Upper semisphere, down:Lower semisphere, screw:Screw ]

// Phyllotaxis angle 
angle = 137.51;

// Pattern #1
pattern1 = "bulb"; // [bulb:Bulb, spike:Spike]
// Pattern #2
pattern2 = "spike"; // [bulb:Bulb, spike:Spike]

// Draw one Pattern #2 every N steps
pattern2_every = 3;

// For spikes: Set scale factor
spikes_scale = 1;
// For spikes: Set scale distribution
spikes_distribution = "Bigger_at_top"; // [Bigger_at_top:Bigger at top, Bigger_at_center:Bigger at center, uniform:Uniform ]
// For spikes: Set scale oscilation trough the sphere
spikes_variation = 0.5; // [0.5:0.5:5]

// For bulbs: Set top decoration
bulb_type="hole"; // [hole:Hole, ball:Ball, flat:Flat ]




/* [Hidden] */
$fn = 16;
c = 3;
num = 360;
zmult = spikes_variation;

//screw
if(part=="screw"){
    translate([0,0,-10]){
        rotate([0,0,0]){
            difference(){
                union(){
                    translate([0,0,0])
                    scale([2,2,1]){
                        screw_thread(45,8,55,20,PI/2,2);
                    }
                    //translate([0,0,8]) cylinder(r1=43,r2=45,h=2,$fn=60);
                }
                translate([0,0,-6]) cylinder(r=37, h = 40,$fn=40);
            }    
        }
    }

}else{
    // PHYLLOTAXIS sphere
    difference(){
        union(){
            difference(){
                union(){
                    // Phyllotaxis loop
                    for(i=[0:num]){
                        
                        
                        // spikes orientation (perpendicular to sphere)
                        gx = 0;
                        gy = 90-90*cos(i*0.5)*abs(cos(i*0.5)); 
                        gz = 0;
                        
                        // Scale of spikes
                        sx = c*(0.5+abs(sin(i*0.5)));
                        sy = sx;
                        sz = sx;
                        
                        // Distribution of spikes (sphere)
                        r = c*15*sin(i*0.5); // distance XY
                        z = c*15*cos(i*0.5); // distance Z
            
                        rx = 0;
                        ry = i*0.25;
                        rz = angle*i;
                        
                        translate([0,0,z])
                        rotate([rx,0,rz]){
                            translate([r,0,0]){
                                    scale([sx,sy,sz]){
                                            rotate([gx,gy,gz]){ 
                                        
                                                  
                                        if(i%pattern2_every==0){
                                            // Pattern 2  
                                            if(pattern2=="spike"){
                                                spike(i);
                                            }else{
                                                bulb(i);
                                            }
                                            
                                        }else{
                                            // pattern 1
                                            if(pattern1=="spike"){
                                                spike(i);
                                            }else{
                                                bulb(i);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                         
                    }
                    
                    difference(){
                        sphere(47,$fn=50);
                        sphere(43,$fn=50);
                        if(part!="all"){
                            translate([0,0,8]) cylinder(r1=46,r2 = 35,h=8,$fn=50);
                            rotate([180,0,0]) translate([0,0,8]) cylinder(r1=46,r2 = 35,h=8,$fn=50);
                        }
                    }
                    


                }
                if(part!="all"){
                    translate([0,0,-10]) cylinder(r=45.5,h=20,$fn=60);
                }
            }


            //nut
            if(part!="all"){
                translate([0,0,-10]){
                    scale([2,2,1]){
                          hex_nut(46,20,8,55,45,0.5);  
                    } 
                }
            }


        } // fin union

        // Diferencia con un cubo para partir por la mitad
        if(part=="up"){
            translate([0,0,-100]) rotate([0,0,0]) cube([200,200,200],center = true); // up
        }
        if(part=="down"){
            translate([0,0,100]) rotate([0,0,0]) cube([200,200,200],center = true); // up
        }
        //    translate([0,0,50]) rotate([0,0,0]) cube([200,200,100],center = true); // down
    } // fin difference

}// fin else


// some modules for geometry
module spike(i){
    color("orange"){
        if(spikes_distribution == "Bigger_at_top"){
            z = 0.5+spikes_scale*abs(cos(i*zmult));
            scale([1,1,z])
            cylinder(r1=c*0.75, r2 = c*0.1, h = c*1);
        }else{
            if(spikes_distribution == "Bigger_at_center"){
                z = 0.5+spikes_scale*abs(sin(i*zmult));
                scale([1,1,z])
                cylinder(r1=c*0.75, r2 = c*0.1, h = c*1);
            }else{
                z = spikes_scale;
                scale([1,1,z])
                cylinder(r1=c*0.75, r2 = c*0.1, h = c*1);
            }
        }
    }
}


module bulb(i){
    difference(){
        cylinder(r1=c*0.8,r2 = c*0.3, h = c*0.5,$fn=15);

        if(bulb_type=="hole"){
            translate([0,0,c*0.2])
            cylinder(r1=c*0,r2=c*0.3,h=c*0.5,$fn = 6);
            
        }
    
    }
    if(bulb_type=="ball"){
        translate([0,0,c*0.5])
        //cylinder(r1=c*0,r2=c*0.3,h=c*0.5,$fn = 6);
        sphere(r = c*0.25, $fn=10);
    }
    

}



// COPY-PASTE of Poor man's screw library (just for customizer)

/*
 *    polyScrewThread_r1.scad    by aubenc @ Thingiverse
 *
 * This script contains the library modules that can be used to generate
 * threaded rods, screws and nuts.
 *
 * http://www.thingiverse.com/thing:8796
 *
 * CC Public Domain
 */

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
        hex_head_1(hg,df); // modfied by Fernando Jerez (for 'ring nuts')
        // hex_head(hg,df); // original library code

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
        for(j=[0:sn-1]){
			pt = [	[0,                  0,                  i*st-st            ],
                        [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
                        [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
								[0,0,i*st],
                        [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
                        [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
                        [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ],
                        [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
                        [0,                  0,                  i*st+st            ]	];
        
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

module hex_head(hg,df)
{
	rd0=df/2/sin(60);
	x0=0;	x1=df/2;	x2=x1+hg/2;
	y0=0;	y1=hg/2;	y2=hg;

	intersection()
	{
	   cylinder(h=hg, r=rd0, $fn=6, center=false);

		rotate_extrude(convexity=10, $fn=6*round(df*PI/6/0.5))
		polygon([ [x0,y0],[x1,y0],[x2,y1],[x1,y2],[x0,y2] ]);
	}
}
 
module hex_head_0(hg,df)
{
    cylinder(h=hg, r=df/2/sin(60), $fn=60, center=false);
}


/*************
Added by Fernando Jerez (useful for 'ring nuts'
*/
module hex_head_1(hg,df)
{
    cylinder(h=hg, r=df/2, $fn=60, center=false);
}
/**************/


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

