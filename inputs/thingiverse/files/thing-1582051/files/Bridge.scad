Bridge_Width=1;
Bridge_Height=1;
Thickness=.1;
Inner_Height=Bridge_Height-Thickness*2;
Distance_1=0;
Distance_2=2.5;
Distance_3=3.5;
Distance_4=5.82;
Angle_1=-55;
Angle_2=0;
Angle_3=-0;
Angle_4=55;

union() {
intersection(){
cube(size=[Bridge_Width,6,Bridge_Height], center=false);

translate([0,Distance_1,0]) 
rotate([Angle_1, 0, 0])
cube(size=[Bridge_Width,Thickness,6]);
}
intersection(){
cube(size=[Bridge_Width,6,Bridge_Height], center=false);
translate([0,Distance_2,]) 
rotate([Angle_2, 0, 0])
cube(size=[Bridge_Width,Thickness,6]);
}
intersection(){
cube(size=[Bridge_Width,6,Bridge_Height], center=false);
translate([0,Distance_3,0]) 
rotate([Angle_3, 0, 0])
cube(size=[Bridge_Width,Thickness,6]);
}
intersection(){
cube(size=[Bridge_Width,6,Bridge_Height], center=false);
translate([0,Distance_4,0]) 
rotate([Angle_4, 0, 0])
cube(size=[Bridge_Width,Thickness,6]);
}
  difference()
  {
 polyhedron(
  points=[[0,0,0],
          [Bridge_Width,0,0],
          [Bridge_Width,6,0],
          [0,6,0], // base
          [0,1.5,Bridge_Height],
          [Bridge_Width,1.5,Bridge_Height],
          [Bridge_Width,4.5,Bridge_Height],
          [0,4.5,Bridge_Height]], // top 
  faces=[ [0,1,2,3], // bottom
          [4,5,1,0], // front
          [7,6,5,4], // top
          [5,6,2,1], // right
          [6,7,3,2], // back
          [7,4,0,3] ] // left
 );
      translate([-.5,0,Thickness]) 
          cube(size=[4,7,Inner_Height],center=false);
      
  }
  }