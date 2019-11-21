//Radius of the wheel
wheel_radius=15.5;

//Height of the wheel
wheel_height=10;

//Number of steps on the wheel for grip and numbers
wheel_steps=8;

//When printing steps numbers, which number to start with (offset from 0)
wheel_steps_start=0;

//Lenth of the rod
rod_length=40;

//External radius of the rod
rod_radius=3.40;

//Number of sides of the rod. Example 6 for hexagon.
rod_sides=6;

//Text size
text_size=7;

//Text Depth
text_depth=3;

//Print angles values with a 0.1 precision instead of the step numbers
text_print_angles=false;

$fn=30;

module regular_polygon(order, r=1){
 	angles=[ for (i = [0:order-1]) i*(360/order) ];
 	coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
 	polygon(coords);
 }
 
 
union() {
    translate([0,0,wheel_height]) linear_extrude(rod_length) regular_polygon(rod_sides,rod_radius);
 
     difference() {
         cylinder(wheel_height,wheel_radius,wheel_radius);
         grip_radius=2*3.14*wheel_radius/4/wheel_steps;
         grip_translate=wheel_radius+1/3*grip_radius;
         text_translate=wheel_radius*0.9;
         for(count=[0:1:wheel_steps-1]) {
             angle=360/wheel_steps*count;
             num=count+wheel_steps_start;
             rotate(angle,[0,0,1]) {
                 translate([grip_translate,0,0]) cylinder(10,grip_radius,grip_radius);
             }
             rotate(angle+360/wheel_steps/2,[0,0,1]) {
                 text_content=(text_print_angles?str(floor(10*angle)/10):str(num));
                 translate([text_translate,0,text_depth]) rotate(180,[1,0,0]) rotate(90,[0,0,1]) linear_extrude(text_depth) text(str(text_content),size=text_size,halign="center");
             }
         }
     }
 }