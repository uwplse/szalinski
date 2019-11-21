//by Eric Hughes

//Roundness - 20 for testing, 50 for printing
$fn=50;

//Thickness of panes
thick = 2;//

//GPS Width
bbx = 122.55;

//How far the shade extends out from the face
bby = 60;

//GPS thickness (gap needed to slide down from top)
GThick = 15.65; 

// How far down the left and right shade extends 
z = 63;

//holding bracket lip on x (sides).  How much covers face.
hx = 10; 

//holding bracket lip in Z (top)
hz = 5;

//how far down holding bracket goes (if hbd=z then all the way)(don't let it cover your USB power jack)
hbd = 55; 

//width of cut needed for back support bracket
bsx = 31;

//how much of GThick can stay without bracket getting in the way.  If it overhangs the face this number should be negative
bsy = 3;

//from the bottom, how much of the shade corder should be cut off in the z direction (height)
crnrz=30;

//from the bottom, how much of the shade corner should be cut off in the y direction (depth)
crnry=60;


finalizeshade();
//buildshade();

module finalizeshade(){
difference(){
    moveshade();
    cornercut();
    }}

module moveshade(){
translate([(bbx+2*thick)/2, (bby+GThick+thick)/2, (z+thick)/2]){
buildshade();
}}

module cornercut(){
rotate([90,0,90])
//rotate(90)
linear_extrude(height=500){
polygon(points=[[0,0],[crnry,0],[0,crnrz]]);
}}
   
module buildshade(){
    difference(){
    holder();
    cutblock2();
        }
difference(){
    baseblock();
    cutblock1();
    backsupportcut();
    backcut();
    backcircularcut();
}}

module baseblock(){
    cube([bbx+2*thick, bby+GThick+thick, z+thick],center=true);
}

module cutblock1(){
    translate([0,-thick,-thick]){
    cube([bbx, bby+GThick+thick , z+thick],center=true);
}}

module holder(){
     translate([0,((bby+GThick)/2)-thick-GThick,(z-hbd)/2]){
    cube([bbx+2*thick, thick, z+thick-(z-hbd)],center=true);
}}

module cutblock2(){
    translate([0,-thick-.01,-thick-hz-.01]){
    cube([bbx-2*hx, bby+GThick+thick, z+thick],center=true);
}}

module backsupportcut(){
    translate([0,25+(bby/2)+(GThick/2)+(thick/2)-thick-(GThick-bsy),0]){
    cube([bsx,50, 2*z],center=true);
    }}
    
module backcut(){
    translate([0,0,-hbd-thick]){
        cube([bbx, bby+GThick+thick, z+thick],center=true);
}}

module backcircularcut(){
    translate([0,.5+(bby+GThick+thick)/2,(z+thick)/2-thick-hbd]){
    rotate([90,0,0]){
        scale([1,(hbd-hz)/((bbx-2*hx)/2)])cylinder(h=thick+1, d=(bbx-2*hx));
}}}
