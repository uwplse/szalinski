d_coin = 22.5; // coin diameter, 22.5 for pound, 23.8 for euro
t_coin = 3.15; // coin thickness, 3.15 for pound, 2 for euro
d_hole = 7; // hole diameter
l_tail = 27; // distance from coin center to hole center
$fn = 200; // render quality
text="UK";
font="Liberation Sans:style=Bold";
fontsize=5;

// put it all together
difference()
{
    coinToken();
    embossedText();
}

// functions
module coinToken()
{
    difference()
    {
        // coin
        cylinder(h=t_coin, d=d_coin);

        // cutout
        copyMirror() {
            translate([15, -11, -0.5]) scale([1, 0.5, 1]) cylinder(h=t_coin+1, d=30);
        }
    }

    difference()
    {
        // tail
        hull()
        {
            cylinder(h=t_coin, d=5);
            translate([0, -l_tail, 0]) cylinder(h=t_coin, d=13);
        }

        // hole
        translate([0, -l_tail, -0.5]) cylinder(h=t_coin+1, d=d_hole);
    }
}

module embossedText()
{
    translate([0,-16,t_coin/2])
        rotate([0,0,90])
            linear_extrude(height=t_coin/2+0.5)
                text(text=text, font=font, halign="center", valign="center", size=fontsize);
}

module copyMirror(vec=[1,0,0])
{
    children();
    mirror(vec) children();
}
