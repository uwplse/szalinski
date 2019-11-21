FilamentDiameter = 1.8;
// Total size will be ToolSize+2
ToolSize = 50;
ShowFilament = 0; // [0:No, 1:Yes]
InnerHole = 1; // [0:Cube, 1:Cylinder]
ThicknessAdjustX = 2.5;
// Keep little bigger than X one
ThicknessAdjustY = 4; 

/* [HIDDEN] */
$fn = 25;
FilamentRadius = FilamentDiameter/2;
toolX = FilamentDiameter+ThicknessAdjustX;
toolY = FilamentDiameter+ThicknessAdjustY;
baseToolSize = ToolSize +2;

// Rotate to better preview in Thingiverse
rotate([0,0,-90])
    tool();
if(1==ShowFilament){
    cylinder(h=baseToolSize*1.2,r=FilamentRadius,center=true);
}

module tool(){
    addRadius = 0.5;
    difference(){
        cube([toolX,toolY,baseToolSize],center=true);
        
        translate([0,0,-baseToolSize*0.25]) 
        if(0==InnerHole)
            cube([2*(FilamentRadius+addRadius),
                  2*(FilamentRadius+addRadius),
                  baseToolSize*2],center=true);
        else
            cylinder(r=FilamentRadius+addRadius,h=baseToolSize*2,center=true);
        
        translate([toolX/2,0,0])
            cube([toolX/2,FilamentDiameter*0.9,baseToolSize-6],center=true);
    }
    fc = FilamentDiameter < 2.25 ? 1.5 : 1.25;
    markSize = ThicknessAdjustY/2;
    for(i = [0:1:(baseToolSize/5)-1]){
        z = 3-(baseToolSize/2) + 5 * i;
        if(z < (baseToolSize/2)-3){ // Precaution IF
            translate([toolX/2,-(markSize/2)+((i%2==0 ? 1 : -1)*(FilamentRadius+markSize/2)),z])
                cube([0.5,markSize,1]);
        }
    }
}