$fn=50;

boardLength = 150;
boardWidth =85;
boardHeight = 15;

distanceToBorderY =5;
distanceToBorderX =5;

rowLength = 60;
rowWidth = 7;
distanceBetweenRows = 3;
numberOfRows =7;

boxLenght = 60;
boxWidth = 60;
boxHeight = 10;

holeSize = 10;

difference()
{
//board
linear_extrude(height=boardHeight)
{
    scale([boardLength,boardWidth])
    translate([-0.5,-0.5])
        square([1,1]);
}
//rows
for(i=[0:numberOfRows])
{
    //cylindric coutout of rows
    translate([-boardLength/2 + rowWidth/2 + distanceToBorderX +i * (rowWidth  + distanceBetweenRows),
    -rowLength /2- (boardWidth -rowLength)/2 + distanceToBorderY+ rowWidth/2,boardHeight])
    rotate([0,90,90])
        linear_extrude(height= rowLength- rowWidth)
        scale(rowWidth)
        circle(0.5);
    
    
    //x ajustment of rows
    translate([-boardLength/2 + rowWidth/2 + distanceToBorderX +i * (rowWidth  +
    distanceBetweenRows),0,0])
    {
        //lower roundings of rows
        translate([0,
        -rowLength /2- (boardWidth -rowLength)/2 +distanceToBorderY + rowWidth/2,
        boardHeight])
        scale(rowWidth)
        sphere(0.5);
        
        //upper rounding of rows
        translate([0,
        -rowLength /2- (boardWidth -rowLength)/2 +distanceToBorderY + rowWidth/2 +rowLength-rowWidth,
        boardHeight])
        scale(rowWidth)
        sphere(0.5);
    }
}

//box
translate([(boardLength -boxLenght) /2 - distanceToBorderX,-(boardWidth -boxWidth) /2 + distanceToBorderY,boardHeight - boxHeight])
    linear_extrude(height=boxHeight+0.01)
{
    scale([boxLenght,boxWidth])
    translate([-0.5,-0.5])
        square([1,1]);
}

//hole
translate([boardLength/2 -holeSize/2 -distanceToBorderX,boardWidth/2 -holeSize/2 -distanceToBorderY,-0.01])
linear_extrude(height= boardHeight+0.02)
        scale(holeSize)
        circle(0.5);

    }
