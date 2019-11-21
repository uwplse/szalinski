// Strenght of your Table in mm
tabletop = 30; // [18:60]
// Width of the Hook in mm
width = 10; // [8:30]
// Choose with or without barb
closedhook = "false"; // [true,false]
// The depth of the hook
depth = 10; // [7:30]

str = tabletop;
mst = str *0.7;

if (closedhook=="true") {
linear_extrude(height = width , center = true, convexity = 10, twist = 0)
polygon(points=[[0,0],[30,0],[30,-1],[27,-4],[-depth-5,-4],[-depth-8,-1],[-depth-8,str+1],[-depth-5,str+4],[-depth,str+4],[-depth+1,str+3],[-depth+1,str+1],[-depth,str],[-depth-3,str],[-depth-4,str-1],[-depth-4,0],[-4,0],[-4,str+1],[-1,str+4],[27,str+4],[30,str+1],[30,str],[0,str]]); }
else {
linear_extrude(height = width , center = true, convexity = 10, twist = 0)
polygon(points=[[0,0],[30,0],[30,-1],[27,-4],[-depth-5,-4],[-depth-8,-1],[-depth-8,mst+3],[-depth-7,mst+4],[-depth-6,mst+4],[-depth-4,mst+2],[-depth-4,0],[-4,0],[-4,str+1],[-1,str+4],[27,str+4],[30,str+1],[30,str],[0,str]]); }