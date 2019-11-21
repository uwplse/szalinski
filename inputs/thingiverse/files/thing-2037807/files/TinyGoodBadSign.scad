//length of green slide, not counting pull handle thickness
s=10;   
//thickness (of walls, pull handle, etc.)
t=2;  
//delta - additional tolerance space between pieces for better snap and slide
d=0.25; 
//Letter for green/good slide. 
good="C";   
//Letter for red/dirty back
bad="D";    
//Font - include styles as desired. 
ff="Liberation Sans:style=Bold";  
//font size - same as or slightly smaller than 's', depending on font
fs=8;  

color("green") {
    difference() {
        translate([-(s/2),-s/2+d]) cube(size=[s,s-2*d,t-2*d],center=false);
        translate([0,0,t/2-2*d]) linear_extrude(height=t/2) text(good, font=ff, size=fs, valign="center", halign="center");
    }
    translate([s/2,-s/2+d,0]) cube(size=[t,s-2*d,2*t+1],center=false);
}

color("red") {
    difference() {
        translate([-(3*s/2),s/2+t,0]) cube(size=[2*s+t,s,t],center=false);
        translate([t,s+t,t/2]) linear_extrude(height=t/2) text(bad, font=ff, size=fs, valign="center", halign="center");
    }
}

color("white") {
    difference() {
        translate([-(3*s/2+2*t),(3*s/2+2*t),0]) cube(size=[2*s+3*t,s+2*t,3*t],center=false);
        translate([-(3*s/2+t),(3*s/2)+3*t,t]) cube(size=[2*s+t,s,2*t],center=false);
        translate([-(3*s/2+t+d/2),(3*s/2)+3*t-d/2,2*t]) cube(size=[2*s+t+d,s+d,2*t],center=false);
        translate([-s/2-t+2*d,3*s/2+3*t+d,0]) cube(size=[s+t-2*d,s-2*d,t],center=false);
    }
}
