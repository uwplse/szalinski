row = 8;
column = 5;
height = 2;


x = (row * 2.54) ;
y = (column * 2.54) ;


fen_x = ( x / 2.54 )  ; 
fen_y = ( y / 2.54 )  ; 


difference() {
    translate([-2,-2, 0]) {
    cube(size=[x+3.54, y+3.54, height]); }; //base cube
    
    for (i = [0:fen_x - 1]) {
      translate([i * 2.54, 0, 0])
        
      for (i = [0:fen_y - 1]) {
        translate([0, i * 2.54, -1])
          
        cube([2, 2, height+2]); //Cube - hole
      }
    }
  }
  
  
