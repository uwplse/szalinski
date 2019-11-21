NecklaceText = "OPEN SWAG";

OpenSWAGNecklace(NecklaceText);

module OpenSWAGNecklace(NecklaceText) {
    TextDepth = 10;
    TextSize = 20;
    TextFont = "Bitstream Vera Sans:style=Bold";
    TotalLength = 3000;
    ParaCordDiameter = 5;
    CircumferentialLength = .1;

    difference() {
        //Necklace Text
        linear_extrude(height=TextDepth, convexity=4)
        text(NecklaceText, 
             size=TextSize,
             font=TextFont,
             halign="center",
             valign="center");
        
        translate([-TotalLength/2,TextSize/4,TextDepth/2.5])
        rotate([0,90,0])
        cylinder(h = TotalLength, d = ParaCordDiameter, $fs = CircumferentialLength);
    }
}
