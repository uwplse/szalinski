$fn = 50;

layers = 26;
layerThickness = 14;
beginRadius = 48.5;
endRadius = 16.17;
chamferRadius = 16.17;
holeRadius = 5;

connectorRadius = 5;
connectorHeight = 10;
connectorMargin = 0.3;

tower();
//assembly();

module assembly()
{
    difference()
    {
        tower();
        translate([0, 0, layers / 2 * layerThickness])
        {
            cylinder(r = 1000, h = 1000);
            connectorCutouts();
        }
    }
    
    
    translate([0, 2 * beginRadius + 5, -layers / 2 * layerThickness])
    {
        difference()
        {
            tower();
            cylinder(r = 1000, h = layers / 2 * layerThickness);
            translate([0, 0, layers / 2 * layerThickness])
            {
                connectorCutouts();
            }
        }
    }
    
    translate([2 * beginRadius, 0, 0])
    {
        connectors();
    }
}


module connectors()
{
    for(i = [0:120:240])
    {
        rotate([0, 0, i])
        {
            translate([0, (beginRadius + endRadius) / 2, 0])
            {
                cylinder(r = connectorRadius - connectorMargin, h = connectorHeight - connectorMargin);
            }
        }
    }
}

module connectorCutouts()
{
    for(i = [0:120:240])
    {
        rotate([0, 0, i])
        {
            translate([0, (beginRadius + endRadius) / 2, 0])
            {
                cylinder(r = connectorRadius, h = connectorHeight, center = true);
            }
        }
    }
}

module tower()
{
    union()
    {
        for(i = [0:1:layers - 1])
        {
                
            translate([0, 0, layerThickness * i])
            {
                linear_extrude(height = layerThickness)
                {
                    difference()
                    {
                        hull()
                        {
                            for(j = [0:120:240])
                            {
                                rotate([0, 0, j])
                                {
                                    R = beginRadius - (beginRadius - endRadius) / (layers - 1) * i;
                                    echo(R);
                                    translate([0, R, 0])
                                    {
                                        circle(r = chamferRadius);
                                    }
                                }
                            }
                        }
                        circle(r = holeRadius);
                    }
                }
            }
        }
    }
}