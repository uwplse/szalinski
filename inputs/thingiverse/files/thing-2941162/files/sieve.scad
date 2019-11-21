// Length of the base of the sieve, without the stacking, so the frame_thickness will be added twice.
length=110;

// Width of the base of the sieve, without the stacking, so the frame_thickness will be added twice.
width=110;

// Length and width of the holes.
hole_size=6;

// Thickness of the sieve bottom.
sieve_thickness=2;

// Width of the bottom of the space between holes, keep to a multiple of your extrusion width for better results.
bottom_width=0.8;

// Maximum width the space between holes, keep it larger than bottom_width. The maximum width is at 2/3rd of the hole. Keep in mind that the slope needs to be printed without support.
max_width=1.6;

// Thickness of the frame.
frame_thickness=4;

// Height of the frame.
frame_height=110;

sieve(x=length, y=width, d=sieve_thickness, s1=bottom_width, s2=max_width, l=hole_size, rd=frame_thickness, r=frame_height);

module sieve(x, y, d, s1, s2, l, rd, r)
{
  nx = floor((x - 2*rd - 2*s2) / (s2 + l)) - 1;
  ny = floor((y - 2*rd - 2*s2) / (s2 + l)) - 1;

  difference()
  {
    union()
    {
      translate([-x/2, -y/2, 0])
        cube([x, y, d]);

      translate([-x/2, -y/2+rd, 0])
        rotate([0,0,270])
          side(x=x,rd=rd,r=r);

      translate([x/2, y/2-rd, 0])
        rotate([0,0,90])
          side(x=x,rd=rd,r=r);

      translate([-x/2+rd, y/2, 0])
        rotate([0,0,180])
          side(x=y,rd=rd,r=r);

      translate([x/2 - rd, -y/2, 0])
        side(x=y,rd=rd,r=r);
    }

    base_x=(l+(s2-s1))/2;
    top_x =(l+(s2-s1)/3)/2;
    translate([-nx/2*(s2+l), -ny/2*(s2+l), 0])
      for (dx = [0:nx])
        for (dy = [0:ny])
          translate([(s2+l)*dx, (s2+l)*dy, 0])
           polyhedron(
              points = [
                [-base_x,-base_x,0],
                [base_x, -base_x,0],
                [base_x,  base_x,0],
                [-base_x, base_x,0],
                [-l/2,   -l/2,   d*2/3],
                [l/2,    -l/2,   d*2/3],
                [l/2,     l/2,   d*2/3],
                [-l/2,    l/2,   d*2/3],
                [-top_x, -top_x, d],
                [top_x,  -top_x, d],
                [top_x,   top_x, d],
                [-top_x,  top_x, d],
                
              ],
              faces = [
                [0,1,2,3],
                [4,5,1,0],
                [5,6,2,1],
                [6,7,3,2],
                [7,4,0,3],
                [4,8,9,5],
                [4,7,11,8],
                [6,5,9,10],
                [7,6,10,11],
                [8,11,10,9], 
              ]
            );
  }
}


/*
    This is the profile of the side, which is not flat. The oposite side has the faces in the same order, from 8 to 15.
     4      5
      +----+
      |    |
      |    |
      |    |    7
     3+    +---+
       \  6    |
        \      |
         \     |
          +2   |
          |    |
          |    |
          |    |
          |    |
          +----+
         1      0
    The 0 point is 0,0,0.
*/
module side(x,rd,r) {
  ease=0.1;
  ease2=3*ease;
  // Have a minimum slope that is about 30° so it can be printed without supports, then it grows as the sides grow to make it sturdier.
  slope=max(rd*1.5, r*0.15);
  // The larger the sieve, the  
  raise=max(rd, r*0.15);
  polyhedron(
    points = [
      [0,          0,          0],             // 0
      [rd,         0,          0],             // 1
      [rd,         0,          r-raise-slope], // 2
      [rd*2-ease,  -rd-ease,   r-raise],       // 3
      [rd*2+ease2, -rd-ease2,  r],             // 4
      [rd+ease2,   -ease2,     r],             // 5
      [rd+ease,    -ease,      r-raise],       // 6
      [0,          0,          r-raise],       // 7
      [0,          x,          0],             // 8
      [rd,         x,          0],             // 9
      [rd,         x,          r-raise-slope], // 10
      [rd*2-ease,  x+rd+ease,  r-raise],       // 11
      [rd*2+ease2, x+rd+ease2, r],             // 12
      [rd+ease2,   x+ease2,    r],             // 13
      [rd+ease,    x+ease,     r-raise],       // 14
      [0,          x,          r-raise],       // 15
    ],
    faces = [
      [0,7,2,1], [2,7,6], [2,6,3], [3,6,4], [4,6,5],
      [8,9,10,15], [10,14,15], [10,11,14], [11,12,14], [12,13,14],
      [0,1,9,8],
      [0,8,15,7],
      [1,2,10,9],
      [6,7,15,14],
      [5,6,14,13],
      [2,3,11,10],
      [3,4,12,11],
      [4,5,13,12],
    ]
    );
}