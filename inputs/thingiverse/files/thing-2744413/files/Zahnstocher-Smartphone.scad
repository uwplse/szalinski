// Variablen
width=2;
min_height=0.4;
length=45;

// Code
linear_extrude(height = width)
polygon(points = [[0,0], [0, min_height],  [length, 1.0], [length,0]]);

linear_extrude(height = width)
polygon(points = [[length,0],[length,-1.5],[length-10,-1.5],[length-10,-0.7],[length-2,-0.7],[length-2,0]]);