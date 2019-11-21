ocular_r = 31.6;
ocular_l = 20;



difference(){
    union(){
        import("lenscap.stl", convexity =500, center = true);
        translate([0,0,-ocular_l-0.2])
        linear_extrude(ocular_l)
            circle(r=ocular_r/2, $fn=500);
        }
     translate([0,0,-ocular_l*1.1])
        linear_extrude(ocular_l*1.2)
            circle(r=11.92, $fn = 500);  
     translate([0,0,-ocular_l*1.2-1])
        linear_extrude(ocular_l*1.2)
            circle(r=ocular_r/2-1, $fn = 500);
}
