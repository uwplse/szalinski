// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Title:        Parametric Test Block
// Version:      1.2
// Release Date: 2018-07-28 (ISO 8601)
// Author:       Rohin Gosling
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
//
// Description:
//
// - Simple 3D object generator, to generate test and calibration parts for 3D printers.
//
// Release Notes:
//
// - Version 1.1
//   * Removed extended ASCII characters to make the source code compatible with the UTF-8 encoding required by the Thingiverse Customizer.
//
// - Version 1.0
//   * Model created.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Constants:
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// System constants.

C_CONSTANT = 0 + 0;     // Used to hide constant values from Thingiverse. Add to other constants to hide them as well.

// General constants.

C_NONE = C_CONSTANT + 0;

// SCG constants.

SCG_OVERLAP = C_CONSTANT + 0.01;    // Used for overlapping Boolean operations in order to avoid Boolean edge artefacts.

// Shape

C_SHAPE_NONE      = C_CONSTANT + 0;
C_SHAPE_CUBOID    = C_CONSTANT + 1;
C_SHAPE_CYLINDER  = C_CONSTANT + 2;
C_SHAPE_PYRAMID   = C_CONSTANT + 3;
C_SHAPE_PRISM     = C_CONSTANT + 4;
C_SHAPE_ELLIPSOID = C_CONSTANT + 5;
C_SHAPE_TORUS     = C_CONSTANT + 6;

// Minimum and maximum constraints.

C_RESOLUTION_MIN  = C_CONSTANT + 8;
C_RESOLUTION_MAX  = C_CONSTANT + 64;
C_SIZE_MIN        = C_CONSTANT + 1.0;
C_SIDE_COUNT_MIN  = C_CONSTANT + 3;
C_SIDE_COUNT_MAX  = C_CONSTANT + 12;


// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Thingiverse Parameters.
//
// - These parameters are used to integrate with the Thingiverse Customizer, and should only be used by the
//   class member variables specified in the "Model parameters" section below.
//
// - These Thingiverse Parameters should never be accessed from inside any module. We do this to enforce 
//   principles of object orientation.
//
// - By separating concerns between variables exposed to Thingiverse vs. variables used internally by the 
//   SCAD model (class), we are better able to manage the ordering and grouping of variables exposed to 
//   Thingiverse, vs. the ordering and constraints of variables used internally by the model.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

/* [Assembbly Parameters] */

object_shape    = 1;        // [ 1:Cuboid, 2:Cylinder, 3:Pyramid, 4:Prism, 5:Ellipsoid, 6:Torus ]
x_bore_shape    = 0;        // [ 0: None, 2:Cylinder, 4:Prism ]
y_bore_shape    = 0;        // [ 0: None, 2:Cylinder, 4:Prism ]
z_bore_shape    = 0;        // [ 0: None, 2:Cylinder, 4:Prism ]
resolution      = 128;

/* [Cuboid Parameters] */

cuboid_x      = 10.0;
cuboid_y      = 10.0;
cuboid_z      = 10.0;
cuboid_fillet = 0.0;

/* [Cylinder Parameters] */

cylinder_diameter_base = 20.0;
cylinder_diameter_top  = 20.0;
cylinder_height        = 20.0;

/* [Pyramid Parameters] */

pyramid_side_count  = 4;
pyramid_side_length = 20.0;
pyramid_height      = 20.0;

/* [Prism Parameters] */

prism_side_count  = 3;
prism_side_length = 20.0;
prism_height      = 20.0;

/* [Ellipsoid Parameters] */

ellipsoid_diameter_x = 20.0;
ellipsoid_diameter_y = 20.0;
ellipsoid_diameter_z = 20.0;

/* [Torus Parameters] */

torus_major_radius = 12.0;
torus_minor_radius = 6.0;

/* [Bore Parameters] */

x_bore_diameter         = 10;
y_bore_diameter         = 10;
z_bore_diameter         = 10;
x_bore_prism_side_count = 4;
y_bore_prism_side_count = 4;
z_bore_prism_side_count = 4;

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Model parameters and geometric constraints. (Class member variables).
//
// - If we treat an OpenSCAD file as though it is an object oriented class, then we can prefix global variables
//   with "m_", to denote class membership. 
//   - As an alternative to "m_", we could also use "this_" as a standard. However, "m_" is shorter and faster to type.
//   - Another advantage of this convention, is that we can arrange parameters meant for display in Thingiverse, in 
//     an order that makes sense to the user, while arranging the member versions of the parameters in an order
//     that better accommodates constraint computation.
//
// - Once we have defined global variables as member variables of a class, in this case the class represented
//   by the SCAD file, then we are free to better manage global vs local scope of class member 
//   variables, vs. local module (method) variables.
//
// - Thingiverse only integrates constant literal values. So as long as we reference other parameters or 
//   initialize variables as expressions, then none of these will appear in the Thingiverse customizer.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// Assembly Parameters

m_object_shape    = object_shape;
m_x_bore_shape    = x_bore_shape;
m_y_bore_shape    = y_bore_shape;
m_z_bore_shape    = z_bore_shape;
m_resolution      = clip ( resolution, C_RESOLUTION_MIN, C_RESOLUTION_MAX );

// Cuboid Parameters.

m_cuboid_x             = ( cuboid_x < C_SIZE_MIN ) ? C_SIZE_MIN : cuboid_x;
m_cuboid_y             = ( cuboid_y < C_SIZE_MIN ) ? C_SIZE_MIN : cuboid_y;
m_cuboid_z             = ( cuboid_z < C_SIZE_MIN ) ? C_SIZE_MIN : cuboid_z;
m_cuboid_min_dimention = ( m_cuboid_x < m_cuboid_y && m_cuboid_x < m_cuboid_z ) ? m_cuboid_x : ( m_cuboid_y < m_cuboid_x && m_cuboid_y < m_cuboid_z ) ? m_cuboid_y : m_cuboid_z;
m_cuboid_fillet        = clip ( cuboid_fillet, 0.0, m_cuboid_min_dimention/2.0 );

// Cylinder Parameters.

m_cylinder_diameter_base = ( cylinder_diameter_base < 0.0 ) ? 0.0 : cylinder_diameter_base;
m_cylinder_diameter_top  = ( cylinder_diameter_top  < 0.0 ) ? 0.0 : cylinder_diameter_top;
m_cylinder_height        = ( cylinder_height < C_SIZE_MIN ) ? C_SIZE_MIN : cylinder_height;

// Pyramid Parameters.

m_pyramid_side_count  = clip ( pyramid_side_count, C_SIDE_COUNT_MIN, C_SIDE_COUNT_MAX );
m_pyramid_side_length = ( pyramid_side_length < C_SIZE_MIN ) ? C_SIZE_MIN : pyramid_side_length;
m_pyramid_height      = ( pyramid_height < C_SIZE_MIN ) ? C_SIZE_MIN : pyramid_height;

// Prism Parameters.

m_prism_side_count  = clip ( prism_side_count, C_SIDE_COUNT_MIN, C_SIDE_COUNT_MAX );
m_prism_side_length = ( prism_side_length < C_SIZE_MIN ) ? C_SIZE_MIN : prism_side_length;
m_prism_height      = ( prism_height < C_SIZE_MIN ) ? C_SIZE_MIN : prism_height;

// Ellipsoid Parameters.

m_ellipsoid_diameter_x = ( ellipsoid_diameter_x < C_SIZE_MIN ) ? C_SIZE_MIN : ellipsoid_diameter_x;
m_ellipsoid_diameter_y = ( ellipsoid_diameter_y < C_SIZE_MIN ) ? C_SIZE_MIN : ellipsoid_diameter_y;
m_ellipsoid_diameter_z = ( ellipsoid_diameter_z < C_SIZE_MIN ) ? C_SIZE_MIN : ellipsoid_diameter_z;

// Torus Parameters.

m_torus_major_radius = ( torus_major_radius < C_SIZE_MIN ) ? C_SIZE_MIN : torus_major_radius;
m_torus_minor_radius = ( torus_minor_radius < C_SIZE_MIN ) ? C_SIZE_MIN : torus_minor_radius;

// Bore.

m_x_bore_diameter         = ( x_bore_diameter < C_SIZE_MIN ) ? C_SIZE_MIN : x_bore_diameter;
m_y_bore_diameter         = ( y_bore_diameter < C_SIZE_MIN ) ? C_SIZE_MIN : y_bore_diameter;
m_z_bore_diameter         = ( z_bore_diameter < C_SIZE_MIN ) ? C_SIZE_MIN : z_bore_diameter;
m_x_bore_prism_side_count = clip ( x_bore_prism_side_count, C_SIDE_COUNT_MIN, C_SIDE_COUNT_MAX );
m_y_bore_prism_side_count = clip ( y_bore_prism_side_count, C_SIDE_COUNT_MIN, C_SIDE_COUNT_MAX );
m_z_bore_prism_side_count = clip ( z_bore_prism_side_count, C_SIDE_COUNT_MIN, C_SIDE_COUNT_MAX );

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// DEBUG: Console Output. 
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

C_DEBUG_ENABLED = false;

if ( C_DEBUG_ENABLED )
{
    //echo ( m_x = m_x ); 
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      Main
// Module Type: Model
//
// Description:
//
// - Program entry point.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

main();

module main ()
{   
    // Initialize model resolution.
    
    $fn = m_resolution;
    
    // Generate hinge assembly.
        
    assembly ();    
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      assembly_main
// Module Type: Assembly
//
// Description:
//
// - Main component assembly.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module assembly ()
{
    if      ( m_object_shape == C_SHAPE_NONE )      object_none ();
    else if ( m_object_shape == C_SHAPE_CUBOID )    object_cuboid ();
    else if ( m_object_shape == C_SHAPE_CYLINDER )  object_cylinder ();
    else if ( m_object_shape == C_SHAPE_PYRAMID )   object_pyramid ();
    else if ( m_object_shape == C_SHAPE_PRISM )     object_prism ();
    else if ( m_object_shape == C_SHAPE_ELLIPSOID ) object_ellipsoid ();
    else if ( m_object_shape == C_SHAPE_TORUS )     object_torus ();    
    else if ( m_object_shape == C_SHAPE_NONE )      object_none ();    
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      object_none
// Module Type: Object
//
// Description:
//
// - Placeholder module for dealing with zero object selection.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module object_none ()
{
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      object_cuboid
// Module Type: Object
//
// Description:
//
// - Cuboid object defined by width, length, height and fillet size.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module object_cuboid ()
{
    // Initialize parameters.
    
    sf = m_cuboid_fillet;
    sx = m_cuboid_x;
    sy = m_cuboid_y;
    sz = m_cuboid_z;
    
    // Generate object.

    difference ()
    {
        // Generate base object.
        
        if ( sf > 0 )
        {
            object_cuboid_filleted ();
        }
        else
        {
            cube ( size = [ sx, sy, sz ], center = true );
        }
        
        // Subtract bores.
        
        cutting_tool_bore ( sx, sy, sz );
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      object_cuboid_filleted
// Module Type: Object
//
// Description:
//
// - Used by the Cuboid object, to implement fillets.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module object_cuboid_filleted ()
{
    // Local constants.
    
    EDGE_CENTER = 0;    
    EDGE_ANGLE  = 1;
    EDGE_LENGTH = 2;
    
    // Initialize parameters.
    
    sf = m_cuboid_fillet;
    sx = m_cuboid_x;
    sy = m_cuboid_y;
    sz = m_cuboid_z;
    
    // Generate object.

    difference ()
    {
        // Generate base object.
        
        union ()
        {
            // Create cube work pieces.
            
            c = 2.0*sf;
            cube ( size = [ sx,     sy - c, sz - c ], center = true );
            cube ( size = [ sx - c, sy - c, sz     ], center = true );
            cube ( size = [ sx - c, sy,     sz - c ], center = true );
            
            // Create fillets.
            
            rx = sx/2.0 - sf;
            ry = sy/2.0 - sf;
            rz = sz/2.0 - sf;
            
            ex = m_cuboid_x - 2.0*sf;
            ey = m_cuboid_y - 2.0*sf;;
            ez = m_cuboid_z - 2.0*sf;;
            
            // Create vertex fillets.
            
            n_vertex = 8;
            v_vertex =
            [
                [ rx, ry,  rz ],[ -rx, ry,  rz ], [ -rx, -ry,  rz ], [ rx, -ry,  rz ],
                [ rx, ry, -rz ],[ -rx, ry, -rz ], [ -rx, -ry, -rz ], [ rx, -ry, -rz ]
            ];
                              
            for ( i = [ 0 : n_vertex - 1 ] )
            {
                translate ( v_vertex [ i ] ) sphere ( r = sf, center = true );
            }
            
            // Create edge fillets.
            
            n_edge = 12;
            v_edge =
            [
                [ [  rx,  ry, 0.0 ], [  0.0,  0.0, 0.0 ], ez ], [ [ -rx,  ry, 0.0 ], [  0.0,  0.0, 0.0 ], ez ],
                [ [  rx, -ry, 0.0 ], [  0.0,  0.0, 0.0 ], ez ], [ [ -rx, -ry, 0.0 ], [  0.0,  0.0, 0.0 ], ez ],
                [ [  rx, 0.0,  rz ], [ 90.0,  0.0, 0.0 ], ey ], [ [  rx, 0.0, -rz ], [ 90.0,  0.0, 0.0 ], ey ],
                [ [ -rx, 0.0,  rz ], [ 90.0,  0.0, 0.0 ], ey ], [ [ -rx, 0.0, -rz ], [ 90.0,  0.0, 0.0 ], ey ],
                [ [ 0.0,  ry,  rz ], [  0.0, 90.0, 0.0 ], ex ], [ [ 0.0,  ry, -rz ], [  0.0, 90.0, 0.0 ], ex ],
                [ [ 0.0, -ry,  rz ], [  0.0, 90.0, 0.0 ], ex ], [ [ 0.0, -ry, -rz ], [  0.0, 90.0, 0.0 ], ex ]
            ];
            
            for ( i = [ 0 : n_edge - 1 ] )
            {
                v = v_edge [ i ][ EDGE_CENTER ];
                a = v_edge [ i ][ EDGE_ANGLE  ];
                s = v_edge [ i ][ EDGE_LENGTH ];
                
                echo ( a = a );
                
                translate ( v ) rotate ( a ) cylinder ( r = sf, h = s, center = true );
            }
            
        }
        
        // Subtract bores.
        
        cutting_tool_bore ( sx, sy, sz );
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      object_cylinder
// Module Type: Object
//
// Description:
//
// - Cylinder object defined by base diameter, top diameter and height.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module object_cylinder ()
{
    // Initialize parameters.
    
    d1 = m_cylinder_diameter_base;
    d2 = m_cylinder_diameter_top;
    h  = m_cylinder_height;
    
    // Generate object.
    
    difference ()
    {
        // Generate base object.
        
        cylinder ( d1 = d1, d2 = d2, h = h, center = true );
        
        // Subtract bores.
        
        d_max = ( d1 > d2 ) ? d1 : d2;
        cutting_tool_bore ( sx = d_max, sy = d_max, sz = h );
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      object_pyramid
// Module Type: Object
//
// Description:
//
// - Pyramid object defined by height, side length, and side count.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module object_pyramid ()
{
    // Initialize parameters.
    
    n = m_pyramid_side_count;    
    s = m_pyramid_side_length;
    h = m_pyramid_height;
    t = 180/n;
    
    // Compute base diameter based on side length.
        
    d1 = s/sin(180/n);
    d2 = 0;
    
    // Generate object.
    
    difference ()
    {
        // Generate base object.
        
        rotate ( [ 0, 0, t ] ) cylinder ( d1 = d1, d2 = d2, h = h, $fn = n, center = true );
        
        // Subtract bores.
        
        d_max = ( d1 > d2 ) ? d1 : d2;
        translate ( [ 0, 0, -h/5 ] ) cutting_tool_bore ( sx = d_max, sy = d_max, sz = 2*h );
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      object_prism
// Module Type: Object
//
// Description:
//
// - Prism object defined by height, side length, and side count.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module object_prism ()
{
    // Initialize parameters.
    
    n = m_prism_side_count;    
    s = m_prism_side_length;
    h = m_prism_height;
    t = 180/n;
    
    // Compute base diameter based on side length.
        
    d1 = s/sin(180/n);
    d2 = d1;
    
    // Generate object.
    
    difference ()
    {
        // Generate base object.
        
        rotate ( [ 0, 0, t ] ) cylinder ( d1 = d1, d2 = d2, h = h, $fn = n, center = true );
        
        // Subtract bores.
                
        cutting_tool_bore ( sx = d1, sy = d1, sz = h );
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      object_ellipsoid
// Module Type: Object
//
// Description:
//
// - Ellipsoid object defined by width, length and height.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module object_ellipsoid ()
{
    // Compute ellipsoid scaling.
     
    d  = 1.0;     
    sx = m_ellipsoid_diameter_x;
    sy = m_ellipsoid_diameter_y;
    sz = m_ellipsoid_diameter_z;
    
    // Generate object.
    
    difference ()
    {
        // Generate base object.
        
        scale ( [ sx, sy, sz ] ) sphere ( d = d );
        
        // Subtract bores.
                
        cutting_tool_bore ( sx = sx, sy = sy, sz = sz );
    } 
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      object_torus
// Module Type: Object
//
// Description:
//
// - Torus object defined by major and minor radii.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module object_torus ()
{
    // Initialize parameters.
    
    R = m_torus_major_radius;
    r = m_torus_minor_radius;    
    
    // Generate object.
    
    difference ()
    {
        // Generate base object.
        
        rotate_extrude ()
        {
            translate ( [ R, 0, 0 ] ) circle ( r = r);
        }
        
        // Subtract bores.
        
        s  = 2*( r + R );
        sx = s;
        sy = s;
        sz = 2*r;
        
        cutting_tool_bore ( sx = sx, sy = sy, sz = sz );
    } 
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      cutting_tool_bore
// Module Type: Cutting tool
//
// Description:
//
// - Cutting tool used to cut the bore holes into the base object.
//
// Parameters:
//
// - N/A
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module cutting_tool_bore ( sx, sy, sz )
{
    nx = m_x_bore_prism_side_count;
    ny = m_y_bore_prism_side_count;
    nz = m_z_bore_prism_side_count;
    
    txo = ( nx == 6 ) ? 90.0 :   0.0;
    tyo = ( ny == 6 ) ? 0.0  : -90.0;
    
    tx = 180/nx + txo;
    ty = 180/ny + tyo;
    tz = 180/nz;
            
    // Subtract cylindrical bores.
        
    if ( m_x_bore_shape == C_SHAPE_CYLINDER ) rotate ( [ 0, 90, 0 ] ) cylinder ( d = m_x_bore_diameter, h = sx + SCG_OVERLAP, center = true );
    if ( m_y_bore_shape == C_SHAPE_CYLINDER ) rotate ( [ 90, 0, 0 ] ) cylinder ( d = m_y_bore_diameter, h = sy + SCG_OVERLAP, center = true );
    if ( m_z_bore_shape == C_SHAPE_CYLINDER ) rotate ( [ 0,  0, 0 ] ) cylinder ( d = m_z_bore_diameter, h = sz + SCG_OVERLAP, center = true );
            
    // Subtract prisim bores.
    
    if ( m_x_bore_shape == C_SHAPE_PRISM ) rotate ( [ 0, 90, 0 ] ) rotate ( [ 0, 0, tx ] ) cylinder ( d = m_x_bore_diameter, h = sx + SCG_OVERLAP, $fn = nx, center = true );
    if ( m_y_bore_shape == C_SHAPE_PRISM ) rotate ( [ 90, 0, 0 ] ) rotate ( [ 0, 0, ty ] ) cylinder ( d = m_y_bore_diameter, h = sy + SCG_OVERLAP, $fn = ny, center = true );
    if ( m_z_bore_shape == C_SHAPE_PRISM ) rotate ( [ 0,  0, 0 ] ) rotate ( [ 0, 0, tz ] ) cylinder ( d = m_z_bore_diameter, h = sz + SCG_OVERLAP, $fn = nz, center = true );
}


// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      Rectangle.
// Module Type: 2D Shape.
//
// Description:
//
// - Creates a 2D rectangle.
//
// Parameters:
//
// - w
//   Rectangle width.
//
// - h
//   Rectangle height.
//
// - center
//   Center the rectangle about the origin (0,0,0) if true, else place the rectangle in the positive quadrant.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module fillet_rectangle ( w, h, r, center )
{
    xs = w - 2*r;
    ys = h - 2*r;
    xd = w/2.0 - r;  
    yd = h/2.0 - r;    
    
    union ()
    {
        scale ( [ xs, h  ] ) square ( size = 1.0, center = center );
        scale ( [ w,  ys ] ) square ( size = 1.0, center = center );
        translate ( [  xd,  yd ] ) circle ( r = r, center = center );
        translate ( [  xd, -yd ] ) circle ( r = r, center = center );
        translate ( [ -xd, -yd ] ) circle ( r = r, center = center );
        translate ( [ -xd,  yd ] ) circle ( r = r, center = center );
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      Rectangle.
// Module Type: 2D Shape.
//
// Description:
//
// - Creates a 2D rectangle.
//
// Parameters:
//
// - w
//   Rectangle width.
//
// - h
//   Rectangle height.
//
// - center
//   Center the rectangle about the origin (0,0,0) if true, else place the rectangle in the positive quadrant.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module rectangle ( w, h, center )
{
    scale ( [ w, h ] ) square ( size = 1.0, center = center );
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Function: Clip
//
// Description:
//
// - Clips an input value, to a minimum and maximum value.
//
//   x_min <= x <= x_max
// 
// Parameters:
//
// - x
//   Input value.
//
// - x_min
//   Minimal value constraint. Any x less than x_min, is set to x_min. 
//
// - x_max
//   Maximum value constraint. Any x greater than x_max, is set to x_max.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

function clip ( x, x_min, x_max ) = ( x < x_min ) ? x_min : ( x > x_max ) ? x_max : x;


// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Function: funtion_name
//
// Description:
//
// - Function description.
//
// Return Value:
//
// - Description of return value.
//
// Parameters:
//
// - x
//   Argument x description.
//
// - y
//   Argument y description.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      module_name
// Module Type: [ 2D Shape, Profile, Tool, Workpiece, Component ] 
// Description:
//
// - Module description.
//
// Parameters:
//
// - x
//   Argument x description.
//
// - y
//   Argument y description.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------


