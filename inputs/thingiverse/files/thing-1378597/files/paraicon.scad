/*parameters in the equations

    x = cos(a*t) - pow(cos(b*t),j)
    y = sin(c*t) - pow(sin(d*t),k)

*/

a=1;
b=3;
c=3;
d=2;
j=5;
k=6;
cycles=1;

// scaling
scale_x=15;
scale_y=15;
height=10;
thickness=2;


function hadamard(a,b) =
       len(a)==len(b)
           ?  [for (i=[0:len(a)-1]) a[i]*b[i]] 
           :  [];

module line(p1,p2,thickness=0.5) {
    linear_extrude(p1.z)
      hull() {
        translate(p1) circle(d=thickness);
        translate(p2) circle(d=thickness);
     }
}    

module graph(fn,min,max,step,scale=[1,1,1],thickness=0.5) {
   linear_extrude(scale.z)
   for(t = [min:step:max-step]) {
      hull() {
          translate(hadamard(f(fn,t),scale)) circle(d=thickness);
          translate(hadamard(f(fn,t+step),scale)) circle(d=thickness);
      }
  }
}


// see https://en.wikipedia.org/wiki/Parametric_equation  



function f(fn,t) =
   fn==1 ?  [cos(a*t) - pow(cos(b*t),j),
             sin(c*t) - pow(sin(d*t),k),
             0]
   : 0 ;

graph(1,0,cycles*360,1,scale=[scale_x,scale_y,height],thickness=thickness);     