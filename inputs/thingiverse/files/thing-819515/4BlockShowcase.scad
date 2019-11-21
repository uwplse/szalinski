//4 Block Showcase

//Cube 1 Width
Cube1Width = 50;

//Cube 1 Length
Cube1Length = 50;

//Cube 1 Height
Cube1Height = 50;


//Cube 2 Width
Cube2Width = 40;

//Cube 2 Length
Cube2Length = 40;

//Cube 2 Height
Cube2Height = 40;


//Cube 3 Width
Cube3Width = 30;

//Cube 3 Length
Cube3Length = 30;

//Cube 3 Height
Cube3Height = 30;


//Cube 4 Width
Cube4Width = 20;

//Cube 4 Length
Cube4Length = 20;

//Cube 4 Height
Cube4Height = 20;


//Bottom Thickness
BottomThickness = 5;

//Length Of Wall
LengthOfWall = 3;

//4 Cubes
translate([0,0,BottomThickness]){
    //Cube 1
    color("red")
    cube([Cube1Width,Cube1Length,Cube1Height]);

    //Cube 2
    color("orange")
    translate([0,Cube1Length,0]){
        cube([Cube2Width,Cube2Length,Cube2Height]);
    }

    //Cube 3
    color("yellow")
    translate([Cube1Width,0,0]){
        cube([Cube3Width,Cube3Length,Cube3Height]);
    }
    
    //Cube 4
    color("green")
    translate([Cube2Width,(Cube1Length+Cube2Length)-Cube4Length,0]){
        cube([Cube4Width,Cube4Length,Cube4Height]);
    }
    
    //Wall 1
    color("blue")
    translate([Cube1Width,0,Cube3Height]){
        cube([Cube3Width,LengthOfWall,Cube1Height-Cube3Height]);
    }
    
    //Wall 2
    color("purple")
    translate([Cube2Width,(Cube1Length+Cube2Length)-LengthOfWall,Cube4Height]){
        cube([Cube4Width,LengthOfWall,Cube2Height-Cube4Height]);
    }
    
    //Wall 3
    color("pink")
    translate([0,Cube1Length,Cube2Height]){
        cube([LengthOfWall,Cube2Length,Cube1Height-Cube2Height]);
    }
    
    //Wall 4
    color("gold")
    translate([LengthOfWall,(Cube1Length+Cube2Length)-LengthOfWall,Cube2Height]){
        cube([(Cube1Width+Cube3Width)-LengthOfWall,LengthOfWall,Cube1Height-Cube2Height]);
    }
    
    //Wall 5
    color("saddlebrown")
    translate([Cube2Width+Cube4Width,(Cube1Length+Cube2Length)-LengthOfWall,0]){
        cube([(Cube1Width+Cube3Width)-(Cube2Width+Cube4Width),LengthOfWall,Cube2Height]);
    }
}

//Base
    color("grey")
    cube([Cube1Width+Cube3Width,Cube1Length+Cube2Length,BottomThickness]);
