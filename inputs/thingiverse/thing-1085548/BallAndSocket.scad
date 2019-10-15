// Ball-and-socket joint for an articulated mirror stuck to a wall

part = "makeBoth"; // [makeBall:Ball,makeSocket:Socket,makeBoth:Both,assembled:Assembled]

// Diameter of Ball
ballSize = 15;

// Oversize for Socket
ballSlop = 1;

// Thickness of socket walls
socketThickness = 2.5;

// Thickness of Flange
flangeThickness = 2.5;

// Diameter of Flange
flangeDiameter = 40;

// Length of neck extension
neckLength = 10;

// Diameter of Mounting Holes
holeSize = 3.2; 

// Diameter of Screw Head
screwHead = 6.5;

/* [Hidden] */
$fn=50;
flangeMountFactor=.27; // placement for flange holes

if (part=="makeBall") ball();
else if (part=="makeSocket") socket();
else if (part=="makeBoth")
{
    ball();
    translate([flangeDiameter + 1, 0, 0]) socket();
}
else // assembled
{    
    socket();
    translate([0,0,(flangeThickness+neckLength)*2-ballSize*.25]) rotate([180,0,0]) ball();
}

module ball()
{
    union()
    {
        base();
    
        // ball
        translate([0,0,flangeThickness+neckLength]) sphere(d=ballSize);
    }
}

module socket()
{
    difference()
    {
        union()
        {
            base();
        
            // outer ball
            translate([0,0,flangeThickness+neckLength-ballSize*.25]) sphere(d=ballSize+(socketThickness*2));
            
        }
        
        // cut off top of ball
        translate([0,0,flangeThickness+neckLength]) cylinder(d=2*ballSize,h=2*ballSize);
        
        // add socket hole
        translate([0,0,flangeThickness+neckLength-ballSize*.25]) sphere(d=ballSize+ballSlop);
        
        // second sphere to bevel the lip
        translate([0,0,flangeThickness+neckLength+ballSize*.15]) sphere(d=ballSize+ballSlop);
        
        // add notches for easier insertion
        for (i=[0,90])
        rotate([0,0,i]) translate([0,0,flangeThickness+neckLength]) cube([socketThickness,ballSize + (socketThickness*2) + .1,ballSize*.6], center=true);
        
        // make sure bottom stays flat
        translate([0,0,-flangeDiameter]) cube(flangeDiameter*2,center=true);
    }
}


module base()
{
    difference()
    {
        union()
        {
            // flange base
            translate([0,0,flangeThickness/2])cylinder (d=flangeDiameter,h=flangeThickness,center=true);
            
            // neck
            hull()
            {
                translate([0,0,flangeThickness/2])cylinder (d=flangeDiameter/2,h=flangeThickness,center=true);
                translate([0,0,flangeThickness/2+neckLength-ballSize*.3]) cylinder(d=ballSize/2,h=.1,center=true);
            }
        }
        
        // flange holes
        for (i=[-1,1],j=[-1,1])
        translate ([i*(flangeDiameter*flangeMountFactor),j*(flangeDiameter*flangeMountFactor),-.1]) cylinder (d=holeSize,h=flangeThickness+neckLength);

        
        // screwhead relief
        for (i=[-1,1],j=[-1,1])
        translate ([i*(flangeDiameter*flangeMountFactor),j*(flangeDiameter*flangeMountFactor),flangeThickness-.4]) cylinder (d=screwHead,h=neckLength);
        
    }
    
}