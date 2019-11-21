
Left_heart_letter = "A"; //Just one letter
Rigth_heart_letter = "B";//Just one letter

linear_extrude(height = 8)
 
  translate([8, 8]) {
     
   text(Left_heart_letter);
 }
 
 linear_extrude(height = 10)
  translate([28, -8]) {
   text(Rigth_heart_letter);
 }


module flatstuff()
{
square(20);
translate([10,20,0]) circle(10);
translate([20,10,0]) circle(10);
}
linear_extrude(height=5) flatstuff();
module flatstuff2()
{
translate([20,-15,0])   
square(20);
translate([30,5,0]) circle(10);
translate([40,-5,0]) circle(10);
}

linear_extrude(height=7) flatstuff2();



difference(){
    translate([55,-5,0]) 
    cylinder(r=6.5, h=6);
    translate([55,-5,0]) 
    cylinder(r=2, h=6);
}

