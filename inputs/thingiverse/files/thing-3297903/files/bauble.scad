// bauble
// version 0.0.2
// by pixelhaufen
// is licensed under CC BY-SA 3.0 -> https://creativecommons.org/licenses/by-sa/3.0/

//------------------------------------------------------------------
// User Inputs

/*[main]*/

edges=8; // [6:1:18]
size=60; // [30:1:90]
stretch=1; // [1:0.1:2]
pattern="zigzag a"; // [left,right,zigzag a,zigzag b]
hole="no"; // [yes,no]

/*[Hidden]*/
$fn = 40; // can't be modified on thingiverse
base=size/12;
radius_base = 1/12*size;

//------------------------------------------------------------------
// Main

if(hole=="yes")
{
    difference()
    {
        base();
        
        rotate([90,0,0])
            translate([0,-radius_base/2,-radius_base])
                cylinder(r1=radius_base/4, r2=radius_base/4, h=radius_base*2, center=false);
    }
}
else
{
    base();
}

if(pattern=="left")
{
    pattern_value=[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
    ball(pattern_value);
}
else if(pattern=="right")
{
    pattern_value=[1,1,1,1,1,1,1,1,1,1,1];
    ball(pattern_value);
}
else if(pattern=="zigzag a")
{
    pattern_value=[1,-1,1,-1,1,-1,1,-1,1,-1,1];
    ball(pattern_value);
}
else if(pattern=="zigzag b")
{
    pattern_value=[-1,1,-1,1,-1,1,-1,1,-1,1,-1];
    ball(pattern_value);
}


//------------------------------------------------------------------
// Modules

module base()
{
    hull()
    {
        translate([0,0,-radius_base])
            linear_extrude(height = .1, center = false)
                circle(r=radius_base);
        
        linear_extrude(height = 0.1, center = false)
        {
            angles=[ for (i = [0:edges-1]) i*(360/edges) ];
            coords=[ for (th=angles) [radius_base*cos(th), radius_base*sin(th)] ];
            polygon(coords);
        }
    }
}

module ball(pattern_value)
{
    // ball start
    polyg(base, 1/20*size*stretch, edges, 2, pattern_value[0]);
    
    rotate([0,0,180/edges])
        translate([0,0,1/20*size*stretch])
            polyg(base*2, 1/20*size*stretch, edges, 3/2, pattern_value[1]);
    
    translate([0,0,1/10*size*stretch])
            polyg(base*3, 1/15*size*stretch, edges, 4/3, pattern_value[2]);
    
    rotate([0,0,180/edges])
        translate([0,0,1/6*size*stretch])
            polyg(base*4, 1/10*size*stretch, edges, 5/4, pattern_value[3]);
    
    translate([0,0,4/15*size*stretch])
            polyg(base*5, 1/6*size*stretch, edges, 6/5, pattern_value[4]);
    
    // ball center
    rotate([0,0,180/edges])
        translate([0,0,13/30*size*stretch])
            polyg(base*6, 2/15*size*stretch, edges, 1, pattern_value[5]);
    
    // ball end
    translate([0,0,17/30*size*stretch])
            polyg(base*6, 1/6*size*stretch, edges, 5/6, pattern_value[6]);
    
    rotate([0,0,180/edges])
        translate([0,0,11/15*size*stretch])
            polyg(base*5, 1/10*size*stretch, edges, 4/5, pattern_value[7]);
    
    translate([0,0,5/6*size*stretch])
            polyg(base*4, 1/15*size*stretch, edges, 3/4, pattern_value[8]);
    
    rotate([0,0,180/edges])
        translate([0,0,9/10*size*stretch])
            polyg(base*3, 1/20*size*stretch, edges, 2/3, pattern_value[9]);
    
    translate([0,0,19/20*size*stretch])
            polyg(base*2, 1/20*size*stretch, edges, 1/2, pattern_value[10]);
}

module polyg(radius, height, edges, scale, dir)
{
    linear_extrude(height = height, center = false, convexity = 10, scale=[scale,scale], twist = 180/edges*dir,slices = 50)
    {
        angles=[ for (i = [0:edges-1]) i*(360/edges) ];
        coords=[ for (th=angles) [radius*cos(th), radius*sin(th)] ];
        polygon(coords);
    }
 }
 