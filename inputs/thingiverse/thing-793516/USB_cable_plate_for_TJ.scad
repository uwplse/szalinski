plateWidth = 100;
plateHeight = 75;
plateThickness = 2;
plateHalfWidth = plateWidth / 2;
plateHalfHeight = plateHeight / 2;

plateCornerRadius = 5;
plateCornerCenterXOffset = plateHalfWidth - plateCornerRadius;
plateCornerCenterYOffset = plateHalfHeight - plateCornerRadius;

plugDiameter = 26.5;
plugRadius = plugDiameter / 2;
plugThickness = 10;

totalThickness = plateThickness + plugThickness;

usbHoleCount = 4;
usbHoleDiameter = 4;
usbHoleRadius = usbHoleDiameter / 2;
usbHoleSpacing = (plugDiameter - usbHoleDiameter * usbHoleCount) / usbHoleCount;
usbHoleHalfSpacing = usbHoleSpacing / 2;
usbHoleCenterSpacing = usbHoleSpacing + usbHoleDiameter;
usbHoleOuterCenterY = plugRadius - usbHoleHalfSpacing - usbHoleRadius;

mountingHoleDiameter = 6.35;
mountingHoleRadius = mountingHoleDiameter / 2;
mountingHoleEdgeClearance = 10;
mountingHoleCenterEdgeClearance = mountingHoleEdgeClearance + mountingHoleRadius;
mountingHoleYOffset = plateHalfHeight - mountingHoleCenterEdgeClearance;
mountingHoleOuterXOffset = plateHalfWidth - mountingHoleCenterEdgeClearance;
mountingHoleInnerXOffset = mountingHoleCenterEdgeClearance;

alignmentTabYOffset = plateHalfHeight - plugRadius;
alignmentTabDiameter = 3;
alignmentTabRadius = alignmentTabDiameter / 2;

separationForPrinting = 2;
halfSeparation = separationForPrinting / 2;

$fs = 0.1;

union()
{
    RotateCopy([0, 0, 180])
    {
        translate([halfSeparation, 0, 0])
        {
            intersection()
            {
                translate([0, 0, plateThickness / 2])
                {
                    difference()
                    {
                        union()
                        {
                            // Mounting plate
                            
                            hull()
                            {
                                for (y = [-plateCornerCenterYOffset, plateCornerCenterYOffset],
                                    x = [-plateCornerCenterXOffset, plateCornerCenterXOffset])
                                {
                                    translate([x, y, 0])
                                    {
                                        cylinder(h = plateThickness, r = plateCornerRadius, center = true,
                                            $fa = 1);
                                    }
                                }
                            }
                    
                            // Plug
                    
                            translate([0, 0, (plateThickness + plugThickness) / 2])
                            {
                                cylinder(h = plugThickness, r = plugRadius, center = true);
                            }
                        }
                        
                        // Mounting holes

                        for (x = [mountingHoleInnerXOffset, mountingHoleOuterXOffset])
                        {
                            for (y = [-mountingHoleYOffset, mountingHoleYOffset])
                            {
                                translate([x, y, 0])
                                {
                                    cylinder(h = plateThickness + 1, r = mountingHoleRadius, center = true);
                                }
                            }
                        }
                        
                        // Alignment slot
                        
                        translate([0, alignmentTabYOffset, 0])
                        {
                            cylinder(h = plateThickness + 1, r = alignmentTabRadius, center = true);
                        }

                        // USB holes
                        
                        for (y = [-usbHoleOuterCenterY :  usbHoleCenterSpacing : usbHoleOuterCenterY])
                        {
                            translate([0, y, -plateThickness / 2 - 0.5])
                            {
                                cylinder(h = totalThickness + 1, r = usbHoleRadius);
                            }
                        }
                    }
                    }
                
                // Bounding box to get the right half
                
                translate([0, -plateHalfHeight, -1])
                {
                    cube([plateHalfWidth, plateHeight, plateThickness + plugThickness + 1]);
                }
            }
                
            // Alignment tab
            
            translate([0, -alignmentTabYOffset, 0])
            {
                cylinder(h = plateThickness, r = alignmentTabRadius);
            }
        }
    }
}

module RotateCopy(normal)
{
    children();
    
    rotate(a = normal)
    {
        children();
    }
}

module MirrorCopy(normal)
{
    children();
    
    mirror(normal)
    {
        children();
    }
}