height = 100;
innerR = 16;
outerR = 22;

difference(){
    cylinder(h = height, r = outerR);
    cylinder(h = height+1, r = innerR);
}