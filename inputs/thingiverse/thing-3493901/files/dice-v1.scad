/* [Parameters] */
// Size of the die
size = 16;
// Depth of the marks
depth = 0.6;
// Corner roundness
roundness=0.75;

/* [Hidden] */
//Binary matrix with the die number pattern 
one=[[0,0,0],
     [0,1,0],
     [0,0,0]];
two=[[0,0,1],
     [0,0,0],
     [1,0,0]];
three=[[0,0,1],
       [0,1,0],
       [1,0,0]];
four=[[1,0,1],
      [0,0,0],
      [1,0,1]];
five=[[1,0,1],
      [0,1,0],
      [1,0,1]];
six=[[1,0,1],
     [1,0,1],
     [1,0,1]];

//Die
difference(){
  
  //Body die
  intersection(){
    cube(size, center=true);
    sphere(roundness*size, $fn=100);
  }
  
  //face 1
  face(size, depth, one);
  
  //face 6
  rotate([0,0,180])
    face(size, depth, six);
    
  //face 2
  rotate([0,0,90])
    face(size, depth, two);
    
  //face 5
  rotate([0,0,-90])
    face(size, depth, five);
    
  //face 3
  rotate([0,-90,0])
    face(size, depth, three);
    
  //face 4
  rotate([0,90,0])
    face(size, depth, four);
}
/* Create the marks on the die face pointing towards the x axis
    "s" is die size
    "d" is mark depth
    "n" is a binary matrix with de number pattern */
module face(s, d, n) {
  pos=[-s/4, 0, s/4];
  for(i=[0:len(n)]) {
    for(j=[0:len(n[i])]){
      if(n[i][j]==1) {
        translate([(s-d+0.1)/2, pos[j], -1*pos[i]])
          rotate([0,90,0])
            cylinder(r=0.09375*s, h=d, center=true, $fn=20);    
      }
    }   
  }      
}