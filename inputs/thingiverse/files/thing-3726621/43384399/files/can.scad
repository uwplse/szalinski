topDiameter = 77.13; // [.1:1:150]
topHeight = 2.5;     // [.1:1:10]
topEdgeRadius = .5;  // [.1:.1:1] 
neckHeight = 5;      // [.1:1:20] 
canDiameter = 74.7;  // [.1:1:150]
baseDiameter = 73;   // [.1:1:150]
canHeight = 102.3;   // [.1:1:150]
baseHeight = 4;      // [.1:1:10]
canEdgeRadius = 5;   // [.1:1:10] 
$fn=100;             // [0:100]

pringlesCan   = true;
shortCan      = true;
tallCan       = true;
standardCan   = true;
customizerCan = true;

module can( $fn           = $fn,          
            baseDiameter  = baseDiameter,
            baseHeight    = baseHeight,   
            canDiameter   = canDiameter,  
            canEdgeRadius = canEdgeRadius,
            canHeight     = canHeight,    
            neckHeight    = neckHeight,   
            topDiameter   = topDiameter,  
            topEdgeRadius = topEdgeRadius,
            topHeight     = topHeight)
{
    translate([0,0,topHeight+neckHeight+canHeight+baseHeight])
    {
        cylinder(h = topHeight/2, r1 = topDiameter/2, r2 = topDiameter/2 - topHeight/2, center = false);

        translate([0,0,-topHeight/2])
        {
            cylinder(h = topHeight/2, r1 = topDiameter/2 - topHeight/2, r2 = topDiameter/2, center = false);
        }

        translate([0,0, -topHeight/2 - neckHeight])
        {
            color("green")
            {
                cylinder(h = neckHeight, r1 = canDiameter/2, r2 = topDiameter/2 - topHeight/2, center = false);
            }
        }

        translate([0,0, -topHeight/2 - neckHeight - canHeight])
        {
            color("blue")
            {
                cylinder(h = canHeight, r1 = canDiameter/2, r2 = canDiameter/2, center = false);
            }
        }

        translate([0,0, -topHeight/2 - neckHeight - canHeight- baseHeight])
        {
            color("red")
            {
                cylinder(h = baseHeight, r1 = baseDiameter/2, r2 = canDiameter/2, center = false);
            }
        }
    }
}

module short_can()
{
    can
    (
        $fn = 100,
        baseDiameter = 53,
        baseHeight = 2,
        canDiameter = 57,
        canEdgeRadius = 5,
        canHeight = 99.3,
        neckHeight = 2,
        topDiameter = 54.5,
        topEdgeRadius = 1,
        topHeight = 2.5
    ); 
}
    
    
module tall_can()
{
    can
    (
        $fn = 100,
        baseDiameter = 53,
        baseHeight = 2,
        canDiameter = 57,
        canEdgeRadius = 5,
        canHeight = 150.5,
        neckHeight = 2,
        topDiameter = 54.5,
        topEdgeRadius = 1,
        topHeight = 2.5
    );
}

module standard_can()
{
    can
    (
        $fn = 100,
        baseDiameter = 53,
        baseHeight = 6,
        canDiameter = 66.05,
        canEdgeRadius = 5,
        canHeight = 102.3,
        neckHeight = 14,
        topDiameter = 54.5,
        topEdgeRadius = 1,
        topHeight = 2.5
    );
 }
 
 
 module pringles_short_can()
 {
     can
     (
         $fn = 100,
         baseDiameter = 73,
         baseHeight = 4,
         canDiameter = 76,
         canEdgeRadius = 5,
         canHeight = 50,
         neckHeight = 0,
         topDiameter = 78.5,
         topEdgeRadius = 0.5,
         topHeight = 2.5
     );
}

if(customizerCan) translate([0,0,0])       can();   // default settings (customizer) 
if(shortCan)      translate([100,100,0])   short_can();
if(tallCan)       translate([100,-100,0])  tall_can();
if(standardCan)   translate([-100,100,0])  standard_can();
if(pringlesCan)   translate([-100,-100,0]) pringles_short_can();

