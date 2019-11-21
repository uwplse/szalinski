rotate([0,-90,0])
   complex(
      clears=[22.3,15.3,15.3],
      bridges= 7,
      height=25,
      deep = 50,
      walls = 0.5
   );



//module 
module complex(
   bridges= 10,
   height=20,
   deep = 50,
   walls = 0.5,
   clears=[15,15,15,15]
   ) {   
   howmany = len(clears)-1;
   union() {
       for (j = [0:  howmany]) {
           // bridge position
          mv = (bridges * j) + (sumv(clears,j) - clears[j]);
          
          // Move bridge to it's position 
           translate([0,mv,0])
           bridge(deep=deep,
               width=bridges, 
               height=height, 
               walls=walls);
           
           // Move clearing after the last bridge
            translate([0,  mv + bridges ,0])
               cube([deep, clears[j], walls]);
          
          // When last need to add an extra bridge
          if (j==howmany) {
            translate([0,mv + bridges + clears[j],0])
              bridge(deep=deep,
                  width=bridges, 
                  height=height, 
                  walls=walls);
          }
       }
   }
}


module bridge(deep, width, height, walls) {
    difference(){
        cube([deep,width, height]);
        translate([-1,walls,-1])
        cube([deep+2, 
            width -(walls*2),
            height+1-walls]);
    }
}


// sumv function by https://www.thingiverse.com/MichaelAtOz/about
// https://www.thingiverse.com/thing:70745
function sumv(v,i,s=0) = (i==s ? v[i] : v[i] + sumv(v,i-1,s));