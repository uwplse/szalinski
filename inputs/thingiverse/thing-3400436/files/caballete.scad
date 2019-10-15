d=9.5;
h=25;
b=20;
t=3;
wall=2;


module part(){
    rotate([0,0,360/8/2])cylinder(d=d+2*wall,h=h,$fn=8,center=true);
}
module hole(){
    translate([0,0,-2])cylinder(d=d,h=h,$fn=50,center=true);
}

module top(){
    difference(){
        hull(){
            rotate([0,20,0])translate([0,0,-h/2])part();
            rotate([0,-20,0])translate([0,0,-h/2])part();
            rotate([30,0,0])translate([0,0,-h/2])part();
        }
        rotate([0,20,0])translate([0,0,-h/2])hole();
        rotate([0,-20,0])translate([0,0,-h/2])hole();
        rotate([30,0,0])translate([0,0,-h/2])hole();
    }
}

module side(){
    
    difference(){
        hull(){
            rotate([0,20,0])part();
            translate([h/2,(d+4)*cos(360/8/2)/2,0])rotate([0,90,0])part();
        }
        
        rotate([0,20,0])scale([1,1,1.5])hole();
        translate([h/2,(d+2*wall)*cos(360/8/2)/2,0])rotate([0,90,0])scale([1,1,1.5])hole();
        
    }    
    
}

module base(){
    difference(){
        union(){
           part();
            translate([b/2+(d+2*wall)*cos(360/8/2)/2,0,0])cube([b,t,h],center=true);
            translate([b/2+(d+2*wall)*cos(360/8/2)/2+b/2,t/2,0])cube([t,2*t,h],center=true);
        }
        scale([1,1,1.5])hole();
    
    }
    
}
translate([3+h,0,0])base();
top();
translate([0,3+h,0])side();
mirror([0,1,0])translate([0,3+h,0])side();