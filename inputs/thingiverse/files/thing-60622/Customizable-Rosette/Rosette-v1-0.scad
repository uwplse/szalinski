// Rosette
// (c) 2013 Wouter Robers

HoleDiameter=24;
NumberOfSidesForHole=6; //[4:60]
NumberOfLeaves=12; //[3:30]
LeafLength=20;  //[10:40]
LeafWidth=15; //[2:20]
LeafThickness=3; //[1:10]
LeafPointyness=4; //[0:10]
HalfOrFull="Full"; //[Half,Full]
// Polygons
$fn=15; //[15:Rough,30:Medium,60:Fine]

difference(){
union(){
translate([0,0,-0.1]) cylinder(r1=28,r2=0,h=17,$fn=12);
translate([0,0,15]) for(i=[1:NumberOfLeaves]){
rotate([0,27,i*360/NumberOfLeaves])
intersection(){
scale([LeafLength,LeafWidth,LeafThickness]) translate([1,-LeafPointyness/10,0])sphere(1);
scale([LeafLength,LeafWidth,LeafThickness]) translate([1,LeafPointyness/10,0])sphere(1);
}
}

}
// Cutting floor
translate([0,0,-100]) cube(200,center=true);
//Cutting half
if(HalfOrFull=="Half"){
translate([0,-50,0]) cube(100,center=true);}
// Hexagonal hole
translate([0,0,-1]) cylinder(r=HoleDiameter/2/cos(180/NumberOfSidesForHole),h=70,$fn=NumberOfSidesForHole);
translate([0,0,-0.1]) cylinder(r1=12/(0.5*sqrt(3))+9,r2=HoleDiameter/2/sin(60),h=9,$fn=NumberOfSidesForHole);
}




