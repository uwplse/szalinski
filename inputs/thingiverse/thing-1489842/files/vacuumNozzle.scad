innerRadius = 25;
wallThickness = 2;
nozzleWidth = 40;
nozzleHeight = 7;

difference()
{
union()
{
    translate([0,0,0])cylinder(25, innerRadius+wallThickness, innerRadius+wallThickness, false, $fn = 50);
    
        hull()
        {
        translate([0,0,20])cylinder(25, innerRadius+wallThickness, innerRadius+wallThickness, false, $fn = 50);
        translate([0,0,90])cube([nozzleWidth+2*wallThickness, nozzleHeight+2*wallThickness, 40], true);
           
        }
}
union()
    {
    translate([0,0,-1])cylinder(26, innerRadius, innerRadius, false, $fn = 50);
        
        hull()
        {
        translate([0,0,19])cylinder(26, innerRadius, innerRadius, false, $fn = 50);
        translate([0,0,90])cube([nozzleWidth, nozzleHeight, 41], true);
           
        }
    }
}