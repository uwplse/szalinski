//Paper Holder 2

//Width Of Polyhedron
WidthOfPolyhedron = 100;

//Length Of Polyhedron
LengthOfPolyhedron = 100;

//Height Of Polyhedron
HeightOfPolyhedron = 40;

//Height Of Cube (In Red)
HeightOfCube = 10;

//Width Of Cube (In Red)
WidthOfCube = 10;

//Length Of Cube (In Red)
LengthOfCube = 50;

//Width Of Slot
WidthOfSlot = 1;

//Depth Of Slot
DepthOfSlot = 10;

//Polyhedron
polyhedron( points = [ 
[0,0,0], 
[WidthOfPolyhedron*0.4,0,0], 
[0,LengthOfPolyhedron*0.4,0], 
[WidthOfPolyhedron*0.6,LengthOfPolyhedron*0.4,0], 
[WidthOfPolyhedron*0.4,LengthOfPolyhedron*0.6,0],
[WidthOfPolyhedron,LengthOfPolyhedron*0.6,0],
[WidthOfPolyhedron*0.6,LengthOfPolyhedron,0],
[WidthOfPolyhedron,LengthOfPolyhedron,0], 
[WidthOfPolyhedron*0.2,LengthOfPolyhedron*0.2,HeightOfPolyhedron], 
[WidthOfPolyhedron*0.8,LengthOfPolyhedron*0.8,HeightOfPolyhedron], 
[WidthOfPolyhedron*0.6,LengthOfPolyhedron*0.4,HeightOfPolyhedron], 
[WidthOfPolyhedron*0.4,LengthOfPolyhedron*0.6,HeightOfPolyhedron]
],
faces = [ 
[0,3,1], 
[0,2,4], 
[0,4,3], 
[3,7,5], 
[4,6,7], 
[7,3,4], 
[0,8,1],
[0,2,8], 
[1,8,3], 
[2,4,8], 
[8,11,10], 
[8,10,3], 
[8,4,11], 
[9,10,11], 
[9,3,10], 
[9,11,4], 
[9,5,3], 
[9,4,6], 
[9,7,5], 
[9,6,7]
]);
 
//Cube On Top 
translate([WidthOfPolyhedron/2,LengthOfPolyhedron/2,HeightOfPolyhedron+(1/2*HeightOfCube)]){
    rotate([0,0,-45]){
        difference(){
            color("red")
            cube([WidthOfCube,LengthOfCube,HeightOfCube],center = true);
            color("white")
            cube([WidthOfSlot,LengthOfCube,DepthOfSlot],center = true);
        }
    }
}