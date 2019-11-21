$fa=0.01;
list = [ for (x = [0 : 1 : 400]) [ 200*sqrt((1-(x/100-2)*(x/100-2)/4)*(1-0.2*(x/100-2))),x ]];
points = concat(list, [[0,400]]);

difference() {
cylinder(10,15,15,true,$fn=200);
    scale([0.1,0.10,0.175])
    rotate_extrude($fn=200)
    polygon(
    points
    );
}