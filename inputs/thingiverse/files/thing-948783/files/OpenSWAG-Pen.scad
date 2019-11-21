FrontFaceText = "OPENSWAG";
TopFaceText = "BLACKBAUD";
BottomFaceText = "JULY 30th 2015";
Tolerance = .5;

OpenSWAGPen(FrontFaceText,TopFaceText,BottomFaceText, Tolerance);

module OpenSWAGPen(FrontFaceText,TopFaceText,BottomFaceText, Tolerance) {
    InkTipDiameter = 4 + Tolerance;
    InkTipLength = 9.5;
    InkStickDiameter = 3 + Tolerance;
    InkStickLength = 112.5;
    TotalLength = InkTipLength + InkStickLength;
    TotalDiameter = 12;
    TextDepth = 1;
    TextSize = TotalDiameter - 2;
    TextFont = "Bitstream Vera Sans:style=Bold";
    DistanceToFace = TotalDiameter / 4.3;
    CircumferentialLength = .1;
        
    translate([(-TotalLength/2),0,20])
    rotate ([180,0,0]) 
    rotate ([0,90,0]) 
    
    intersection() {
        difference() {
            intersection() {
                //Triangular pen body
                cylinder(h = TotalLength, d = TotalDiameter + 3, $fn = 3);
                
                //Truncate Triangular pen body edges
                rotate ([0,0,60]) 
                cylinder(h = TotalLength, d = TotalDiameter*2.3, $fn = 3);
            }
            
            //Ink stick
            translate([0,0,InkTipLength - .001])
            cylinder(h = InkStickLength + .002, d = InkStickDiameter, $fs = CircumferentialLength);
                
            //Ink tip
            translate([0,0, -.001])
            cylinder(h = InkTipLength + .002, d = InkTipDiameter, $fs = CircumferentialLength);
            
            //Front Face Text
            translate([-DistanceToFace,0,10 + ((TotalLength-10)/2)])
            rotate ([0,-90,0]) 
            linear_extrude(height=TextDepth, convexity=4)
            text(FrontFaceText, 
                 size=TextSize,
                 font=TextFont,
                 halign="center",
                 valign="center");
            
            //Top Face Text
            translate([DistanceToFace/2,-DistanceToFace/2 - 1,10 + ((TotalLength-10)/2)])
            rotate ([0,-90,120]) 
            linear_extrude(height=TextDepth, convexity=4)
            text(TopFaceText, 
                 size=TextSize - 1.5,
                 font=TextFont,
                 halign="center",
                 valign="center");

            //Bottom Face Text
            translate([-DistanceToFace/2 + 2.6,DistanceToFace/2 + 1.1,10 + ((TotalLength-10)/2)])
            rotate ([0,-90,-120]) 
            linear_extrude(height=TextDepth, convexity=4)
            text(BottomFaceText, 
                 size=TextSize - 1.5,
                 font=TextFont,
                 halign="center",
                 valign="center");
                 
            //Ink level view slit
            translate([TotalDiameter/2,0,0])
            rotate ([0,0,90]) 
            cube([.75,TotalDiameter,TotalLength*2], center = true);
        }

        // Tip Cone
        translate([0,0, -1])
        cylinder(h = TotalLength + 5, d1 = InkTipDiameter, d2 = 150, $fs = CircumferentialLength);
    }
}
