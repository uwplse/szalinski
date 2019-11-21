/*

 program to make containers from
simple motifs - 3x3, 4x4, 5x5, 
and 6x6 arrays of squares

based on the method used to make
hexagonal boxes - see thingiverse
thing:77843

the code is somewhat parametric
choices are the length, width, and
height of the rods making up the squares;
one of the 4 sets of arrays of squares;
and whether the box is a half height cube
or a full height cube

parameters

l, w, and h length width and height
            of basic rod (l + 10% overlap)

note: limited to values of h which are near w

values that worked well on the Replicator
were l = 6, w = 2 and h = 2 or
     l = 8, w = 2 and h = 2 or
     l = 10, w = 2 and h = 2 
which make boxes with bigger and bigger
openings -


mark choses array and height

mark = 1 3x3 array - half height
mark = 2 4x4 array - half height
mark = 3 5x5 array - half height
mark = 4 6x6 array - half height

mark = 11 3x3 array - full height
mark = 12 4x4 array - full height
mark = 13 5x5 array - full height
mark = 14 6x6 array - full height

mark = 21 3x3 array - double height
pcm

*/


// choose parameters

  l = 6;
  w = 2;
  h = w;

mark = 1;



// start of code

if (mark == 3)
union()
{
translate([0,0,-w])
   for  ( i =[
         [0,0,90],[0,0,180],[0,0,270],
           [0,0,0],])
{
         rotate(i)
          fivex5();
}
for ( j = [
     [0,90,0],[0,90,90],[0,90,180],
     [0,90,270],
    ])
{
   rotate(j)
   translate([0,0,5*l-w/2])
   rotate([0,0,90])
   for  ( i =[
    [0,0,0],[0,0,90],
             ])
 {
         rotate(i)
        fivex5();
}}}

else

if (mark==2)
union()
{
translate([0,0,-w])
   for  ( i =[
         [0,0,90],[0,0,180],[0,0,270],
           [0,0,0],])
{
         rotate(i)
          fourx4();
}
for ( j = [

     [0,90,0],[0,90,90],[0,90,180],
     [0,90,270],
    ])
{
   rotate(j)
   translate([0,0,4*l-w/2])
   rotate([0,0,90])
   for  ( i =[
    [0,0,0],[0,0,90],
             ])
 {
         rotate(i)
          fourx4();
}}}

else

if (mark==1)
union()
{
translate([0,0,-w])
   for  ( i =[
         [0,0,90],[0,0,180],[0,0,270],
           [0,0,0],])
{
         rotate(i)
          threex3();
}

for ( j = [

     [0,90,0],[0,90,90],[0,90,180],
     [0,90,270],
    ])
{
   rotate(j)
   translate([0,0,3*l-w/2])
   rotate([0,0,90])
   for  ( i =[
    [0,0,0],[0,0,90],
             ])
 {
         rotate(i)
          threex3();
}}}

else

if (mark==4)

union()
{
translate([0,0,-w])
   for  ( i =[
         [0,0,90],[0,0,180],[0,0,270],
           [0,0,0],])
{
         rotate(i)
          sixx6();
}

for ( j = [

     [0,90,0],[0,90,90],[0,90,180],
     [0,90,270],
    ])
{
   rotate(j)
   translate([0,0,6*l-w/2])
   rotate([0,0,90])
   for  ( i =[
    [0,0,0],[0,0,90],
             ])
 {
         rotate(i)
          sixx6();
}
}
}

else

if (mark == 13)
union()
{
translate([0,0,-5*l-w])
   for  ( i =[
         [0,0,90],[0,0,180],[0,0,270],
           [0,0,0],])
{
         rotate(i)
          fivex5();
}
for ( j = [
     [0,90,0],[0,90,90],[0,90,180],
     [0,90,270],
    ])
{
   rotate(j)
   translate([0,0,5*l-w/2])
   rotate([0,0,90])
   for  ( i =[
    [0,0,0],[0,0,90],
    [0,0,180],[0,0,270],
             ])
 {
         rotate(i)
        fivex5();
}}}

else

if (mark==12)
union()
{
translate([0,0,-4*l-w])
   for  ( i =[
         [0,0,90],[0,0,180],[0,0,270],
           [0,0,0],])
{
         rotate(i)
          fourx4();
}
for ( j = [

     [0,90,0],[0,90,90],[0,90,180],
     [0,90,270],
    ])
{
   rotate(j)
   translate([0,0,4*l-w/2])
   rotate([0,0,90])
   for  ( i =[
    [0,0,0],[0,0,90],
    [0,0,180],[0,0,270],
             ])
 {
         rotate(i)
          fourx4();
}}}


else

if (mark==11)
union()
{
translate([0,0,-3*l-w])
   for  ( i =[
         [0,0,90],[0,0,180],[0,0,270],
           [0,0,0],])
{
         rotate(i)
          threex3();
}

for ( j = [

     [0,90,0],[0,90,90],[0,90,180],
     [0,90,270],
    ])
{
   rotate(j)
   translate([0,0,3*l-w/2])
   rotate([0,0,90])
   for  ( i =[
    [0,0,0],[0,0,90],
     [0,0,180],[0,0,270],
             ])
 {
         rotate(i)
          threex3();
}}}




else

if (mark==14)

union()
{
translate([0,0,-6*l-w])
   for  ( i =[
         [0,0,90],[0,0,180],[0,0,270],
           [0,0,0],])
{
         rotate(i)
          sixx6();
}

for ( j = [

     [0,90,0],[0,90,90],[0,90,180],
     [0,90,270],
    ])
{
   rotate(j)
   translate([0,0,6*l-w/2])
   rotate([0,0,90])
   for  ( i =[
    [0,0,0],[0,0,90],
    [0,0,180],[0,0,270],
             ])
 {
         rotate(i)
          sixx6();
}
}
}

else
if (mark==21)
union()
{
translate([0,0,-3*l-w])
   for  ( i =[
         [0,0,90],[0,0,180],[0,0,270],
           [0,0,0],])
{
         rotate(i)
          threex3();
}

for ( j = [

     [0,90,0],[0,90,90],[0,90,180],
     [0,90,270],
    ])
{
   rotate(j)
   translate([0,0,3*l-w/2])
   rotate([0,0,90])
   for  ( i =[
    [0,0,0],[0,0,90],
     [0,0,180],[0,0,270],
             ])
 {
         rotate(i)
          threex3();
}}

for ( k = [

     [0,90,0],[0,90,90],[0,90,180],
     [0,90,270],
    ])
{
   rotate(k)
   translate([-6*l,0,3*l-w/2])
   rotate([0,0,90])
   for  ( i =[
    [0,0,0],[0,0,90],
     [0,0,180],[0,0,270],
             ])
 {
         rotate(i)
          threex3();
}}
}



// end of code - modules below

module fivex5()
{
linear_extrude(height=h)
translate ([l/2,0,0])
   union()
   {

 translate([        0.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        0.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([       -0.5*l,       0.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        0.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        1.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        2.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        2.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        2.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        3.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        3.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        3.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        4.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        4.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        4.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        4.5*l,       1.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        4.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        3.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        3.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        2.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        1.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        0.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        0.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([       -0.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([       -0.5*l,       2.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        0.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        0.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        2.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        3.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        3.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        3.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        3.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        4.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        4.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        4.5*l,       3.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        4.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        3.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        3.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        2.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        1.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        0.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        0.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([       -0.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([       -0.5*l,       4.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        0.0*l,       5.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        0.5*l,       4.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       5.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.5*l,       4.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       5.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        2.5*l,       4.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        3.0*l,       5.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        3.5*l,       4.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        4.0*l,       5.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        4.5*l,       4.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

    }
}


module fourx4()
{
linear_extrude(height=h)
translate ([l/2,0,0])
   union()
   {

 translate([        0.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        0.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([       -0.5*l,       0.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        0.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        1.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        2.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        2.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        2.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        3.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        3.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        3.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        3.5*l,       1.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        3.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        2.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        1.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        0.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        0.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([       -0.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([       -0.5*l,       2.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        0.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        0.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        2.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        2.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        3.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        3.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        3.5*l,       3.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        3.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        2.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        1.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        0.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        0.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([       -0.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

    }
}

module threex3()
{
linear_extrude(height=h)
translate ([l/2,0,0])

   union()
   {

 translate([        0.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        0.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([       -0.5*l,       0.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        0.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        1.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        2.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        2.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        2.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        2.5*l,       1.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        2.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        1.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        0.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        0.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([       -0.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([       -0.5*l,       2.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        0.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        0.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        2.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

    }
}

module sixx6()
{
linear_extrude(height=h)
translate ([l/2,0,0])

   union()
   {

 translate([        0.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        0.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([       -0.5*l,       0.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        0.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        1.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        2.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        2.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        2.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        3.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        3.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        3.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        4.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        4.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        4.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        5.0*l,       0.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        5.5*l,       0.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        5.0*l,       1.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        5.5*l,       1.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        5.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        4.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        4.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        3.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        3.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        2.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        1.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        0.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        0.0*l,       2.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([       -0.5*l,       1.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([       -0.5*l,       2.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        0.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        0.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        2.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        3.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        3.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        4.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        4.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        4.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        4.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        5.0*l,       3.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        5.5*l,       2.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        5.5*l,       3.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        5.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        4.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        4.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        3.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        3.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        2.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        1.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        0.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        0.0*l,       4.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([       -0.5*l,       3.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([       -0.5*l,       4.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        0.0*l,       5.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        0.5*l,       4.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       5.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        1.5*l,       4.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       5.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        2.5*l,       4.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        3.0*l,       5.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        3.5*l,       4.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        4.0*l,       5.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        4.5*l,       4.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        5.0*l,       5.0*l,0])
 rotate([0,0,          0.])
   line(l,w);

 translate([        5.5*l,       4.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        5.5*l,       5.5*l,0])
 rotate([0,0,         90.])
   line(l,w);

 translate([        5.0*l,       6.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        4.5*l,       5.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        4.0*l,       6.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        3.5*l,       5.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        3.0*l,       6.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        2.5*l,       5.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        2.0*l,       6.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        1.5*l,       5.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        1.0*l,       6.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([        0.5*l,       5.5*l,0])
 rotate([0,0,        270.])
   line(l,w);

 translate([        0.0*l,       6.0*l,0])
 rotate([0,0,        180.])
   line(l,w);

 translate([       -0.5*l,       5.5*l,0])
 rotate([0,0,        270.])
   line(l,w);
}}


 module line(l,w)
    {
     square([1.1*l,w],center=true);
    }

