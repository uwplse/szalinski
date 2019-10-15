X_Dimension = 1;
Y_Dimension = 2;
Z_Dimension = 3;

X_Offset = 4;
Y_Offset = 5;
Z_Offset = 6;

module mycube(length,width,height,movex,movey,movez) {translate([movex,movey,movez]){cube([length,width,height]);}}

mycube(X_Dimension,Y_Dimension,Z_Dimension,X_Offset,Y_Offset,Z_Offset);
