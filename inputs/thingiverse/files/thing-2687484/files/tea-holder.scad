ballRadius = 40;
$fn=ballRadius*10;
difference() {
    cylinder(h=ballRadius+5,r=ballRadius+5, c=true);
    
        translate([0,0,ballRadius+5])
            color([0,1,0])
                sphere(r=ballRadius+1);
}
