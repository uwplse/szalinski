
/*Customizer Variables*/
diameter=43.5; //[30:0.5:50]
depth=8;//[5:0.2:15]
hole=17;//[2:0.5:30]

support=1;//[0:No,1:Yes]
supportWidth=0.41;//[0.2:0.01:1]

$fn=100;

if (support==1)
{
    render() difference()
    {
     cylinder(h=depth-1.2, r=diameter/2+5.5);
     cylinder(h=depth-1.2, r=diameter/2+5.5-supportWidth);
    }
}


render() difference()
{

difference()
{
    cylinder(h=depth, r=diameter/2+6);
    translate([0,0,1]) cylinder(h=depth, r=diameter/2-1);
}

difference()
{
    cylinder(h=depth-1, r=diameter/2+6);
    cylinder(h=depth-1, r=diameter/2);
}


cylinder(h=2, r=hole/2);
}

