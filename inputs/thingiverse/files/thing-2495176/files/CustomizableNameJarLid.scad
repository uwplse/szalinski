$fn=150;

external_radius=28;
internal_radius=26.25;
half_c_distance_plus_seven_point_five=32.25;

content="THYME";
font="Arial";
font_size=8;

x=-18;
y=-4;

difference() {
    cylinder (r=external_radius,h=10);
    translate ([0,0,1])
    cylinder (r=internal_radius,h=10);
  rotate ([180,0,0])
  translate ([x,y,-0.4])
  linear_extrude(height=1) 
    {text(content,font=font,size=font_size);}
    }
intersection() {
  cylinder (r=internal_radius,h=10);
    translate ([-half_c_distance_plus_seven_point_five,0,8.6])
    cylinder (d=15,h=1.4);}
intersection() {
  cylinder (r=internal_radius,h=10);
    translate ([half_c_distance_plus_seven_point_five,0,8.6])
    cylinder (d=15,h=1.4);}
intersection() {
  cylinder (r=internal_radius,h=10);
    translate ([0,-half_c_distance_plus_seven_point_five,8.6])
    cylinder (d=15,h=1.4);}
intersection() {
  cylinder (d=52.5,h=10);
     translate ([0,half_c_distance_plus_seven_point_five,8.6])
     cylinder (d=15,h=1.4);}