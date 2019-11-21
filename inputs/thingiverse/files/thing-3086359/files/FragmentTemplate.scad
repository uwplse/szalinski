D1=57;
D2=76;
D3=122;
D4=152;
D5=85;
W=100;
H=120;

//End Variables
difference(){
Core();
Core2();

}

        translate([-W/4,H/3.5,0])linear_extrude(3)text(str(D1));
        
        translate([W/4-8,H/3.5,0])linear_extrude(3)text(str(D2));
    
        translate([10,0+12,0])rotate([0,0,-90])linear_extrude(3)text(str(D3));
        
        translate([-10,0-12,0])rotate([0,0,90])linear_extrude(3)text(str(D4));
        
        translate([0+8,-H/3.5+8,0])rotate([0,0,180])linear_extrude(3)text(str(D5));

module Core(){
   difference(){
    union(){
            cube([W,H,6],center=true);
    }
    translate([-W/4,H/2+(D1/3),0])cylinder(d=D1,center=true,h=10,$fn=64);
    
    translate([W/4,H/2+(D2/2.5),0])cylinder(d=D2,center=true,h=10,$fn=64);
    
    translate([W/2+D3/3,0/2.5,0])cylinder(d=D3,center=true,h=10,$fn=64);
    
    translate([-W/2-D4/3,0/2.5,0])cylinder(d=D4,center=true,h=10,$fn=64);
    
    translate([0,-H/2-(D5/3),0])cylinder(d=D5,center=true,h=10,$fn=64);
    
} 
}
module Core2(){
   difference(){
    union(){
            translate([0,0,3])cube([W-2,H-2,5],center=true);
    }
    translate([-W/4,H/2+(D1/3),0])cylinder(d=D1+2,center=true,h=10,$fn=64);
    
    translate([W/4,H/2+(D2/2.5),0])cylinder(d=D2+2,center=true,h=10,$fn=64);
    
    translate([W/2+D3/3,0/2.5,0])cylinder(d=D3+2,center=true,h=10,$fn=64);
    
    translate([-W/2-D4/3,0/2.5,0])cylinder(d=D4+2,center=true,h=10,$fn=64);
    
    translate([0,-H/2-(D5/3),0])cylinder(d=D5+2,center=true,h=10,$fn=64);
    
} 
}