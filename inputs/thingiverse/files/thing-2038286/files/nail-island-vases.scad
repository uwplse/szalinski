holesize = 26;
baseheight = 20;

translate([holesize*3,0,0])
    rotate([0,180,0])
        linear_extrude(height=baseheight, center=true, scale=[2,1])
            circle(d=holesize,$fn=200);

cylinder(h=baseheight,r1=holesize,r2=holesize/2,$fn=4,center=true);
