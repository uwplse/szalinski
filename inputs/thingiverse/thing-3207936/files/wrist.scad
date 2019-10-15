diam_M3=3.5;
servo_t=19.8;
servo_w1=40.6;
servo_w2=48.4;
servo_w3=53.4;
servo_d=17.3;
servo_a=20;
servo_fixingscrew_diam=4.5;
servo_fixingscrew_distance=10.2;
thickness=3;
bigger=5;
width=36+thickness;

difference()
{
union(){    
cube([servo_w3+thickness*2+bigger,width,thickness],center=true);
translate([-(servo_w3+thickness*2+bigger)/2,-width/2,0])cube([thickness,width,15]);    
}
cube([servo_w1+2,servo_t+2,thickness*2],center=true);    
//servo screw holes
translate([-servo_w2/2,-servo_fixingscrew_distance/2,0])cylinder(d=servo_fixingscrew_diam,h=100,$fn=20,center=true);
translate([-servo_w2/2,+servo_fixingscrew_distance/2,0])cylinder(d=servo_fixingscrew_diam,h=100,$fn=20,center=true);    
translate([servo_w2/2,-servo_fixingscrew_distance/2,0])cylinder(d=servo_fixingscrew_diam,h=100,$fn=20,center=true);
translate([servo_w2/2,+servo_fixingscrew_distance/2,0])cylinder(d=servo_fixingscrew_diam,h=100,$fn=20,center=true);        
//holes for arm attachment
translate([-(servo_w3+thickness+bigger)/2,8+5,8])rotate([0,90,0]) cylinder(r=diam_M3/2,h=thickness*3,center=true,$fn=20);    
translate([-(servo_w3+thickness+bigger)/2,-8-5,8])rotate([0,90,0]) cylinder(r=diam_M3/2,h=thickness*3,center=true,$fn=20);  
}

translate([0,-width/2,0])hull() {
translate([-(servo_w3+thickness*2+bigger)/2,-thickness/2,0])cube([thickness,thickness,15]); 
cube([servo_w3+thickness*2+bigger,thickness,thickness],center=true);    
}
translate([0,width/2,0])hull() {
translate([-(servo_w3+thickness*2+bigger)/2,-thickness/2,0])cube([thickness,thickness,15]); 
cube([servo_w3+thickness*2+bigger,thickness,thickness],center=true);    
}