// Angle of View
aov=220; // [30:270]

function pa(a) =  a / 2;
function ma(a) =  0 - a / 2;

union() {
  translate([0, 0, 20])
    rotate_extrude(angle = 110, $fn=55)
      translate([16.75, 0])
        circle(1.75);

  translate([0, 0, 20])
    rotate_extrude(angle = -110, $fn=55)
      translate([16.75, 0])
        circle(1.75);

    rotate_extrude(angle = 110, $fn=55)
      translate([17.5, 0])
        circle(2);

    rotate_extrude(angle = -110, $fn=55)
      translate([17.5, 0])
        circle(2);

    rotate_extrude(angle = 110, $fn=55)
      translate([16, 0, 0])
        polygon( points=[[0.5,0],[0,20],[2.5,20],[3.5,0]] );

    rotate_extrude(angle = -110, $fn=55)
      translate([16, 0, 0])
        polygon( points=[[0.5,0],[0,20],[2.5,20],[3.5,0]] );

    rotate_extrude(angle = pa(aov), $fn=55)
      translate([17.5, 0, 0])
        polygon( points=[[2,0],[20,-20],[18,-20],[1,-1]] );

    rotate_extrude(angle = ma(aov), $fn=55)
      translate([17.5, 0, 0])
        polygon( points=[[2,0],[20,-20],[18,-20],[1,-1]] );

    rotate_extrude(angle = pa(aov), $fn=55)
      translate([35.5, -65, 0])
        polygon( points=[[0,0],[0,45],[2,45],[2,0]] );

    rotate_extrude(angle = ma(aov), $fn=55)
      translate([35.5, -65, 0])
        polygon( points=[[0,0],[0,45],[2,45],[2,0]] );

}