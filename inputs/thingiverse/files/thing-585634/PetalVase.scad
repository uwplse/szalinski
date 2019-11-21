$fn=48*1;
NumberOfPetals=10;        //Number of Petals
WidthOfVase=100;          //Length of Petals
WidthOfPetals=90;         //Inverse width of Petals
HeightOfVase=200;         //Vase height
SHeight=HeightOfVase*1.1; //Shell Height
WallThickness=2;          //Relative Thickness of Vase wall
BottomToTopRotation=100;  //Degrees of Rotation of base shape
BDepth=2*1 ;              //Vase Base Depth


        
difference()    {
//Outer
linear_extrude(height=HeightOfVase,convexity=10,twist=BottomToTopRotation)  
scale([1,1,1])    
for(i=[0:360/NumberOfPetals:360])    { 
rotate(a=[0,0,i])      { 
intersection(){
translate([0,WidthOfVase/2,0])   
{circle(r=WidthOfVase/2);}

rotate(a=[0,0,WidthOfPetals])      { 
translate([0,WidthOfVase/2,0])   
{circle(r=WidthOfVase/2);}}}}};
//

//Inner
difference()    {
scale([(100-WallThickness)/100,(100-WallThickness)/100,1])
translate([0,0,0])   {
linear_extrude(height=SHeight,convexity=10,twist=(BottomToTopRotation/HeightOfVase)*SHeight)       
for(i=[0:360/NumberOfPetals:360])    { 
rotate(a=[0,0,i])      { 
intersection(){
translate([0,WidthOfVase/2,0])   
{circle(r=WidthOfVase/2);}

rotate(a=[0,0,WidthOfPetals])      { 
translate([0,WidthOfVase/2,0])   
{circle(r=WidthOfVase/2);}}}}};;}

translate([0,0,BDepth/2])
{cube([WidthOfVase*2,WidthOfVase*2,BDepth],center=true);}}}
;