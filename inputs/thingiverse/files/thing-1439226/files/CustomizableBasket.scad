//!OpenSCAD

//Total Width in mm
totalWidth = 30; // [20:75]
//Total Width in mm
totalDepth = 30; // [20:75]
//Total Width in mm
totalHeight = 30; // [30:50]
//Thickness of corner pillars in mm
pillarThickness = 3; // [2:4]
//Height of bottom of basket in mm
bottomHeight = 10; // [5:20]
//Number of bars in X
numberOfXBars = 3; // [1:5]
//Number of bars in Y
numberOfYBars = 2; // [1:5]
//Bar width in mm
barWidth = 2; // [1.6:3]
// Height of top rim in mm
rimHeight = 4; // [4:6]
//Your Name
initials = "Mr. Johnson";

barXSpacing = totalWidth/(numberOfXBars+1);
barYSpacing = totalDepth/(numberOfYBars+1);

difference()
{
    union()
    {
        // Pillars
        
        cube([pillarThickness,pillarThickness,totalHeight]);
        translate([totalWidth-pillarThickness,0,0])
        cube([pillarThickness,pillarThickness,totalHeight]);
        translate([totalWidth-pillarThickness,totalDepth-pillarThickness,0])
        cube([pillarThickness,pillarThickness,totalHeight]);
        translate([0,totalDepth-pillarThickness,0])
        cube([pillarThickness,pillarThickness,totalHeight]);

        // Top Square

        translate([0,0,totalHeight-pillarThickness])
        difference()
        {
            cube([totalWidth,totalDepth,rimHeight]);
            translate([pillarThickness,pillarThickness,0])
            cube([totalWidth-2*pillarThickness,totalDepth-2*pillarThickness,rimHeight]);
        }
        
        // Mesh in YZ plane
        for(i=[1:numberOfXBars])
        {
            translate([i*barXSpacing-barWidth/2,0,bottomHeight])
            {
                cube([barWidth,totalDepth,barWidth]);
                cube([barWidth,pillarThickness,totalHeight-bottomHeight]);
                translate([0,totalDepth-pillarThickness,0])
                cube([barWidth,pillarThickness,totalHeight-bottomHeight]);
            }    
        }
        
        // Mesh in XZ plane
        for(i=[1:numberOfYBars])
        {
            translate([0,i*barYSpacing-barWidth/2,bottomHeight])
            {
                cube([totalWidth,barWidth,barWidth]);
                cube([pillarThickness,barWidth,totalHeight-bottomHeight]);
                translate([totalWidth-pillarThickness,0,0])
                cube([pillarThickness,barWidth,totalHeight-bottomHeight]);
            }    
        }
    }
    
    // Engraved text
    translate([1,.5,totalHeight-pillarThickness+1]) 
        rotate([90,0,0])
            scale([0.25,0.25,1])
                color("Red",1) 
                    linear_extrude(height = 1)          
                        text(initials);  
}