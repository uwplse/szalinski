d=55;
h=10;

difference()
{
    rotate_extrude(convexity = 10, $fa=1)
    polygon(points=[[d,0],[d+h,0],[d,h]]);
    
    translate([-d-h-0.05,0,-.05])
    cube([2*d+d*h+0.1,d+h+0.1,h+0.1]);
    
};
