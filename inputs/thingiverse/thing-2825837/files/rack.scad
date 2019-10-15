rotate([0,-90,0])
   basic(
      bridges= 5,
      height=20,
      deep = 50,
      walls = 0.5,
      clear=15,
      howmany = 4);


//module 
module basic(bridges= 10,
   height=20,
   deep = 50,
   walls = 0.5,
   clear=15,
   howmany = 4
   ) {   
   union() {
       for (j = [0:  howmany]) {
           translate([0, (clear+bridges) * j,0])
           bridge(deep=deep,
               width=bridges, 
               height=height, 
               walls=walls);
           if (j<howmany) {
               translate([0, bridges+ ((clear+bridges) *j),0])
               cube([deep, clear, walls]);
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

