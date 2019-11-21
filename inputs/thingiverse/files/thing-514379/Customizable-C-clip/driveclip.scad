height = 12.99;
width = 8.64;
depth = 19.4;
overhang = 1.5;
thickness = 1.44;

translate ([0,0,height/2])
difference () {
cube ([width+2*thickness,depth+2*thickness,height],center=true);
cube ([width,depth,height+1],center=true);
translate ([width/2,0,0])
cube ([width,depth-overhang*2,height+1],center=true);
}