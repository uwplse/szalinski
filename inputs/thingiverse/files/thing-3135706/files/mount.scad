
boxPostsDistance = 92;

raspberrypiHoleX = 58;
raspberrypiHoleY = 49;

raspberrypiStandOffHeight = 5;

standOffBoardHeight = 3;

innerCornerRadius = 4;
outerCornerRadius = 10;

outerOffset = 6;

/*piOffsetX = 7;*/
/*piOffsetY = 10;*/
piOffsetX = boxPostsDistance/2 - raspberrypiHoleX/2 - 1.75;
piOffsetY = boxPostsDistance/2 - raspberrypiHoleY/2 - 7;

linear_extrude( standOffBoardHeight )
difference() {

  union() {
    /* support board wings */
    for( a = [0,1] ) {
      rotate([0,0,a*90])
      /*square( [ boxPostsDistance + 8 , 10 ], center = true );*/
      hull() {
        translate([ -boxPostsDistance/2 - 2.5,  3.33, 0 ])circle( d = 3.33, center = true, $fn = 30 );
        translate([  boxPostsDistance/2 + 2.5,  3.33, 0 ])circle( d = 3.33, center = true, $fn = 30 );
        translate([ -boxPostsDistance/2 - 2.5, -3.33, 0 ])circle( d = 3.33, center = true, $fn = 30 );
        translate([  boxPostsDistance/2 + 2.5, -3.33, 0 ])circle( d = 3.33, center = true, $fn = 30 );
      }
    }

    hull() {
      for( a = [-1,1] ) {
        for( b = [-1,1] ) {
          translate([piOffsetX, -piOffsetY, 0])
          translate( [ a * -raspberrypiHoleX/2 + a * -outerOffset, b * -raspberrypiHoleY/2 + b * -outerOffset, 0 ] )
          translate( [ a * outerCornerRadius/2, b * outerCornerRadius/2, 0 ] )
          circle( d = outerCornerRadius, center = true, $fn = 20 );
        }
      }
    }

  }

  union() {

    /*support board wing holes */
    for( a = [0,1] ) {
      rotate([0,0,a*90]) {
        translate([ ( boxPostsDistance / 2 ), 0, 0 ])
        circle( d = 4.5, $fn = 20 );
        translate([ ( - boxPostsDistance / 2 ), 0, 0 ])
        circle( d = 4.5, $fn = 20 );
      }
    }

    /* lower board holes */
    for( a = [-1,1] ) {
      for( b = [-1,1] ) {
        translate([piOffsetX, -piOffsetY, 0])
        translate([ a * raspberrypiHoleX/2 , b * raspberrypiHoleY/2 , 0 ])
        circle( d = 3.9, $fn = 20 );
      }
    }

    /* central support board */
    hull() {
      for( a = [-1,1] ) {
        for( b = [-1,1] ) {
          translate([piOffsetX, -piOffsetY, 0])
          translate( [ ( a * ( raspberrypiHoleX/2 - innerCornerRadius-2.5 ) ), ( b * ( raspberrypiHoleY/2 - innerCornerRadius-2.5 ) ), 0 ] )
          circle( r = innerCornerRadius, center = true, $fn = 20 );
        }
      }
    }

  }

}

/* loop through inverse and direct positions for the stand offs */
for( a = [-1,1] ) {
  for( b = [-1,1] ) {

    /* position the stand offs */
    translate([piOffsetX, -piOffsetY, 0])
    translate([ a * raspberrypiHoleX/2 , b * raspberrypiHoleY/2 ,standOffBoardHeight ])
    linear_extrude( raspberrypiStandOffHeight )
    difference() {
      /*circle( d = 6.5, $fn = 20 );*/
      /*circle( d = 3.9, $fn = 20 );*/
      circle( d = 7, $fn = 50 );
      circle( d = 5, $fn = 50 );
    }

  }
}
