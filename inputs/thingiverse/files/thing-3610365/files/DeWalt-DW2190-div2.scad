/********************************************************//**
 * Customizable DeWALT DW2190 Divider with Two Shank Clasps *
 * by Tobin Kyllingstad                                     *
 * 2019/05/05                                               *
 *                                                          *
 * Divider for DeWalt Medium Tough Case (DW2190) with two   *
 * integrated shank clasps.                                 *
 * https://www.thingiverse.com/kyllingstad                  *
 ************************************************************/
// (inches or millimeters)
Units = 1; // [1:in,25.4:mm]
// Shank Clasp A Inner Diameter
Shank_A_Diameter = 0.235;
// Shank Clasp B Inner Diameter
Shank_B_Diameter = 0.22;
// Height of shank axis above base
Axis_Height = 0.5;
// Shank clasp thickness
Clasp_Thickness = 0.08;
// Shank clasp width
Clasp_Width = 0.125;
// Gap between clasp and wall
Gap_Width = 0.03125;
// Outer wall width
Wall_Width = 0.09375;
// Thickness of supporting structure
Floor_Thickness = 0.09375;
/* [Hidden] */
max_overhang_angle = 50;
margin = 0.001;
a_inner_radius = Shank_A_Diameter/2/Units;
b_inner_radius = Shank_B_Diameter/2/Units;
axis_height = Axis_Height/Units;
clasp_thickness = Clasp_Thickness/Units;
clasp_width = Clasp_Width/Units;
gap_width = Gap_Width/Units;
wall_width = Wall_Width/Units;
floor_thickness = Floor_Thickness/Units;

scale([25.4, 25.4, 25.4])
{
   two_clasp_divider( a_inner_radius, b_inner_radius, axis_height, clasp_thickness, clasp_width,
                      gap_width, wall_width, floor_thickness );
}

module two_clasp_divider( a_inner_radius,
                          b_inner_radius,
                          axis_height,
                          clasp_thickness,
                          clasp_width,
                          gap_width,
                          wall_width,
                          floor_thickness )
{
   div_height = 0.68;
   div_width = 1.2;
   div_depth = 0.75;
   hole_width = div_width - 0.375;
   space = (hole_width - 2*a_inner_radius - 2*b_inner_radius - 4*clasp_thickness) / 3;
   a_offset = -(hole_width/2 - space - a_inner_radius - clasp_thickness);
   b_offset =  (hole_width/2 - space - b_inner_radius - clasp_thickness);
   min_inner_radius = min( a_inner_radius, b_inner_radius );
   floor_height = max( axis_height - min_inner_radius - clasp_thickness, floor_thickness );
   union()
   {
      difference()
      {
         divider( div_height, div_width, div_depth, hole_width, clasp_thickness, clasp_width,
                  floor_thickness, floor_height, gap_width, wall_width );
         translate([ a_offset, 0, 0 ])
         {
            slot( a_inner_radius, clasp_thickness/2, div_height - axis_height, div_depth, axis_height );
         }
         translate([ b_offset, 0, 0 ])
         {
            slot( b_inner_radius, clasp_thickness/2, div_height - axis_height, div_depth, axis_height );
         }
      }
      translate([ 0, 0, axis_height ])
      {
         translate([ a_offset, 0, 0 ])
         {
            clasp( a_inner_radius, clasp_thickness, axis_height - floor_height, clasp_width );
         }
         translate([ b_offset, 0, 0 ])
         {
            clasp( b_inner_radius, clasp_thickness, axis_height - floor_height, clasp_width );
         }
      }
   }
}

module divider( height,
                width,
                depth,
                hole_width,
                clasp_thickness,
                clasp_width,
                floor_thickness,
                floor_height,
                gap_width,
                wall_width )
{
   middle = clasp_width + 2*gap_width + 2*wall_width;
   hole_height = height - floor_thickness;
   hole_depth = clasp_width + 2*gap_width;
   difference()
   {
      divider_base( width, depth, middle, height );
      translate( [ 0, 0, floor_height + height/2 ] )
      {
         cube( size=[ hole_width, hole_depth, height ], center=true );
      }
      base_void( hole_width, hole_depth, floor_height - floor_thickness );
   }
}

module divider_base( width,
                     depth,
                     middle,
                     height )
{
   linear_extrude( height, convexity = 10 )
   {
      divider_profile( width, depth, middle );
   }
}

module divider_profile( width,
                        depth,
                        middle )
{
   polygon(points = [ [ width/2, depth/2],
                      [ width/2, 0.125],
                      [ (width/2 - 0.125), 0.1875],
                      [ (width/2 - 0.125), 0.0625],
                      [ width/2, 0.0625],
                      [ width/2,-0.0625],
                      [ (width/2 - 0.125),-0.0625],
                      [ (width/2 - 0.125),-0.1875],
                      [ width/2,-0.125],
                      [ width/2,-depth/2],
                      [ (width/2 + middle/2 - depth/2),-middle/2],
                      [-(width/2 + middle/2 - depth/2),-middle/2],
                      [-width/2,-depth/2],
                      [-width/2,-0.125],
                      [-(width/2 - 0.125),-0.1875],
                      [-(width/2 - 0.125),-0.0625],
                      [-width/2,-0.0625],
                      [-width/2, 0.0625],
                      [-(width/2 - 0.125), 0.0625],
                      [-(width/2 - 0.125), 0.1875],
                      [-width/2, 0.125],
                      [-width/2, depth/2],
                      [-(width/2 + middle/2 - depth/2), middle/2],
                      [ (width/2 + middle/2 - depth/2), middle/2] ]);
}

module slot( inner_radius,
             corner_radius,
             top_to_axis,
             depth,
             axis_height )
{
   translate([0, 0, axis_height])
   {
      rotate([90, 0, 0])
      {
         linear_extrude(height = depth, center = true, convexity = 10 )
         {
            slot_profile( inner_radius, corner_radius, top_to_axis );
         }
      }
   }
}

module slot_profile( inner_radius,
                     corner_radius,
                     top_to_axis )
{
   difference()
   {
      union()
      {
         circle(r = inner_radius, $fn = 50);
         polygon(points = [ [ inner_radius, 0],
                            [ inner_radius, top_to_axis - corner_radius],
                            [ (inner_radius + corner_radius), top_to_axis],
                            [ (inner_radius + corner_radius), top_to_axis + margin],
                            [-(inner_radius + corner_radius), top_to_axis + margin],
                            [-(inner_radius + corner_radius), top_to_axis],
                            [-inner_radius, top_to_axis - corner_radius],
                            [-inner_radius, 0] ]);
      }
      translate([ (inner_radius + corner_radius), top_to_axis - corner_radius])
      {
         circle(r = corner_radius, $fn = 20);
      }
      translate([-(inner_radius + corner_radius), top_to_axis - corner_radius])
      {
         circle(r = corner_radius, $fn = 20);
      }
   }
}

module base_void( width,
                  depth,
                  height )
{
   rotate([0, 0, 90])
   {
      rotate([90, 0, 0])
      {
         translate([0, 0, -width/2])
         {
            linear_extrude(height = width)
            {
               base_void_profile( depth, height );
            }
         }
      }
   }
}

module base_void_profile( depth,
                          height )
{
   polygon(points = [ [ 0, height ],
                      [  depth/2, height - tan(90 - max_overhang_angle) * depth/2 ],
                      [  depth/2, -margin ],
                      [ -depth/2, -margin ],
                      [ -depth/2, height - tan(90 - max_overhang_angle) * depth/2 ] ]);
}

module clasp( inner_radius,
              clasp_thickness,
              base_to_axis,
              clasp_width )
{
   rotate([90,0,0])
   {
      linear_extrude(height = clasp_width, center = true, convexity = 10)
      {
         clasp_profile( inner_radius, clasp_thickness, base_to_axis );
      }
   }
}

module clasp_profile( inner_radius,
                      clasp_thickness,
                      base_to_axis )
{
   outer_radius = inner_radius + clasp_thickness;
   opening_angle = 60;
   fillet_radius = ( min( base_to_axis, outer_radius ) -
                     outer_radius * cos(max_overhang_angle) ) /
                   ( 1 + cos(max_overhang_angle) );
   union()
   {
      difference()
      {
         union()
         {
            circle(r = outer_radius, $fn = 50);
            polygon(points = [ [ 0,0 ],                                         // center of clasp
               [ (outer_radius + fillet_radius) * sin(max_overhang_angle),
                -(outer_radius + fillet_radius) * cos(max_overhang_angle) ],    // center of fillet
               [ (outer_radius + fillet_radius) * sin(max_overhang_angle),
               -((outer_radius + fillet_radius) * cos(max_overhang_angle) +
                 fillet_radius + margin) ],                                     // bottom fillet
               [-(outer_radius + fillet_radius) * sin(max_overhang_angle),
               -((outer_radius + fillet_radius) * cos(max_overhang_angle) +
                 fillet_radius + margin) ],                                     // bottom fillet
               [-(outer_radius + fillet_radius) * sin(max_overhang_angle),
                -(outer_radius + fillet_radius) * cos(max_overhang_angle) ] ]); // center of fillet
         }
         circle(r = inner_radius, $fn = 50);
         translate([ (outer_radius + fillet_radius) * sin(max_overhang_angle),
                    -(outer_radius + fillet_radius) * cos(max_overhang_angle), ])
         {
            circle(r = fillet_radius, $fn = 50);
         }
         translate([-(outer_radius + fillet_radius) * sin(max_overhang_angle),
                    -(outer_radius + fillet_radius) * cos(max_overhang_angle), ])
         {
            circle(r = fillet_radius, $fn = 50);
         }
         polygon(points = [ [ 0,0 ],
            [ (outer_radius) * tan(opening_angle), (outer_radius) ],
            [-(outer_radius) * tan(opening_angle), (outer_radius) ] ]);
      }
      translate([ (inner_radius + clasp_thickness/2) * sin(opening_angle),
                  (inner_radius + clasp_thickness/2) * cos(opening_angle) ])
      {
         circle(d = clasp_thickness, $fn=20);
      }
      translate([-(inner_radius + clasp_thickness/2) * sin(opening_angle),
                  (inner_radius + clasp_thickness/2) * cos(opening_angle) ])
      {
         circle(d = clasp_thickness, $fn=20);
      }
   }
}
