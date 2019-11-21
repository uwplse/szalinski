drill = 6;
height = 3;
width = 30;
$fn = 60;

module logo_bi2_flat()
{
    a=[[0,0],[13,0],[13,9],[5,9],[5,10],[14,10],[14,0],[18,0],[22,6],[22,0],[48,0],[46,4],[40,4],[40,5],[46,5],[46,10],[48,14],[36,14],[36,10],[42,10],[42,9],[36,9],[36,4],[26,4],[26,14],[22,14],[18,8],[18,14],[0,14],[2,10],[2,4]];
    b=[[5,4],[10,4],[10,5],[5,5]];
    c=[[0,0],[1,1],[0,3],[-1,1]];
    difference()
    {
        polygon(a); 
        polygon(b);
    }
    translate([31,11]) for(i=[0:72:360])rotate([0,0,i]) polygon(c);
}

module keychain()
{
    difference()
    {
        union()
        {
            translate([0,0,0]) cylinder(d=(drill+3),h=height);
            translate([(drill/2),(drill/2),0])hull()
            {
                translate([0,(width/3),0]) cylinder(d=5,h=height);
                translate([width,(width/3),0]) cylinder(d=5,h=height);
                translate([0,0,0]) cylinder(d=5,h=height);
                translate([width,0,0]) cylinder(d=5,h=height);
            }
        }
        union()
        {
            translate([0,0,-0.5]) cylinder(d=drill,h=(height+1));
            translate([3,3,height*0.67]) 
                resize([(width),(width*0.33),(height/3)]) 
                    linear_extrude(height/3) 
                        logo_bi2_flat();
            translate([(width+3),3,-0.01]) 
                mirror([1,0,0]) resize([(width),(width*0.33),(height/3)]) 
                    linear_extrude(height/3) 
                        logo_bi2_flat();
        }
    }
}


keychain();
