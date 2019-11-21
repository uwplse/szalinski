shaftDiameter = 7.5;
spoolShaftDiameter = 51.5;
resolution = 180;
// frictionFit = 0;

textOffset = 23;
slimmed = 1;
showTieholes = 1;
fontSize = 4;

engraveDiameters = 1;

capThickness = 3;
tieholeRotation = 45;
tieslotDepth = .75;
tieholeFromCenter = 11.1;
shaftWallHeight = 12;
shaftWallWidth = 3;

/* assembly and positioning of the different pieces */
linear_extrude( height = tieslotDepth )
spoolHubCapSlice();

translate([0,0,tieslotDepth - 0.01])
linear_extrude( height = 0.01 + capThickness - tieslotDepth )
spoolHubCapSlice( tSlot = false, tVis = false );

translate([0,0,capThickness - 0.01])
linear_extrude( height = 0.01 + shaftWallHeight )
spoolCapShaft();
/* end assembly and positioning of the different pieces */

module tiehole(){
  if( showTieholes ){
    circle( r = 1.5, $fn = resolution );
  }
}
module tieslot(){
  if( showTieholes ){
    square( [sqrt( pow( tieholeFromCenter, 2 ) + pow( tieholeFromCenter, 2 ) ), 3], center = true );
  }
}
module slimSection( offset = 0 ) {
  width = 20;
  height = 15;

  translate([0, spoolShaftDiameter / 2 + width / 4 - offset,0])
  square([ spoolShaftDiameter, spoolShaftDiameter / 2], center = true);
}

module spoolHubCapSlice ( tHole = true, tSlot = true, tVis = true ) {
  difference() {
  // union() {

    // create initial hub cap
    circle( spoolShaftDiameter / 2 + 3, $fn = resolution );

    // put together all of the pieces to remove from the cap
    union() {

      // center hole
      circle( shaftDiameter / 2, $fn = resolution );

      // tie holes should penetrate the face of the hub
      for( tieholeRotationIndex = [0:3] ) {
        rotate([0,0,tieholeRotationIndex * 90 + tieholeRotation - 45 ])
        translate([tieholeFromCenter, 0]){
          tiehole();
        }
      }

      // tie slots should be cut into face of hub
      if( tSlot ) {
        for( tieslotRotationIndex = [0,180] ) {
          rotate([0, 0, 0 + tieslotRotationIndex + tieholeRotation - 45 ] ){
            translate([0, tieholeFromCenter]){
              rotate([0, 0, 45 ] ){
                translate([sqrt( pow( tieholeFromCenter, 2 ) + pow( tieholeFromCenter, 2 ) )/-2,0,0])
                tieslot();
              }
            }
          }
        }
      }

      // slice the layer to proper width
      if( slimmed ) {
        slimSection( -3 );
        mirror([0,1,0])
        slimSection( -3 );
      }

      // engraving
      if( engraveDiameters && tVis ) {
        translate([-1*textOffset ,0,0])
        rotate([0,0,90])
        mirror([1,0,0])
        text( str( spoolShaftDiameter, " mm OD"), halign = "center", valign = "top", fontSize );

        translate([ textOffset ,0,0])
        rotate([0,0,90])
        mirror([1,0,0])
        text( str( shaftDiameter, " mm ID"), halign = "center", valign = "bottom", fontSize );
      }
    }

  }
}

module spoolCapShaft() {
  difference() {

    // outer shaft
    difference() {
      circle( spoolShaftDiameter / 2, $fn = resolution );
      if( slimmed ) {
        slimSection( -3 );
        mirror([0,1,0])
        slimSection( -3 );
      }
    }

    // outer shaft
    difference() {
      circle( spoolShaftDiameter / 2 - shaftWallWidth, $fn = resolution );
      if( slimmed ) {
        slimSection( );
        mirror([0,1,0])
        slimSection( );
      }
    }

  }
}

