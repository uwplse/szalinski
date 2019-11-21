module tooth(){
    rotate(250,0,0){
        difference(){
            circle(4,$fn=200);
            translate([-4,-1,0]){square([4,5],center=false);}
            translate([-4,-4,0]){square([8,4],center=false);}
            translate([-0.32,2.1218,0]) {
                rotate(112,0,0){
                    minkowski(){
                        scale([0.5,0.5])polygon(points=[[0,0],[1,4],[3,4],[4,0]]);
                        scale([0.6,0.5])circle(2,$fn=200);
                    }
                }
            } 
        }
    }
}
module wheel(){
    r=6.5;
    n=12;
    circle(r,$fn=12);
    for(i=[0:n])
        rotate([0,0,i/n*360])
            translate([r,0,0])
                scale([1,1])tooth();
}
module droplet(){
    render(convexity = 1){
        fPoints = 200;
        sphDiameter = 1;
        sphRadius = sphDiameter/2;
        cHeight = (sphDiameter/(32/77));
        cDiameter = 0.01;
        cRadius = cDiameter/2;
        squWidth = sphDiameter;
        squHeight = cHeight+cRadius;
        squDepth = sphRadius;
        rotate([270,0,0]){
            difference(){
                hull(){
                    translate([0,0,cHeight])
                    sphere(d = cDiameter, $fn=fPoints);
                    translate([0,0,sphRadius])
                    sphere(d = sphDiameter, $fn=fPoints);
                }
                rotate([90,0,0]){
                    translate([(-squWidth/2),0,-squDepth])
                    cube([squWidth,squHeight,squDepth]);
                }
            }
        }
    }
}
union(){
    linear_extrude(height = 0.5, convexity = 10, scale=1)
        rotate(-12,0,0){translate([0,0,1])scale([0.2,0.2])wheel();}
    translate([0,-1.20,0.5])scale([.80,1])droplet();
}