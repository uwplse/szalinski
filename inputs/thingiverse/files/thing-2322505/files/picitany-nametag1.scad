length = 150; // how long the tag is
text_H = 18; // How tall is the text
name = "Your_Name"; // Your Name here!
style = "recessed"; // [recessed:recessed text,not:not recessed text]
profile=[[0,1],[0,12],[27,12],[27,1],[22.5,1],[22.5,2],[25,5],[22.5,8.3],[5,8.3],[2.5,5],[5,2],[5,1]];

make_it();
module make_it()
{
    if (style == "recessed")
    {
        recessed();
    }else if (style == "not")
    {
        not();
    }else
    {
        recessed();
    }
}
    

module not()
{
    union()
    {
        rotate([270,270,0]) translate([0,13.5,11]) linear_extrude(height = 3) text(name, valign="center", size = text_H);
        difference()//main shape
        {
            linear_extrude(height = length) polygon(profile);
            translate([0, 6,length/2]) 
            rotate([0,90,0])  cylinder(h = 30, r1 = 4.9/2, r2 = 4.9/2);    
        }
    }
}

module recessed()
{
     union()
    {//words
        rotate([270,270,0]) translate([3,13.5,11]) linear_extrude(height = 3) text(name, valign="center", size = text_H);
        union()
        {
            difference()//border for words
            {
                 translate([0,10,0]) cube([27,4,length]);
            translate([3,11,3]) cube([27-6,3,length-6]);
           
            }
            difference()//main shape
            {
              linear_extrude(height = length) polygon(profile);
              translate([0, 6,length/2]) 
              rotate([0,90,0])  cylinder(h = 30, r1 = 4.9/2, r2 = 4.9/2);    
            }
        }

    }
}