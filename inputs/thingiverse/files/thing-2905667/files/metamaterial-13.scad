// Meta-material Grid Generetator

// Hiroya Tanaka 
// Director, Social Fabrication Lab
// Professor, Keio University SFC
// 2018.04.22 in Den Haag (Netherland) ibis Hotel 
// 2018.05.11 in Kamakura (Japan) Home



echo(version=version());


frame_width=5;			// [0:255]

outer_frame_width=1;			// [0:255]

xy_pitch=50;         		// [0:255]

z_pitch=50;                    // [0:255]

x_rotation=0;			// [0:360]

y_rotation=0;			// [0:360]

z_rotation=0;			// [0:360]


// example:


render(convexity = 1) intersection(){
   cube(100+frame_width/2,true);
   structure();
  
}
 frame();



module structure(){
union(){
xggrid(frame_width,xy_pitch,frame_width,z_pitch,x_rotation,y_rotation,z_rotation);
yggrid(frame_width,xy_pitch,frame_width,z_pitch,x_rotation,y_rotation,z_rotation);
zggrid(frame_width,xy_pitch,frame_width,z_pitch,x_rotation,y_rotation,z_rotation);
 }
 }
 
module xggrid(xy_l,xy_p,z_l,z_p,x_r,y_r,z_r){
       
    
    for(zz=[-100:z_p:100])
    
    for(xx=[-100:xy_p:100])       
    
        //echo(xx,zz);
    rotate([x_r,y_r,z_r])
    
    translate([xx,0,zz])    
    cube([xy_l,200,xy_l],true);
      
    
    


}

module yggrid(xy_l,xy_p,z_l,z_p,x_r,y_r,z_r){
    
    for(yy=[-100:xy_p:100])
    
    for(xx=[-100:xy_p:100])       
    
        //echo(xx,zz);
    rotate([x_r,y_r,z_r])
    
    translate([xx,yy,0])    
    cube([xy_l,xy_l,200],true);
      
    
    

}

module zggrid(xy_l,xy_p,z_l,z_p,x_r,y_r,z_r){
    
    
    for(zz=[-100:z_p:100])
    
    for(yy=[-100:xy_p:100])       
    
        //echo(xx,zz);
    rotate([x_r,y_r,z_r])
    
    translate([0,yy,zz])    
    cube([200,xy_l,xy_l],true);
      
    
    
}
    
        
    

module frame(){
union(){
fxggrid(outer_frame_width,xy_pitch,frame_width,z_pitch,x_rotation,y_rotation,z_rotation);
fyggrid(outer_frame_width,xy_pitch,frame_width,z_pitch,x_rotation,y_rotation,z_rotation);
fzggrid(outer_frame_width,xy_pitch,frame_width,z_pitch,x_rotation,y_rotation,z_rotation);
 }
 }
 
module fxggrid(xy_l,xy_p,z_l,z_p,x_r,y_r,z_r){
       
    
    for(zz=[-50:100:-50]){
    
    for(xx=[-50:xy_p:50]){       
    translate([xx,0,zz])    
    cube([xy_l,100+xy_l,xy_l],true);
    }
    
    for(xx=[-50:xy_p:50]){       
    translate([0,xx,zz])    
    cube([100+xy_l, xy_l,xy_l],true);
    }
}
}  
    
    


    
   module fyggrid(xy_l,xy_p,z_l,z_p,x_r,y_r,z_r){
       
    
    for(yy=[-50:100:50]){
    
    for(xx=[-50:xy_p:50]){       
    translate([xx,yy,0])    
    cube([xy_l,xy_l,100+xy_l],true);
    }
    
    for(xx=[-50:xy_p:50]){       
    translate([0,yy,xx])    
    cube([100+xy_l, xy_l,xy_l],true);
    }
}
}       
    

   module fzggrid(xy_l,xy_p,z_l,z_p,x_r,y_r,z_r){
       
    
    for(xx=[-50:100:50]){
    
    for(yy=[-50:xy_p:50]){       
    translate([xx,0,yy])    
    cube([xy_l,100+xy_l,xy_l],true);
    }
    
    for(yy=[-50:xy_p:50]){       
    translate([xx,yy,0])    
    cube([xy_l,xy_l,100+xy_l],true);
    }
}
}    



