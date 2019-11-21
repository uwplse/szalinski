
aa = 50; // size of cube
bb = 35; // height of box
ss = 0.4; // wall thickness
gap =0.6; // gap betwin box and cover
dir = 2.5; // slit thickness

difference(){

    
    cube([aa,aa,bb]);
    
    translate([ss,ss,ss])
    cube([aa-ss*2,aa-ss*2,bb]);
    

  for (i=[10:10:aa-5]){
//      
      translate([i-dir/2,-5,5])    
      cube([dir,aa+10,bb-10]);
      
      translate([-5,i-dir/2,5])    
      cube([aa+10,dir,bb-10]);
 
      }  
 
}

for (i =[5:10:aa]) {
    
translate([i,0,0])
cube([ss,5+ss,bb-2]);
    
translate([i,aa-5,0])
cube([ss,5,bb-2]);  
    
translate([i,0,0])
cube([ss,aa,5]);
    
translate([0,i,0])
cube([aa,ss,5]);   
    
translate([0,i,0])
cube([5,ss,bb-2]);    

translate([aa-5,i,0])
cube([5,ss,bb-2]);    
    
        
    
}


translate([aa+10,0,0]){
    difference(){
cube([aa+ss*2+gap*2,aa+ss*2+gap*2,5]);


translate([ss,ss,ss])   
cube([aa+gap*2,aa+gap*2,5]);
}

}




