
d1=10; // dimension of ellipse
h=10;   // height of spoon holder

linear_extrude(height = h, twist = 0, slices = 6){
 difference()
 {
     offset(r=2)
{
     resize([d1,d1/2])circle(d=d1);
}
     offset(r=1)
{
     resize([d1,d1/2])circle(d=d1);
}
}

difference()
 {
     offset(r=2)
{

translate([-4,-2.62,0])rotate([0,0,60]) resize([d1,d1/2])circle(d=d1);
}
offset(r=1)
{
translate([-4,-2.62,0])rotate([0,0,60]) resize([d1,d1/2])circle(d=d1);
}
}
difference()
 {
     offset(r=2)
{
 translate([-4,2.5,0])rotate([0,0,120]) resize([d1,d1/2])circle(d=d1);
}
offset(r=1)
{
  translate([-4,2.5,0])rotate([0,0,120]) resize([d1,d1/2])circle(d=d1);
}
}
}
linear_extrude(height = h/3, twist = 0, slices = 6){
resize([d1*1.2,(d1*1.2)/2])circle(d=d1);
     translate([-4,-2.62,0])rotate([0,0,60]) resize([d1*1.2,(d1*1.2)/2])circle(d=d1);
     translate([-4,2.5,0])rotate([0,0,120]) resize([d1*1.2,(d1*1.2)/2])circle(d=d1);
     }