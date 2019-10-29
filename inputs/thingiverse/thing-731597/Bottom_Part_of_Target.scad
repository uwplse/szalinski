$fn=50;
width=60;//dont change unless you change the width of the part that goes into this slot
length=80;
total_height=25;
hole_thickness=5.25;//dont change these if your using my other design part unless you change the other part the same
difference()
{
union()

{

translate([-75,-30,0])cube([length,width,total_height/5]);
translate([-45,-25,0])cube([length-50,width-10,total_height/1.25]);
}

rotate([0,90,0])translate([-105,-15,-30])cube([total_height*4,width/1.98347107,5.25]);
}
