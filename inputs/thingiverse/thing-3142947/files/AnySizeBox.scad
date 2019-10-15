//Variables

//Width of Box
Width = 20;
//Lenght of Box
Length = 15;
//Height of Box
Height = 10;
//WallThickness of Box
WallThickness = 1;

//OuterCube
module LargeCube() {
    cube(size = [Width,Length,Height], center=true);
}

//InnerCuttout
module SmallCube() {
    cube(size = [Width-WallThickness, Length-WallThickness, Height-WallThickness], center=true);
}
//Difference
difference() {
    LargeCube(center=true);
    translate([0,0,WallThickness], center =true) SmallCube(center = true);
}
