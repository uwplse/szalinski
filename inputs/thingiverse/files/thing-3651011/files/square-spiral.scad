gapWidth = 5; // [3:10]
lineWidth = 0.4; // [0.2,0.4,0.8,1.0,1.2]
lineHeight = 0.2; // [0.1:0.01:1]
//number of lines
steps = 20; // [1:1:50]

//builds a single layer high single extrusion width "square sprial" for checking bed level;

translate([ 0*gapWidth, 0*gapWidth,0]) rotate(  0) cube([gapWidth*1,lineWidth,lineHeight]);
for(i=[1:steps]){
x = (1-2*(1-(ceil(i/2)%2)))*ceil(i/2);
y = (1-2*(ceil((i+1)/2)%2))*(2*ceil((i-1)/4));
translate([ x *gapWidth, y*gapWidth,0]) rotate(90*(i%4)) cube([gapWidth*(i+1),lineWidth,lineHeight]);
}