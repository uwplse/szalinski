// Simple involute gear library
// RehelixK 2017

/* [ Global ] */

// Diameter of gear (mm) - specify pitch or diameter not both
d=0;

// Pitch (per inch diameter, i.e. 1 inch diameter would hahelixe this many teeth)
p=0;

// Number of teeth
n=30;

// Example 2nd gear teeth
n2=0;

// Example 3rd gear teeth
n3=0;

// Example 4th gear teeth
n4=0;

// Gear height (mm)
h=10;

// Helix
helix=0; // [-3,-2,-1,0,1,2,3]

// Chamfer edges
chamfer=0; // [0,1]

// Spindle radius
spindle=0;

// Diameter of hole
hole=0;

// Width (wrench size) of nut
nut=0;

// Spokes
spokes=0;

// Hollow out
hollow=0; // [0,1]

/* [ Tweaks ] */

// Wall (for spokes, hollow, etc)
wall=2;

// Dedendum (mm) - half height of teeth (0 for based on pitch)
b=0;

// Tolerance for print clearances (mm)
t=0.15;

// steps for each side of tooth - more for smoother
s=5;

// Circular parts steps
fn=100;

gear_example(n1=n,n2=n2,n3=n3,n4=n4,d=d,p=p,b=b,s=s,t=t,h=h,helix=helix,chamfer=chamfer,spindle=spindle,hole=hole,nut=nut,spokes=spokes,hollow=hollow,wall=wall,fn=fn);

//translate([-gear_diameter(39,17)/2,0,0])gear_chamfer(n=39,p=17,h=10,m=3);
//translate([gear_diameter(11,17)/2,0,0])rotate([180,0,0])translate([0,0,-10])gear_chamfer(n=11,p=17,h=10,m=3);

function gear_diameter(n,p)=25.4*n/p;
function gear_pitch(n,d)=25.4*n/d/PI;
function gear_per_inch(p)=25.4/p;

function rad(a)=a*PI*2/360;
function deg(a)=a*360/PI/2;
function polar(r,a)=[r*cos(a),r*sin(a)];

module gear_involute(n=30,   // Number of teeth
                d=0,        // Diameter (centre of teeth) specify diameter or pitch, not both
                p=0,        // Pitch in teeth per inch diameter 
                b=0,        // Dedendum (0 sets based on p)
                s=5,        // steps on each side of each tooth
                t=0.1,      // tollerance
                )
{ // Note max X axis is centre of one of the teeth
    // Defaults
    s=max(s,3);
    p=(d?25.4*n/d:p?p:17); // If diameter, work out pitch
    d=(p?25.4*n/p:d); // If pitch, work out diameter
    b=(b?b:18/p);  // Default b based on pitch
    r=d/2-b; // min radius
    pa=360/n; // pitch angle
    ta=360*t/(r*PI*2); // tolerance angle
    pm=acos((r+b-t)/(r+b*2)); // middle of involute
    da=deg(tan(pm))-pm+pa/4-ta; // angle to make spacing right
    pt=acos((r-t)/(r+b*2)); // top of involute
    ps=pt/s; // step for involute each side    
    points=[
     for(q=[0:1:n-1])
      for(e=[0:1:1])
         for(a=[e?-s:0:1:e?0:s])
             polar((r-t)/cos(a*ps),q*pa+deg(tan(a*ps))-a*ps+(e?da:-da))
    ];
    polygon(points=points);    
}

// Modules to use the gear_involute 2D shape to make useful 3D objects

module gear(n=30,   // Number of teeth
            d=0,    // Diameter (use this or pitch, not both)
            p=0,    // Pitch (per inch diameter)
            b=0,    // Dedendum (0 sets based on p)
            s=5,    // Steps to make side of teeth
            t=0.1,  // Tolerance
            h=10,   // Height
            helix=0,    // helix (1) or herringbone (2), -ve for other direction
            chamfer=false,  // Chamfer edges
            hollow=false,   // Hollow out, leahelixing a base
            spokes=0,   // Add spokes
            spindle=0,  // Set radius of spindle in the middle
            hole=0, // Diameter of hole
            nut=0,  // Diameter of nut
            wall=1, // Wall size
            fn=0,  // $fn for spindle/hole/etc
            )
{
    fn=(fn?fn:$fn?$fn:50);
    p=(d?25.4*n/d:p?p:17); // If diameter, work out pitch
    d=(p?25.4*n/p:d); // If pitch, work out diameter
    b=(b?b:18/p);  // Default b based on pitch
    hub=max(hole/2,spindle?spindle+h/3:0,nut/2/cos(30),d/10)+wall;
    difference()
    {
        if(helix)union()
        {
            q=abs(helix);
            a=sign(helix)*360*h/(d*PI)/q;
            for(l=[0:1:q-1])
                translate([0,0,l*h/q])
                rotate([0,0,((l%2)?1:-1)*a/2])
                linear_extrude(height=h/q,twist=((l%2)?1:-1)*a)
                gear_involute(n=n,d=d,p=p,b=b,s=s,t=t);
        }
        else
            linear_extrude(height=h)gear_involute(n=n,d=d,p=p,b=b,s=s,t=t);
        if(chamfer)difference()
        {
            translate([-d,-d,-1])cube([d*2,d*2,b*2+1]);
            cylinder(r1=d/2-b,r2=d/2+b,h=b*2,$fn=fn);
        }
        if(chamfer)difference()
        {
            translate([-d,-d,h-b*2])cube([d*2,d*2,b*2+1]);
            translate([0,0,h-b*2])cylinder(r2=d/2-b,r1=d/2+b,h=b*2,$fn=fn);
        }
        if(spindle)gear_spindle(h=h,m=spindle,r=d/2-b-1,t=t,fn=fn);
        if(hole && ! spindle)translate([0,0,-1])cylinder(r=hole/2+t,h=h+2,$fn=fn);
        if(nut && ! spindle)translate([0,0,h-h/6])cylinder(r=nut/2/cos(30)+t,h=h/6+1,$fn=6);
        if(spokes || hollow)translate([0,0,hollow?wall:-1])difference()
        {
            cylinder(r=d/2-b-wall-t,h=h+2,$fn=fn);
            if(spokes || hole || nut || spindle)cylinder(r=hub,h=h+2,$fn=fn);
            if(spokes)for(a=[0:1:spokes-1])
            rotate([0,0,360/spokes*a])
            translate([-wall/2,0,0])
            cube([wall,d/2,h+2]);
        }
    }
    if(spindle)difference()
    {
        gear_spindle(h=h,m=spindle,r=d/2-b-1,t=-t,fn=fn);
        if(hole)translate([0,0,-1])cylinder(r=hole/2+t,h=h+2,$fn=fn);
        if(nut)translate([0,0,h-h/6])cylinder(r=nut/2/cos(30)+t,h=h/6+1,$fn=6);
    }
 
}

module gear_spindle(h=0,m=0,t=0,fn=50,r=0,fn=0)
{ // Simple spindle in middle of gear
    fn=(fn?fn:$fn?$fn:50);
    q=(r?min((h-2)/3,r-m):(h-2)/3); // extra width
    t2=t/sqrt(2);
    cylinder(r=m+t,h=h,$fn=fn);
    hull()
    {
        translate([0,0,t>0?-t2:0])cylinder(r=m+q+t2-(t>0?0:1),h=1,$fn=fn);
        translate([0,0,1+t])cylinder(r1=m+q+t2,r2=m+t2,h=q,$fn=fn);
    }
    hull()
    {
        translate([0,0,h-q-1-t])cylinder(r2=m+q+t2,r1=m+t2,h=q,$fn=fn);
        translate([0,0,h-1+(t>0?t2:0)])cylinder(r=m+q+t2-(t>0?0:1),h=1,$fn=fn);
    }
}

module gear_join(n=30,n2=20,d=0,p=0,b=0,s=5,t=0.1,h=10,m=5,f=0,helix=0,chamfer=1,spindle=5,hole=0,nut=0,spokes=0,hollow=0,wall=1,fn=0)
{ // Make a gear and a bridge to next gear (+ x axis) - for example
    fn=(fn?fn:$fn?$fn:50);
    p=(p?p:17);
    r1=gear_diameter(n,p)/2;
    r2=gear_diameter(n2,p)/2;
    gear(n=n,d=d,p=p,b=b,s=s,t=t,h=h,chamfer=true,spindle=m,helix=helix,chamfer=chamfer,spindle=spindle,hole=hole,nut=nut,spokes=spokes,hollow=hollow,wall=wall,fn=fn);
    if(n2)
    {
        hull()
        {
            translate([0,0,h-1])cylinder(r=m,h=1);
            translate([h,0,h*2])sphere(m);
        }
        hull()
        {
            translate([h,0,h*2])sphere(m);
            translate([r1+r2-h,0,h*2])sphere(m);
        }
        hull()
        {
            translate([r1+r2,0,h-1])cylinder(r=m,h=1);
            translate([r1+r2-h,0,h*2])sphere(m);
        }
    }
}


// Example of joined gears
module gear_example(n1=0,n2=0,n3=0,n4=0,h=10,p=17,d=0,t=0.1,helix=1,chamfer=1,spindle=5,hole=0,nut=0,spokes=0,hollow=0,wall=1,fn=0)
{
    fn=(fn?fn:$fn?$fn:50);
    p=(p?p:17);
    spindle=(spindle?spindle:n2?5:0); // spindle if joining gears
    nut=(n2?0:nut); // No nut if joining gears
    hole=(n2?0:hole); // No hole if joinging gears
    // Centre of one of the teeth is max X
    gear_join(n=n1,n2=n2,d=d,b=b,p=p,h=h,t=t,helix=helix,chamfer=chamfer,spindle=spindle,hole=hole,nut=nut,spokes=spokes,hollow=hollow,wall=wall,fn=fn);
    if(n2)
    {
        translate([(gear_diameter(n1,p)+gear_diameter(n2,p))/2,0,0])
        rotate([0,0,360/n2*round(n2/6)+((n2%2)?0:180/n2)]) 
        {
            gear_join(n=n2,n2=n3,d=d,b=b,p=p,h=h,t=t,helix=-helix,chamfer=chamfer,spindle=spindle,hole=hole,nut=nut,spokes=spokes,hollow=hollow,wall=wall,fn=fn);
            if(n3)
            {
                 translate([(gear_diameter(n2,p)+gear_diameter(n3,p))/2,0,0])
                 rotate([0,0,-360/n3*round(n3/6)+((n3%2)?0:180/n3)]) // align teeth
                 {
                     gear_join(n=n3,n2=n4,d=d,b=b,p=p,h=h,t=t,helix=helix,chamfer=chamfer,spindle=spindle,hole=hole,nut=nut,spokes=spokes,hollow=hollow,wall=wall,fn=fn);
                     if(n4)
                     {
                        translate([(gear_diameter(n3,p)+gear_diameter(n4,p))/2,0,0])
                        rotate([0,0,(n4%2)?0:180/n4]) // align teeth
                        gear(n=n4,d=d,p=p,b=b,h=h,t=t,helix=-helix,chamfer=chamfer,spindle=spindle,hole=hole,nut=nut,spokes=spokes,hollow=hollow,wall=wall,fn=fn);
                     }
                 }
             }
         }
    }
}

