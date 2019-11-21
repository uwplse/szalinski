
linear_extrude(10){
difference(){
Hex(7.4);
Hex(4.8);
}
}
module Hex(size){
 circle(size/2,$fn=6);
} 