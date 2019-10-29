/* [Parameters] */
// Size of the dice
size = 16;
// Depth of the marks
depth = 0.6;
// Corner roundness
roundness=0.75;

/* [Hidden] */
// Binary matrix with the number pattern
one = [[0,0,0],
       [0,1,0],
       [0,0,0]]; //dice face one
    
two = [[0,0,1],
       [0,0,0],
       [1,0,0]]; //dice face two
       
three = [[0,0,1],
         [0,1,0],
         [1,0,0]]; //dice face three
         
four = [[1,0,1],
        [0,0,0],
        [1,0,1]]; //dice face four
        
five = [[1,0,1],
        [0,1,0],
        [1,0,1]]; //dice face five
        
six = [[1,0,1],
       [1,0,1],
       [1,0,1]];  //dice face six

// opposite sides of a dice add up to seven
numbers =[one, six, two, five, three, four];

rotations = [[0,  0,   0],
             [0,  0, 180],
             [0,  0,  90],
             [0,  0, -90],
             [0,-90,   0],
             [0, 90,   0]];

//dice
difference(){
  //dice body
  intersection(){
    cube(size, center=true);
    sphere(roundness*size, $fn=50);
  }
  //dice faces
  for (i=[0:5])
    rotate(rotations[i])
      marks(size, depth, numbers[i]);
}
/* Create the marks on the dice face pointing towards the x axis
    "s" is dice size
    "d" is mark depth
    "n" is a binary matrix with de number pattern */
module marks(s, d, n) {
  pos=[-s/4, 0, s/4];
  for(i=[0:len(n)]) {
    for(j=[0:len(n[i])]){
      if(n[i][j]==1)
        translate([(s-d+0.1)/2, pos[j], -1*pos[i]])
          rotate([0,90,0])
            cylinder(r=0.09375*s, h=d, center=true, $fn=20);    
    }   
  }      
}