// Ice sphere mould

/* [ Global ] */

// Radius of sphere
r=15;

// Thickness
t=3;

// Gap
g=0.1;

// Hole
h=5;

// Shape
side="dark"; // ["dark","light"]

// Angle width of lines
cutw=3;

// Cut depth
cutd=0.5;

base();
translate([r*2.4+t*4,0,0])top();

module cut(a,b)
{ // Cut in to a sphere between angles a and b
    render()
    difference()
    {
        hull()
        {
            cylinder(r1=0.01,r2=r*1.1*cos(a),h=r*1.1*sin(a));
            cylinder(r1=0.01,r2=r*1.1*cos(b),h=r*1.1*sin(b));
        }
        cylinder(r1=0.01,r2=r*1.1*cos(b),h=r*1.1*sin(b));
    }
}

module slice(a,b)
{
    render()
    difference()
    {
        union()
        {
            cut(a,a+cutw);
            if(a<b)
            { // virtical
                intersection()
                {
                    cut(a,b);
                    union()
                    {
                        for(z=rands(0,170,10,a+b))
                        rotate([0,0,z])
                        rotate([0,90,0])
                        cylinder(h=r*PI*cutw/180,r=r*1.1,center=true);
                    }
                }
            }
        }
        sphere(r=r-cutd);
    }
}

module ice()
{ // This is the sphere you are making
    if(side=="light")
    {
        sphere(r=r,$fn=100);
    }else
    {
        difference()
        {
            // Main sphere
            sphere(r=r,$fn=100);
            // Weapon
            rotate([0,-30,0])
            translate([r*1.3,0,0])
            sphere(r=r/2,$fn=100);
            // Cuts
            slice(1,25);
            slice(25,35);
            slice(35,80);
            slice(80,80);
            mirror([0,0,1])
            {
                slice(1,26);
                slice(26,36);
                slice(36,51);
                slice(51,71);
                slice(71,71);
            }
        }
    }
}

module base()
{
    difference()
    {
        cylinder(r=r*1.3+t,h=(r+t)*2,$fn=6);
        translate([0,0,r+t])
        ice();
        translate([0,0,r+t])
        cylinder(r=r*1.3+g,h=r+t+1,$fn=6);
        translate([0,0,-1])
        difference()
        {
            cylinder(r1=r*1.2,r2=r,h=r+t+1,$fn=6);
            translate([0,0,r])sphere(r=r+t);
            cylinder(r1=r/2*1.2,r2=r,h=r+t);
            translate([-t/2,-r-t,0])
            cube([t,r*2+t*2,r]);
        }
    }
}

module top()
{
    difference()
    {
        union()
        {
            cylinder(r=r*1.3+t,h=r,$fn=6);
            cylinder(r=r*1.3,h=r*2+t+1,$fn=6);
        }
        translate([0,0,r*2+t])
        rotate([180,0,0])
        ice();
        cylinder(d=h,h=r*2+t+2,$fn=100);
        translate([0,0,-1])
        cylinder(d1=h+r/2,d2=h,h=r/2,$fn=100);
        translate([0,0,-1])
        difference()
        {
            cylinder(r1=r*1.2,r2=r,h=r+t+1,$fn=6);
            translate([0,0,r*2])sphere(r=r+t);
            cylinder(r1=r/2*1.2,r2=r,h=r+t+1);
            translate([-t/2,-r-t,0])
            cube([t,r*2+t*2,r]);
        }
        *for(a=[30:60:359])
        rotate([0,0,a])
        translate([r-t,0,r/3+t/2])
        rotate([0,90,0])
        cylinder(r=r/3,h=t*4);
    }
}