// Written by  akaJes 2016 (c)
// used as sources
//http://www.thingiverse.com/thing:1103976/#remixes
//http://www.thingiverse.com/thing:119616/#files

//xMotor();
/* [general] */
show_assembled=1; //[0:No,1:Yes]
carriage_position=5; //[0:10]

//between centers of flat rod and screw rod
axis_distance=17;
motor_shift=0;
motor_hole_flanges=1; //[0:No,1:Yes]

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
show_idler=1; //[0:No,1:Yes]
show_carriage=1; //[0:No,1:Yes]
show_T8m5=1; //[0:No,1:Yes]
show_endstop=1; //[0:No,1:Yes]
show_tensioner=1; //[0:No,1:Yes]

if (!show_assembled){
  if (show_tensioner){
    translate([-12,30,0])tensioner_clamp();
    translate([28,45,0])tensioner_cap();
    translate([105,85,0])tensioner_knob();
  }
  if (show_endstop){
    translate([55,10,19])rotate([0,90,0])xEndStop();
  }
  if(show_motor){
    translate([0,60,0])
    xMotor();
    //%translate([])import("X-MOTOR_17mm.STL");
  }
  if(show_T8m5){
    translate([-15,60,0])nutT8m5();
    translate([-15,90,0])nutT8m5();
  }
  if(show_idler){
      xIdler();
  }
  if(show_carriage){
    translate([60,00,0])xCarriage();
    //%translate([])import("X-CARRIAGE.STL");
  }
}else 
if(show_assembled==1){
translate([0,0,carriage_height])rotate([0,180,0]){
  if (show_motor){
    xMotor();
    translate([axis_distance+11,23/2,-50])color("silver")cylinder(h=220,d=rod_diameter);
    if(show_T8m5)
      translate([11,11.5,-3.6])color("brown")nutT8m5();
  }
  translate([-180,25,7.5])color("silver"){
    rotate([0,90,0])cylinder(h=220,d=rod_diameter);
    translate([0,0,rod_distance])
      rotate([0,90,0])cylinder(h=220,d=rod_diameter);
  }
  if (show_idler)
  translate([-200,0,0]){
    xIdler(support=0);
    translate([23/2,23/2,-50])color("silver")cylinder(h=220,d=rod_diameter);
    if(show_T8m5)
      translate([23/2+axis_distance,11.5,-3.6])color("brown")nutT8m5();
  }
}
if (show_carriage)
  translate([60+(1-$t)*(carriage_position)*10,13,41-rod_distance])rotate([-90,180,0])
    xCarriage(0);
  if (show_endstop){
    translate([-4,16,0])rotate([0,0,0])color("brown")xEndStop();
    //translate([15,16,-5])rotate([90,-90,0])color("red")EendPCB();
  }
  if (show_tensioner){
    translate([185-axis_distance,17+17/2,carriage_height/2-16/2])rotate([0,0,90])color("brown")tensioner_clamp();
    translate([210,17+17/2,carriage_height/2]){
      rotate([0,-90,0])tensioner_cap();
      translate([.1,0,0])rotate([0,90,0])color("brown")tensioner_knob();
    }
  }
}
/* MODULES */
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
module tensioner_clamp(l=axis_distance,d=tensioner_bearing_diameter){
  nut=3;
  flatm3=nut*1.6+nozzle;
  difference(){
    union(){
      difference(){
        union(){
          translate([0,-1,0])rounded_brick([17,17,16],sides=[1,2,1,2]);
                translate([0,-l/2-16/2,0])
          rounded_brick([7.75,l,16],sides=[0,1,0,1]);
        }
        translate([0,2,8])rotate([0,90,0])cylinder(h=8,r=16/2+3,center=true);
      }
      translate([-9/2+.5,2,8])rotate([0,90,0])cylinder(h=.5,d1=d*2,d2=d+2);
      translate([9/2-.5,2,8])rotate([0,-90,0])cylinder(h=.5,d1=d*2,d2=d+2);
    }
    translate([0,2,8])rotate([0,90,0])
      cylinder(h=18,d=d+nozzle,center=true,$fn=16);
    translate([-17/2-.1,2,8])rotate([0,90,0])
      cylinder(h=1,d1=d*2,d2=d+nozzle);
    translate([17/2+.1-2.5,2,8])rotate([0,90,0])
      nutMhex(d);//cylinder(h=2.5,d=1.8*d+nozzle,$fn=6);
    //translate([-4,-l-3,16/2-flatm3/2])cube([8,nut,flatm3]);
    translate([-4,-l,16/2])rotate([90,0,0])hull(){
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
        if (!support)
          cube([20,thickness+.2,idler_hole_height]);
        else
          for (i=[0:floor(20/sstep)-1])
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
      translate([width/2,rod_axis,0])rounded_brick([width,thickness,23],sides=[0,4,4,4]);
      translate([(shift+36+motor_shift)/2,rod_axis,0])rounded_brick([shift+36+motor_shift,thickness,height],sides=[0,4,4,4]);
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
module xCarriage(g=0){
  width=56;
  height=rod_distance+23;
  hole_dist=23;
  hole_d=4.25;
  lw=30.25;
  th=36.3;
  translate([width/2,0,0])
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

module lm8holder(hole=1,h=9){
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

module prusa_holes(){
  hole_dist=23;
  hole_d=4.25;
  for (i=[0:3])
      mirror([floor(i/2),0,0])mirror([0,i%2,0])
          translate([hole_dist/2,hole_dist/2,0])
            cylinder(d=hole_d,h=20,$fn=36);
}
module graber_holes(){
  hole_dist=30;
  hole_dist2=25;
  hole_d=3.25;
  translate([hole_dist/2,0,0])
  cylinder(d=hole_d,h=20,$fn=36);
  translate([-hole_dist/2,0,0])
  cylinder(d=hole_d,h=20,$fn=36);
  translate([0,-hole_dist2,0])
  cylinder(d=hole_d,h=20,$fn=36);
}
module belt_t2(l=10,w=6){
  step=2;
  d=1;
  cube([l,0.8,w]);
  for (i=[1:l/2-1])
    translate([2*i,0,0])
      hull(){
        translate([-d/2,d/2,0])cube([1,1,w]);
        translate([0,0.6+0.7,0])cylinder(d=1,h=w,$fn=16);
      }
}
module rounded_brick_old(d=[10,10,10],sides=[1,1,1,1]){
  hull()
    for (i=[0:3])
        mirror([floor(i/2),0,0])mirror([0,i%2,0])
          if (sides[i])
            translate([d[0]/2-sides[i],d[1]/2-sides[i],0])
              cylinder(h=d[2],r=sides[i],$fn=36);
          else
            translate([d[0]/2-1,d[1]/2-1,0])
              cube([1,1,d[2]]);
}
module rounded_brick(d=[10,10,10],sides=[1,1,1,1],r=-1,$fn=36){
  module rounded_(d=[10,10,10],sides=[1,1,1,1]){
    if(max(sides)){
      hull()
        for (i=[0:3])
          mirror([floor(i/2),0,0])mirror([0,i%2,0])
            if (sides[i])
              translate([d[0]/2-sides[i],d[1]/2-sides[i],0])
                cylinder(h=d[2],r=sides[i],$fn=$fn);
            else
              translate([d[0]/2-1,d[1]/2-1,0])
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
module lm8uu(ts=7.4,cs=12){
  bearing_d=15;
  bearing_l=24;
  gap=0.6;
  d=15;
  l=24;
  r=2;//pits
  cylinder(d=d+nozzle,h=l+gap,center=true);
  cylinder(d=11,h=1.5*l,center=true);
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
    cylinder(d=2*1.8+2*nozzle,h=d+.1,$fn=6);
}