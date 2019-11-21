
//Scale factor (1 = millimeters, 25.4 = inches)
_scale = 1;
//Resolution
$fn = 64;

/* [Cup Size] */

//The outside diameter of the pencil holder
OD = 100;
//The inside diameter of the pencil holder
ID = 85;
//The thickness of the base and the ring around the top
base_t = 5;
//The height of the pencil holderh
h = 120;

/* [Spirals] */

//How many spirals
spirals = 20;
//The degrees that the spirals will twist
t = 90;

scale(_scale) render_pencil_holder();

/* [ Hidden ] */
_render = false;
//Spiral_Diameter
sd = (OD-ID)/3;

module pencil_holder(){
  //The base
  cylinder(d = OD, h = base_t);
  //The ring around the top of the pencil holder
  translate([0,0,h-base_t]) difference(){
    cylinder(d = OD, h = base_t);
    cylinder(d = ID, h = base_t);
  }
  translate([0,0,base_t])
    linear_extrude(height = h-2*base_t, twist = t)
      for(i = [0:360/spirals:360])
        rotate(i)
          translate([(OD+ID)/4,0,0])
            circle(d = sd);

}
module render_pencil_holder(){
  if(_render)
    render(){
      pencil_holder();
    }
  else
    pencil_holder();
}
