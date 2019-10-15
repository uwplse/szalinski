  //Dimension 
  
  length = 224;
  
  width = 162;
  
  depth = 30;
  
  frame = 10 //[5:50]
  ;
  
  picture = 3;
  
  deepening = 3
  // You can adjust the depth of your picture (0 = mid)
  ;
  picture_height= 0 //[-30:+30]
  ;
  
  // Add a hanger to mount the frame on a wall
  hanger = "no"; // [yes,no]
  ;
  
  
  difference(){
  
//create outer frame 
  cube([length, width, depth], true);
      
//difference inner frame
  cube([length-2*frame, width-2*frame, depth], true);

//difference picture
 translate([-(frame-2*deepening),0,depth*picture_height/100]) 
  cube([length-(frame-deepening*2), width-2*frame+2*deepening, picture], true);
} 


if (hanger=="yes"){

difference () {   

translate([-length/2+frame+4,0,-depth/2+1])
cylinder(  2, d=14, center=true);

translate([-length/2+frame+4,0,-depth/2+1])
cylinder(  2, d=7, center=true);
}    
}
      
       


         
  