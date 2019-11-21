length = 11; //[8:100]
width = 8; //[5:60]
height = 6; //[1:30]

polyhedron(
points=[
//~-~!!BOTTOM!!~-~
//curve
[1-width/2,1,0], //0
[0,0,0], //1
[width/2-1,1,0], //2
//left notch
[2-width/2,2,0], //3
[1.8-width/2,2.2,0], //4
[0.65-width/2,1.25,0], //5
[0.45-width/2,2.2,0], //6
//right notch
[width/2-2,2,0], //7
[width/2-1.8,2.2,0], //8
[width/2-0.65,1.25,0], //9
[width/2-0.45,2.2,0], //10
//point
[0,length,0], //11
//~-~!!TOP!!~-~
//curve
[1.5-width/2,1.5,height/10], //12
[0,1,height/10], //13
[width/2-1.5,1.5,height/10], //14
//left notch
[2-width/2,2,height/10], //15
[1.8-width/2,2.2,height/10], //16
[1.15-width/2,1.75,height/10], //17
[1.05-width/2,2.65,height/10], //18
//right notch
[width/2-2,2,height/10], //19
[width/2-1.8,2.2,height/10], //20
[width/2-1.15,1.75,height/10], //21
[width/2-1.05,2.65,height/10], //22
//point
[0,length-2.5,height/10] //23
],
triangles=[
//~-~!!BOTTOM!!~-~
//base
[0,1,2],
//inside notches
[0,7,3],
[7,0,2],
//above notches
[8,4,3],
[8,3,7],
//outside notches
[5,4,6], //left
[8,9,10], //right
//point
[11,6,4],
[11,4,8],
[11,8,10],
//~-~!!WALLS!!~-~
//!!base!!
//left
[0,12,1],
[12,13,1],
//right
[1,13,14],
[1,14,2],
//!~!notches!~!
//!!left!!
//inside
[3,15,0],
[15,12,0],
//middle
[4,16,3],
[16,15,3],
//outside
[5,17,4],
[17,16,4],
//!!right!!
//inside
[2,14,7],
[14,19,7],
//middle
[7,19,8],
[19,20,8],
//outside
[8,20,9],
[20,21,9],
//!~!outside top!~!
//!!left!!
//bottom
[5,6,17],
[6,18,17],
//point
[6,11,18],
[11,23,18],
//!!right!!
//bottom
[9,21,10],
[21,22,10],
//point
[10,22,11],
[22,23,11],
//~-~!!TOP!!~-~
//base
[12,14,13],
//inside notches
[12,15,19],
[12,19,14],
//above notches
[16,20,15],
[15,20,19],
//outside notches
[16,17,18], //left
[20,22,21], //right
//above all that
[16,18,22],
[16,22,20],
//point
[18,23,22]
]
);