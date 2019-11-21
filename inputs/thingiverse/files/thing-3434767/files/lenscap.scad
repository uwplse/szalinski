// the circle is approximated by this number of lines.  A 45-agon is pretty close to a circle.
$fn = 45;
// Diameter of the eyepiece in mm
innerDiameter = 38.5; 
innerRadius = innerDiameter/2;

// Diameter of the lenscap on the outside in mm
outerDiameter = 39.5; 
outerRadius = outerDiameter/2;

// thickness of the flat disk of the lenscap
pancakeThickness = 0.5;

// height of the lenscap
height = 10;

// size of inner ridges in mm.
ridgeSize = 0.5;

// size of ridges on the outside, in mm.
OuterRidgeSize = 0.25;

// number of ridges on the inside of the cap
ridges = 6;

//number of ridges out the outside of the cap
outerRidges = 20;

// how much bigger the far end of the cap is, so it gets tighter as you push farther
taper = 0.5;


module cap()
{
union(){
    difference(){ 
        {cylinder(h=height, r1=outerRadius, r2=outerRadius + taper );};  
        union(){ 
            translate([0,0,pancakeThickness*2]){cylinder(h=height         
                            , r1=innerRadius, r2=innerRadius + taper);};
            // a small transition strip from the horizontal to the vertical.
            translate([0,0,pancakeThickness]){cylinder(h=pancakeThickness         
                , r1=innerRadius -pancakeThickness , r2=innerRadius);};
        };
    };
    ridges();
}   
}

module ridges()
{
    if (ridges > 0)
    {
        step = 360/ridges;
        for( i=[0:ridges])
        {
            intersection()
            {
                rotate(a=i*step){
                translate([innerRadius-ridgeSize/2  + taper , 0,0])
                    cylinder(h=height, r1=ridgeSize + taper , 
                        r2=ridgeSize, $fn = 10); 
                };
                cylinder(h=height , r1=innerRadius, 
                    r2=innerRadius + taper);
            }
        };
    }   
    if (outerRidges > 0)
    {
        outerStep = 360/outerRidges;
        for( i=[0:outerRidges])
        {
            intersection()
            {
                rotate(a=i*outerStep){
                translate([outerRadius-OuterRidgeSize/2  + taper , 0,0])
                cylinder(h=height, r1=OuterRidgeSize  + taper , 
                    r2=OuterRidgeSize , $fn = 10 );
                };
                cylinder(h=height , r1=outerRadius + OuterRidgeSize, 
                    r2=outerRadius + OuterRidgeSize + taper);
            }        
        };
    }
}

cap();

