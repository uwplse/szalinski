/* [Parameters] */
// Size of the dice
size = 18;
// Depth of the holes
depth = 0.6;
// Corner roundness
roundness=0.75; //[0.5:0.01:1]
// Types of marks
marks = "spheres"; //[holes, spheres]

/* [Patterns] */
/* Bidimensional binary matrix with the dice face pattern.
Opposite sides of a dice add up to seven */
//Dice face one on +z axis
z_pos = [[0,0,0], [0,1,0], [0,0,0]]; 

//Dice face six on -z axis
z_neg = [[1,0,1], [1,0,1], [1,0,1]];  

//Dice face five on +y axis
y_pos = [[1,0,1], [0,1,0], [1,0,1]]; 

//Dice face two on -y axis    
y_neg = [[1,0,0], [0,0,0], [0,0,1]]; 

//Dice face three on +x axis          
x_pos = [[1,0,0], [0,1,0], [0,0,1]];

//Dice face four on -x axis       
x_neg = [[1,0,1], [0,0,0], [1,0,1]]; 
         
/* [Hidden] */
faces =[z_pos, z_neg, y_pos, y_neg, x_pos, x_neg];

rotations = [[  0,  0, 0], //face z
             [180,  0, 0], //face -z
             [-90,  0, 0], //face y
             [ 90,  0, 0], //face -y
             [  0, 90, 0], //face x
             [  0,-90, 0]];//face -x


//dice
difference(){
  //dice body
  intersection(){
    cube(size, center=true);
    sphere(roundness*size, $fn=100);
  }
  //dice faces
  for (i=[0:5])
    rotate(rotations[i])
      marks(size, depth, faces[i], marks);
}


/* Create the marks on the dice face pointing towards the z axis
    "s" is dice size
    "d" is mark depth
    "n" is a binary bidemensional matrix with de number pattern
    "m" is a mark shape (holes or spheres)*/
module marks(s, d, n, m="spheres") {
  pos=[-s/4, 0, s/4];
  for(i=[0:len(n)]) {
    for(j=[0:len(n[i])]){
      if(n[i][j]==1) {
        translate([pos[j],-1*pos[i],(s-d+0.1)/2])
          if(m=="holes") cylinder(r=0.09375*s, h=d, center=true, $fn=20);
          else sphere(r=0.09375*s, center=true, $fn=50);         
      }
    }   
  }      
}

