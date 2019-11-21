/*

  <l4=5 >
  xxxxxxx ^
  xxxxxxx |
  xxxxxxx |
  xxxxxxx |
  xxxxxxx - - - - dia = 5       5     + h2 = 11
  xxxxxxx |                    <l>    |
  xxxxxxx |                    xxx       ^
  xxxxxxx | h3 = 11           xxxx       + h4 = 2
  xxxxxxx v                  xxxxx       v
  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      ^   ^
  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx    |   | gap = 3.2
  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  |   v  
  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxxxx  |   ] ind =   1.0
  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx    |         | h1 = 7
  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx    +         v
  
  <----------- l1 = 21 ----------><- l2 = 9 ->
                                         <l3 >  
*/

e = 0.4;

h1 = 7;
h2 = 12;
h3 = 11;
h4 = 2;
l2 = 8.5;
l3 = 7;
l4 = 5;
l5 = 2;
gap = 3.2;
ind = 1.0;
dia = 5;
taper=2;

//l1 = 21;
l1 = 10;

height = 20;

outline1 = [[0,0],[l1,0],[l1,h1-gap],
           [l1+l2-l3,h1-gap],[l1+l2-l3,h1-gap-ind],[l1+l2,h1-gap-ind],[l1+l2,h1-gap],
           [l1,h1],[l1,h1+h4],[l1-l5,h1+h4],[l1-l5-h4,h1],[l4,h1],[l4,h1+h3],[0,h1+h3] ];
outline2 = [[0,0],[l1,0],[l1,h1-gap],
           [l1+l2,h1-gap],[l1+l2,h1-gap/2],[l1+l2-gap/2,h1],/*[l1+l2,h1], */
           [l1,h1],[l1,h1+h4],[l1-l5,h1+h4],[l1-l5-h4,h1],[l4,h1],[l4,h1+h3],[0,h1+h3] ];
outline3 = [[0,0],[l1-l5-h4,0],
           [l1-l5-h4,h1],[l4,h1],[l4,h1+h3],[0,h1+h3] ];

rotate([0,0,-90])difference(){
    union(){
        translate([0,0, 0])linear_extrude(5)polygon(outline1);
        translate([0,0, 5])linear_extrude(1)polygon(outline3);
        translate([0,0, 6])linear_extrude(8)polygon(outline2);
        translate([0,0,14])linear_extrude(1)polygon(outline3);
        translate([0,0,15])linear_extrude(5)polygon(outline1);
    }
    translate([0,h2,height/2])rotate([0,90,0])cylinder(h=l4-taper,d=dia,$fn=36);
    translate([l4-taper,h2,height/2])rotate([0,90,0])cylinder(h=taper,d1=dia,d2=dia+2*taper,$fn=36);
}
  