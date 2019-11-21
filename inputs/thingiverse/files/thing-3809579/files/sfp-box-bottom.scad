sfp_col=4;
sfp_row=5;
 
 
module sfp(x,y){
translate([x,y,0]) {
   color([1,0,0])
  cube([14.75,9.75,55]);
}
}

module gbics(sfp_col,sfp_row){
 for(x = [0 : 19.75 : sfp_col*19.75-0.5]){
   for(y = [0 : 14.75 : sfp_row*14.75-0.5]){
     sfp(x,y);
   }
 }
}




module box(sfp_col,sfp_row){
difference(){
cube([sfp_col*19.75+5,sfp_row*14.75+5,45]);
translate([5,5,5]){
     gbics(sfp_col,sfp_row);
 }
}
}



module shell(){
    translate([0,0,35]){
cube([sfp_col*19.75+5,2,20]);
cube([2,sfp_row*14.75+5,20]);
translate([0,sfp_row*14.75+3,0]){
cube([sfp_col*19.75+5,2,20]);
}
translate([sfp_col*19.75+3,0,0]){
cube([2,sfp_row*14.75+5,20]);
}
}
}

difference(){
box(sfp_col,sfp_row);
    shell(sfp_col,sfp_row);
 }