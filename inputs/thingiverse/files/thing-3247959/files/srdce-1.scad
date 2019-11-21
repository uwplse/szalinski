$fn = 30;
velikost = 25;
height = 3;
jmeno = "REX";
id = "123";
cislo = "123456789";


module srdce()
{
    union()
    {
        hull()
        {
            translate([0,0,0]) cylinder(d=(velikost/5),h=height);
            translate([velikost,-(velikost/2.5),0]) cylinder(d=(velikost),h=height);
        }
        hull()
        {
            translate([0,0,0]) cylinder(d=(velikost/5),h=height);
            translate([velikost,(velikost/2.5),0]) cylinder(d=(velikost),h=height);
        }
    }
}

module privesek()
{
    difference()
    {
        union()
        {
            hull()
            {
                translate([velikost*1.5,0,0]) cylinder(d=(velikost/3),h=height*0.6);
                translate([velikost,0,0]) cylinder(d=(velikost/3),h=height*0.6);
            }
            srdce();
        }
        union()
        {
            translate([velikost*1.5,0,0]) cylinder(d=(velikost/5),h=height*0.6);
            hull()
            {
                translate([0,0,height*0.6]) cylinder(d=((velikost/5)-2),h=height);
                translate([velikost,-(velikost/2.5),height*0.6]) cylinder(d=(velikost-2),h=height);
            }
            hull()
            {
                translate([0,0,height*0.6]) cylinder(d=((velikost/5)-2),h=height);
                translate([velikost,(velikost/2.5),height*0.6]) cylinder(d=(velikost-2),h=height);
            }
        }
    }
}

module t(t, s = 3, style = "Courier New:style=Regular") 
{
  rotate([0, 0, 0])
    linear_extrude(height = 0.5)
    text(t, size = s, font = str(style), $fn = 30);
}

module znamka()
{
    difference()
    {
        union()
        {
            privesek();
            translate([velikost*0.7,velikost*0.6,0]) 
            {
                rotate([0,0,-90])
                {
                    resize([velikost*1.2,velikost*0.4,height]) t(jmeno,8,"Courier New:style=BOLD");
                }
            } 
            translate([velikost*0.25,velikost*0.3,0]) 
            {
                rotate([0,0,-90])
                {
                    resize([velikost*0.5,velikost*0.2,height]) t(id,8,"Courier New:style=BOLD");
                }
            } 
        }
        translate([velikost*1.2,velikost*0.7,0]) 
        {
            mirror([1,0,0]) rotate([0,0,-90])
            {
                resize([velikost*1.4,velikost*0.3,height/6]) t(cislo,8,"Courier New:style=BOLD");
            }
        } 

    }
}

znamka();