// number of faces around the outside of the vase (minimum 3)
noOfFaces = 40; // [3:100]
// radius in mm
radius = 25;
// no of layers
layers = 5; // [1:50]
// how thick you'd like the walls behind the studs to be
wallThickness=10; 
// height to width ratio. 1 gives square studs. Values over 1 give tall studs. Values under 1 give wide studs
heightToWidthRatio=2;
// degree of the stud coming out from the wall. Can break the model if too large
faceStep=1;

angleStep=360/max(noOfFaces,3);
height=heightToWidthRatio*sqrt((radius*radius)+(radius*radius)-2*(radius*radius)*cos(angleStep));
echo (height);
union(){
for(layer=[0:1:layers-1]){    
    translate ([0,0,layer*height])
for (angle=[0:angleStep:355.9]){ 
    
    faceAngle=atan(faceStep/(radius+faceStep));
    
 //   translate([0,0,angle/1]) //good values: 1, 29
    polyhedron([[radius*sin (angle),radius*cos (angle),0], //0
                [radius*sin ((angle+angleStep)%360),radius*cos((angle+angleStep)%360),0], 
                [radius*sin ((angle+angleStep)%360),radius*cos((angle+angleStep)%360),height],
                [radius*sin (angle),radius*cos (angle),height],
    
                [(radius-wallThickness)*sin (angle),(radius-wallThickness)*cos (angle),0], //4
                [(radius-wallThickness)*sin ((angle+angleStep)%360),(radius-wallThickness)*cos((angle+angleStep)%360),0],
                [(radius-wallThickness)*sin ((angle+angleStep)%360),(radius-wallThickness)*cos((angle+angleStep)%360),height],
                [(radius-wallThickness)*sin (angle),(radius-wallThickness)*cos (angle),height],
    
                [(radius+faceStep)*sin (angle+faceAngle),(radius+faceStep)*cos (angle+faceAngle),faceStep], //8
                [(radius+faceStep)*sin ((angle+angleStep-faceAngle)%360),(radius+faceStep)*cos((angle+angleStep-faceAngle)%360),faceStep],
                [(radius+faceStep)*sin ((angle+angleStep-faceAngle)%360),(radius+faceStep)*cos((angle+angleStep-faceAngle)%360),height-faceStep],
                [(radius+faceStep)*sin (angle+faceAngle),(radius+faceStep)*cos (angle+faceAngle),height-faceStep],
    ],
    [
    [4,5,1,0],  // front
    
    [7,6,5,4],  // back
    [5,6,2,1],  // right
    [6,7,3,2],  // back
    [7,4,0,3], //left
    
    [0,1,9,8], //bottom bevel
    [8,11,3,0], //left bevel
    [9,1,2,10], //right bevel
    [2,3,11,10], //top bevel
    
    [8,9,10,11] //outer face
    ]); // left
 
}
}}