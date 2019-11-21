bt=20;  // board thickness
at=2;   // arc thickness

co=50;  // corner offset

th=10;  // tooth height
tt=10;  // tooth thickness
dt=5;   // distance between teeth
nt=10;  // number of teeth

w=nt*tt+(nt-1)*dt; // width row of teeth
echo(Row_of_teeth = w);

difference()
{
    union()
    {
        cube([w+co,w+co,at]);
        
        color("Blue")
        translate([co,0,at-0.01])
        cube([w,bt,bt+th+0.01]);

        color("Purple")
        translate([0,co,at-0.01])
        cube([bt,w,bt+th+0.01]);
    };

    color("Green")
    translate([0,0,at/2])
    cylinder(h=2*at,r=co,center=true, $fn=60);

    color("Red")
    translate([w+co,w+co,at/2])
    cylinder(h=2*at,r=w,center=true, $fn=60);
    
    color("Orange")
    translate([bt/2,bt/2,at])
    cube([w+co,w+co,bt]);
    
    color("Fuchsia")
    for(n=[1:nt-1])
    {
        translate([co-dt+n*(tt+dt),-0.5,at+bt-0.01])
        cube([dt,bt+1,th+1]);
        
        translate([-0.5,co-dt+n*(tt+dt),at+bt-0.01])
        cube([bt+1,dt,th+1]);
    };
};