function f(x,y) = sin(36*sqrt((x*x)+(y*y)));

for (x=[-10:0.1:+10]){
    for (y=[-10:0.1:10]) {
        translate ([x,y,0])
        cube ([0.3,0.1,5.2+3*f(x,y)],false);
    }
}