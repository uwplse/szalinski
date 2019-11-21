// Initialed Heart Ornament
// By Jake Poznanski
// preview[view:north east, tilt:top]

//Enter your two letter initials
initials = "AJ"; 

//The height of the main heart body in mm
height = 3; // [3:10]

//The height of the letters themselves
letter_height = 1; // [1:5]

//Internal variables
heartAngle = 90*1;
size = 14*1;
ratio = 48/28;
elipseSize = [size * ratio,size,height];

//Importing this module directly for Makerbot customizer script
// Spiff Sans
// Author: Stuart P. Bentley <stuart@testtrack4.com>

module spiffsans_puts(letters, count, offsets)
{
  for(i=[0:count-1])
  {
    translate([offsets[i],0,0])
    {
      spiffsans_lookup_draw(letters[i]);
    }
  }
}

module spiffsans_lookup_draw(char)
{
  if(char==" ") {} //silly lookup, space can't be printed
  else if(char =="!") spiffsans_exclaim();
  else if(char =="-") spiffsans_hyphen();
  else if(char ==".") spiffsans_period();
  else if(char =="0") spiffsans_digit_0();
  else if(char =="1") spiffsans_digit_1();
  else if(char =="2") spiffsans_digit_2();
  else if(char =="3") spiffsans_digit_3();
  else if(char =="4") spiffsans_digit_4();
  else if(char =="5") spiffsans_digit_5();
  else if(char =="6") spiffsans_digit_6();
  else if(char =="7") spiffsans_digit_7();
  else if(char =="8") spiffsans_digit_8();
  else if(char =="9") spiffsans_digit_9();
  else if(char ==":") spiffsans_colon();
  else if(char =="?") spiffsans_question();
  else if(char =="A" || char == "a") spiffsans_capital_a();
  else if(char =="B" || char == "b") spiffsans_capital_b();
  else if(char =="C" || char == "c") spiffsans_capital_c();
  else if(char =="D" || char == "d") spiffsans_capital_d();
  else if(char =="E" || char == "e") spiffsans_capital_e();
  else if(char =="F" || char == "f") spiffsans_capital_f();
  else if(char =="G" || char == "g") spiffsans_capital_g();
  else if(char =="H" || char == "h") spiffsans_capital_h();
  else if(char =="I" || char == "i") spiffsans_capital_i();
  else if(char =="J" || char == "j") spiffsans_capital_j();
  else if(char =="K" || char == "k") spiffsans_capital_k();
  else if(char =="L" || char == "l") spiffsans_capital_l();
  else if(char =="M" || char == "m") spiffsans_capital_m();
  else if(char =="N" || char == "n") spiffsans_capital_n();
  else if(char =="O" || char == "o") spiffsans_capital_o();
  else if(char =="P" || char == "p") spiffsans_capital_p();
  else if(char =="Q" || char == "q") spiffsans_capital_q();
  else if(char =="R" || char == "r") spiffsans_capital_r();
  else if(char =="S" || char == "s") spiffsans_capital_s();
  else if(char =="T" || char == "t") spiffsans_capital_t();
  else if(char =="U" || char == "u") spiffsans_capital_u();
  else if(char =="V" || char == "v") spiffsans_capital_v();
  else if(char =="W" || char == "w") spiffsans_capital_w();
  else if(char =="X" || char == "x") spiffsans_capital_x();
  else if(char =="Y" || char == "y") spiffsans_capital_y();
  else if(char =="Z" || char == "z") spiffsans_capital_z();
  else echo(str("Unknown character: ", char));
}

module spiffsans_exclaim()
{
  polygon(points=[[0,3],[0,10],[2,10],[2,3],[0,0],[0,2],[2,2],[2,0]],paths=[[0,1,2,3],[4,5,6,7]]);
}

module spiffsans_hyphen()
{
  polygon(points=[[0,4],[0,6],[4,6],[4,4]],paths=[[0,1,2,3]]);
}

module spiffsans_period()
{
  polygon(points=[[0,0],[0,2],[2,2],[2,0]],paths=[[0,1,2,3]]);
}

module spiffsans_digit_0()
{
  polygon(points=[[5,0],[1,0],[0,2],[0,8],[1,10],[5,10],[6,8],[6,2],[2,8],[4,8],[2,5],[2,2],[4,5],[4,2]],paths=[[0,1,2,3,4,5,6,7],[8,9,10],[11,12,13]]);
}

module spiffsans_digit_1()
{
  polygon(points=[[0,0],[0,2],[2,2],[2,7],[0,7],[2,10],[4,10],[4,2],[5,2],[5,0]],paths=[[0,1,2,3,4,5,6,7,8,9]]);
}

module spiffsans_digit_2()
{
  polygon(points=[[0,0],[0,2],[4,6],[4,8],[2,8],[2,6],[0,6],[0,8],[1,10],[5,10],[6,8],[6,5.5],[2.5,2],[6,2],[6,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]]);
}

module spiffsans_digit_3()
{
  polygon(points=[[1,0],[0,2],[0,4],[2,4],[2,2],[4,2],[4,4],[3,4],[3,6],[4,6],[4,8],[2,8],[2,6],[0,6],[0,8],[1,10],[5,10],[6,8],[6,6],[5.5,5],[6,4],[6,2],[5,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]]);
}

module spiffsans_digit_4()
{
  polygon(points=[[4,0],[4,4],[0,4],[0,10],[2,10],[2,6],[4,6],[4,10],[6,10],[6,0]],paths=[[0,1,2,3,4,5,6,7,8,9]]);
}

module spiffsans_digit_5()
{
  polygon(points=[[0,0],[0,2],[4,2],[4.5,3],[4,4],[0,4],[0,10],[6,10],[6,8],[2,8],[2,6],[5,6],[6,4],[6,2],[5,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]]);
}

module spiffsans_digit_6()
{
  polygon(points=[[1,0],[0,2],[0,8],[1,10],[5,10],[5.5,8],[2,8],[2,6],[5,6],[6,4],[6,2],[5,0],[2,2],[2,4],[4,4],[4,2]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11],[12,13,14,15]]);
}

module spiffsans_digit_7()
{
  polygon(points=[[1,0],[1,3],[3,8],[0,8],[0,10],[5,10],[5,8],[3,3],[3,0]],paths=[[0,1,2,3,4,5,6,7,8]]);
}

module spiffsans_digit_8()
{
  polygon(points=[[1,0],[0,2],[0,4],[0.5,5],[0,6],[0,8],[1,10],[5,10],[6,8],[6,6],[5.5,5],[6,4],[6,2],[5,0],[2,6],[2,8],[4,8],[4,6],[2,2],[2,4],[4,4],[4,2]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13],[14,15,16,17],[18,19,20,21]]);
}

module spiffsans_digit_9()
{
  polygon(points=[[1,0],[0,2],[4,2],[4,4],[1,4],[0,6],[0,8],[1,10],[5,10],[6,8],[6,2],[5,0],[2,6],[2,8],[4,8],[4,6]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11],[12,13,14,15]]);
}

module spiffsans_colon()
{
  polygon(points=[[0,6],[0,8],[2,8],[2,6],[0,2],[0,4],[2,4],[2,2]],paths=[[0,1,2,3],[4,5,6,7]]);
}

module spiffsans_question()
{
  polygon(points=[[2,3],[4,6],[4,8],[2,8],[2,6],[0,6],[0,8],[2,10],[4,10],[6,8],[6,6],[4,3],[2,0],[2,2],[4,2],[4,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11],[12,13,14,15]]);
}

module spiffsans_capital_a()
{
  polygon(points=[[0,0],[0,8],[1,10],[5,10],[6,8],[6,0],[4,0],[4,4],[2,4],[2,0],[2,6],[2,8],[4,8],[4,6]],paths=[[0,1,2,3,4,5,6,7,8,9],[10,11,12,13]]);
}

module spiffsans_capital_b()
{
  polygon(points=[[0,0],[0,10],[5,10],[6,8],[6,6],[5.5,5],[6,4],[6,2],[5,0],[2,6],[2,8],[4,8],[4,6],[2,2],[2,4],[4,4],[4,2]],paths=[[0,1,2,3,4,5,6,7,8],[9,10,11,12],[13,14,15,16]]);
}

module spiffsans_capital_c()
{
  polygon(points=[[6,0],[1,0],[0,2],[0,8],[1,10],[6,10],[6,8],[2,8],[2,2],[6,2]],paths=[[0,1,2,3,4,5,6,7,8,9]]);
}

module spiffsans_capital_d()
{
  polygon(points=[[0,0],[0,10],[5,10],[6,8],[6,2],[5,0],[2,2],[2,8],[4,8],[4,2]],paths=[[0,1,2,3,4,5],[6,7,8,9]]);
}

module spiffsans_capital_e()
{
  polygon(points=[[0,0],[0,10],[5,10],[5,8],[2,8],[2,6],[4,6],[4,4],[2,4],[2,2],[5,2],[5,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11]]);
}

module spiffsans_capital_f()
{
  polygon(points=[[0,0],[0,10],[5,10],[5,8],[2,8],[2,6],[4,6],[4,4],[2,4],[2,0]],paths=[[0,1,2,3,4,5,6,7,8,9]]);
}

module spiffsans_capital_g()
{
  polygon(points=[[6,0],[1,0],[0,2],[0,8],[1,10],[5.5,10],[6,8],[2,8],[2,2],[4,2],[4,6],[6,6]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11]]);
}

module spiffsans_capital_h()
{
  polygon(points=[[0,0],[0,10],[2,10],[2,6],[4,6],[4,10],[6,10],[6,0],[4,0],[4,4],[2,4],[2,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11]]);
}

module spiffsans_capital_i()
{
  polygon(points=[[0,0],[0,2],[1.5,2],[1.5,8],[0,8],[0,10],[5,10],[5,8],[3.5,8],[3.5,2],[5,2],[5,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11]]);
}

module spiffsans_capital_j()
{
  polygon(points=[[0.5,0],[0,1],[0,4],[2,4],[2,2],[4,2],[4,8],[0,8],[0,10],[6,10],[6,1],[5.5,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11]]);
}

module spiffsans_capital_k()
{
  polygon(points=[[0,0],[0,10],[2,10],[2,6],[4,6],[4,10],[6,10],[6,6],[5,5],[6,4],[6,0],[4,0],[4,4],[2,4],[2,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]]);
}

module spiffsans_capital_l()
{
  polygon(points=[[0,0],[0,10],[2,10],[2,2],[5,2],[5,0]],paths=[[0,1,2,3,4,5]]);
}

module spiffsans_capital_m()
{
  polygon(points=[[0,0],[0,8],[1,10],[9,10],[10,8],[10,0],[8,0],[8,8],[6,8],[6,0],[4,0],[4,8],[2,8],[2,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13]]);
}

module spiffsans_capital_n()
{
  polygon(points=[[0,0],[0,8],[1,10],[5,10],[6,8],[6,0],[4,0],[4,8],[2,8],[2,0]],paths=[[0,1,2,3,4,5,6,7,8,9]]);
}

module spiffsans_capital_o()
{
  polygon(points=[[5,0],[1,0],[0,2],[0,8],[1,10],[5,10],[6,8],[6,2],[2,2],[2,8],[4,8],[4,2]],paths=[[0,1,2,3,4,5,6,7],[8,9,10,11]]);
}

module spiffsans_capital_p()
{
  polygon(points=[[0,0],[0,10],[5,10],[6,8],[6,6],[5,4],[2,4],[2,0],[2,6],[2,8],[4,8],[4,6]],paths=[[0,1,2,3,4,5,6,7],[8,9,10,11]]);
}

module spiffsans_capital_q()
{
  polygon(points=[[1,0],[0,2],[0,8],[1,10],[5,10],[6,8],[6,0],[2,2],[2,8],[4,8],[4,2]],paths=[[0,1,2,3,4,5,6],[7,8,9,10]]);
}

module spiffsans_capital_r()
{
  polygon(points=[[0,0],[0,10],[5,10],[6,8],[6,6],[5.5,5],[6,4],[6,0],[4,0],[4,4],[2,4],[2,0],[2,6],[2,8],[4,8],[4,6]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11],[12,13,14,15]]);
}

module spiffsans_capital_s()
{
  polygon(points=[[1,0],[0,2],[0,3],[2,3],[2,2],[4,2],[4,4],[1,4],[0,5],[0,8],[1,10],[5,10],[6,8],[6,7],[4,7],[4,8],[2,8],[2,6],[5,6],[6,5],[6,2],[5,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]]);
}

module spiffsans_capital_t()
{
  polygon(points=[[2,0],[2,8],[0,8],[0,10],[6,10],[6,8],[4,8],[4,0]],paths=[[0,1,2,3,4,5,6,7]]);
}

module spiffsans_capital_u()
{
  polygon(points=[[1,0],[0,2],[0,10],[2,10],[2,2],[4,2],[4,10],[6,10],[6,2],[5,0]],paths=[[0,1,2,3,4,5,6,7,8,9]]);
}

module spiffsans_capital_v()
{
  polygon(points=[[2,0],[0,4],[0,10],[2,10],[2,4],[4,4],[4,10],[6,10],[6,4],[4,0]],paths=[[0,1,2,3,4,5,6,7,8,9]]);
}

module spiffsans_capital_w()
{
  polygon(points=[[9,0],[1,0],[0,2],[0,10],[2,10],[2,2],[4,2],[4,10],[6,10],[6,2],[8,2],[8,10],[10,10],[10,2]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13]]);
}

module spiffsans_capital_x()
{
  polygon(points=[[0,0],[0,4],[1,5],[0,6],[0,10],[2,10],[2,6],[4,6],[4,10],[6,10],[6,6],[5,5],[6,4],[6,0],[4,0],[4,4],[2,4],[2,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]]);
}

module spiffsans_capital_y()
{
  polygon(points=[[2,0],[2,4],[1,4],[0,6],[0,10],[2,10],[2,6],[4,6],[4,10],[6,10],[6,6],[5,4],[4,4],[4,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13]]);
}

module spiffsans_capital_z()
{
  polygon(points=[[0,0],[0,2],[3,8],[0,8],[0,10],[5,10],[5,8],[2,2],[5,2],[5,0]],paths=[[0,1,2,3,4,5,6,7,8,9]]);
}


union()
{

translate([0,0,height])
scale([size/10,size/10,1])
linear_extrude(height=letter_height)
rotate(heartAngle+(90-heartAngle)/2+45)
translate([-2.0*(size/10)-5, -size/20,0])
spiffsans_puts(initials, 2, [0,10]);

union(){
intersection(){

union(){
scale(elipseSize)
cylinder(h = 1, r = 1,$fn=60);

rotate(heartAngle)
scale(elipseSize)
cylinder(h = 1, r = 1,$fn=60);
}

rotate(heartAngle+(90-heartAngle)/2+45)
translate([-elipseSize.x,0,-height/2])
cube(size = elipseSize*2);
}

intersection(){

intersection(){
scale(elipseSize)
cylinder(h = 1, r = 1,$fn=60);

rotate(heartAngle)
scale(elipseSize)
cylinder(h = 1, r = 1,$fn=60);
}

rotate(heartAngle+(90-heartAngle)/2+45)
translate([-elipseSize.x,-elipseSize.x,-height/2])
cube(size = elipseSize*2);
}
}


}
