numberOfSides=26;
linear_extrude(scale=0,height=numberOfSides) circle(numberOfSides,$fn=numberOfSides/2);
mirror([0,0,1]) linear_extrude(scale=0,height=numberOfSides) circle(numberOfSides,$fn=numberOfSides/2);