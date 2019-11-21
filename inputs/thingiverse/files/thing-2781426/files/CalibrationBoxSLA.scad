// 3D Calibration box with drain holes for SLA
 
// Length of box (X), in mm
Length = 20;   // [5:1:500]

// Depth of box (Y), in mm
Depth = 20;   // [5:1:500]

// Height of box (Z), in mm
Height = 10;   // [5:1:500]

// Should the box be hollow, boolean
hollow = 1; //   // [0:false, 1:true]

// Wall thickness, in mm
wallThickness = 1.5;    // [0.1:0.1:10.0]

// Should drain holes be included, boolean
drains = 1; //   // [0:false, 1:true]

// Corner drain diameter, in mm
drainDiameter = 2.5;    // [0.2:0.1:10.0]

// Corner drain quality
drainQuality = 40;  // [20:1:200]

// Include axis labels, boolean
labels = 1; //   // [0:false, 1:true]

// Indention of text, percentage
textIndentPercent = 25; // [1:90]


module calibrationBox()
{
    cornerDist3 = sqrt( (Length*Length)/4 + (Depth*Depth)/4 + (Height*Height)/4 );
 //   cornerDist2 = sqrt( (Length*Length)/4 + (Depth*Depth)/4 );
    cornerAngleXY = atan2(Depth,Length);
    cornerAngleX = asin( Height / (2*cornerDist3) );
    cornerLength = cornerDist3 * 2.5;
    cornerRadius = drainDiameter/2;
    
    difference()
        {
        cube( [Length,Depth,Height], center=true );
        
        if (hollow == 1)
            {
            // inner hollow
            cube( [Length-2*wallThickness,Depth-2*wallThickness,Height-2*wallThickness], center=true );

            if (drains == 1)
                {
                // corner drains
                rotate([90-cornerAngleX,0,90-cornerAngleXY])
                    cylinder( cornerLength, cornerRadius, cornerRadius, center=true, $fn=drainQuality );
                rotate([90+cornerAngleX,0,90-cornerAngleXY])
                    cylinder( cornerLength, cornerRadius, cornerRadius, center=true, $fn=drainQuality );
                rotate([90-cornerAngleX,0,90+cornerAngleXY])
                    cylinder( cornerLength, cornerRadius, cornerRadius, center=true, $fn=drainQuality );
                rotate([90+cornerAngleX,0,90+cornerAngleXY])
                    cylinder( cornerLength, cornerRadius, cornerRadius, center=true, $fn=drainQuality );
                
                }   // end drains
                
            }   // end hollow

        if (labels == 1)
            {
            // axis labels
            tX = min( Length, Height ) - 2*wallThickness;
            tY = min( Depth,  Height ) - 2*wallThickness;
            tZ = min( Length, Depth  ) - 2*wallThickness;
            
            tIndent = wallThickness * textIndentPercent / 100;
            
           translate([Length/2 - tIndent,0,0])
              rotate([90,0,90])
                linear_extrude(tIndent+1)
                  text("X", size=tX,
                       halign="center", valign="center");
            
           translate([-Length/2 - wallThickness + tIndent,0,0])
              rotate([90,0,90])
                linear_extrude(tIndent+1)
                  text("X", size=tX,
                       halign="center", valign="center");
            
           translate([0,Depth/2 + wallThickness - tIndent,0])
              rotate([90,0,0])
                linear_extrude(tIndent+1)
                  text("Y", size=tY,
                       halign="center", valign="center");
            
           translate([0,-Depth/2 + tIndent,0])
              rotate([90,0,0])
                linear_extrude(tIndent+1)
                  text("Y", size=tY,
                       halign="center", valign="center");
            
           translate([0,0,Height/2 - tIndent])
              rotate([0,0,0])
                linear_extrude(tIndent+1)
                  text("Z", size=tZ,
                       halign="center", valign="center");
            
           translate([0,0,-Height/2 + tIndent ])
              rotate([180,0,0])
                linear_extrude(tIndent+1)
                  text("Z", size=tZ,
                       halign="center", valign="center");
           }    // end labels
            
        }   // end difference

}   // end calibrationBox

calibrationBox();
