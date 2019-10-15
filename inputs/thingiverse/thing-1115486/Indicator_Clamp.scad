


translate(v = [0, 0, 6]){
 
difference(){ 
     

 cylinder (h = 12, r=10
   , center = true, $fn=150);

 cylinder (h = 14, r=5, center = true, $fn=150);
  
translate(v = [0,4.25, 0]) {
 

    cube([2,14,14],center= true);}
} 
}



        
difference(){ 


translate(v = [0, 12, 6]) {

cube([8,10,12],center= true);
}

      
 translate(v = [0,11.5, 6]) {


    cube([2,12,15],center= true);
}


translate(v = [-3,13,6]) {
   rotate ([0,90,0]){
       
     cylinder (2.2, 3.5,3.5, center = true, $fn=6);
     }         
 }  
  
 translate(v = [0,13,6]){ 
     
    rotate ([0,90,0]){
   
   cylinder ( 8.1, 1.55,1.55, center=true, $fn=150);    
       
  } }  
}
