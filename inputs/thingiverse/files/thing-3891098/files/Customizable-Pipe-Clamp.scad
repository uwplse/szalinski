//U-Clamp for Pipe in mm
//25.4mm = 1 inch

// Enter your Diameter of Pipe
pipe_dia=40;

difference(){
difference(){
union(){cylinder($fn=100, h=pipe_dia, d=pipe_dia*1.25, center=true);
translate([-pipe_dia/4,0,0])
    cube([pipe_dia/2, pipe_dia*1.25, pipe_dia], center=true);
translate([(-pipe_dia/2.25),0,0])
    cube([(pipe_dia*1.25-pipe_dia)/2,pipe_dia*3,pipe_dia],center=true);}
cylinder($fn=100,h=pipe_dia+1, d=pipe_dia, center=true);
translate([(-pipe_dia/2)-sqrt(pipe_dia/3.9),0,0])    
cube([pipe_dia+1,pipe_dia,pipe_dia+1], center=true);}
translate([0,-pipe_dia,0])
rotate([0,90,0])
cylinder($fn=100, d=sqrt(pipe_dia), h=pipe_dia*5, center=true);
translate([0,pipe_dia,0])
rotate([0,90,0])
cylinder($fn=100, d=sqrt(pipe_dia), h=pipe_dia*5, center=true);}
