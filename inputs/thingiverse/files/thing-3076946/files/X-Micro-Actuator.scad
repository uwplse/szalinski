difference () {
    translate ([0,-2.8,0]) {
   cube([28,5.6,8]); //main body
    }
       translate ([2.0,-0.9,-1]) {
           cube([36,1.8,8]); //internal hollow
       }
       translate ([12,-4,2.4])  {
           cube([8,8,3.0]); // screw slot
       }

}
