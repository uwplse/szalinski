bt=20;  // board thickness
bw=300; // board width
bl=400; // board length
at=2;   // arc thickness

co=50;  // corner offset

th=10;  // tooth height
tt=10;  // tooth thickness
dt=5;   // distance between teeth
nt=10;  // number of teeth

w=nt*tt+(nt-1)*dt; // width row of teeth
echo(Row_of_teeth = w);

ax=atan(at/(bw-co+bt/2)/sqrt(2));
echo(ax_= ax);
ay=atan(at/(bl-co+bt/2)/sqrt(2));
echo(ay_= ay);


difference()
{
    union()
    {
        color("Yellow")
        translate([0,0,-2*at])
        cube([w+co,w+co,3*at]);
        
        color("Blue")
        translate([co,0,at-0.01])
        cube([w,bt,bt+th+0.01]);

        color("Purple")
        translate([0,co,at-0.01])
        cube([bt,w,bt+th+0.01]);
    };

    color("Green")
    translate([0,0,0])
    cylinder(h=3*at,r=co,center=true, $fn=60);

    color("Red")
    translate([w+co,w+co,0])
    cylinder(h=3*at,r=w,center=true, $fn=60);
    
    color("Orange")
    translate([bt/2,bt/2,at])
    cube([bw,bl,bt]);
    
    color("Gray")
    translate([bw+bt/2,bl+bt/2,at])
    rotate([ay,-ax,0])
    translate([-bw-1-bt/2,-bl-1-bt/2,-bt])
    cube([bw+1+bt/2,bl+1+bt/2,bt]);
    
    color("Fuchsia")
    for(n=[1:nt-1])
    {
        translate([co-dt+n*(tt+dt),-0.5,at+bt-0.01])
        cube([dt,bt+1,th+1]);
        
        translate([-0.5,co-dt+n*(tt+dt),at+bt-0.01])
        cube([bt+1,dt,th+1]);
    };
};