element = "Rotor";//[Rotor, Bottom case, Top case, Bearring holder, Engine holder, Assembled]

base_r = 25;
base_h = 2/1;

blade_num = 10;
blade_h = 22;

engine_shaft_r = 4;
engine_shaft_h = 8;

paddle_l = base_r*0.7;

paddle_h = blade_h;
paddle_num = blade_num;
$fn = 50;

screw_r =  1.5;

holl_r = screw_r + 0.2;
nut_r = 3;
nut_h = 3;

bearing_r = 5.2;
bearing_h = 4.2;
bearing_heat_r = bearing_r +  4.5;


case_inside_r = base_r + 0;
case_inside_h = paddle_h + 2;

case_wall = 3;

case_outside_r = case_inside_r + case_wall;
case_outside_h = case_inside_h + case_wall * 2 ;

output_width = 14;

wylot_h = case_outside_h;
wyl_holl_h = wylot_h - case_wall * 2;
wyl_holl_w = output_width;
wylot_w = wyl_holl_w + case_wall * 2;



engine_holl_r = 5.2;
engine_r = 14;
engine_mount_h = 7/1;
engine_mh_d = engine_r + 5;


base_shaft_holder_r = max(engine_shaft_r, nut_h) + case_wall/2;

module base(){
   cylinder(r=base_r, h=base_h, center=true);
}

module paddle(){
   angle = 40;
   intersection() {
      rotate(90, [0, 1, 0]) translate([0, 0, -(paddle_l / 2 * cos(angle)) + base_r]) rotate(angle,[1,0,0]) cube([paddle_h*2, 1, paddle_l], center=true);
      cube([100,100, paddle_h], center = true);
   }
}

//paddle();
//circle_paddle();
module circle_paddle(){
   angle = 40;
   a1 = 30;
   a2 = 90;
   da = a2 - a1;
   rb = paddle_l * 360 / (da * 2 * PI) ;
   rs = rb - (0.4*4);

   x = sin(da) * rb;
   y = cos(da) * rb;

   translate([-x + base_r, -y, 0])intersection() {
      difference() {
         cylinder(r = rb, h = paddle_h * 2, center = true);
         cylinder(r = rs, h = paddle_h * 3, center = true);

         rotate(a1) translate([-rb, rb, 0]) cube([rb*2,rb*2,paddle_h * 3], center = true);
         rotate(180 - a2) translate([-rb, -rb, 0]) cube([rb*2,rb*2,paddle_h * 3], center = true);

         translate([-rb, 0, 0]) cube([rb*2,rb*2,paddle_h * 3], center = true);
         translate([0, -rb, 0]) cube([rb*2,rb*2,paddle_h * 3], center = true);

      }

      cube([rb*2,rb*2, paddle_h], center = true);
   }

}
//circle_paddle();

//rotor();
module rotor(){

   big_holl_h = engine_shaft_h + nut_h*2;

   intersection(){
      translate([0, 0, 0]) union() {
         translate([0, 0, base_h/2]) base();
         for (i=[0:paddle_num]) rotate(i * 360 / paddle_num) translate([0, 0, paddle_h/2]) circle_paddle();
         cylinder(r=base_shaft_holder_r, h = paddle_h - base_shaft_holder_r * 0.7);
         translate([0, 0, paddle_h - base_shaft_holder_r  * 0.7 ]) sphere(r=base_shaft_holder_r);
         sphere(r=base_shaft_holder_r + case_wall/2);
      }
      difference() {
         cylinder(r=base_r, h = paddle_h);
         translate([0, 0, big_holl_h + 0.4*4]) cylinder(r=holl_r, h = paddle_h*2);

         translate([0, 0, paddle_h - nut_h]) cylinder(r=nut_r, h = nut_h);

         cylinder(r=engine_shaft_r, h = big_holl_h);
      }
   }

}


/*difference(){
   rotor();
   translate([0, -50, 0]) cube([100,100,100], center = true);
}*/
module case(){




   //h = paddle_h + 2;
   difference(){
      union(){
          muszla(begin_r = case_outside_r, end_r = case_outside_r + wylot_w/2, h = case_outside_h);
          translate([case_outside_r ,25,0]) cube([wylot_w,50, wylot_h], center = true);

          for (p=[0:3])
          for (i=[case_inside_h/2 , -case_outside_h/2 ]) translate([0, 0, i]) {
               d = case_outside_r + (p+1) * (wylot_w/2)/4 + holl_r + 2;
               w = case_wall * 2 + holl_r * 2;

               rotate (-90 + 90*p) difference() {
                  union() {
                     translate([-d, -w/2, 0]) cube([d, w, case_wall]);
                     translate([-d, 0, 0]) cylinder(r = holl_r + case_wall, h = case_wall);
                  }
                  translate([-d, 0, 0]) cylinder(r = holl_r, h = case_wall);
               }
         }
      }
      translate([case_outside_r ,40,0]) cube([wyl_holl_w,80,wyl_holl_h], center = true);
      muszla(begin_r = case_inside_r, end_r = case_inside_r + wylot_w/2, h = case_inside_h);

   }
}


/*difference(){
   union(){
      case_bottom();
      //case_top();
   }
   translate([0, -50, 0]) cube([100,100,100], center = true);
}*/

module engine_hat(){
   difference() {
      union() {
         cylinder(r=engine_holl_r +  4.5, h = case_wall ,center=true);
         cube([(engine_mh_d)*2, (holl_r + case_wall)*2 , case_wall], center=true);
         for (i=[0:1]) rotate(i*180) translate([engine_mh_d, 0, 0]) cylinder(r=holl_r + case_wall, h=case_wall, center=true);

      }
      for (i=[0:1]) rotate(i*180) translate([engine_mh_d, 0, 0]) cylinder(r=holl_r, h=50, center=true);
      translate([0, 0, 0]) cylinder(r=engine_holl_r, h = case_wall,center = true);
   }
}
//engine_hat();

module bering_hat(){
   difference() {

      cylinder(r=bearing_heat_r, h = case_wall ,center=true);
      translate([0, 0, -case_wall - (case_wall - bearing_h)]) cylinder(r=bearing_r, h = case_wall,center = true);
      cylinder(r=holl_r, h = case_wall*4 ,center=true);
   }
}
//bering_hat();


//case_top();
module case_top(){
   difference(){
      case();
      translate([0, 0, -case_inside_h/2 - 100/2]) cube([200,200, 100] ,center = true);

      translate([0, 0, case_wall/2 + case_inside_h/2]) cylinder(r=bearing_r, h = case_wall,center = true);

      vent_r = 1;
      vent_big_r = base_r / 7.5;
      vent_num = 10;

      a = 360 / vent_num;
      //vent_d = vent_num * ( 2 * vent_r + case_wall) / (2 * PI);
      //vent_big_d = vent_num * ( 2 * vent_big_r + case_wall) / (2 * PI) - vent_d;

      vent_d = (vent_r + case_wall/2) / sin(a/2);
      vent_big_d = (vent_big_r + case_wall/2) / sin(a/2) - vent_d;

      for (i=[0:vent_num]) {

             rotate(i * 360 / vent_num) translate([vent_d, 0, case_inside_h/2 - case_wall/2]) union(){

                  a = acos((vent_big_r - vent_r) / vent_big_d);
                  b = 180 - a;
                  bd = 180 - b;

                  x1 = cos(bd) * vent_r;
                  y1 = sin(bd) * vent_r;

                  x2 = cos(a) * vent_big_r;
                  y2 = sin(a) * vent_big_r;

                  cylinder(r = vent_r, h = case_wall*2);
                  translate([vent_big_d,0,0]) cylinder(r = vent_big_r, h = case_wall*2);
                  linear_extrude(height = case_wall*2) polygon(points=[[-x1,-y1],[-x1,y1],[-x2 + vent_big_d,y2],[-x2 + vent_big_d,-y2]]);

               }
      }

   }
}
module case_bottom(){

   free_space = 0.2;
   lock_h = 1;

   difference() {
      union() {
         intersection() {
            case();
            translate([0, 0, -case_inside_h/2 - 100/2]) cube([200,200, 100] ,center = true);
         }
         /*translate([0, 0, -case_inside_h/2]) {
            muszla(begin_r = case_inside_r - free_space , end_r = case_inside_r + wylot_w/2 - free_space, h = 2);
            translate([case_outside_r ,25,0]) cube([wyl_holl_w - free_space ,50 - free_space, 2], center = true);
         }*/


         translate([0, 0, -engine_mount_h/2 - case_inside_h/2]) difference(){
            minkowski() {
               r = engine_mount_h/2 * 0.6;
               cylinder(r = engine_mh_d + holl_r - r + case_wall, h = engine_mount_h - r * 2 , center = true);
               sphere(r= r, center=true);
            }


            cylinder(r = engine_r, h = engine_mount_h, center = true);
         }
      }
      translate([0, 0, -case_wall/2 - case_inside_h/2]) cylinder(r=engine_holl_r, h = case_wall,center = true);
      for (i=[0:1]) {
         rotate(i*180) translate([engine_mh_d, 0, -25 - case_inside_h/2 - nut_h - 0.4*4]) cylinder(r=holl_r, h=50, center=true);
         rotate(i*180) translate([engine_mh_d, 0, -nut_h/2 - case_inside_h/2]) cylinder(r=nut_r, h=nut_h, center=true);
      }
   }
}
//case_bottom();

//rotor();
module assembly(){
   rotor();
   translate([0, 0, paddle_h/2]) {
      translate([0, 0, case_outside_h/2 + case_wall/2]) bering_hat();
      case_bottom();
      case_top();
   }

   translate([0, 0, -40]) engine_hat();

}

module print(){
   translate([0, 0, 0]) rotor();



   translate([8, 65, -case_inside_h/2]) rotate(180, [1,0,0]) case_bottom();

   translate([8, -85, case_outside_h/2]) rotate(180, [1,0,0]) case_top();

   translate([base_r + 12, 0, + case_wall/2]) rotate(180, [1,0,0]) bering_hat();
   translate([-base_r -5, 30, + case_wall/2]) rotate(90) engine_hat();

}
//print();

module print_selectable(co = element){
   if("Rotor" == co) rotor();
   if("Bottom case" == co) rotate(180, [1,0,0]) case_bottom();
   if("Top case" == co)  rotate(180, [1,0,0]) case_top();
   if("Bearring holder" == co) rotate(180, [1,0,0]) bering_hat();
   if("Engine holder" == co) rotate(90) engine_hat();
   if("Assembled" == co) assembly();
}
print_selectable();
//print();
/*difference(){
   assembly();
   translate([0, -50, 0]) cube([100,100,100], center = true);
}
*/



module muszla(begin_r = case_outside_r, end_r = case_outside_r + 10, h = case_outside_h){

   step_r = (end_r - begin_r) / $fn;
   //step_a = (2 * PI * begin_r) / $fn;

   function actual_r(stp) = step_r * stp + begin_r;
   function actual_a(stp) = stp * 360 / $fn;

   points = [
      for (i=[0:$fn]) [cos(actual_a(i)) * actual_r(i), sin(actual_a(i)) * actual_r(i)]
   ];

   linear_extrude(height = h, center = true) polygon(points=points);

}
//   muszla();
