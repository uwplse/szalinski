$fn=50;

mirror([0,1,0])
union(){
difference(){
    translate([0,-2,0]) cube([63,12.5,2]);
    translate([5,1,0]) cylinder(2,2,2);
    translate([58,5,0]) cylinder(2,2,2);
    translate([58,3,0]) cylinder(2,2,2);
    translate([56,3,0]) cube([4,2,2]);
    }
points=[[0,-2,0],    //0
             [10,-1,6],  //1
             [17,0,6],  //2
             [10,-1,0],  //3
             [0,1,0],    //4
             [10,1,0],  //5
             [17,1,6],  //6
             [10,1,6]  //7
             ];
faces=[
             [0,1,2,3], //right
             [4,5,6,7],  //left
             [0,4,7,1],  //schräge oben
             [0,3,5,4],  //bottom
             [1,7,6,2],  //top
             [2,6,5,3]    //schräge unten
           ]; 
    translate([53,9.5,1]) 
        polyhedron(points,faces,convexity=10);
    translate([63,8.5,3]) cube([20,2,4]);
}
