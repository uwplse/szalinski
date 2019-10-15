// Under-section
undership=8;

// Height
ha=60;

// radius
ta=100;

// Offset
ep=2;

// Number of columns
col=8;

// Resize X
rx=0.9;

// Resize Y
ry=1.05;

// Resize Z
rz=1.025;

// Translation X
tx=0;

// Translation Y
ty=-10;

// Translation Z
tz=1;

// Quality
qu=16;

// Divisor quality columns
divqucols=2;


tata();

module tata(it=1)
{
    toto();
    if (it<=undership)
    {
        translate([tx,ty,tz])
        scale([1*rx,1*ry,1*rz])
        tata(it=it+1);
    }
}

module toto()
{
    union()
    {
        difference()
        {
            cylinder(r=ta,h=ha,center=true,$fn=qu);
            cylinder(r=ta-ep,h=ha+ep,center=true,$fn=qu);
            cylinder(r=ta+ep,h=ha-2*ep,center=true,$fn=qu);
        }

        difference()
        {
            cylinder(r=ta,h=ep,center=true,$fn=qu);
            cylinder(r=ta-ep,h=ha+ep,center=true,$fn=qu);
        }
        
        
        for (i=[1:col])
        {
            rotate([0,0,360/col*i])
            translate([ta-ep/2,0])
            cylinder(r=ep/2,h=ha-ep,$fn=qu/divqucols,center=true);
        }
   }
}