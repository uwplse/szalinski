// Written by  akaJes 2016 (c)
// used as sources
//http://www.thingiverse.com/thing:1103976/#remixes
//http://www.thingiverse.com/thing:119616/#files
//use <cable_chains.scad>;
//xMotor();
/* [general] */
show_assembled=1; //[0:No,1:Yes]
carriage_position=5; //[0:10]

//between centers of flat rod and screw rod
axis_distance=17;
motor_shift=0;
motor_hole_flanges=0; //[0:No,1:Yes]

/* [additional] */

//for rod hole
nozzle=0.3;
rod_diameter=8;
rod_distance=45;
carriage_height=60;
carriage_thickness=17;
belt_hole_height=30;
belt_hole_width=8;
idler_hole_height=17;
tensioner_bearing_diameter=5;

/* [visual] */

show_motor=1; //[0:No,1:Yes]
show_carriage=1; //[0:No,1:Yes]
show_idler=1; //[0:No,1:Yes]
show_tensioner=1; //[0:No,1:Yes]
show_T8m5=1; //[0:No,1:Yes]
show_endstop=1; //[0:No,1:Yes]
show_endchains=1; //[0:No,1:Yes]
show_chains=1; //[0:No,1:Yes]
//for first print testing nozzle size
show_testconnection=0; //[0:No,1:Yes]

/* [hidden] */

//show_adapter=0; //[0:No,1:Yes]

if (show_assembled==2){
  lm8uuABS();
}
if (!show_assembled){
  if(show_testconnection){
    translate([90,35,0]){
    //if(0)
      intersection(){
      translate([0,0,56/2])rotate([0,90,0])xCarriage(1);
        translate([-10,20,0])cube([40,40,8]);
      }
      intersection(){
      rotate([0,0,90])xCarriage(4);
        translate([-40,20,0])cube([40,40,40]);
      }
    }
  }
  if (show_tensioner){
    translate([-12,25,0])tensioner_clamp();
    translate([28,45,0])tensioner_cap();
    translate([-15,45,0])tensioner_knob();
  }
  if (show_endstop){
    translate([42,0,19])rotate([0,90,0])xEndStop();
  }
  if (show_endchains){
    translate([90,0,0])rotate([0,0,0])endChain1();
    translate([120,0,0])rotate([0,0,0])endChain2();
  }
  if (show_chains){
    translate([130,30,0])rotate([0,0,0])chain();
    translate([160,30,0])rotate([0,0,90])chain();
    translate([160,60,0])rotate([0,0,180])chain();
    translate([130,60,0])rotate([0,0,-90])chain();
  }
  if(show_motor){
    translate([0,60,0])
    xMotor();
    //%translate([])import("X-MOTOR_17mm.STL");
  }
  translate([-15,70,0])
  if(show_T8m5){
    nutT8m5();
    translate([0,25,0])nutT8m5();
  }
  if(show_idler){
      xIdler();
  }
  if(show_carriage){
    translate([90,35,0]){
      translate([0,0,56/2])rotate([0,90,0])xCarriage(1);
      translate([0,0,30/2])rotate([0,90,0])xCarriage(2);
      translate([5,10,0])rotate([0,0,90])xCarriage(4);
    }
    //%translate([])import("X-CARRIAGE.STL");
  }
}else 
if(show_assembled==1){
  translate([0,0,rod_distance+7.5])rotate([0,180,0]){
    if (show_motor){
      xMotor();
      translate([55,28,0-13])rotate([-20,0,90])
      if(show_endchains)
        color("brown")endChain2();
      translate([11+axis_distance+32+motor_shift,34,carriage_height/2]){
        color("black")translate([-21,0,-21])cube([42,34,42]);
        color("silver")translate([0,0,0])rotate([90,0,0])cylinder(d=16,h=15);
        for (i=[0:3])
          color("silver")rotate([0,45+i*90,0])translate([31/2*sqrt(2),0,0])
        rotate([90,0,0])cylinder(d=4,h=15);
      }
      translate([axis_distance+11,23/2,-50])color("silver")cylinder(h=220,d=rod_diameter);
      if(show_T8m5)
        translate([11,11.5,-3.6])color("brown")nutT8m5();
    }
    if (show_idler)
    translate([-200,0,0]){
      xIdler(support=0);
      translate([23/2,23/2,-50])color("silver")cylinder(h=220,d=rod_diameter);
      if(show_T8m5)
        translate([23/2+axis_distance,11.5,-3.6])color("brown")nutT8m5();
    }
  }
  translate([-30,25,0])color("silver"){
    rotate([0,90,0])cylinder(h=220,d=rod_diameter);
    translate([0,0,rod_distance])
      rotate([0,90,0])cylinder(h=220,d=rod_diameter);
  }
  if (show_carriage)
    translate([30+(carriage_position)*10,13,0]){rotate([-90,180,0])
      xCarriage();
  if(show_chains)
    translate([5,15,rod_distance+23/2])rotate([0,0,90]){
      if(show_endchains)
        color("brown")endChain1();
      f=floor((1-carriage_position/10)*3.5);
      a=(1-carriage_position/10);
      translate([0,3,5.5])
      color("red")Achain([for(i=[0:18])(i<8+f&&i>=f)?-(25.4+a):0],0);
    }
  }
  if(0)
  if (show_adapter)
    translate([60+(1-$t)*(carriage_position)*10,13-6,rod_distance/2+8])rotate([-90,180,0])
      xAdapter();
  if (show_endstop){
    translate([-4,16,-8])rotate([0,0,0])color("brown")xEndStop();
    //translate([15,16,-5])rotate([90,-90,0])color("red")EendPCB();
  }
  if (show_tensioner){
    translate([185-axis_distance,17+17/2,rod_distance/2-16/2])rotate([0,0,90])color("brown")tensioner_clamp();
    translate([210,17+17/2,rod_distance/2]){
      rotate([0,-90,0])tensioner_cap();
      translate([.1,0,0])rotate([0,90,0])color("brown")tensioner_knob();
    }
  }
}
/* MODULES */
module Achain(ar,i){
  translate([0,-16,0])rotate([ar[i],0,0]){
    translate([0,-3,-5.5])chain(); //shift to left center
    if (i+1<len(ar))
      Achain(ar,i+1);
  }
}
module endChain2(){
  module t(i=0,w=13){
    difference(){
      union(){
        translate([0,6.5/2,6.5/2])rotate([0,90,0])
          cylinder(d=6.5,h=2);
        translate([0,0,2])cube([2,6.5,w-2]);
        if(i)
          translate([0,0,w])rotate([-90,90,0])
            cylinder(r=2,h=6.5,$fn=16);
      }
    translate([-.1,3.8-.6,8])rotate([0,90,0])hull(){
      cylinder(h=3,d=3.2,$fn=32);
      translate([4,0,0])cylinder(h=3,d=3.2,$fn=32);
    }
  }
}
  difference(){
    chain(); 
    translate([-12,-20,-.1])cube([25,16.2,13]);
  }
  mirror([0,0,1])
    translate([11.2-4.8,-3.8,-23])
      t();
  mirror([1,0,0])mirror([0,0,1])
    translate([11.2,-3.8,-23])
      t(1);
}
  
module endChain1(){
  difference(){
    chain();
    translate([-25/2,2.5,-1])cube([25,25,25]);
  }
  difference(){
    translate([-11.2+4.75/2,0+15/2,0])rounded_brick([4.75,15,8]);
    translate([0,8,4])rotate([0,-90,0])cylinder(d=3,h=15,$fn=24);
  }
}
module xCarriage(l=7){
  width=56;
  lw=30;
  p1=l%2;
  p2=floor(l/2)%2;
  p3=floor(l/4)%2;
    difference(){
      union(){
        if(p1)
          translate([width/2,rod_distance,23/2])
            rotate([-90,0,90]){
              difference(){
                lm8holder(0,width,s=4);
                lm8holder(1,width+.2,30,205,s=4);
              }
              translate([23/2+4-.001,23/2,width/2-3])rotate([0,90,-90])
                difference(){
                  union(){
                    rounded_brick([10,8,3.8],sides=[3,0,3,0]);
                    translate([7,-2,0])
                      rounded_brick([8,8,3.8],sides=[6,0,0,0],$fn=4);
                  }
                  translate([0,0,-.1])cylinder(d=3,h=5,$fn=24);
                }
            }
        if(p2)
          assign(h=lw)translate([h/2,0,23/2])
            mirror([0,1,0])rotate([-90,0,90])
              difference(){
                lm8holder(0,h,s=.1);
                lm8holder(1,h+.2,45,181,s=.1);
              }
        if(p3)assign(hh=10,th=8.5,tb=7,gap=nozzle)assign(tp=23/2-2+gap/2){
          translate([0,rod_distance-tp,0]){
            translate([0,-5-hh/2,0])
              rounded_brick([width,hh,th],sides=[0,6,0,6]);
            translate([0,0,6])
              rotate([90,90,0])trapezoid([8-nozzle,width,5],[5-nozzle]);
            assign(hh=10)
              for (i=[0,1])
                mirror([i,0,0])
                  translate([-width/2+6.5+2,-hh,th])
                    difference(){
                      rounded_brick([13+4,10,tb],sides=[3,3,0,6]);
                      translate([-9,5+nozzle*1.5,0]) //vis 0.001
                        mirror([0,1,0])belt_t2(l=14+5,w=8);
                      translate([-9,-2,0])
                        rotate([0,0,-10])belt_t2(l=14+5,w=8);
                    }
        
          }
          assign(w=width-2*6,h=rod_distance-(tp+5-.001)*2)
            translate([0,tp+5,0])
              difference(){
                translate([-w/2,0,0])cube([w,h,th]);
                for (i=[0,1])
                  mirror([i,0,0])
                    translate([-lw/2-20/2,(h-hh-1)/2,-.1])
                      rounded_brick([20,(h-hh+1),th+.2],sides=[6,0,0,0]);
              }
          translate([0,tp,6])
            rotate([-90,90,0])trapezoid([8-nozzle,lw,5],[5-nozzle]);
        }
      }
      assign(hh=10)
        for (i=[0,1])
          mirror([i,0,0])
            translate([-width/2+6.5+2-4,rod_distance-23/2+2-9,5])
              cylinder(d=2.7,h=11,$fn=36);
      translate([0,rod_distance-45/2,-1]){
        prusa_holes();
        for(i=[1,-1])
          translate([15*i,3,0])cylinder(d=3.3,h=30,$fn=36);
      }
    }
}

//belt width = 6
module xCarriage_(g=0){
  width=56;
  height=rod_distance+23;
  hole_dist=23;
  hole_d=4.25;
  lw=30.25;
  th=36.3;
//  translate([width/2,0,0])
  translate([0,-height/2,0])
    difference(){
      union(){
        h1=26;
        translate([0,height-h1/2,0])
            rounded_brick([width,h1,12],sides=[6,0,6,0]);
        translate([0,height-th/2,0])
          rounded_brick([width,th,6],sides=[6,6,6,6]);
        translate([10,height+4,0])difference(){
            rounded_brick([10,8,3.8],sides=[3,0,3,0]);
            translate([0,0,-.1])cylinder(d=3,h=5,$fn=24);
        }
        for (i=[0,1])
          mirror([i,0,0])
            translate([(-width/2+6.5+2),height-th+14.8/2,0])
              difference(){
                rounded_brick([13+4,14.8,15],sides=[3*2*2,3,3,6]);
                translate([-7-2,2.9,9])
                  mirror([0,1,0])belt_t2(l=14+5,w=7);
                translate([-7-2,2.9-7,9])
                  rotate([0,0,-10])belt_t2(l=14+5,w=7);
                translate([-7+3,2.9-4,5])
                  cylinder(d=2.7,h=11,$fn=36);
              }
        translate([0,13,0])
          rounded_brick([lw,26,12],sides=[3,6,3,6]);
        w=width-2*6;
        h=height-26-th+7;
        translate([-w/2,26-6,0])
          cube([w,h,6]);
      }
      union(){
        h=height-26-th+7;
        for (i=[0,1])
          mirror([i,0,0])
            translate([-lw/2-20/2,height-th-h/2,-.1])
              rounded_brick([20,h,7],sides=[6,0,0,0]);
        translate([0,11.5,12]){
          rotate([0,90,0])lm8uu();
          for(i=[-1,1])
            translate([i*13.2,rod_distance,0])
              rotate([0,90,0])lm8uu(ts=9);
        }
        translate([0,height/2,-5])
          prusa_holes();
        translate([0,height/2,-5])
          for(i=[1,-1])
            translate([15*i,3,0])cylinder(d=3.3,h=30,$fn=36);
        if (g)
        translate([0,height/2-10,-5])
          graber_holes();
      }
    }
}
module EendPCB(){
  difference(){
    union(){
      cube([40,16,1.5]);
      translate([7,0,1.5])cube([12.7,6.3,5.8]);
    }
    translate([0,4,-.1]){
      translate([2+3.75/2,0,0])
      cylinder(d=3.75,h=2,$fn=16);
      translate([2+22.5-3.75/2,0,0])cylinder(d=3.75,h=2,$fn=16);
      translate([2+22.5+15.4-3.75/2,0,0])cylinder(d=3.75,h=2,$fn=16);
    }
  }
}

module tensioner_cap(){
  d=3;
  difference(){
    union(){
      rounded_brick([carriage_height,carriage_thickness,5.5]);
      translate([0,0,5.5])
        rounded_brick([belt_hole_height-nozzle*2,belt_hole_width-nozzle*2,3]);
    }
    translate([0,0,-.1])cylinder(d=d+nozzle,h=10,$fn=16);
    for(i=[1,-1])
      translate([i*rod_distance/2,0,-.1]){
        cylinder(d=d+nozzle,h=6,$fn=16);
        translate([0,0,3.2])nutMhex(3);//cylinder(d=2*d+nozzle,h=3,$fn=6);
      }
  }
}
module tensioner_knob(){
  ro=1;
  o=20;
  h=5;
  d=3;
  difference(){
    intersection(){
      cylinder(d=o,h=h);
      cylinder(d1=o-ro*2,h=h,d2=o+(h-ro)*2);
      cylinder(d2=o-ro*2,h=h,d1=o+(h-ro)*2);
    }
    translate([0,0,-.1])cylinder(d=d+nozzle,h=6,$fn=16);
    translate([0,0,2.5+.1])nutMhex(3);//cylinder(d=2*d+nozzle,h=3,$fn=6);
    pits(5,26,2,9);
  }
}
module tensioner_clamp(l=axis_distance,d=tensioner_bearing_diameter,id=5){
  nut=3;
  flatm3=nut*1.6+nozzle;
  height=16;
  difference(){
    union(){
      difference(){
        union(){
          translate([0,-1,0])rounded_brick([17,17,16],sides=[1,2,1,2]);
                translate([0,-l/2-16/2,0])
          rounded_brick([7.75,l,16],sides=[0,1,0,1]);
        }
        translate([0,2,height/2])rotate([0,90,0])
          cylinder(h=8,r=16/2+3,center=true);
      }
      for(i=[1,-1])
      translate([-4*i,2,height/2])rotate([0,i*90,0])
        cylinder(h=(8-id)/2,d1=d*2,d2=d+2);
    }
    translate([0,2,height/2])rotate([0,90,0]){
      cylinder(h=18,d=d+nozzle,center=true,$fn=16);
      translate([0,0,-17/2-.1])
        assign(h=3.2)cylinder(h=h,d1=d+nozzle+2*tan(38)*h,d2=d+nozzle);
      translate([0,0,17/2-3.5])nutMhex(d);
    }
    translate([-4,-l,height/2])rotate([90,0,0])hull(){
      nutMhex(nut);
      translate([7,0,0])nutMhex(nut);
    }
    translate([0,-5,8])rotate([90,0,0])cylinder(h=50,d=nut+nozzle,$fn=16);
  }
}
module wireClip(l=7,w=4){
  difference(){
    translate([0,-2,0])rounded_brick([l,w,5],sides=[0,2,0,2]);
    translate([0,-2.5/2,-.1])rounded_brick([l-3,w-1.5,5.2],sides=[0,1,0,1]);
    translate([-1/2,0,-.1])mirror([0,1,0])cube([1,w+.1,5.2]);
    translate([-l/2-.1,-w/2,3]){
      mirror([0,1,0])cube([l+.2,5,3]);
      rotate([45,0,0])cube([l+.2,sqrt(8),3]);
    }
  }
}
module xEndStop(l=19,h=15,w=17){
  difference(){
    union(){
      translate([l/2,w/2,0])rounded_brick([l,w,h],sides=[4,0,0,0]);
      difference(){
        translate([l-11,-3,h/2])rotate([0,90,0])
          rounded_brick([h,6,11],sides=[0,2,0,2]);
        translate([l-11-.1,0,-.1])rotate([0,0,-60])
          mirror([0,1,0])cube([11.2,4,h+.2]);
        translate([l-11-.1,-3,h/2-1])
          mirror([0,1,0])cube([11.2,4,2]);
      }
    }
    translate([-.1,w/2,h/2])rotate([0,90,0])
      cylinder(d=rod_diameter+nozzle,h=l+.2,$fn=24);
    translate([l-6+.1,-5,1])cube([6,6,h-2]);
    translate([l-11-.1,-4,1])cube([11.2,4,h-2]);
    
  }
  translate([3.5,0,0])
    wireClip();
}
module nutT8m5(){
  od=22;
  oh=3.6;
  hd=3.6;

  nd=10;
  nh=2.4;

  nut=5;
  difference(){
    union(){
      cylinder(d=od,h=oh,$fn=36);
      cylinder(d=nd,h=oh+nh,$fn=36);
    }
    translate([0,0,oh-1])
      nutMhex(5);//cylinder(d=1.8*nut+nozzle,h=3.6,$fn=6);
    translate([0,0,-.1]){
      cylinder(d=nut+1,h=oh+nh+.2,$fn=36);
        for (i=[0:3])rotate(360/4*i)
          translate([-8,0,0])cylinder(d=hd,h=oh+0.2,$fn=36);
    }
  }
  
}
module xIdler(shift=axis_distance,support=1){
  height=carriage_height;
  thickness=carriage_thickness;
  rod_axis=25.5;
  sstep=4;
  difference(){
    union(){
      translate([(shift+25)/2,rod_axis,0])rounded_brick([shift+25,thickness,height],sides=[4,4,0,0]);
      translate([23/2,rod_axis-14,0]){
        lm8holder(0,height);
        translate([shift,0,0])nutT8(0);
        joint(0,shift);
      }
    }
    translate([23/2,rod_axis-14,0]){
      mirror([1,0,0])lm8holder(1,height);
      translate([shift,0,0])mirror([1,0,0]){
        nutT8(shift<20?1:2);
        joint(1,shift);
      }
    }
    translate([-.1,rod_axis,0]){
      //rod
      for (i=[0,rod_distance])
        translate([0,0,i+7.5])
          rotate([0,90,0])
            cylinder(d=rod_diameter+nozzle,h=shift+25+.2,$fn=36);
      //belt
      translate([0,-belt_hole_width/2,height/2-belt_hole_height/2])
          cube([shift+26,belt_hole_width,belt_hole_height]);
      translate([shift+25+.2,-thickness/2-.1,height/2-idler_hole_height/2])
        mirror([1,0,0])
        assign(deep=20)
        if (!support)
          cube([deep,thickness+.2,idler_hole_height]);
        else
          for (i=[0:floor(deep/sstep)-1])
            translate([i*sstep+nozzle*2,0,0])
            cube([sstep-nozzle*2,thickness+.2,idler_hole_height]);
    }
  }
}
module xMotor(shift=axis_distance,motor_shift=motor_shift,flanges=motor_hole_flanges,clips=0){
  height=carriage_height;
  width=shift+65+motor_shift;
  thickness=carriage_thickness;
  bearing_d=15;
  rod_axis=25.5;
  difference(){
    union(){
      translate([width/2,rod_axis,0])rounded_brick([width,thickness,20],sides=[0,4,4,4]);
      assign(sh=shift+36+motor_shift-3)
      translate([sh/2,rod_axis,0])rounded_brick([sh,thickness,height],sides=[0,4,4,4]);
      translate([11,rod_axis-14,0]){
        nutT8(0);
        translate([shift,0,0])lm8holder(0,height);
        joint(0,shift);
      }
    }
  //holes
    union(){
      translate([-.1,rod_axis,0]){
        //rod
        for (i=[0,rod_distance])
          translate([0,0,i+7.5])
            rotate([0,90,0])
              cylinder(d=rod_diameter+nozzle,h=shift+22+.1,$fn=36);
        //mount
        translate([11+shift+32+motor_shift,0,0]){
          for (i=[0,-11])
            translate([i,thickness/2+.1,4])
              rotate([90,0,0])cylinder(d=3+nozzle,h=thickness+.2,$fn=36);
          for (i=[5,15.5,-15.5])
            translate([i,0,-.1])
              cylinder(d=2.7,h=15,$fn=36);
        }
        //belt
        translate([0,-8/2,height/2-belt_hole_height/2])
          hull(){
            cube([shift+21+motor_shift,8,belt_hole_height]);
            translate([0,0,10-2])
              cube([shift+28+motor_shift,8,14]);
          }
          translate([0,-thickness/2-.1,45-.1])
            cube([4+.1,thickness+.2,20]);
      }
      translate([11,rod_axis-14,0]){
        nutT8(shift<20?1:2);
        translate([shift,0,0])lm8holder(1,height);
        joint(1,shift);
      }
      //motor
      translate([11+shift+32+motor_shift,rod_axis-thickness/2-.1,carriage_height/2])
        rotate([-90,0,0]){
          rotate([0,0,360/16])cylinder(d=34,h=thickness*3,$fn=8);
          d=3+nozzle;
          f=d;
          for (i=[0:3])
            rotate([0,0,360/4*(i+.5)])
              translate([21.9,0,0]){
                rotate([0,0,45])cylinder(d=d,h=thickness+.2,$fn=16);
                if (flanges)
                  cylinder(d1=d+f,d2=d,h=f/2,$fn=36);
              }
        }
    }
  }
  if (clips){
    translate([width/2,rod_axis+thickness/2,height])
      rotate([-90,0,180])wireClip();
    translate([20,rod_axis,height])
      rotate([-90,0,0])wireClip();
  }
}
module xAdapter(g=0){
  translate([0,0,-8])
  difference(){
    translate([0,-3,0])rounded_brick([40,43,6],r=8);
    translate([0,0,-.1]){
      prusa_holes();
      prusa_holes(8,3,$fn=6);
    }
    translate([0,-25+23/2+20,-.1]){
      graber_holes();
      translate([0,0,3.2])
        graber_holes(5,3,$fn=6);
    }
  }
}
module xCarriage_old(g=0){
  //color("red")cylinder(r=1,h=20);
  width=56;
  height=rod_distance+23;
  hole_dist=23;
  hole_d=4.25;
  lw=30.25;
  th=36.3;
  translate([0,-height/2,0])
    difference(){
      union(){
        h1=26;
        translate([0,height-h1/2,0])
            rounded_brick([width,h1,12],sides=[6,0,6,0]);
        translate([0,height-th/2,0])
          rounded_brick([width,th,6],sides=[6,6,6,6]);
        for (i=[0,1])
          mirror([i,0,0])
            translate([(-width/2+6.5),height-th+14.8/2,0])
              difference(){
                rounded_brick([13,14.8,15],sides=[3,3,3,6]);
                translate([-7,2.9,9])
                  mirror([0,1,0])belt_t2(l=14,w=7);
              }
        translate([0,13,0])
          rounded_brick([lw,26,12],sides=[3,6,3,6]);
        w=width-2*6;
        h=height-26-th+7;
        translate([-w/2,26-6,0])
          cube([w,h,6]);
      }
      union(){
        h=height-26-th+7;
        for (i=[0,1])
          mirror([i,0,0])
            translate([-lw/2-20/2,height-th-h/2,-.1])
              rounded_brick([20,h,7],sides=[6,0,0,0]);
        translate([0,11.5,12]){
          rotate([0,90,0])lm8uu();
          for(i=[-1,1])
            translate([i*13.2,rod_distance,0])
              rotate([0,90,0])lm8uu(ts=9);
        }
        translate([0,height/2,-5])
          prusa_holes();
        if (g)
        translate([0,height/2-10,-5])
          graber_holes();
      }
    }
}
/*helpers*/
module joint(hole=1,shift,d=8,h0=9,r0=22/2,r1=23/2){
  a=(pow(r0+d/2,2)-pow(r1+d/2,2)+pow(shift,2))/(2*shift);
  h=sqrt(pow(r0+d/2,2)-pow(a,2));
  if (hole){
    translate([a,-h,-.1])
      cylinder(d=d,h=h0+.2,$fn=36);
  }else{
    jw=a/h*d;
    jh=d/2/(r0+d/2)*h;
    translate([a-jw/2,r0,0])mirror([0,1,0])
      cube([jw,r0+h-jh,h0]);
  }
}
module pits(height=5,c=14,d=6,shift=0,skip=0){
  for (z=[1:c-skip])
    rotate([0,0,360/c*z])
      translate([shift+d/2,0,0])
        hull(){
          sphere(d=d,$fn=16);
          translate([0,0,height])sphere(d=d,$fn=16);
        }
}

module lm8holder_old(hole=1,h=9){
  id=15;
  od=23;
  r=1;
  if(!hole){
    cylinder(d=od,h=h,$fn=36);
    translate([-od/2,0,0])cube([od,od/2,h]);
  }else
    translate([0,0,-.1]){
        cylinder(d=id,h=h+.2,$fn=36);
        cylinder(d1=id+r,d2=id,h=r,$fn=36);
        translate([0,0,h-r+.2])cylinder(d2=id+r,d1=id,h=r,$fn=36);
      translate([0,-2,0])cube([12,2,h+.2]);
    }
}
module lm8holder(hole=1,h=9,p=0,a=0,s=0){
  id=15;
  od=23;
  r=1;
  if(!hole){
    cylinder(d=od,h=h,$fn=36);
    translate([-od/2,0,0])cube([od,od/2,h]);
    if(s)
      translate([-od/2-3,-s,0])cube([5,od/2+s,h]);
  }else
    translate([0,0,-.1]){
      if (s)
      mirror([1,0,0])
      translate([od/2-2+.001,od/2-6,h/2+.1])
        rotate([90,0,90])trapezoid([8+nozzle,h+.2,5],[5+nozzle]);
      if (s)
    translate([-od/2-3-.1,-2-s,0])cube([8,2,h+.2]);
      
        cylinder(d=id,h=h+.2,$fn=36);
        cylinder(d1=id+r,d2=id,h=r,$fn=36);
        translate([0,0,h-r+.2])cylinder(d2=id+r,d1=id,h=r,$fn=36);
        if(p)
          rotate([0,0,a])pie(12,h+.2,p);
        else
          translate([0,-2,0])cube([12,2,h+.2]);
    }
}

module nutT8(hole=1,h=9){
  id=10+2*nozzle;
  od=22;
  r=1;
  hd=2.7;//for tapping d3 //3.5;
  if (!hole){
    cylinder(d=od,h=h,$fn=36);
      translate([-od/2,0,0])cube([od,od/2,h]);
  }else
    translate([0,0,-.1]){
      cylinder(d=id,h=h+0.2,$fn=36);
      cylinder(d1=id+r,d2=id,h=r,$fn=36);
      for (i=[0:2])rotate(360/4*(-i+hole))
        translate([-8,0,0])cylinder(d=hd,h=h+0.2,$fn=36);
  }
}

module prusa_holes(d=4.25,h=20,$fn=36){
  hole_dist=23;
  hole_d=d;//4.25;
  for (i=[0:3])
      mirror([floor(i/2),0,0])mirror([0,i%2,0])
          translate([hole_dist/2,hole_dist/2,0])
            cylinder(d=hole_d,h=h);
}
module graber_holes(d=3.25,h=20,$fn=36){
  hole_dist=30;
  hole_dist2=25;
  hole_d=d;//3.25;
  translate([hole_dist/2,0,0])
  cylinder(d=hole_d,h=h);
  translate([-hole_dist/2,0,0])
  cylinder(d=hole_d,h=h);
  translate([0,-hole_dist2,0])
  cylinder(d=hole_d,h=h);
}
module belt_t2(l=10,w=6){
  step=2;
  d=1;
  cube([l,0.8+nozzle/2,w]);
  for (i=[1:l/2-1])
    translate([2*i,.8+nozzle/2,0])
      cylinder(d=1+nozzle,h=w,$fn=16);
}

module rounded_brick(d=[10,10,10],sides=[1,1,1,1],r=-1,$fn=36){
  module rounded_(d=[10,10,10],sides=[1,1,1,1]){
    if(max(sides)){
      hull()
        for (i=[0:3])
          mirror([floor(i/2),0,0])mirror([0,i%2,0])
            translate([d[0]/2-sides[i],d[1]/2-sides[i],0])
              if (sides[i]){
                intersection(){
                  cylinder(h=d[2],r=sides[i],$fn=$fn);
                  cube([sides[i],sides[i],d[2]]);
                }
              }else
                translate([-1,-1,0])
                  cube([1,1,d[2]]);
    }else
      translate([-d[0]/2,-d[1]/2,0])
        cube(d);
  }
  if(r>=0)
    rounded_(d,[r,r,r,r]);
  else
    rounded_(d,sides);
}
module pipe(do,di,h,fi=[0,0],fo=[0,0]){
  vis=.001;
  difference(){
    intersection(){
      cylinder(d=do,h=h);
      if(fo[0])
        cylinder(d1=do-fo[0]*2,d2=do-fo[0]*2+2*h,h=h);
      if(fo[1])
        cylinder(d2=do-fo[1]*2,d1=do-fo[1]*2+2*h,h=h);
    }
    if(di)
      translate([0,0,-vis]){
        cylinder(d=di,h=h+2*vis);
        if (fi[0])
          cylinder(d1=di+fi[0]*2,d2=di,h=fi[0]);
        if (fi[1])
          translate([0,0,h-fi[1]+2*vis])
            cylinder(d1=di,d2=di+fi[1]*2,h=fi[1]); //flange top
      }
  }
}
module lm8uuABS(di=8,do=15,h=24,teeth=4*5,pits=0){
  doABS=do/0.99-nozzle;
//  diABS=di/0.99+nozzle;
  diABS=di+nozzle+.04;
  vis=.001;
  difference(){
    pipe(doABS,diABS,h,[.5,.5],[.5,.5],$fn=72);
    if(pits)
      for (i=[0,17.5-1.1])
        translate([0,0,3.25+i])
          pipe(doABS+1,doABS-1,1.1+.5,fi=[0,.5],$fn=72);
    translate([0,0,-vis]){
       for(i=[0:360/teeth:360])assign(t=2*nozzle)
         rotate([0,0,i])translate([0,-t/2,0])
           cube([do/2-4*nozzle,t,h+2*vis]);
    }
  }
}
module lm8uu(ts=7.4,cs=12){
  bearing_d=15;
  bearing_l=24;
  gap=0.6;
  d=15;
  l=24;
  r=2;//pits
  cylinder(d=d+nozzle,h=l+gap,center=true);
  cylinder(d=11,h=1.5*l,center=true);
  if(ts)
  for (i=[0:3])
    mirror([0,0,floor(i/2)])mirror([0,i%2,0]){
      translate([-d,8.5,-ts])
        cube([2*d,1.5,3]);
        translate([cs-1-r+.1,8.5-r,-ts])
          difference(){
            union(){
              cube([r+1,1.5+r,3]);
              translate([r,.1,0])mirror([0,90,0])cube([1,d/2+1.5,3]);
            }
            translate([0,0,-.1])cylinder(r=r,h=3.2,$fn=16);
          }
    }
}
module nutMhex(d){
  if (d==3)
    cylinder(d=6+2*nozzle,h=2.4+.1,$fn=6);
  else
  if (d==4)
    cylinder(d=7.7+2*nozzle,h=3.2+.1,$fn=6);
  else
  if (d==5)
    cylinder(d=8.8+2*nozzle,h=4+.1,$fn=6);
  else
    cylinder(d=d*1.8+2*nozzle,h=d+.1,$fn=6);
}
module pie(r,h,a){
  module cb(n){
    translate([-r*floor(n/2),-r*(n%2),0])cube([r,r,h]);
  }
  intersection(){
    cylinder(r=r,h=h);
    union(){
      rotate([0,0,a])cb(1);
      for (i=[[90,0],[180,2],[270,3]])
        if (a%360>i[0]) cb(i[1]);
    }
    if (a%360<90) cb(0);
  }
}
module trapezoid(s=[2,2,2],t=[1,1]){
  translate([-s[0]/2,-s[1]/2,0])
  intersection(){
    hull(){
      translate([0,0,-1])cube([s[0],s[1],1]);
      assign(x=t[0]?t[0]:s[0],y=t[1]?t[1]:s[1])
      translate([(s[0]-x)/2,(s[1]-y)/2,s[2]-1])cube([x,y,1]);
    }
    cube(s);
  }
}
module chain(h=12.8){
  for(i=[0,1])mirror([i,0,0])
    difference(){
      union(){
        translate([6.45,0,0])
          hull(){
            translate([0,6.73,h/2])rotate([0,90,0])cylinder(h=2,d=h,$fn=64);
            translate([0,-8.4,0])cube([4.75,11.1,h]);
            translate([0,-13.1,0])cube([4.75,1,1]);
            translate([0,-9.15,h/2])
              rotate([0,90,0])cylinder(h=4.75,d=7.95,$fn=64);
          }
          union(){
            translate([0,-3.8,0])cube([6.45+.1,6.5,5]);
            translate([0,-2.8,0])cube([6.45+.1,3.2,h]);
          }
      }
      translate([6.45,0,0]){
        translate([2,2.7,-.1])cube([3,12,13]);
        translate([-.1,-9.15,h/2])
          rotate([0,90,0])difference(){
            translate([0,0,-6.45])cylinder(h=2.4+6.45,d=14,$fn=64);
            translate([0,0,1.15])cylinder(h=1.2+.1,d1=5.2,d2=5.8,$fn=64);
          }
        translate([.75,6.73,h/2])rotate([0,90,0])cylinder(h=1.3,d1=5.6,d2=6.4,$fn=64);
        translate([-.1,-3.8,-.1])mirror([0,1,0])cube([2.4,11.2,2]);
      }
      hull(){
        translate([6.45-2,3,1.9+2])rotate([90,0,0]){
          cylinder(d=4,h=7,$fn=64);
          translate([0,5,0])cylinder(d=4,h=7,$fn=64);
        }
        translate([-.1,-4,1.9])cube([1,10,9]);
      }
    }
}
