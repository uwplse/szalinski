NumberOfBlades=100;
b=1+NumberOfBlades*0.62;
difference(){
cube([75,31,b+5]);
translate([5,5,6.2])
union(){
polyhedron(
    points=[
        [0,0,0],            //0
        [65.52,0,0],        //1
        [50.64,21,0],       //2
        [14.88,21,0],       //3
        [14.88,21,b],       //4
        [50.64,21,b],       //5
        [65.52,0,b],        //6
        [0,0,b]             //7
    ],
    faces=[
        [0,1,2,3],          //Bottom
        [3,2,5,4],          //Back
        [0,3,4,7],          //Left
        [2,1,6,5],          //Right
        [4,5,6,7],          //Top
        [7,6,1,0]           //Front
    ]
);
if(NumberOfBlades>50){
    translate([14.5,-6,5])
        cube([36,8,b-10]);
    translate([24.5,19,5])
        cube([16,8,b-10]);}
if(NumberOfBlades>5){
polyhedron(
    points=[
        [0,0,0],         //0
        [65.52,0,0],     //1
        [69.43,-6,0],    //2
        [-3.91,-6,0],    //3
        [-3.91,-6,.7],   //4
        [69.43,-6,.7],   //5
        [65.52,0,.7],    //6
        [0,0,.7]         //7
        ],
    faces=[
        [3,2,1,0],          //Bottom
        [2,3,4,5],          //Back
        [7,4,3,0],          //Left
        [5,6,1,2],          //Right
        [7,6,5,4],          //Top
        [6,7,0,1]           //Front
        ]);
}
translate([24.5,0,-6.4]){
    if(NumberOfBlades>5){
        cube([16,27,7]);}{
        cube([16,21,7]);}}
}
}