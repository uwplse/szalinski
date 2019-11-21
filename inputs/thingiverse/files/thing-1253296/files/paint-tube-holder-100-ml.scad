segments = 3;



module t15t() {
    
      xt = 30;
      yt = 30;
      zt = 14; //20
      st = 2.4;
      dt = 15;
    
    
    translate([0,0,-zt]){
    difference(){
        
        cube([ xt,yt,zt]);
        
        translate([st,-0.1,st])
        cube([ xt- st*2, yt - st, zt - st*2]);
        
        translate([xt/2,yt-dt/2-st*3,-0.1])
        cylinder(d = dt, h = 2*st, $fn =20);
        
         translate([xt/2,yt-dt/2-st*3,-0.1])
        cylinder(d = 3.3, h = zt+2*st, $fn =50);     
        
       
        
        translate([xt/2,yt-dt/2-st*3,zt-st-0.1])
        cylinder(d2 = 3.2, d1 = 6, h = st, $fn =50);   
        
        
      translate([xt/2,st,zt/2])
          rotate([-90,0,0])      
        cylinder(d = 3.3, h = yt, $fn =50);     
          translate([xt/2,yt-st-0.2,zt/2])
          rotate([-90,0,0])
        cylinder(d2 = 3.2, d1 = 6, h = st, $fn =50);   
         
        
        
        
        translate([xt/2-dt/2,-0.1,-0.1])
        cube([dt,yt-dt/2-st*3,2*st]);
        
        
    }   
    
}}




module t17t() {
    
      xt = 37;
      yt = 37;
      zt = 24; //27
      st = 2.4;
      dt = 17;
    translate([0,0,-zt]){
    difference(){
        
        cube([ xt,yt,zt]);
        
        translate([st,-0.1,st])
        cube([ xt- st*2, yt - st, zt - st*2]);
        
        translate([xt/2,yt-dt/2-st*3,-0.1])
        cylinder(d = dt, h = 2*st, $fn =50);
        
         translate([xt/2,yt-dt/2-st*3,-0.1])
        cylinder(d = 3.3, h = zt+2*st, $fn =50);     
        
        translate([xt/2,yt-dt/2-st*3,zt-st-0.1])
        cylinder(d2 = 3.2, d1 = 6, h = st, $fn =50);   
        
        translate([xt/2-dt/2,-0.1,-0.1])
        cube([dt,yt-dt/2-st*3,2*st]);
            
        translate([xt/2,st,zt/2])
          rotate([-90,0,0])      
        cylinder(d = 3.3, h = yt, $fn =50);     
          translate([xt/2,yt-st-0.2,zt/2])
          rotate([-90,0,0])
        cylinder(d2 = 3.2, d1 = 6, h = st, $fn =50);   
         
         
        
    }   
    
}}











module t30t() {
    
      xt = 55; //55!
      yt = 50;
      zt = 25; //20
      st = 2.4;
      dt = 36.5;
    translate([0,0,-zt]){
    difference(){
        
        cube([ xt,yt,zt]);
        
        translate([st,-0.1,st])
        cube([ xt- st*2, yt - st, zt - st*2]);
        
        translate([xt/2,yt-dt/2-st*3,-0.1])
        cylinder(d = dt, h = 2*st, $fn =50);
        
         translate([xt/2,yt-dt/2-st*3,-0.1])
        cylinder(d = 3.3, h = zt+2*st, $fn =50);     
        
        translate([xt/2,yt-dt/2-st*3,zt-st-0.1])
        cylinder(d2 = 3.2, d1 = 6, h = st, $fn =50);   
        
        translate([xt/2-dt/2,-0.1,-0.1])
        cube([dt,yt-dt/2-st*3,2*st]);
        
        translate([xt/2,st,zt/2])
        rotate([-90,0,0])      
        cylinder(d = 3.3, h = yt, $fn =50);     
        translate([xt/2,yt-st-0.2,zt/2])
        rotate([-90,0,0])
        cylinder(d2 = 3.2, d1 = 6, h = st, $fn =50);   
         
        
        translate([-0.1,yt+st/3,-st*0.7])
        rotate([45,0,0])
        cube([xt+0.2,st,st]);
          
        translate([-0.1,yt+st/3,zt-st*0.7])
        rotate([45,0,0])
        cube([xt+0.2,st,st]);      
        
        
        translate([0,yt-st/3,-0.1])
        rotate([0,0,45])
        cube([st,st,zt+0.2]);  
        
        translate([xt,yt-st/3,-0.1])
        rotate([0,0,45])
        cube([st,st,zt+0.2]);   
    }   
    
}}


















//for ( i = [0:30-2.4:(segments - 1) * (30-2.4)]){
//    
//    translate([i,0,0])
//    rotate([-90,00,0])
//     t15t();
//
//}
////
////
//for ( i = [0:37-2.4:(segments - 1) *(37-2.4)]){
//    
//    translate([i,40,0])
//rotate([-90,00,0])
//t17t();
//
//}
//
//
//
for ( i = [0:55-2.4:(segments - 1) * (55-2.4)]){
    
    translate([i,90,0])
 rotate([-90,00,0])
t30t();

}