$fn=10;

module hook(off,d,w=30+3,h=5+3)
{
    linear_extrude(d) {
    polygon(
            points=[
                [-off   ,          0],
                [-off   +h,        h+off],
                [+off   +h+w,      h+off],
                [+off   +h*2+w,    0],
            ]
           );
        }
}

// off2 from hook
module mount(off,off2, d,w=30+3,h=5+3)
{
    linear_extrude(d) {
    polygon(
            points=[
            [-off2,             off],
            [-off-off2 +h,      h+off2-off],
            [-off+off2+h+w,     h+off2-off],
            // this isnt 100% proper but it works
            [+off-50,           -2*off+70],
            [+off-50,           +off]
            ]
           );
    }
}

// for speedup in dev you can: 1) set $fn to 10, 2) disable minkowki and set off=2*minkowski val
minkowski() {
    cylinder(r=1.8,h=16);
color("blue")
union() {
    difference() {
        hook(0.5,16);
        translate([0,-0.01,-0.01])
            scale(1.01)
            hook(0);
    }
difference() {
mount(0,0.5,16);
        translate([0,-0.01,-0.01])
            scale(1.01)
mount(0.5,0.5,16);
}
}
}
