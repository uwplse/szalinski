//Enter text
texty="The Kaspriak's"; //

//Enter text size
sizey=5; //

//Enter Left/Right Adjustment
movey=-24;

difference(){

cylinder(h=3,r=30,center=false);

scale([0.1,0.1])
translate([-160,-75,-1])
linear_extrude(height = 5, center = false, convexity = 15)
polygon(points=[[0,58],[85,25],[133,0],[142,9],[109,29],[101,47],[117,34],[146,45],[149,50],[193,63],[215,48],[250,47],[274,38],[283,57],[321,52],[336,82],[294,95],[254,82],[242,92],[222,91],[201,114],[176,105],[146,149],[115,101],[14,73]],  paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]],convexity=10);
rotate([0,0,180])
translate([movey,-15,-5])    
linear_extrude(height=10){
text(texty, size=sizey,font = "Liberation Sans:style=Bold Italic");}}