/**
 * A locking clip for IKEA SAMLA boxes.
 * Copyright (C) 2013 Roland Hieber <rohieb+ikeasamlaclip@rohieb.name>
 *
 * Adapted for Thingiverse customiser by Greg Tan <greg@gregtan.com>.
 * Contains parts of the obiscad library (https://github.com/Obijuan/obiscad/) 
 * inine as customiser can only use a single file.
 *
 * The contents of this file are licenced under CC-BY-NC-SA 3.0 Unported.
 * See https://creativecommons.org/licenses/by-nc-sa/3.0/deed for the
 * licensing terms.
 */

// preview[view:south west, tilt:side]

// How long should the clip be (in mm)?
length = 40; // [20:100]

// What text should be ebmossed on the clip?
text = "My stuff";

// What font should be used?
font = "orbitron.dxf"; // [BlackRose.dxf:Black Rose, braille.dxf:Braille, knewave.dxf:Knewave, Letters.dxf:Letters, orbitron.dxf:Orbitron]

// How large should the font be?
fontsize = 12; //[6:24]

/* [Hidden] */

thickness = 2; // wall thickness
in_width = 19; // inside dimension on y axis
in_height = 12.5; // inside dimension on x axis
out_hook_length = 7; // length of outer hook segment
in_hook_length = out_hook_length-thickness; // length of inner hook segment
in_hook_offset = 4; // offset of inner hook segment on the y axis
in_big_radius = 7; // radius of the big beveled edge
in_small_radius = 1; // radius of the small beveled edges
logo_height = 2; // extrusion height of the logo

// Create the clip
ikea_samla_clip_with_text(length = length, text=text, font=font, fontsize=fontsize/2);

use <write/Write.scad>

/* [Global] */


/**
 * A locking clip for IKEA SAMLA boxes.
 * Parameters:
 * length: Length of the clip. Default is 40 mm.
 */
module ikea_samla_clip(length=40) {
	$fn=50;

	// inside bevel connectors
	ci1e = [[0,0,length/2], [0,0,1], 0];
	ci1n = [ci1e[0], [-1,-1,0], 0];
	*connector(ci1e);
	*connector(ci1n);
	ci2e = [[0,in_width,length/2], [0,0,1], 0];
	ci2n = [ci2e[0], [-1,1,0], 0];
	*connector(ci2e);
	*connector(ci2n);
	ci3e = [[in_height,0,length/2], [0,0,1], 0];
	ci3n = [ci3e[0],[1,-1,0],0];
	*connector(ci3e);
	*connector(ci3n);
	ci4e = [[in_height,in_hook_offset,length/2], [0,0,1], 0];
	ci4n = [ci4e[0], [1,1,0], 0];
	*connector(ci4e);
	*connector(ci4n);

	// outside bevel connectors
	co1e = [[-thickness,-thickness,length/2], [0,0,1], 0];
	co1n = ci1n;
	*connector(co1e);
	*connector(co1n);
	co2e = [[-thickness,in_width+thickness,length/2], [0,0,1], 0];
	co2n = ci2n;
	*connector(co2e);
	*connector(co2n);
	co3e = [[in_height+thickness,-thickness,length/2], [0,0,1], 0];
	co3n = ci3n;
	*connector(co3e);
	*connector(co3n);
	co4e = [[in_height+thickness,in_hook_offset+thickness,length/2], [0,0,1], 0];
	co4n = ci4n;
	*connector(co4e);
	*connector(co4n);

	// bevel connectors for hole in inner hook
	cihhle = [[in_height-in_hook_length/2,in_hook_offset+thickness/2,length/5],
		[0,1,0], 0];
	cihhln = [cihhle[0], [1,0,-1], 0];
	*connector(cihhle);
	*connector(cihhln);
	cihhue = [[cihhle[0][0],cihhle[0][1],4*length/5], [0,1,0], 0];
	cihhun = [cihhue[0], [1,0,1], 0];
	*connector(cihhue);
	*connector(cihhun);

	difference() {
		// outer edge
		translate([-thickness, -thickness, 0])
			cube([in_height+2*thickness, in_width+2*thickness, length]);
		bevel(co1e, co1n, l=length+1, cr=in_big_radius+thickness, cres=$fn/4);
		bevel(co2e, co2n, l=length+1, cr=in_small_radius+thickness, cres=$fn/4);
		bevel(co3e, co3n, l=length+1, cr=in_small_radius+thickness, cres=$fn/4);
		bevel(co4e, co4n, l=length+1, cr=in_small_radius+thickness, cres=$fn/4);

		// inner edge
		difference() {
			cube([in_height, in_width, length+1]);
			bevel(ci1e, ci1n, l=length+1, cr=in_big_radius, cres=$fn/4);
			bevel(ci2e, ci2n, l=length+1, cr=in_small_radius, cres=$fn/4);
			bevel(ci3e, ci3n, l=length+1, cr=in_small_radius, cres=$fn/4);
			bevel(ci4e, ci4n, l=length+1, cr=in_small_radius, cres=$fn/4);

			// inner, upward hook
			difference() {
				translate([in_height-in_hook_length, in_hook_offset, 0])
					cube([in_hook_length, thickness, length]);
			}
		}

		// shorten the outer hook
		translate([out_hook_length, in_hook_offset+thickness, 0])
			cube([in_height, in_width, length+1]);

		// add a hole in the inner hook for the cross ribs under the boxes' rim
		if(length >= 40) {
			difference() {
				translate([in_height-in_hook_length, in_hook_offset, length/5])
					cube([in_hook_length/2, thickness, length/5*3]);
				bevel(cihhle, cihhln, l=thickness, cr=in_hook_length/2, cres=0);
				bevel(cihhue, cihhun, l=thickness, cr=in_hook_length/2, cres=0);
			}
		}
	}
}

/**
 * A locking clip for IKEA SAMLA boxes with text.
 * Parameters:
 * length: Length of the clip. Default is 40mm.
 * text: Text that is rendered on the clip
 * font: DXF font file for Write.scad
 * fontsize: font size of the text
 */
module ikea_samla_clip_with_text(length=40, text="stuff", font="write/orbitron.dxf", fontsize=19/2) {
	ikea_samla_clip(length=length);
	translate([-thickness, in_width-in_big_radius, length/2])
		rotate([0,-90,0])
		write(text, center=true, font=str("write/", font), h=fontsize, t=2*0.7);
}

/**
 * A locking clip for IKEA SAMLA boxes with logo.
 * Parameters:
 * length: Length of the clip. Default is 40mm.
 * logo: Path to a DXF file that is rendered as a logo on the clip. Logos should
 *  be 50mm×50mm to be rendered correctly. For a collection of logos, see
 *  https://github.com/rohieb/thing-logos
 */
module ikea_samla_clip_with_logo(length=40,
	logo="thing-logos/stratum0-lowres.dxf") {
	ikea_samla_clip(length=length);
	translate([-thickness, in_big_radius, length/2])
		scale((in_width-in_big_radius-thickness)/50)
		translate([-logo_height/2, 50, -25])
		rotate([90,0,-90])
		linear_extrude(height=logo_height, center=true)
		import(logo, center=true);
}

// Modules copied from ObiScad library as customiser doesn't allow library usage

// inline bevel.scad
//---------------------------------------------------------------
//-- Openscad Bevel library
//-- Bevel the edges or add buttress to your parts!
//---------------------------------------------------------------
//-- This is a component of the obiscad opescad tools by Obijuan
//-- (C) Juan Gonzalez-Gomez (Obijuan)
//-- Sep-2012
//---------------------------------------------------------------
//-- Released under the GPL license
//---------------------------------------------------------------

//-----------------------------------------------------------------
//- Rotate a vector an angle teta around the axis given by the
//-- unit vector k
//-----------------------------------------------------------------
function Rot_axis_ang(p,k,teta) =
  p*cos(teta) + cross(k,p*sin(teta)) + k*dot(k,p)*(1-cos(teta));

//-- Transformation defined by rotating vfrom vector to vto
//-- It is applied to vector v
//-- It returns the transformed vector
function Tovector(vfrom, vto, v) = 
   Rot_axis_ang(v, unitv(cross(vfrom,vto)), anglev(vfrom,vto));

//-- Auxiliary function for extending a vector of 3 components to 4
function ev(v,c=0) = [v[0], v[1], v[2], c];

//-- Calculate the determinant of a matrix given by 3 row vectors
function det(a,b,c) = 
   a[0]*(b[1]*c[2]-b[2]*c[1])
 - a[1]*(b[0]*c[2]-b[2]*c[0])  
 + a[2]*(b[0]*c[1]-b[1]*c[0]);


//-- Sign function. It only returns 2 values: -1 when x is negative,
//-- or 1 when x=0 or x>0
function sign2(x) = sign(x)+1 - abs(sign(x));

//--------------------------------------------------------------------
//-- Beveled concave corner
//-- NOT AN INTERFACE MODULE (The user should call bconcave_corner instead)
//--
//-- Parameters:
//--   * cr: Corner radius
//--   * cres: Corner resolution
//--   * l: Length
//-    * th: Thickness
//--------------------------------------------------------------------
module bconcave_corner_aux(cr,cres,l,th)
{
  
  //-- vector for translating the  main cube
  //-- so that the top rigth corner is on the origin
  v1 = -[(cr+th)/2, (cr+th)/2, 0];

  //-- The part frame of reference is on the
  //-- internal corner
  v2 = [cr,cr,0];

  //-- Locate the frame of ref. in the internal
  //-- corner
  translate(v2)
  difference() {

    //-- Main cube for doing the corner
    translate(v1)
        //color("yellow",0.5)
        cube([cr+th, cr+th, l],center=true);
 
    //-- Cylinder used for beveling...
    cylinder(r=cr, h=l+1, center=true, $fn=4*(cres+1));
  }
}


//-----------------------------------------------------------------------------
//-- API MODULE
//--
//-- Beveled concave corner
//--
//-- Parameters:
//--   * cr: Corner radius
//--   * cres: Corner resolution
//--   * l: Length
//-    * th: Thickness
//--   * ext_corner: Where the origin is locate. By default it is located
//--       in the internal corner (concave zone). If true, 
//--       it will be in the external corner (convex zone)
//----------------------------------------------------------------------------
module bconcave_corner(cr=1,cres=4,th=1,l=10,ext_corner=false)
{
  //-- Locate the origin in the exterior edge
  if (ext_corner==true)
    translate([th,th,0]) 
      bconcave_corner_aux(cr,cres,l,th);
  else
     //-- Locate the origin in the interior edge
     translate([0.01, 0.01,0])
       bconcave_corner_aux(cr,cres,l,th);
}

//----------------------------------------------------------------------
//-- Auxiliary module (NOT FOR THE USER!)
//-- It is and standar "attach", particularized for placing concave
//-- corners
//----------------------------------------------------------------------
module bconcave_corner_attach_final(
        cfrom,  //-- Origin connector
        cto,    //-- Target connector
        cr,
        cres,
        l,
        th,
        ext_corner)
{
 
  //-- This block represent an attach operation
  //-- It is equivalent to:  attach(cto,cfrom)
  translate(cto[0])
    rotate(a=cto[2], v=cto[1])
      rotate(a=anglev(cfrom[1],cto[1]), 
             v=cross(cfrom[1],cto[1]) )
        translate(-cfrom[0]) 

  //-- Place the concave corner (along with some debug information)
  union() {
    //color("Blue")
    //connector(cfrom);
    //connector([cfrom[0],cnormal_v,0]);
    bconcave_corner(cr=cr,
             cres=cres, 
             l=l,
             th=th,
             ext_corner=ext_corner);
  }
}


//-------------------------------------------------------------------------
//-- Auxiliary module (NOT FOR THE USER!)
//-- It is the general module for performing the bconcave corner attach
//-- All the parameters should be passed to it
//--
//--  External connectors are where de concave corner will be placed. They
//--  are provided by the user
//--
//--  Internal connectors refers to the connectors of the concave corner
//--
//--  Then an attach between the internal and external connectors is done
//-------------------------------------------------------------------------
module bconcave_corner_attach_aux(

         //-- External connectors
         edge_c, 
         normal_c,

         //-- Internal connectors
         iedge_c,
         inormal_c,

	 //-- Other params
         cr,
         cres,
         th,
         l,
         ext_corner)

{
  //-- Get the Corner vectors from the internal connectors
  cedge_v = iedge_c[1];         //-- Corner edge vector
  cnormal_v = inormal_c[1];     //-- Corner normal vector

  //-- Get the vector paralell and normal to the edge
  //-- From the external connectors
  edge_v = edge_c[1];      //-- Edge verctor
  enormal_v = normal_c[1]; //-- Edge normal vector

  //---------------------------------------------------------------
  //-- For doing a correct attach, first the roll angle for the  
  //-- external connector should be calculated. It determines the
  //-- orientation of the concave corner around the edge vector
  //--
  //-- This orientation is calculated using the edge normal vectors
  //-- that bisec the corner
  //--
  //-- There are 2 different cases: depending on the relative angle
  //-- between the internal and external edges. They can be parallel
  //-- or not
  //-----------------------------------------------------------------
  //-- The roll angle has two components: the value and the sign

  //-- Calculate the sign of the rotation (the sign of roll)
  s=sign2(det(cnormal_v,enormal_v,edge_v));

  //-- Calculate the roll when the edges are paralell
  rollp = s*anglev(cnormal_v, enormal_v);

  //-- Calculate the roll in the general case
  Tcnormal_v = Tovector(cedge_v, edge_v, cnormal_v);
  rollg=s*anglev(Tcnormal_v, enormal_v);

  //-- For the paralell case... use rollp
  if (mod(cross(cedge_v,edge_v))==0) {
    //echo("Paralell");

     //-- Place the concave bevel corner!
     bconcave_corner_attach_final(
       cfrom = [[0,0,0],   cedge_v,   0],
       cto   = [edge_c[0], edge_c[1], rollp],
       cr    = cr,
       cres  = cres,
       l     = l,
       th    = th,
       ext_corner = ext_corner);
  }

  //-- For the general case, use rollg
  else {
    //echo("not paralell");

     //-- Place the concave bevel corner!
     bconcave_corner_attach_final(
       cfrom = [[0,0,0],   cedge_v,   0],
       cto   = [edge_c[0], edge_c[1], rollg],
       cr    = cr,
       cres  = cres,
       l     = l,
       th    = th,
       ext_corner = ext_corner);
  }
}

//---------------------------------------------------------------------------
//-- API MODULE
//--
//--  Bevel an edge. A concave corner is located so that the calling 
//--  module can easily perform a difference() operation
//--
//--  Two connectors are needed:
//--    * edge_c   : Connector located on the edge, paralell to the edge
//--    * normal_c : Connector located on the same point than edge_c 
//--                 pointing to the internal corner part, in the direction
//--                 of the corner bisector
//--    * cr        : Corner radius
//--    * cres      : Corner resolution
//--    * l         : Corner length
//--------------------------------------------------------------------------  
module bevel(
           edge_c, 
           normal_c,
           cr=3,
           cres=3,
           l=5)
{

  //-- Call the general module with the correct internal connectors
  bconcave_corner_attach_aux(

         //-- External connectors
         edge_c   = edge_c,
         normal_c = normal_c,

	 //-- Internal connectors 
         iedge_c   = [[0,0,0], unitv([0,0,1]), 0],
         inormal_c = [[0,0,0], [-1,-1,0]       , 0],

         //-- The other params
         cr=cr,
         cres=cres,
         l=l,
         th=1,
         ext_corner=false);
}


//---------------------------------------------------------------------------
//-- API MODULE
//--
//--  Attach a Beveled concave corner
//--  Two connectors are needed:
//--    * edge_c   : Connector located on the edge, paralell to the edge
//--    * normal_c : Connector located on the same point than edge_c 
//--                 pointing to the internal corner part, in the direction
//--                 of the corner bisector
//--    * cr        : Corner radius
//--    * cres      : Corner resolution
//--    * l         : Corner length
//--    * th        : Corner thickness (not visible when ext_corner=false)
//--    * ext_corner: If the exterior corner is used as a reference
//--------------------------------------------------------------------------  
module bconcave_corner_attach(
           edge_c, 
           normal_c,
           cr=3,
           cres=3,
           l=5, 
           th=1,
           ext_corner=false)
{

  //-- Call the general module with the correct internal connectors
  bconcave_corner_attach_aux(

         //-- External connectors
         edge_c   = edge_c,
         normal_c = normal_c,

	 //-- Internal connectors 
         iedge_c   = [[0,0,0], unitv([0,0,1]), 0],
         inormal_c = [[0,0,0], [1,1,0]       , 0],

         //-- The other params
         cr=cr,
         cres=cres,
         l=l,
         th=th,
         ext_corner=ext_corner);

}
  
// inline attach.scad
//--------------------------------------------------------------------
//-- Draw a connector
//-- A connector is defined a 3-tuple that consist of a point
//--- (the attachment point), and axis (the attachment axis) and
//--- an angle the connected part should be rotate around the 
//--  attachment axis
//--
//--- Input parameters:
//--
//--  Connector c = [p , n, ang] where:
//--
//--     p : The attachment point
//--     v : The attachment axis
//--   ang : the angle
//--------------------------------------------------------------------
module connector(c)
{
  //-- Get the three components from the connector
  p = c[0];
  v = c[1];
  ang = c[2];

  //-- Draw the attachment poing
  color("Gray") point(p);

  //-- Draw the attachment axis vector (with a mark)
  translate(p)
    rotate(a=ang, v=v)
    color("Gray") vector(unitv(v)*6, l_arrow=2, mark=true);
}


//-------------------------------------------------------------------------
//--  ATTACH OPERATOR
//--  This operator applies the necesary transformations to the 
//--  child (attachable part) so that it is attached to the main part
//--  
//--  Parameters
//--    a -> Connector of the main part
//--    b -> Connector of the attachable part
//-------------------------------------------------------------------------
module attach(a,b)
{
  //-- Get the data from the connectors
  pos1 = a[0];  //-- Attachment point. Main part
  v    = a[1];  //-- Attachment axis. Main part
  roll = a[2];  //-- Rolling angle
  
  pos2 = b[0];  //-- Attachment point. Attachable part
  vref = b[1];  //-- Atachment axis. Attachable part
                //-- The rolling angle of the attachable part is not used

  //-------- Calculations for the "orientate operator"------
  //-- Calculate the rotation axis
  raxis = cross(vref,v);
    
  //-- Calculate the angle between the vectors
  ang = anglev(vref,v);
  //--------------------------------------------------------.-

  //-- Apply the transformations to the child ---------------------------

  //-- Place the attachable part on the main part attachment point
  translate(pos1)
    //-- Orientate operator. Apply the orientation so that
    //-- both attachment axis are paralell. Also apply the roll angle
    rotate(a=roll, v=v)  rotate(a=ang, v=raxis)
      //-- Attachable part to the origin
      translate(-pos2)
	child(0); 
}


// inline vector.scad

//---------------------------------------------------------------
//-- Openscad vector library
//-- This is a component of the obiscad opescad tools by Obijuan
//-- (C) Juan Gonzalez-Gomez (Obijuan)
//-- Sep-2012
//---------------------------------------------------------------
//-- Released under the GPL license
//---------------------------------------------------------------

obiscad_drawing_resolution = 6;

//----------------------------------------
//-- FUNCTIONS FOR WORKING WITH VECTORS
//----------------------------------------

//-- Calculate the module of a vector
function mod(v) = (sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]));

//-- Calculate the cros product of two vectors
function cross(u,v) = [
  u[1]*v[2] - v[1]*u[2],
  -(u[0]*v[2] - v[0]*u[2]) ,
  u[0]*v[1] - v[0]*u[1]];

//-- Calculate the dot product of two vectors
function dot(u,v) = u[0]*v[0]+u[1]*v[1]+u[2]*v[2];

//-- Return the unit vector of a vector
function unitv(v) = v/mod(v);

//-- Return the angle between two vectores
function anglev(u,v) = acos( dot(u,v) / (mod(u)*mod(v)) );

//----------------------------------------------------------
//--  Draw a point in the position given by the vector p  
//----------------------------------------------------------
module point(p)
{
  translate(p)
    sphere(r=0.7,$fn=obiscad_drawing_resolution);
}

//------------------------------------------------------------------
//-- Draw a vector poiting to the z axis
//-- This is an auxiliary module for implementing the vector module
//--
//-- Parameters:
//--  l: total vector length (line + arrow)
//--  l_arrow: Vector arrow length
//--  mark: If true, a mark is draw in the vector head, for having
//--    a visual reference of the rolling angle
//------------------------------------------------------------------
module vectorz(l=10, l_arrow=4, mark=false)
{
  //-- vector body length (not including the arrow)
  lb = l - l_arrow;

  //-- The vector is locatead at 0,0,0
  translate([0,0,lb/2])
  union() {

    //-- Draw the arrow
    translate([0,0,lb/2])
      cylinder(r1=2/2, r2=0.2, h=l_arrow, $fn=obiscad_drawing_resolution);

    //-- Draw the mark
    if (mark) {
      translate([0,0,lb/2+l_arrow/2])
      translate([1,0,0])
        cube([2,0.3,l_arrow*0.8],center=true);
    }

    //-- Draw the body
    cylinder(r=1/2, h=lb, center=true, $fn=obiscad_drawing_resolution);
  }

  //-- Draw a sphere in the vector base
  sphere(r=1/2, $fn=obiscad_drawing_resolution);
}

//-----------------------------------------------------------------
//-- ORIENTATE OPERATOR
//--
//--  Orientate an object to the direction given by the vector v
//--  Parameters:
//--    v : Target orientation
//--    vref: Vector reference. It is the vector of the local frame
//--          of the object that want to be poiting in the direction
//--          of v
//--    roll: Rotation of the object around the v axis
//-------------------------------------------------------------------
module orientate(v,vref=[0,0,1], roll=0)
{
  //-- Calculate the rotation axis
  raxis = cross(vref,v);
  
  //-- Calculate the angle between the vectors
  ang = anglev(vref,v);

  //-- Rotate the child!
  rotate(a=roll, v=v)
    rotate(a=ang, v=raxis)
      child(0);
}

//---------------------------------------------------------------------------
//-- Draw a vector 
//--
//-- There are two modes of drawing the vector
//-- * Mode 1: Given by a cartesian point(x,y,z). A vector from the origin
//--           to the end (x,y,z) is drawn. The l parameter (length) must 
//--           be 0  (l=0)
//-- * Mode 2: Give by direction and length
//--           A vector of length l pointing to the direction given by
//--           v is drawn
//---------------------------------------------------------------------------
//-- Parameters:
//--  v: Vector cartesian coordinates
//--  l: total vector length (line + arrow)
//--  l_arrow: Vector arrow length
//    mark: If true, a mark is draw in the vector head, for having
//--    a visual reference of the rolling angle
//---------------------------------------------------------------------------
module vector(v,l=0, l_arrow=4, mark=false)
{
  //-- Get the vector length from the coordinates
  mod = mod(v);

  //-- The vector is very easy implemented by means of the orientate
  //-- operator:
  //--  orientate(v) vectorz(l=mod, l_arrow=l_arrow)
  //--  BUT... in OPENSCAD 2012.02.22 the recursion does not
  //--    not work, so that if the user use the orientate operator
  //--    on a vector, openscad will ignore it..
  //-- The solution at the moment (I hope the openscad developers
  //--  implement the recursion in the near future...)
  //--  is to repite the orientate operation in this module

  //---- SAME CALCULATIONS THAN THE ORIENTATE OPERATOR!
  //-- Calculate the rotation axis

  vref = [0,0,1];
  raxis = cross(vref,v);
  
  //-- Calculate the angle between the vectors
  ang = anglev(vref,v);

  //-- orientate the vector
  //-- Draw the vector. The vector length is given either
  //--- by the mod variable (when l=0) or by l (when l!=0)
  if (l==0)
    rotate(a=ang, v=raxis)
      vectorz(l=mod, l_arrow=l_arrow, mark=mark);
  else
    rotate(a=ang, v=raxis)
      vectorz(l=l, l_arrow=l_arrow, mark=mark);

}

//----------------------------------------------------
//-- Draw a Frame of reference
//-- Parameters:
//-- l: length of the Unit vectors
//-----------------------------------------------------
module frame(l=10, l_arrow=4)
{

  //-- Z unit vector
  color("Blue")
    vector([0,0,l], l_arrow=l_arrow);

  //-- X unit vector
  color("Red")
    vector([l,0,0], l_arrow=l_arrow );

  //-- Y unit vector
  color("Green")
    vector([0,l,0],l_arrow=l_arrow);

  //-- Origin
  color("Gray")
    sphere(r=1, $fn=obiscad_drawing_resolution);
}


// vim: set sw=2 ts=2 noet:
