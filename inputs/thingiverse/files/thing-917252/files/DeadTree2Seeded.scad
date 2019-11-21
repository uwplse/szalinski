////////////////////
//Dead Tree generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west, tilt:top diagonal]

//RandomSeed
seed=17894759;//[1111:9999]
part=0;//[0,1]
mycolor=[0.3,0.15,0.09];
module grow(i,j,b)
{ union(){
    r=rands(-5,15+j,1)[0];
     rv=rands(-j*2,j*2,1)[0];
    goon=rands(0.8,2,1)[0];
    t=min(max(15,75/i),i*9);
    
    if(goon<1&&b>1&&j>2){ 
        difference(){
        color(mycolor)hull(){
            sphere(d=2*i,h=0.1,$fn=12);
rotate([r,rv,i]) translate([0,0,t])rotate([15,0,0])cylinder(d=2*(i-1),h=0.1,$fn=12);}
        
      color("tan")  
rotate([r,rv,i]) translate([0,0,t])rotate([15,0,0])cylinder(d=1.7*(i-1),h=5,$fn=12);}}
        
        else{
            color(mycolor)
            hull(){if(i==20)
                {translate([0,0,-10]){
                    sphere(d=2*i,$fn=12);
rotate([0,0,rands(-360,360,1)[0]]) translate([0,(i-1)*1.5,-10])sphere(d=0.5*(i-1),$fn=8);
rotate([0,0,rands(-360,360,1)[0]]) translate([0,(i-1)*1.5,-10])sphere(d=0.5*(i-1),$fn=8);                
rotate([0,0,rands(-360,360,1)[0]]) translate([0,(i-1)*1.5,-10])sphere(d=0.5*(i-1),$fn=8);
                    
                    }
                    }
                else
                {sphere(d=2*i,$fn=12);}
rotate([r,rv,i]) translate([0,0,t])sphere(d=2*(i-1),$fn=12);
if(i>3){rotate([0,0,rands(-360,360,1)[0]]) translate([0,(i-1)*0.6,t*0.6])rotate([-30,30,0])sphere(d=1.1*(i-1),$fn=12);}

                }
        
        
    if(i>1 ){
    
    if(j/15+rands(0,1,1)[0]>=1){
    rotate([r,30+rv,i-180]) translate([0,0,0])grow(i-1,0,b+1);
    rotate([r,rv,i]) translate([0,0,t])grow(i-1,0,b+1);    
    }else
    {rotate([r,rv,i]) translate([0,0,t])grow(i-1,j+1,b);}
        }
        }
    
    }
}


module root(i,j,b)
{ union(){
    r=rands(-25,25,1)[0];
     rv=rands(-0.15,0,1)[0];
    t=max(10,25/i);
    

            color(mycolor)
            hull(){sphere(d=2*i,$fn=12,$fs=10);rotate([rv,r,0]) translate([0,0,t])sphere(d=2*(i-1.5),$fn=12);
                rotate([0,0,rands(-90,90,1)[0]]) translate([0,-(i-1)*0.7,-0.1+t*rands(0,1,1)[0]])rotate([-30,30,0])sphere(d=1*(i-1.5),$fn=12);
             
                }
        
        
    if(i>=1 ){
    
    if(j/2+rands(0,1)[0]>=1){
   rotate([rv,r+45,0]) translate([0,0,t])root(i-1.5,0,b+1);
    rotate([rv,r-20,0]) translate([0,0,t])root(i-1.5,0,b+1);   
    }else
    {rotate([rv,r,0]) translate([0,0,t])root(i-1.5,j+1,b);}
        }
            
    }
}
//module root(i){color(mycolor) union(){r=rands(-15,15,1)[0];rv=rands(-0.11,1,1)[0];t=max(10,25/i);hull(){sphere(d=2*i,h=0.1,$fn=12);rotate([rv,r,0]) translate([0,0,t])sphere(d=2*(i-1),h=0.1,$fn=12);}if(i>=1){rotate([rv,r,0]) translate([0,0,t])root(i-1);if(rands(0,1.08,1)[0]>=1){rotate([rv,r+45,0]) translate([0,0,t])root(i-2);}}}}
module stone(){ color("DarkGray")
    intersection(){
        rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])resize([rands(5, 10, 1)[0],1.4,1.4])
    //import("rock.stl", convexity=3);
    rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])cube(1.5,center=true ); 
 
    rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])resize([rands(5, 10, 1)[0],1.5,1.5])
    //import("rock.stl", convexity=3);
    rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])cube(1.5,center=true ); 
         rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])resize([rands(5, 10, 1)[0],1.4,1.4])
    //import("rock.stl", convexity=3);
    rotate([rands(0, 90, 1)[0],rands(0, 90, 1)[0],rands(0, 90, 1)[0]])cube(1.5,center=true ); 
    }}

*cube([1,1,28]);
scale(0.3)union(){
    
   
  intersection(){ 
   
     color("tan")   cylinder(r=200,h=300);
 translate([0,0,8])  grow(20,0,0);
  }

translate([0,0,-0.001])color("DimGray")cylinder(r=100.001,h=5.001);
translate([0,0,5])color("DimGray")cylinder(r=100.001,r2=95,h=5);
  
   intersection(){ 
       
       color("tan")   cylinder(r=94,h=100);

       translate([0,0,16])union(){  
           for(i=[0:8]){
           color("DarkGray") rotate([0,0,i*40+rands(-0,36,10)[part]]) translate([30+rands(0,20,1)[0],0,-8])resize([40,50,15]) stone();  }
translate([0,0,10])
rotate([60,180,20+rands(-16,16,10)[part]])root(16,0,0);           
rotate([80,181,60+rands(-15,15,10)[0]])root(19,0,0);
           
//rotate([60,180,60])grow(10);
rotate([75,182,200+rands(-15,15,1)[0]])root(20,0,0);
rotate([80,182,180+rands(-15,15,1)[0]])root(12,0,0);
           rotate([80,184,320+rands(-15,15,1)[0]])root(15,0,0);
//rotate([60,180,300])grow(10);
}}
 }