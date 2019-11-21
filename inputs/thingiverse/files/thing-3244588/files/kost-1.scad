$fn=30;
width = 35;
height = 20;
body_height = 3;
name = "Kelly";
number = "123456789";
text_hei_kor = 0.01;
text_pos_kor = 0.01;



module t(t, s = 3, style = "Courier New:style=Regular") 
{
  rotate([0, 0, 0])
    linear_extrude(height = 0.5)
    text(t, size = s, font = str(style), $fn = 100);
}

module kost(body_height=2)
{
    difference()
    {
        union()
        {
            translate([-15,6,0]) cylinder(d=14,h=body_height);
            translate([-15,-6,0]) cylinder(d=14,h=body_height);
            translate([15,6,0]) cylinder(d=14,h=body_height);
            translate([15,-6,0]) cylinder(d=14,h=body_height);
            translate([-15,-9,0]) cube([30,18,body_height]);
        }
        union()
        {
            translate([0,9,0])
            {
                resize([17.4,5,body_height]) cylinder(d=1,h=1);
            }
            translate([0,-9,0])
            {
                resize([17.4,5,body_height]) cylinder(d=1,h=1);
            }
        }
    }
}

difference()
{
    union()
    {
        translate([0,0,0]) 
        {
            resize([width,height,body_height]) 
            {
                kost();
            }
        }
        translate([0,width*0.22,0]) 
        {
            cylinder(d=width*0.25,h=body_height*0.6);
        }
    }
    union()
    {
        translate([0,0,body_height*0.6]) 
        {
            resize([width-2,height-4,body_height]) 
            {
                kost();
            }
        }
        mirror([1,0,0])
        {
            translate([-width*0.3,-height*0.2,0]) 
            {
                resize([width*0.6,height*0.4,body_height/5]) 
                {
                    t(number,8,"Courier New:style=Bold");
                }
            }
        }
        translate([0,width*0.22,0]) 
        {
            cylinder(d=width*0.15,h=body_height*0.6);
        }
    }
}
translate([-width*0.35,-height*(0.15+text_pos_kor),body_height/2]) 
{
    resize([width*0.7,height*(0.4+text_hei_kor),body_height/2]) 
    {
        t(name,8,"Courier New:style=Bold");
    }
}




