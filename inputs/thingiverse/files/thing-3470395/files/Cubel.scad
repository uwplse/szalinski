side=30; //ребро куба//side size
global_one=side;//глобально//global,dont tuch,please

d_hull=global_one/2.5; //радиус фасок//chamfer rounding
fn_hull=10; //гладкость фасок//chamfer smoothness
dotd=global_one/2.5; //диаметр точек//diameter of points
dots_fn=10; //гладкость точек//smooth points


xx=0.85*global_one;
yy=0.65*xx;

module cubel (){
    hull(){
for (x=[0:1:1]){
    for (y=[0:1:1]){
        for (z=[0:1:1]){
translate ([pow(-1,x)*(side-d_hull/2), pow(-1,y)*(side-d_hull/2),pow(-1,z)*(side-d_hull/2)])
sphere (d=d_hull,$fn=fn_hull);
            
                        }
                    }
                }
} 
}


module six(xx,yy) {
    translate ([-xx/2,-yy])
    for (a=[0:1:1]){
    for (b=[0:1:2]){
        translate ([a*xx,b*yy,0])
        sphere (d=dotd,$fn=dots_fn,center=true);
        }
    }
}

module four(xx) {
    
    translate ([-xx/2,-xx/2,0])
    for (a=[0:1:1]){
    for (b=[0:1:1]){
        translate ([a*xx,b*xx,0])
        sphere (d=dotd,$fn=dots_fn,center=true);
    }}
    }
module five(xx) {
     translate ([-xx/2,-xx/2,0])
    for (a=[0:1:1]){
    for (b=[0:1:1]){
        translate ([a*xx,b*xx,0])
        sphere (d=dotd,$fn=dots_fn,center=true);
    }
    }
    
    sphere (d=dotd,$fn=dots_fn,center=true);
    }
module two (xx){
    union () {
translate ([xx/2,xx/2,0])
    sphere (d=dotd,$fn=dots_fn,center=true);
    
translate ([-xx/2,-xx/2,0])
    sphere (d=dotd,$fn=dots_fn,center=true);
    }
    
}


module one() {
sphere (d=dotd,$fn=dots_fn,center=true);
}
module three (xx) {
    
    union () {
        
        sphere (d=dotd,$fn=dots_fn,center=true);
        
translate ([xx/2,xx/2,0])
    sphere (d=dotd,$fn=10,center=true);
    
translate ([-xx/2,-xx/2,0])
    sphere (d=dotd,$fn=dots_fn,center=true);
    }
}



difference(){

cubel ();
    
translate ([0,0,-side])
one();

translate ([0,0,side]) 
six(xx,yy);

translate ([-side,0,0])
rotate ([0,90,0])
five(xx);
    
translate ([side,0,0])
rotate ([0,90,0])
two(xx);

translate ([0,side,0])
rotate ([90,0,0])
four(xx);

translate ([0,-side,0])
rotate ([90,0,0])
three(xx);
  }  
//one();   
//two(10);   
//three(xx=10);
//four(xx=10);
//five(xx=10);    
//six(xx=10,yy=5);
