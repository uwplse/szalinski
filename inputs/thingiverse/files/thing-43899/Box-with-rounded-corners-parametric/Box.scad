//Make a box or a lid:
type="box";//[box,lid]

//Outer height of box with lid:
height=70;//[20:150]
//Outer width of box:
width=70;//[20:150]
//Outer depth of box:
depth=70;//[20:200]

//curvature of sides:
roundness=15;//[5:30]
// How smooth the rounded corners are. 10 is standard, 5 is quite smooth.
$fa=5;//[1:20]

//How thick the walls are:
thickness=5;//[1:20]

//How much space is between lid inset and inside of box:
wiggle_room=1;//[0:3]
//How deep the lid inset is:
flange_height=2;//[0:10]



inner_radius=roundness-thickness;
if(type=="lid"){
translate([-width/2+roundness,-depth/2+roundness,0]){
difference(){
	translate([0,0,roundness]){
	minkowski(){
		cube([width-2*roundness,depth-2*roundness,70-2*roundness]);
		sphere(roundness);}
}
translate([-roundness-1,-roundness-1,roundness])
cube([width+2,depth+2,roundness+70+1]);}
translate([wiggle_room/2,wiggle_room/2,roundness]){
	linear_extrude(height=flange_height){
		minkowski(){
		square([width-2*(inner_radius+thickness)-wiggle_room,depth-2*(inner_radius+thickness)-wiggle_room]);
	circle(inner_radius);}
}}}}

if (type=="box"){
if (inner_radius>0){
translate([-width/2+roundness,-depth/2+roundness,0]){
difference(){
	translate([0,0,roundness]){
	difference(){
	minkowski(){
		cube([width-2*roundness,depth-2*roundness,height-2*roundness]);
		sphere(roundness);}
	minkowski(){
		cube([width-2*(inner_radius+thickness),depth-2*(inner_radius+thickness),height-2*(thickness)]);
		sphere(inner_radius);}
}}
translate([-roundness,-roundness,height-roundness])
cube([width,depth,roundness+1]);}}}}