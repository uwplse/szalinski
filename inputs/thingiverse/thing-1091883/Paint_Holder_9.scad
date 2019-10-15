/* [Global] */

/*[Container Size]*/

//Number of column
column = 2;  //[1:20]
//Number of row
row = 5; //[1:20]
//Degree of the slope
deg = 20;  //[0:25]
//Rendering of 3D model
object = 0;  //[0:Container,1:Container+Cover, 2:Container+Cover+Clip, 3:Clip ]
//Thickness of the plastic cover
coverThick = 1.2;


/*[Bottle Size]*/

//Diameter of each bottle
diameter = 35.5;
//Height of each bottle
bottleH = 42;
//Deepness of each bottle hole
holeH = 21.5;

/*[Advanced]*/
//Thickness of the container edge
space = 1.5;
//Duplicating area of each hole
offset = 1;
//Spacing of each hole against diameter of bottle
holespace = 1.7;
//Support thickness at the bottom
minusThick = 2.5;

/* [Hidden] */

holeDiameter = diameter + holespace ;

x = sqrt(space*space + holeH*holeH) * cos(90-deg-atan(space/holeH));
y = round((holeDiameter*column - offset*(column-1) +space/3) * cos(deg));

totalW = holeDiameter*row-offset*(row-1) + space*2 ;
totalH = ((holeDiameter-offset)*column+18)*sin(deg)+holeH;
totalD = x + y;



module Body(){
    
difference()
{

totalHW = (holeDiameter+3) * row ;

translate([-x,-totalW,-space,])
cube([totalD,totalW,totalH]);

rotate([0,-deg,0])
translate([-x*2,-(holeDiameter/2-2)*3*row,holeH-0.1])
cube([holeDiameter*column*2,(holeDiameter+4)*1.5*row, holeDiameter*column*cos(deg)]);

translate([0 ,-(holeDiameter)/2 - space,0])
rotate([0,-deg,0])
translate([holeDiameter/2*cos(deg)+1,0,0])
    {
for ( i = [0 : row-1 ] ){
translate([0,-(holeDiameter-offset)*i,0,])  
for ( i = [0 : column-1 ] ){
translate([(holeDiameter-offset)*i,0,0,])
cylinder(h = holeH*2, r=holeDiameter/2, $fn=60);     
 }
 }
 }
 
translate([minusThick,minusThick,0])
difference()
{
translate([-x,-totalW,-space-0.1,])
cube([totalD-minusThick*2,totalW-minusThick*2,totalH]);
 
rotate([0,-deg,0])
translate([-x*2,-(holeDiameter/2-2)*3*row,-space/3])
cube([holeDiameter*column*2,(holeDiameter+4)*1.5*row, holeDiameter*column*cos(deg)]);    

translate([-x,-totalW,-space-0.1,]){
for ( i = [1 : row+1 ] ){
translate([0.1,i*(totalW-minusThick*2)/(row+2)-minusThick/2/2,0])
cube([totalD-minusThick*2,minusThick/2,totalH]);   
}
}
}
}
    
}


module cover(){
    
    translate([-x+totalD,-totalW,holeH+sin(deg)*(holeDiameter*column-offset*(column-1)+space*2.2)-0.2])
    mirror([1,0,0])
rotate([0,deg,0]){
cube([5,totalW,bottleH-holeH]);

////hinge
translate([0,0,bottleH-holeH]){
difference(){ 
cube([5,2,5]); 
rotate([90,0,0])
translate([2.5,2.5,-2.5])
cylinder(h = 3, r=2.7/2, $fn=30);
}
translate([0,totalW-2,0])
difference(){ 
cube([5,2,5]); 
rotate([90,0,0])
translate([2.5,2.5,-2.5])
cylinder(h = 3, r=2.7/2, $fn=30);
}
}   



}
    
}


module coverClip(deg){
if (object == 2 || object ==3) {
translate([-x+totalD,-totalW,holeH+sin(deg)*(holeDiameter*column-offset*(column-1)+space*2.2)-0.2]) mirror([1,0,0]) 

    rotate([0,deg,0])
    {
    
translate([0,0,bottleH-holeH]){
    
translate([1.5,2+2/2,1.5])
difference(){ 
    translate([0,0,-(3.5-2)/2])
    cube([11,totalW-2*2-1,3.5]);
    translate([5,-1,1-coverThick/2])
    cube([9,(totalW-2*2)+2,coverThick]); 
}  
 
rotate([90,0,0])
translate([2.25+1,2.5,-2.5]){
    translate([0,0,-0.5])
    cylinder(h = 1.3, r=1.5/2, $fn=6);
    translate([0,0,0.5-(totalW-2*2)])
    mirror([0,0,1])
    cylinder(h = 1, r=1.4/2, $fn=6);
}
}
}
}

}

///////main///////

rotate([0,0,90]) {
if (object ==0 || object ==1 || object ==2)
Body();

if (object == 1 || object ==2) 
cover();

if (object ==3)
coverClip(0);
if (object ==2)
coverClip(deg);

}
