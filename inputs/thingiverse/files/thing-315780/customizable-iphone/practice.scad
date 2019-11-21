//default at position [0,0,0]
//left to right
Xpos = 15; //[-4:4]
// bottom to top
Zpos = 0; //[-16:4]

//default logo scaling [5]
logo_size = 5;

intersection(){
translate([5,0,0]){
color("salmon");
sphere(r=10, center=true);
}
scale([logo_size,logo_size,logo_size]){
cube(2);}
}
echo ("check");
union(){
translate([15,30,0]){
scale([5,5,5]){
color("red")
cube(2,2,2);
  }

 }
 translate([Xpos,30,Zpos]){
    cylinder(r=2, h=4);
  }
}
translate([25,0,0]){
scale([5,5,5]){
color("red")
cube(2,2,2);
  }
}

translate([25,5,15]){
color("red");
sphere(r=10, center=true);
}