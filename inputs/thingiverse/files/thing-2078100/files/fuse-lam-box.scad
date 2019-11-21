include <libs/thread.scad>

$fn=32;
d_lamp=40;
deep_lamp=60;
butt_x=19.5;
butt_y=13.5-0.5;

pwr_x=27.5;
pwr_y=20;
w=0.4*3;

//параметры резьбы
thr_out=40.5+0.5+0.5;
thr_in=38.5+0.5+0.5;
thr_step=22.5/9;


module lid(){
    difference(){
        union(){
            hull(){
                cylinder(d=d_lamp+w*2,h=4);
                cylinder(d=d_lamp+w*8,h=0.1);
            }
            cube([d_lamp+w*8,d_lamp+w*8,w],center=true);
        }
        //translate([0,0,-w])cylinder(d=d_lamp,h=5+w*2);
        translate([0,0,-w])metric_thread (diameter=thr_out, pitch=thr_step, length=7,thread_size=thr_out-thr_in,internal=true);
        translate([d_lamp/2+w,d_lamp/2+w,-w])cylinder(d=3.5,h=5+w*2);
        translate([d_lamp/2+w,-d_lamp/2-w,-w])cylinder(d=3.5,h=5+w*2);
        translate([-d_lamp/2-w,d_lamp/2+w,-w])cylinder(d=3.5,h=5+w*2);
        translate([-d_lamp/2-w,-d_lamp/2-w,-w])cylinder(d=3.5,h=5+w*2);
    }
}



module uho(){
    difference(){
        hull(){
            translate([-3.5*1.2,-3.5*1.2,w/2])cube([3.5*2.2,3.5*2.2,0.01]);
            translate([+3.5,+3.5,-20])cube([0.1,0.1,0.1]);
        }
        translate([0,0,-15])cylinder(d=3,h=16);
    }
}
module box(){
translate([d_lamp/2+w,d_lamp/2+w,-w])uho();
rotate([0,0,90])translate([d_lamp/2+w,d_lamp/2+w,-w])uho();
rotate([0,0,180])translate([d_lamp/2+w,d_lamp/2+w,-w])uho();
rotate([0,0,270])translate([d_lamp/2+w,d_lamp/2+w,-w])uho();
    
    

translate([d_lamp/2+w*3,d_lamp/2+w*3,-deep_lamp])cylinder(d=2,h=deep_lamp-15,$fn=4);
rotate([0,0,90])translate([d_lamp/2+w*3,d_lamp/2+w*3,-deep_lamp])cylinder(d=2,h=deep_lamp-15,$fn=4);
rotate([0,0,180])translate([d_lamp/2+w*3,d_lamp/2+w*3,-deep_lamp])cylinder(d=2,h=deep_lamp-15,$fn=4);
rotate([0,0,270])translate([d_lamp/2+w*3,d_lamp/2+w*3,-deep_lamp])cylinder(d=2,h=deep_lamp-15,$fn=4);
    
    
    translate([-(d_lamp+w*6)/2,-w*2,-deep_lamp+0.5])rotate([0,90,0])cylinder(d=2,h=d_lamp+w*6,$fn=4);
    
    translate([-(d_lamp+w*6)/2,-(d_lamp+w*6)/2,-deep_lamp+0.5])rotate([0,90,0])cylinder(d=2,h=d_lamp+w*6,$fn=4);
    rotate([0,0,90])translate([-(d_lamp+w*6)/2,-(d_lamp+w*6)/2,-deep_lamp+0.5])rotate([0,90,0])cylinder(d=2,h=d_lamp+w*6,$fn=4);
    rotate([0,0,180])translate([-(d_lamp+w*6)/2,-(d_lamp+w*6)/2,-deep_lamp+0.5])rotate([0,90,0])cylinder(d=2,h=d_lamp+w*6,$fn=4);
    rotate([0,0,270])translate([-(d_lamp+w*6)/2,-(d_lamp+w*6)/2,-deep_lamp+0.5])rotate([0,90,0])cylinder(d=2,h=d_lamp+w*6,$fn=4);

difference(){
    translate([0,0,-deep_lamp/2-w/2])cube([d_lamp+w*8,d_lamp+w*8,deep_lamp],center=true);
    translate([0,0,-deep_lamp/2+1])cube([d_lamp+w*6,d_lamp+w*6,deep_lamp+w],center=true);
    
    translate([-pwr_x/2,(d_lamp+w*8)/2-pwr_y-w-2,-deep_lamp-w*2]) cube([pwr_x,pwr_y,w*4]);
    
    translate([-butt_x/2,-(d_lamp+w*8)/2+w+2,-deep_lamp-w*2]) cube([butt_x,butt_y,w*4]);
    translate([0,-d_lamp/2-w,-3])rotate([90,0,0])
        hull(){
            translate([-4,0,0])cube([8,8,4]);
            cylinder(d=8,h=4);}
}


}

module shaiba(){
    difference(){
        cylinder(d=thr_out+4,h=6,$fn=12);
        metric_thread (diameter=thr_out, pitch=thr_step, length=6.1,thread_size=thr_out-thr_in,internal=true);
    }
}
//lid();
box();
//shaiba();

//cylinder(d=thr_out,h=4);
//cylinder(d=thr_in,h=8);
