//Customizable game of Mancala

//length of board
l1=400;
//width of board
w1=150;
//height of board
h1=20;

module base(){
minkowski(){
cube([l1,w1,h1]);
    cylinder(r=w1*.2,h=h1);
}
}


 module holes(){

    for(j=[1:6])
    {
        union(){
  translate([j*l1/8+l1/16,w1*1.2-w1*1.4/4,h1*2])sphere(w1*.15,$fn=30);
  translate([j*l1/8+l1/16,w1*1.4/8,h1*2])sphere(w1*.15,$fn=30);
        }
}
} 



module holeA(){
    union(){
        translate([0,0,h1/2])cube([l1/8,w1,h1*2]);
        translate([l1*7/8,0,h1/2])cube([l1/8,w1,h1*2]);
    }
   }
   
   
difference(){
    base();
    holeA();
    holes();
}
 
  
   
   
   