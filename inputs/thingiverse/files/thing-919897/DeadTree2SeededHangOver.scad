////////////////////
//Dead Tree generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west, tilt:top diagonal]

//RandomSeed
seed=17894759;//[1111:9999]
//Trunk
thick=2;// [1:0.1:4]
//Distal/proximal wigliness dominance
p1=0.25;//[0:0.01:1]
//Branch inheritance factor
p2=0.25;//[0:0.01:1]
//Distal/proximal branching dominance
p3=0.1;//[0:0.01:1]
// z scaler use for overhang control
up=1;//[0:0.1:5]
// x y scale use for overhang control
xyscaler=4.5;//[1:0.1:8]
//Radial Grouping factor
radial=0.2;//[-3:0.1:3]
// ...leave as is
part=0;//[0,1,2]
mycolor=[0.3,0.15,0.09];
module grow(i,j,b,nx,ny,accx,accy)
{ union(){
    ij=i*p1+j*(1-p1);
    sc=xyscaler;
    x=rands(-ij*sc,ij*sc,1)[0]*p2+nx*(1-p2) +(accx/50)*radial;
     y=rands(-ij*sc,ij*sc,1)[0]*p2 +ny*(1-p2)+(accy/50)*radial;
    goon=rands(0,5,1)[0];
    //t=max(rands(1.5,2.3,1)[0]*sc,abs(x),abs(y));
    t=9+up;
    
        
            color(mycolor)
            hull(){
                 rotate([0,0,60])   sphere(d=thick*i,$fn=12);
translate([x,y,t])sphere(d=thick*(i-1),$fn=12);
//translate([x*0.4,y*0.4,t*0.1])sphere(d=1.4*(i-1),$fn=12);

                }
        
        
    if(i>1 ){
    
    if(j/25+(20-i)/20*p3+(i)/50*(1-p3)+rands(0,0.60*p3+0.70*(1-p3),1)[0]>=0.99){
     translate([x,y,t])grow(i-1,1,b+1,x,y,accx+x,accy+y);
     translate([x,y,t])grow(i-2-rands(0,2,1)[0],1,b+1,-nx*0.5,-ny*0.5,accx+x,accy+y);    
    }else
    {translate([x,y,t])grow(i-1,j+1,b,x,y,accx+x,accy+y);}
        }
        
    
    }
}


module root(i,j,b)
{ union(){
    r=rands(-25,25,1)[0];
     rv=rands(-0.15,0,1)[0];
    t=max(10,25/i);
    

            color(mycolor)
            hull(){sphere(d=1.5+thick*0.9*i,$fn=12,$fs=10);rotate([rv,r,0]) translate([0,0,t])sphere(d=1.5+thick*0.9*(i-1.5),$fn=12);
                rotate([0,0,rands(-90,90,1)[0]]) translate([0,-(i-1)*0.2*thick,-0.1+t*rands(0,1,1)[0]])rotate([-30,30,0])sphere(d=0.5+1.5+thick*0.4*(i-1.5),$fn=12);
             
                }
        
        
    if(i>=1 ){
    
    if(j/2+rands(0,1)[0]>=1){
   rotate([rv,r+45,0]) translate([0,0,t])root(i-1.5,0,b+1);
    rotate([rv,r-20,0]) translate([0,0,t])root(i-2,1,b+1);   
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
 translate([0,0,13+thick])  grow(20,0,0,0,0,0,0);
  }

translate([0,0,-0.001])color("DimGray")cylinder(r=100.001,h=5.001);
translate([0,0,5])color("DimGray")cylinder(r=100.001,r2=95,h=5);
  
   intersection(){ 
       
       color("tan")   cylinder(r=94,h=100);

       translate([0,0,16])union(){  
           for(i=[0:8]){
           color("DarkGray") rotate([0,0,i*40+rands(-0,36,10)[part]]) translate([25+thick+rands(0,20,1)[0],0,-8])resize([40,50,15]) stone();  }
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