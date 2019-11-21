use </home/mirek/fonts/honeyquick.ttf>
union(){
linear_extrude(height=3){
    text("jahody", font="honey quick", size=40);
}
length=55;
leg_y=50;
leg_x=15;
z=2;
cube(size = [length,1,z]);
translate([(length-leg_x)/2,-1*leg_y,0]){
    cube(size = [15,leg_y,z]);
    difference(){
    translate([leg_x/2,leg_x/-2,0]){
        rotate ([0,0,45]){
            cube([sqrt(2)*leg_x/2,sqrt(2)*leg_x/2,z]);
        }
    }
    translate([leg_x/2,leg_x/-2,0]){
        rotate ([11,-11,45]){
            cube([sqrt(2)*leg_x/2,sqrt(2)*leg_x/2,z]);
        }
    }}
    
    }
}
    

