$fn = 30;
strip_width = 10;
strip_height = 4;

box_width = 60;// min 50!
box_height = box_width-20;
box_wall = 2;
box_screw = 2.8;
box_holder = 3.8;
box_label = "SMT BOX";


module t(t, s = 18, style = "") 
{
  rotate([90, 0, 0])
    linear_extrude(height = 1)
      text(t, size = s, font = str("Liberation Sans", style), $fn = 16);
}

module smd_strip_box_single()
{
    difference()
    {
        union()
        {
            translate([0,0,0]) cube([box_width,box_height,strip_width+box_wall]);
        }
        union()
        {
            // ohyb v krmitku
            translate([box_wall,box_wall,box_wall]) 
                difference()
                {
                    intersection()
                    {
                        translate([0,0,0]) cube([box_width/5,box_width/5,strip_width]);
                        translate([box_width/5,box_width/5,0])
                            cylinder(r=box_width/5,h=strip_width);
                    }
                    translate([box_width/5,box_width/5,0])
                        cylinder(r=((box_width/5)-(strip_height)),h=strip_width);
                }
            // odvod od krmitka
            translate([box_wall,box_wall+(box_width/5),box_wall]) 
                cube([strip_height,box_height,strip_width]);
            // otvor v krmitku
            hull()
            {
                translate([0,(box_wall)+(box_width/5),box_wall]) 
                    cube([0.2,box_height/2,strip_width]);
                translate([box_wall,(box_wall*2)+(box_width/5),box_wall]) 
                    cube([0.2,(box_height/2)-(box_wall*2),strip_width]);
            }
            // privod do krmitka
            translate([box_wall+(box_width/5),box_wall,box_wall]) 
                cube([(box_height/2),strip_height,strip_width]);
            // zasobnik pasku
            difference()
            {
                translate([box_wall+(box_width/5)+(box_height/2),box_height/2,box_wall]) 
                    cylinder(r=((box_height/2)-box_wall),h=strip_width);
                translate([box_wall+(box_width/5)+(box_height/2),box_height/2,box_wall]) 
                    cylinder(d=(box_screw*5),h=strip_width);
            }
            // montayni otvory
            translate([box_wall+(box_width/5)+(box_height/2),box_height/2,box_wall]) 
                cylinder(d=(box_screw),h=strip_width);
            translate([(box_width/5)-box_wall,(box_width/5)-box_wall,box_wall]) 
                cylinder(d=(box_screw),h=strip_width);
            translate([(box_width/5)-box_wall,box_height-(2*box_screw),box_wall]) 
                cylinder(d=(box_screw),h=strip_width);
            
            translate([box_width-(2*box_screw),box_height-(2*box_screw),box_wall]) 
                cylinder(d=(box_screw),h=strip_width);
            translate([box_width-(2*box_screw),2*box_screw,box_wall]) 
                cylinder(d=(box_screw),h=strip_width);
            
            // popisek
            translate([box_width-(box_wall*0.3),box_height*0.1,box_wall]) 
                rotate([0,0,90])
                    resize([box_height*0.8,box_wall,strip_width-(box_wall*1.2)])
                        t(box_label, s = 18, style = "");
        }
    }
}

module smd_strip_box()
{
    difference()
    {
        union()
        {
            translate([0,0,0]) cube([box_width,box_height,strip_width+box_wall]);
        }
        union()
        {
            // ohyb v krmitku
            translate([box_wall,box_wall,box_wall]) 
                difference()
                {
                    intersection()
                    {
                        translate([0,0,0]) cube([box_width/5,box_width/5,strip_width]);
                        translate([box_width/5,box_width/5,0])
                            cylinder(r=box_width/5,h=strip_width);
                    }
                    translate([box_width/5,box_width/5,0])
                        cylinder(r=((box_width/5)-(strip_height)),h=strip_width);
                }
            // odvod od krmitka
            translate([box_wall,box_wall+(box_width/5),box_wall]) 
                cube([strip_height,box_height,strip_width]);
            // otvor v krmitku
            hull()
            {
                translate([0,(box_wall)+(box_width/5),box_wall]) 
                    cube([0.2,box_height/2,strip_width]);
                translate([box_wall,(box_wall*2)+(box_width/5),box_wall]) 
                    cube([0.2,(box_height/2)-(box_wall*2),strip_width]);
            }
            // privod do krmitka
            translate([box_wall+(box_width/5),box_wall,box_wall]) 
                cube([(box_height/2),strip_height,strip_width]);
            // zasobnik pasku
            difference()
            {
                translate([box_wall+(box_width/5)+(box_height/2),box_height/2,box_wall]) 
                    cylinder(r=((box_height/2)-box_wall),h=strip_width);
                translate([box_wall+(box_width/5)+(box_height/2),box_height/2,box_wall]) 
                    cylinder(d=(box_screw*5),h=strip_width);
            }
            // montayni otvory
            translate([box_wall+(box_width/5)+(box_height/2),box_height/2,0]) 
                cylinder(d=(box_screw),h=strip_width+box_wall);
            translate([(box_width/5)-box_wall,(box_width/5)-box_wall,0]) 
                cylinder(d=(box_screw),h=strip_width+box_wall);
            translate([(box_width/5)-box_wall,box_height-(2*box_screw),0]) 
                cylinder(d=(box_screw),h=strip_width+box_wall);
            
            translate([box_width-(2*box_screw),box_height-(2*box_screw),0]) 
                cylinder(d=(box_screw),h=strip_width+box_wall);
            translate([box_width-(2*box_screw),2*box_screw,0]) 
                cylinder(d=(box_screw),h=strip_width+box_wall);
 
            // popisek
            translate([box_width-(box_wall*0.3),box_height*0.1,box_wall]) 
                rotate([0,0,90])
                    resize([box_height*0.8,box_wall,strip_width-(box_wall*1.2)])
                        t(box_label, s = 18, style = "");
        }
    }
}

module smd_strip_wall()
{
    difference()
    {
        union()
        {
            translate([0,0,0]) cube([box_width,box_height,box_wall]);
        }
        union()
        {
            translate([box_wall+(box_width/5)+(box_height/2),box_height/2,0]) 
                cylinder(d1=box_screw,d2=box_screw*3,h=box_wall);
            translate([(box_width/5)-box_wall,(box_width/5)-box_wall,0]) 
                cylinder(d1=box_screw,d2=box_screw*3,h=box_wall);
            translate([(box_width/5)-box_wall,box_height-(2*box_screw),0]) 
                cylinder(d1=box_screw,d2=box_screw*3,h=box_wall);
            translate([box_width-(2*box_screw),box_height-(2*box_screw),0]) 
                cylinder(d1=box_screw,d2=box_screw*3,h=box_wall);
            translate([box_width-(2*box_screw),2*box_screw,0]) 
                cylinder(d1=box_screw,d2=box_screw*3,h=box_wall);
        }
    }
}







translate([0,0,-(strip_width+(box_wall*3))]) smd_strip_box();
translate([0,0,0]) smd_strip_box_single();
translate([0,0,(strip_width+(box_wall*3))]) smd_strip_wall();