// Part
part = "preview"; // [quarter_barrell, barrell, top_left, top_right, preview] 

// Diameter
D = 218.31309;

// Thickness of the shell
th = 2;

/* [Hidden] */

cut_latitude = 45;
R = D / 2;

seam = 3;
m = 0.3; // margin
l = cut_latitude;

x = [1, 0, 0];
y = [0, 1, 0];
z = [0, 0, 1];

if (part == "quarter_barrell")
    quarter_barrell();
else if (part == "barrell")
    barrell();
else if (part == "top_left")
    rotate(90*y) top_left();
else if (part == "top_right")
    rotate(-90*y) top_right();
else if (part == "preview")
    preview();


module mirrored(dir) { mirror(dir) children(); children(); }

module shell(r=R, th=th)
{
    difference()
    {
        sphere(r = r);
        sphere(r = r-th);
    }
}

module cone()
{
    e = 1;
    h = R+e;
    mirror(z) translate(-h*z) cylinder(h=h, d2=0, r1=tan(90-l)*h);
}


module barrell()
{
    e = 0.1;
    difference()
    {
        shell();
        mirrored(z) cone();
    }
    difference()
    {
        union()
        {
            mirrored(z)
            intersection()
            {
                difference()
                {
                    shell(r=R-th+e, th=th+e);
                    cone();
                }
                translate((R*sin(l)-th*sin(l)-seam)*z) cylinder(d=D, h=seam);
            }
            mirrored(z)
            intersection()
            {
                shell(r=R-th-m, th=th-m);
                translate((R*sin(l)-th*sin(l)-seam)*z) cylinder(d=D, h=seam+th*sin(l));
            }
        }
        translate([-seam-m, -R-e, -R-e]) cube([seam*2, D, D] + 2*[m, e, e]);
        rotate(90*z) translate([-seam-m, -R-e, -R-e]) cube([seam*2, D, D] + 2*[m, e, e]);
    }
}

module quarter_barrell()
{
    e = 0.1;
    difference()
    {
        intersection()
        {
            rotate(45*z) barrell();
            translate(-(R+e)*z) cube([R, R, D] + [e, e, e]*2);
        }
        intersection()
        {
            sphere(r=R-th);
            translate([0, -e, -R]) cube([R, seam+m, D]);
        }
    }
    intersection()
    {
        difference()
        {
            shell(r=R-th+e, th=th+e);
            mirror(x) translate(-(R+e)*z) cube([R, R, D] + [e, e, e]*2);
        }
        translate([-seam, 0, -R*sin(l)+(th+m)*sin(l)]) cube([seam*2, D+e, D*sin(l)-2*(th+m)*sin(l)]);
    }
    intersection()
    {
        difference()
        {
            shell(r=R-th-m, th=th-m);
            translate(-(R+e)*z) cube([R, R, D] + [e, e, e]*2);
        }
        translate([-seam, 0, -R*sin(l)]) cube([seam*2, D+e, D*sin(l)]);
    }
}


module top()
{
    e = 1;
    h = R+e;
    intersection()
    {
        shell();
        mirror(z) translate(-h*z) cylinder(h=h, d2=0, r1=tan(90-l)*h);
    }
}

module top_left()
{
    e = 1;
    difference()
    {
        intersection()
        {
            union()
            {
                difference()
                {
                    sphere(r=R);
                    translate([0, -R-e, -R-e]) cube([R, D, D] + [e, 2*e, 2*e]);
                }
                rotate(-90*y) rotate_extrude() translate((R-th)*x) rotate(-45*z) square([10, 10]);
            }
            sphere(r=R);
            cone();
        }
        sphere(r=R-th);
    }
}

module top_right()
{
    e = 0.1;
    difference()
    {
        union()
        {
            difference()
            {
                top();
                mirror(x) translate((-R*cos(l)-e)*y) cube([R*cos(l)+e, D*cos(l)+2*e, R]);
            }
            intersection()
            {
                shell(r=R-th+e, th=th+e);
                translate([0, -R*cos(l), R*sin(l)-th*sin(l)]) cube([seam, D*cos(l), R-R*sin(l)+th*sin(l)]);
                cone();
            }
            intersection()
            {
                shell(r=R-th-m, th=th-m);
                mirror(x) translate([0, -R*cos(l), R*sin(l)-th*sin(l)]) cube([seam, D*cos(l), R-R*sin(l)+th*sin(l)]);
                cone();
            }
        }
        rotate(-90*y) rotate_extrude() translate((R-th-m)*x) rotate(-45*z) square([10, 10]);
    }
}

module preview()
{
    for(i=[0, 1, 2, 3])
        rotate(90*i*z) translate(30*x) rotate(-45*z) quarter_barrell();
    mirrored(z)
    {
        translate([-20, 0, 25]) top_left();
        translate([20, 0, 25]) top_right();
    }
}
