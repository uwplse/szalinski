function f(x,y) = sin(36*x)*cos(36*y);

for (x=[-9:0.1:+7]){
    for (y=[-9:0.1:+7]) {
        translate ([x,y,0])
        cube ([0.3,0.1,5.2+3*f(x,y)],false);
    }
}