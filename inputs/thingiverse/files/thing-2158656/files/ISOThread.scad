// ISO screw thread modules by RevK @TheRealRevK
// https://en.wikipedia.org/wiki/ISO_metric_screw_thread
// Usable as a library - provides standard nut and both as well as arbitrary thread sections

/* [ Global ] */

// Length of bolt
l=50;

// Size
m=20; // [1.4,1.6,2,2.5,3,4,5,6,7,8,10,12,14,16,18,20,22,24,27,30,33,36]

// Clearance for printer tollerance for nut
t=0.2;

// Steps
$fn=100;

iso_bolt(m=m,l=l);
translate([m*2,0,0])iso_nut(m=m,t=t);

// Examples
//union(){iso_bolt(m=20,l=50);translate([40,0,0])iso_nut(m=20);}
//union(){iso_bolt(m=10,l=30);translate([25,0,0])iso_nut(m=10);}
//iso_thread(l=20,cap=0);
//iso_thread(l=5);
//iso_nut(m=20);
//union(){difference(){iso_bolt(m=20,l=50);linear_extrude(height=0.4)scale(1.4)import("/Users/adrian/Documents/3D/DXF/aac.dxf");};translate([40,0,0])iso_nut(m=20);}

function iso_hex_size(m)    // Return standard hex nut size for m value
=lookup(m,[
 [1.4,3],
 [1.6,3.2],
 [2,4],
 [2.5,5],
 [3,6],
 [3.5,6],
 [4,7],
 [5,8],
 [6,10],
 [7,11],
 [8,13],
 [10,17],
 [12,19],
 [14,22],
 [16,24],
 [18,27],
 [20,30],
 [22,32],
 [24,36],
 [27,41],
 [30,46],
 [33,50],
 [36,55],
 ]);
 
 
 function iso_pitch_course(m)   // Return standard course pitch for m value
=lookup(m,[
[1,0.25],
[1.2,0.25],
[1.4,0.3],
[1.6,0.35],
[1.8,0.35],
[2,0.4],
[2.5,0.45],
[3,0.5],
[3.5,0.6],
[4,0.7],
[5,0.8],
[6,1],
[7,1],
[8,1.25],
[10,1.5],
[12,1.75],
[14,2],
[16,2],
[18,2.5],
[20,2.5],
[22,2.5],
[24,3],
[27,3],
[30,3.5],
[33,3.5],
[36,4],
[39,4],
[42,4.5],
[48,5],
[52,5],
[56,5.5],
[60,5.5],
[62,6]
  ]);

module hex_head(d=30,w=0)
{ // Make a hex head centred 0,0 with height h and wrench size/diameter d
    intersection()
    {
        w=(w?w:d/3);
        r=d/2;
        m=sqrt(r*r+r*r*tan(30)*tan(30))-r;
        cylinder(r=r+m,h=w,$fn=6);
        union()
        {
            cylinder(r1=r,r2=r+m,h=m);
            translate([0,0,m])cylinder(r=r+m,h=w-m*2);
            translate([0,0,w-m])cylinder(r1=r+m,r2=r,h=m);
        }
    }
}

module iso_thread(  // Generate ISO / UTS thread, centred 0,0,
    m=20,    // M size, mm, (outer diameter)
    p=0,  // Pitch, mm (0 for standard coarse pitch)
    l=50,   // length
    t=0,    // tolerance to add (for internal thread)
    cap=1,  // capped ends. If uncapped, length is half a turn more top and bottom
)
{
    p=(p?p:iso_pitch_course(m));
    r=m/2; // radius
    h=sqrt(3)/2*p;  // height of thread
    fn=round($fn?$fn:36); // number of points per turn
    fa=360/fn; // angle of each point
    n=max(fn+1,round(fn*(l+(cap?p*2:0))/p)+1); // total number of points
    q=min(p/16,t); // thread width adjust
    p1=[for(i=[0:1:n-1])[cos(i*fa)*(r-5*h/8+t),sin(i*fa)*(r-5*h/8+t),i*p/fn+q]];
    p2=[for(i=[0:1:n-1])[cos(i*fa)*(r-5*h/8+t),sin(i*fa)*(r-5*h/8+t),i*p/fn+p/4-q]];
    p3=[for(i=[0:1:n-1])[cos(i*fa)*(r+t),sin(i*fa)*(r+t),i*p/fn+p/2+p/8-p/16-q]];
    p4=[for(i=[0:1:n-1])[cos(i*fa)*(r+t),sin(i*fa)*(r+t),i*p/fn+p/2+p/8+p/16+q]];
    p5=[for(i=[0:1:n-1])[cos(i*fa)*(r-5*h/8+t),sin(i*fa)*(r-5*h/8+t),i*p/fn+p+q]];
    p6=[[0,0,p/2],[0,0,n*p/fn+p/2]];
    
    t1=[for(i=[0:1:fn-1])[n*5,i,i+1]];
    t2=[[n*5,n,0],[n*5,n*2,n],[n*5,n*3,n*2],[n*5,n*4,n*3]];
    t3=[for(i=[0:1:n-2])[i,i+n,i+1]];
    t4=[for(i=[0:1:n-2])[i+n,i+n+1,i+1]];
    t5=[for(i=[0:1:n-2])[i+n,i+n*2,i+n+1]];
    t6=[for(i=[0:1:n-2])[i+n*2,i+n*2+1,i+n+1]];
    t7=[for(i=[0:1:n-2])[i+n*2,i+n*3,i+n*2+1]];
    t8=[for(i=[0:1:n-2])[i+n*3,i+n*3+1,i+n*2+1]];
    t9=[for(i=[0:1:n-2])[i+n*3,i+n*4,i+n*3+1]];
    t10=[for(i=[0:1:n-2])[i+n*4,i+n*4+1,i+n*3+1]];
    t11=[for(i=[0:1:fn-1])[n*5+1,n*5-i-1,n*5-i-2]];
    t12=[[n*5+1,n*4-1,n*5-1],[n*5+1,n*3-1,n*4-1],[n*5+1,n*2-1,n*3-1],[n*5+1,n-1,n*2-1]];
   
    intersection()
    {
        translate([0,0,-p/2-(cap?p:0)])
        polyhedron(points=concat(p1,p2,p3,p4,p5,p6),
        faces=concat(t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12));
        if(cap)hull()
        { // champhered ends and capped to exact length
            cylinder(r1=r-5*h/8+t,r2=r+t,h=5*h/8*tan(30));
            translate([0,0,l-5*h/8*tan(30)])cylinder(r1=r+t,r2=r-5*h/8+t,h=5*h/8*tan(30));
        }
    }
}

module iso_bolt(m=20,w=0,l=50,p=0)
{
    hex_head(d=iso_hex_size(m),w=w);
    iso_thread(m=m,l=l,p=p);
}

module iso_nut(m=20,w=0,p=0,t=0.2)
{
    w=(w?w:m/2); // How thick to make the nut
    p=(p?p:iso_pitch_course(m)); // standard pitch
    h=sqrt(3)/2*p;  // height of thread
    r=m/2; // radius
    difference()
    {
        hex_head(d=iso_hex_size(m),w=w);
        translate([0,0,-p/2])iso_thread(m=m,p=p,l=w+p,t=t,cap=0);
        translate([0,0,-1])cylinder(r1=r+t+1,r2=r-5*h/8+t,h=1+5*h/8*tan(30));
        translate([0,0,w-5*h/8*tan(30)])cylinder(r2=r+t+1,r1=r-5*h/8+t,h=1+5*h/8*tan(30));
    }
}
