k=4;    //distance between rings
d2=2;   //hole diameter
h=2;    //hole height
f1=32;  //number of faces for holes
n1=2;   //number of rings, no less than 2
n2=12;  //number of strands

example_box_l=30;   //length of example box
example_box_w=30;   //width of example box
example_box_h=10;   //height of example box
example_box_t=2;    //thickness of example box

module speaker_opening(k, d2, h, f1, n1, n2)
{
    for (j=[2:n1])
    {
        for (i=[0:(360/n2):(360-(360/n2))])
        {
        translate([(sin(i)*(j*k)),(cos(i)*(j*k)),0]) rotate([0,0,(-i)]) cylinder(r=(d2/2),h=(h+2),$fn=f1);
        }
    }
    for (i=[0:(360/(n2/2)):(360-(360/(n2/2)))])
    {
        translate([(sin(i)*(1*k)),(cos(i)*(1*k)),0]) rotate([0,0,(-i)]) cylinder(r=(d2/2),h=(h+2),$fn=f1);
    }
}

difference()
{
    translate([-(example_box_l/2),-(example_box_w/2),0])cube([(example_box_l),(example_box_w),(example_box_h)]);
    translate([-((example_box_l)-(example_box_t))/2,-((example_box_w)-(example_box_t))/2,(example_box_t)]) 
    cube([(example_box_l)-(example_box_t),(example_box_w)-(example_box_t),(example_box_h)]);
    speaker_opening(k,d2,h,f1,n1,n2);
}
