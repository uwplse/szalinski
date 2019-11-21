xSize = 190; // Width of the block
ySize = 150; // Length of the block
thickness = 10; // Height of the block

bottomThickness = 0.7; // Thickness of the remaining block in the tool cut outs

raisedText = 1; // 1 = raised text, anything else = sunk text 
textHeight = 1.2; // Depth of the extruded text

// Extra clearance is required to make to socket slip in nicely
// The amount of tollerance required varies on the size of socket.
toolClearanceOffset = 0.4; // base clearance applied to each hole
toolClearanceGain = 0.01; // 1% of diameter extra clearance

toolSpace = 6; // X Gap between sockets
 
autoRowGap = 15; // The gap between the biggest tool in each row.

textSize = 7; // Size of the text
textOffset = 1; // Y offset of the text from the tool cut out 
 
// Link edges allow peices to slot together. Set to 1 to enable, 0 to disable
topLink = 1;
bottomLink = 1;
leftLink = 1;
rightLink = 1;

// Enter diameters of the tool cut outs as they appear on the block
// the first row must contain a zero and the first entry in each row must be zero
toolDia =  [
[0], 
//  Sockets
[0, 31.9, 35.8, 39.8, 51],
[0, 21.7, 21.7, 24.5, 24.7, 26.3, 27.8],
[0, 11.7,12.8,21.9, 21.9, 21.9, 21.8, 21.9],
//[0, 11.5, 11.6],
// Deep sockets
//[0,   16.9, 16.9, 20,   20.9, 23.8,  25.8],
//[0, 16.8, 18.8, 22,   27.6],
// Hex 
//[0, 21.9, 21.8, 21.9, 23.9, 25.9, 27.9],
//[0, 17.4, 17.4, 17.4, 17.4, 17.4, 17.4],

// Torx
//[0, 17.9, 17.9, 17.9, 17.9, 17.7, 17.8, 17.9, 17.8, 17.9, 17.9],
// External Torx
//[0, 12, 12, 12, 12,11.9, 16.9, 16.9, 17.9, 19.7, 21.9, 23.9],
// Small Torx
//[0, 16.8, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1],
// Step up/down
//[0, 25.1, 22.8, 17.7, 11.7, 22.1, 21.5, 15.7],
];

// add the text for each entry above (there must be an entry for each tool)
// Text must have have dummy entries to match the diameter array
toolText = [
["X"], 
// Sockets
["x",       "24",     "27",     "30",     "36"],
["x",       "15",     "16",     "17",     "18",     "19",     "20"],
["x",       "8","9","10",     "11",     "12",     "13",     "14"],
["x",       "5",      "6"],
// Deep Sockets
["x",        "12", "13",  "14", "15", "17", "19"],
["x",     "10", "11", " 10 Spk" , "14 Spk"],
// Hex sockets
["x", "H8", "H10", "H12", "H14", "H17", "H19"],
["x", "H2.5", "H3", "H4", "H5", "H6", "H7"],
// Torx
["x", "T10", "T15", "T20", "T25", "T27", "T30", "T40", "T45", "T50", "T55"],
// External Torx
["x", "E4", "E5", "E6", "E7", "E8", "E10", "E12", "E14", "E16", "E18", "E20"],
// Torx Small bits
["x", "Adpt", "T10", "T15", "T20", "T25", "T27", "T30", "T40"],
// Step up/downs
["x", "↑", "↑", "↑", "↑", "↓", "↓", "↓"]
];

// number of rows from the array
toolRows = len (toolDia);

// calculate the maximum socket size in this row
function maximum(array, index = 0) = (index < len(array) - 1) ? max(array[index], maximum(array, index+1)) : array[index];

// Recursive sum to calculate accumulative offset
function sum(array,index,start=0, gap) = (index==start ? array[index] : array[index] + sum(array,index-1,start, gap)+gap);

// Add or cut out linked edges
module link(x, y, length, angle, clearance)
{
    rotate (angle, 0, 0) 
    {
        translate ([x,y, - bottomThickness]) cube ([length, 2, 2-clearance]);
        translate ([x,y + 2, - bottomThickness]) cube ([length, 3, 5]);
    }
}

// calculate the row sizes
rowSize = [for (xLoop = [0:toolRows-1]) maximum (toolDia[xLoop],0)];

// Calculate where to start in the y axis to centre tools on the block    
yStart = (ySize+autoRowGap-textSize-sum(rowSize,toolRows-1,0, autoRowGap))/2; 

difference () {
    union () {  
        // Draw the block
        translate ([0,0, -bottomThickness]) cube ([xSize, ySize, thickness + bottomThickness]);
        // Add links
        if (topLink == 1) link (7, ySize, xSize - 14, 0,0.5);
        if (leftLink == 1) link (7, 0, ySize -14, 90, 0.5);

        if (raisedText==1)
        {
            // add the text
            // Loop through the rows
            for (xLoop = [1:toolRows-1]) 
            {
                toolsPerRow = len (toolDia[xLoop]);
                xStart = (xSize+toolSpace-sum(toolDia[xLoop],toolsPerRow-1,0, toolSpace))/2;
             
                // loop through the tools on this row
                for (yLoop = [1:toolsPerRow])
                {
                    diameter = toolDia [xLoop][yLoop];
                    xPos = (sum(toolDia[xLoop],yLoop-1,0, toolSpace)+0.5*diameter) + xStart;
                    yPos =  ySize - ((yStart + sum (rowSize, xLoop-1, 0, autoRowGap)+rowSize[xLoop]) - 0.5*diameter)-textOffset;
                    color ([0,0,1]) translate ([xPos, yPos - (0.5*diameter), thickness]) linear_extrude (height = textHeight) text (toolText [xLoop][yLoop], size = textSize, valign = "top", halign = "center", font = "Liberation Sans");
                }
            }
        }
    }
    // remove the link cut outs
    if (bottomLink == 1) link (0, 0, xSize, 0,0);
    if (rightLink == 1) link (0, -xSize, ySize, 90,0);

    // remove the tools
    // loop through the rows
    for (xLoop = [1:toolRows-1])
    {
        toolsPerRow = len (toolDia[xLoop]);
        xStart = (xSize+toolSpace-sum(toolDia[xLoop],toolsPerRow-1,0, toolSpace))/2;
        
        // loop through the tools in this row
        for (yLoop = [1:toolsPerRow-1])
        {
            toolClearance = (toolDia[xLoop][yLoop] * toolClearanceGain) + toolClearanceOffset;
            diameter = toolDia [xLoop][yLoop] + toolClearance;
            xpos = (sum(toolDia[xLoop],yLoop-1,0, toolSpace)+0.5*diameter) + xStart;
            yPos =  ySize - ((yStart + sum (rowSize, xLoop-1, 0, autoRowGap)+rowSize[xLoop]) - 0.5*diameter);
              
            translate ([xpos, yPos, 0]) cylinder (h = thickness+1, d = diameter, center = false);
            
            if (raisedText!=1)
            {
                // Subtract the text
                translate ([xpos, yPos - (0.5*diameter)-textOffset, thickness-textHeight]) linear_extrude (height = 100+textHeight) text (toolText [xLoop][yLoop], size = textSize, valign = "top", halign = "center", font = "Liberation Sans");
            }
        }
    }
}
