phi =  1.61803398874989484820;
size = 5;
line_width = 2;
xnum = 50/(size-line_width/2);
ynum = 50/(size*phi-line_width/2);
linear_extrude(height=3,convexity=10)
circle(r=50,$fn=100);
rotate_extrude(convexity=10,$fn=100)
translate([48,3,0])
circle(r=2,$fn=100);
p1 = [0,size/2*phi];
p2 = [size/2,0];
p3 = [0,-size/2*phi];
p4 = [-size/2,0];
intersection(){
    cylinder(r1=49,r2=49,h=5);
    union(){
        for(iy = [-ynum:1:ynum]) {   
            for(ix = [-xnum:1:xnum]) {
                linear_extrude(height=4,convexity=10)
                translate([(size-(line_width/2))*ix,(size*phi-(line_width/2))*iy,3])
                difference(){
                    polygon(points=[p1,p2,p3,p4]);
                    scale([(size-line_width)/size,(size-line_width)/size,1])
                    polygon(points=[p1,p2,p3,p4]);
                }
            }
        }
    }
}