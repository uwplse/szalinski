$fn=50;

//outer diameter of tube hole
D_1=10.7;

//inner diameter of tube hole
D_OUT=8.5;

//economic hole
D_in=3;

//height 1
H_1=0.4;

//height 2
H_2=4;


module econom(dout=8.5,din=3,h1=0.4,h2=4,dout2=10.7){
    difference(){
        union(){
            cylinder(d=dout2,h=h1);
            cylinder(d=dout,h=h2);
        }
        cylinder(d=din,h=h2+1);
        translate([0,0,h1*2])cylinder(d=dout-0.4*4,h=h2+1);
    }

}

//colgate
//econom(dout=8.5,din=3,h1=0.4,h2=4,dout2=10.7);

//lyolan
//translate([11,0,0])econom(dout=6.6,din=2,h1=0.4,h2=4,dout2=9.7);

econom(dout=D_OUT,din=D_in,h1=H_1,h2=H_2,dout2=D_1);