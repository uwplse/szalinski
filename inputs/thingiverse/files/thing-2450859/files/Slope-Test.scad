/**
 * 3d Printer Angle Tests 
 * Created by Kevin Gravier <kevin@mrkmg.com>
 *
 * Use this to test your 3d printers limits for overhangs
 * 
 */

startingAngle = 30; // The first Angle
anglePerTest = 5; // The amount in degree's to increment the angle per test
numberOfTests = 10; // The number of tests to include
widthPerTest = 7; // The width in mm of each test
totalHeight = 3; // The overall height in mm
depthOfText = 1; // The depth of the text with each angle
testGap = 2; // Gap between the tests

union() {
    
    for (i = [startingAngle:anglePerTest:(numberOfTests - 1) * anglePerTest + startingAngle]) {
        index = (i-startingAngle) / anglePerTest;
        translate([
        (index * widthPerTest) + (index * testGap),
        0, 
        0])
        slatedCube(
            angle = i, 
            width = widthPerTest, 
            height = totalHeight,
            textDepth = depthOfText);
        
        if (index != numberOfTests - 1)
        translate([(index * widthPerTest) + (index * testGap) + widthPerTest - .001, 0 ,0])
        cube([testGap + .002, widthPerTest, totalHeight]);
    }
}


module slatedCube(width=10, height=20, angle=0, textDepth=2) {
    l = round(tan(angle) * height * 100) / 100;
    f = round((width / 2) * 100) / 100;

    difference () {
        union() {
            cube([width, width, height]);
            
            translate([width, l+width-.001, height])
            rotate([180, 90, 0])
            linear_extrude(width)
            polygon([
                [0, 0],
                [height, l],
                [0, l]
            ]);

            translate([width, -l+.001, 0])
            rotate([0, -90, 0])
            linear_extrude(width)
            polygon([
                [0, 0],
                [height, l],
                [0, l]
            ]);
        };
      
            
        translate([width/2, width/2, height-textDepth])
        linear_extrude(textDepth)
        text(str(angle), f, halign="center", valign="center");  
    }
    
    
};