// Meta-material Grid Generetator

// Hiroya Tanaka 
// Director, Social Fabrication Lab
// Professor, Keio University SFC
// 2018.04.22 in Den Haag (Netherland) ibis Hotel 

// use:
// grid(xy-length,xy-pitch,z-lentgh,z-pitch,x-rotation,y-rotation,z-rotation)



echo(version=version());


xy_length=5;			// [0:255]

xy_pitch=10;         		// [0:255]

z_length=5;	// [0:255]

z_pitch=10;                    // [0:255]

x_rotation=30;			// [0:360]

y_rotation=0;			// [0:360]

z_rotation=0;			// [0:360]

frame =1; 
// example:


intersection(){
   cube([100,100,100],true);
   structure();
}


//   framedraw(frame,xy_pitch,z_pitch);

module structure(){
union(){
xggrid(xy_length,xy_pitch,z_length,z_pitch,x_rotation,y_rotation,z_rotation,frame);
yggrid(xy_length,xy_pitch,z_length,z_pitch,x_rotation,y_rotation,z_rotation,frame);
zggrid(xy_length,xy_pitch,z_length,z_pitch,x_rotation,y_rotation,z_rotation,frame);
 }
 }
 
module xggrid(xy_l,xy_p,z_l,z_p,x_r,y_r,z_r){
       
    
    for(zz=[-200:z_p:200])
    
    for(xx=[-200:xy_p:200])       
    
        //echo(xx,zz);
    rotate([x_r,y_r,z_r])
    
    translate([xx,0,zz])    
    cube([xy_l,400,xy_l],true);
      
    
    


}

module yggrid(xy_l,xy_p,z_l,z_p,x_r,y_r,z_r){
    
    for(yy=[-200:xy_p:200])
    
    for(xx=[-200:xy_p:200])       
    
        //echo(xx,zz);
    rotate([x_r,y_r,z_r])
    
    translate([xx,yy,0])    
    cube([xy_l,xy_l,400],true);
      
    
    

}

module zggrid(xy_l,xy_p,z_l,z_p,x_r,y_r,z_r){
    
    
    for(zz=[-200:z_p:200])
    
    for(yy=[-200:xy_p:200])       
    
        //echo(xx,zz);
    rotate([x_r,y_r,z_r])
    
    translate([0,yy,zz])    
    cube([400,xy_l,xy_l],true);
      
    
    
}
    
        
    

    
    
module  framedraw(f,x,z){
    for(zz=[0:z:100])
    {   
        translate([0,0,zz])
        {cube([100,f,f],false);
        cube([f,100,f],false);
        }
        
        translate([0,100,zz])
        cube([100,f,f],false);
   
         translate([100,0,zz])
        cube([f,100,f],false);
        
        }

 for(xx=[0:x:100])
    {   
        translate([xx,0,0])
        cube([f,f,100],false);
        
        translate([xx,100,0])
        cube([f,f,100],false);
    }
        
    for(yy=[0:x:100])
    {   
        translate([0,yy,0])
        cube([f,f,100],false);
        
        translate([100,yy,0])
        cube([f,f,100],false);
    }
        
        
}


