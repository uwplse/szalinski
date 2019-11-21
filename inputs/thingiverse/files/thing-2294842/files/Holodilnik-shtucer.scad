W=1.2;  //толщина стенок

D1=11; //диаметр трубки 
L1=10; //длина трубки
L_1=1; //продолжение фланца после поворота

F_L=2; //длина перехода соединения трубок

D2=10;   //диаметр второй трубки  
L2=12;  //длина второй трубки

A=60;   //угол поворота

$fn=45;

module pipe1(){
  difference(){
      circle(d=D1);
      circle(d=D1-W*2);
  }
}


module pipe2(){
  difference(){
      circle(d=D2);
      circle(d=D2-W*2);
  }
}



    translate([D1/2,0,-L_1])rotate([90,180,0]){
        rotate_extrude(angle=A, convexity=1)translate([D1/2, 0]) pipe1();

        translate([D1/2,0,0])rotate([90,0,0])linear_extrude(L_1)pipe1();
        rotate([90,0,A+180])translate([-D1/2,0,0])linear_extrude(L1)pipe1();
    }
    

difference(){
    hull(){
        cylinder(d=D1,h=0.1);
        translate([0,0,F_L])cylinder(d=D2,h=0.1);
    }
    hull(){
        translate([0,0,-0.1])cylinder(d=D1-W*2,h=0.1);
        translate([0,0,F_L+0.1])cylinder(d=D2-W*2,h=0.1);
    }

}

translate([0,0,F_L])
    difference(){
        cylinder(d=D2,h=L2);
        translate([0,0,-0.1])cylinder(d=D2-W*2,h=L2+0.2);
    }  

/*difference(){
#hull(){
    cylinder(d=D1,h=0.1);
    rotate([90+A,0,0])cylinder(d=D1,h=0.1);
}

hull(){
    cylinder(d=D1-W*2,h=0.1);
    rotate([90+A,0,0])cylinder(d=D1-W*2,h=0.1);
}
}


difference(){
    cylinder(d=D1,h=L1);
    cylinder(d=D1-W*2,h=L1);
}


rotate([90+A,0,0])difference(){
    cylinder(d=D2,h=L2);
    cylinder(d=D2-W*2,h=L2);
}
*/