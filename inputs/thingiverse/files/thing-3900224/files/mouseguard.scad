// Which one would you like to see?
part = "both"; // [first:Guard only,second:Clamps Only,both:Both,preview:Preview only (do not print!)]

/* [Global] */

// Thickness (mm)
guard_thickness = 1.6;
// Total length of mouse guard (mm)
length = 110;
// Maximum space between clamps (mm)
clamp_distance = 70;
// Adjust for printer accuracy and material and assure a tight fit of clamps
tightness=.4;
// Clamp angle adjust for entrance depth/height
clamp_angle=32;

/* [Hidden] */

// Entrance taper
taper = 1; // [first:1,second:0]

// Size of entrance holes (mm)
hole_size = 10;

leng = length;
heit = 12;
thick = guard_thickness;
heit3 = 30;
slit2 = clamp_distance/2;
angle = clamp_angle;
tight = tightness;
tapering = (taper==1?guard_thickness/2:0);

holdheit = 4;

rad = hole_size;
between = 7;

numholes = floor(leng/(rad+between))-1;
//echo(numholes);
spacing = (rad+between); //leng / numholes;

holesize = spacing*(numholes-1)+rad;
//echo(holesize);

//#cube([holesize,2,2],center=true);


$fn = 60;

offset = leng/2-(leng-holesize)/2-rad/2;

module mycube(lng,het,thc)
{
    rr = 4;
    $fn = 60;
    hull()
    {
        translate([-lng/2+2,-het/2+2,0])
            cube([4,4,thc],center=true);
        translate([lng/2-2,-het/2+2,0])
            cube([4,4,thc],center=true);
        translate([-lng/2+rr,het/2-rr,0])
            cylinder(r=rr,h=thc,center=true);
        translate([lng/2-rr,het/2-rr,0])
            cylinder(r=rr,h=thc,center=true);
    }
}

module front()
{
    difference()
    {
        mycube(leng,heit,thick);

        for(i=[0:numholes-1])
        {
            translate([i*spacing-offset,-heit/2+rad/2-2,0])
                hull()
                {
                    cylinder(r2=rad/2,r1=rad/2+tapering,h=thick,center=true);
                    translate([0,-10,0])
                        cylinder(r2=rad/2,r1=rad/2+tapering,h=thick,center=true);
                }
        }
    //#cube([70,2,2],center=true);
    
        if(floor(numholes/2) == numholes/2)
        {
            //echo("Even");
            position = between/2+floor(slit2/spacing)*spacing-between/2;
            translate([position,-heit/2,-thick])
                holder();
            translate([-position,-heit/2,-thick])
                holder();
        }
        else
        {
            //echo("Odd");
            position = -between/2+floor(slit2/spacing)*spacing-rad/2;
            translate([position,-heit/2,-thick])
                holder();
            translate([-position,-heit/2,-thick])
                holder();
        }
    }
    betwen = 1.6;
    thic = 1.8;
    if(floor(numholes/2) == numholes/2)
    {
        //echo("Even");
        position = between/2+floor(slit2/spacing)*spacing-between/2;
        translate([position,-heit/2+thic/2+thic,betwen/2+thick/2])
            cube([between,1.6,betwen],center=true);
        translate([-position,-heit/2+thic/2+thic,betwen/2+thick/2])
            cube([between,1.6,betwen],center=true);
    }
    else
    {
        //echo("Odd");
        position = -between/2+floor(slit2/spacing)*spacing-rad/2;
        translate([position,-heit/2+thic/2+thic,betwen/2+thick/2])
            cube([between,1.6,betwen],center=true);
        translate([-position,-heit/2+thic/2+thic,betwen/2+thick/2])
            cube([between,1.6,betwen],center=true);
    }
}

module holder(thic = 1.8)
{
    
    translate([0,thic/2,0])
        cube([between,thic,thick*10],center=true);
}

module wedge1()
{
    hull()
    {
        translate([0,.5,0])
        rotate(5,[1,0,0])
            cube([between,.2,3],center=true);
        translate([0,-.8,0])
        rotate(-5,[1,0,0])
            cube([between,.2,3],center=true);
    }
}

module wedge2()
{
    hull()
    {
        translate([0,.3,0])
        rotate(5,[1,0,0])
            cube([between,.2,3],center=true);
        translate([0,-.6,0])
        rotate(-5,[1,0,0])
            cube([between,.2,3],center=true);
    }
}




module clamp(thic = 1.6)
{
    //#cube([6,6,20-7]);
    between = between - 2*tapering;
    cube([between,heit-2,thic]);
    translate([0,0,thick+thic+2+tight])
        cube([between,4,thic]);

    cube([between,thic,2+thic+thick+tight+thic]);

    translate([0,thic*2+thic/2,thic+thick+tight])
        cube([between,thic,2+thic]);


    translate([0,0,thic+thick+tight+thic+thic])
        cube([between,thic+tight,16]);

    translate([0,1,thic+thick+tight+thic+thic])
    rotate(-angle,[1,0,0])
        cube([between,1.2,16]);
}

if(part=="first" || part == "both")
{
translate([0,0,thick/2])
    front();
}

if(part=="second" || part == "both")
{
translate([10,10,between-2*tapering])
rotate(90,[0,1,0])
    clamp();


translate([-10,10,0])
rotate(-90,[0,1,0])
    clamp();
}

if(part=="preview")
{
rotate(180,[0,0,1])
    union()
    {
    rotate(90,[1,0,0])
    translate([0,heit/2,thick/2])
        front();
    
    
    if(floor(numholes/2) == numholes/2)
    {
        position = between/2+floor(slit2/spacing)*spacing-between/2;
        translate([position-(between-tapering)/2,thick+.2,0])
            rotate(90,[1,0,0])
                clamp();
        translate([-position-(between-tapering)/2,thick+.2,0])
            rotate(90,[1,0,0])
                #clamp();
    }
    else
    {
        //echo("Odd");
        position = -between/2+floor(slit2/spacing)*spacing-rad/2;
        translate([position-(between-tapering)/2,thick+.2,0])
            rotate(90,[1,0,0])
                clamp();
        translate([-position-(between-tapering)/2,thick+.2,0])
            rotate(90,[1,0,0])
                clamp();
    }
}
}