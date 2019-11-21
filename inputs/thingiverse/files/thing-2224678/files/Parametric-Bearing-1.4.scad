// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Title:        Parametric Caged Bearing
// Version:      1.4
// Release Date: 2018-07-28 (ISO 8601)
// Author:       Rohin Gosling
// -------------------------------------------------------------------------------------------------------------------------------------------------------------
//
// Description:
//
//   - Parametric caged ball bearing, designed to be printed in one step, with no post printing 
//     assembly required.
//
//   - Features that are parameterized:
//
//     o Ball count.
//     o Bore. i.e. Inner ring, inner diameter.
//     o Outer diameter. i.e. Outer ring, outer diameter.
//     o Radial gauge. Radial thickness of rings.
//     o Axial gauge. Thickness of axial cage and shoulder walls.
//     o Shoulder height. Radial height of raceway shoulders.
//     o Independent component clearances:
//       - Ball to ring clearance.
//       - Ball to cage clearance.
//     o Inner and outer chamfer size.
//     o Inner and outer knurling features:
//       - Knurling count.
//       - Knurling cut depth.
//       - Knurling cut ratio.
//     o Post printing access ports.
//       Access ports are used to facilitate initial manipulation of the balls, in order to free the balls 
//       from the cage after printing.
//       - The access port diameter is parametizable.
//         In general, the larger the ports the better. But care should be taken not to make the port diameter 
//         to large that it weakens the axial walls of the cage.
//
//   - While no post print assembly is required, it can take quite a bit of effort to free the individual parts
//     after printing. The access ports are designed to aid the process of freeing the balls from the cage.
//
// Release Notes:
//
// - Version 1.4
//   * Removed extended ASCII characters to make the source code compatible with the UTF-8 encoding required by the Thingiverse Customizer.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Constants:
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

// System constants.

C_CONSTANT = 0 + 0;         // Used to hide constant values from Thingiverse. Add to other constants to hide them as well.
C_NULL     = C_CONSTANT;    // Used to specify non assigned value.

// Booleans
// - Used in place of the OpenSCAD booleans for Thingiverse compatibility.

C_FALSE = C_CONSTANT + 0;
C_TRUE  = C_CONSTANT + 1;

// Tolerances and constrain minima and maxima.

C_EXCESS             = C_CONSTANT + 0.5;    // Small overshoot used to prevent modelling artefacts during cuts (differences) at co-planar faces.
C_MIN_GAUGE          = C_CONSTANT + 0.01;   // Minimum gauge size.
C_MIN_KNURLING_COUNT = C_CONSTANT + 1;      // Minimum knurling count.
C_MIN_RESOLUTION     = C_CONSTANT + 32;     // Minimum model resolution.
C_MIN_BALL_COUNT     = C_CONSTANT + 3;      // Minimum number of balls.

// debugging constants.

C_EXTRUDE_ENABLED       = C_TRUE;
C_BALL_TEMPLATE_ENABLED = C_FALSE;
C_CONSOLE_LOG_ENABLED   = C_TRUE;


// -------------------------------------------------------------------------------------------------------------------------------------------------------------
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
//   Thingiverse, vs. the ordering of variables used internally by the model.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

// Model options.

// We use integer values for Thingiverse booleans, because Thingiverse does not support boolean values
// at this time (2017-03-25).

/* [Model Options] */

// Recommended value of 64 or more. Default = 128.
resolution                      = 128;
enable_inner_ring               = 1;     // [ 0:No, 1:Yes ]
enable_outer_ring               = 1;     // [ 0:No, 1:Yes ]
enable_cage                     = 1;     // [ 0:No, 1:Yes ]
enable_balls                    = 1;     // [ 0:No, 1:Yes ]
enable_inner_ring_chamfer       = 1;     // [ 0:No, 1:Yes ]
enable_outer_ring_chamfer       = 1;     // [ 0:No, 1:Yes ]
enable_inner_ring_knurling      = 1;     // [ 0:No, 1:Yes ]
enable_outer_ring_knurling      = 1;     // [ 0:No, 1:Yes ]
// Recommended to accommodate support material for the balls. 
enable_bottom_cage_access_ports = 1;     // [ 0:No, 1:Yes ]
enable_top_cage_access_ports    = 1;     // [ 0:No, 1:Yes ]

/* [Ring and Cage] */

bore                      = 20.15;  // Add 0.15 for a tight fit on loosly sanded 20mm PVC pipe. Or, +0.2 for a loose fit on 20mm PVC pipe.
outer_diameter            = 50.0;
shoulder_height           = 1.0;
radial_gauge              = 2.0;
axial_gauge               = 1.0;
cage_access_port_diameter = 2.5;

/* [Mechanical Parameters] */

ball_count          = 9;
ball_ring_clearance = 0.1;
// Recommended, 2x greater than ball ring clearance, or more.
ball_cage_clearance = 0.4;

/* [Feature Parameters] */

inner_chamfer_size       = 1.0;
outer_chamfer_size       = 1.0;

inner_knurling_count     = 3;
inner_knurling_depth     = 1.0;
inner_knurling_cut_ratio = 0.2;

outer_knurling_count     = 18;
outer_knurling_depth     = 1.0;
outer_knurling_cut_ratio = 0.2;

/* [Color Settings] */

enable_multiple_colors = 0;     // [ 0:No, 1:Yes ] 
// Used if "Enable Multiple Colors" is set to "No".
default_color          = "silver";
inner_ring_color       = "red";
outer_ring_color       = "blue";
ball_color             = "yellow";
cage_color             = "green";

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Model parameters and geometric constraints. (Class member variables).
//
// - If we treat an SCAD file as though it is an object oriented class, then we can prefix global variables
//   with "m_", to denote class membership. 
//   As an alternative to "m_", we could also use "this_" as a standard.
//   However, "m_" is shorter and faster to type.
//
// - Once we have defined global variables as member variables of a class, in this case the class represented
//   by the SCAD file, then we are free to better manage global vs local scope of class member 
//   variables, vs. local module (method) variables.
//
// - Thingiverse only integrates constant literal values. So as long as we reference other parameters or 
//   initialize variables as expressions, then none of these will appear in the Thingiverse customizer.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

// Integer to Boolean conversion.

m_inner_ring_enabled               = ( enable_inner_ring               == 1 ) ? true : false;
m_outer_ring_enabled               = ( enable_outer_ring               == 1 ) ? true : false;
m_cage_enabled                     = ( enable_cage                     == 1 ) ? true : false; 
m_balls_enabled                    = ( enable_balls                    == 1 ) ? true : false;
m_inner_ring_chamfer_enabled       = ( enable_inner_ring_chamfer       == 1 ) ? true : false;
m_outer_ring_chamfer_enabled       = ( enable_outer_ring_chamfer       == 1 ) ? true : false;
m_inner_ring_knurling_enabled      = ( enable_inner_ring_knurling      == 1 ) ? true : false;
m_outer_ring_knurling_enabled      = ( enable_outer_ring_knurling      == 1 ) ? true : false;
m_bottom_cage_access_ports_enabled = ( enable_bottom_cage_access_ports == 1 ) ? true : false;
m_top_cage_access_ports_enabled    = ( enable_top_cage_access_ports    == 1 ) ? true : false;
m_colors_enabled                   = ( enable_multiple_colors          == 1 ) ? true : false;

// Mechanical parameters.

m_ball_ring_clearance = clip ( ball_ring_clearance, 0.0, 1.2 );
m_ball_cage_clearance = clip ( ball_cage_clearance, 0.0, 1.2 );
m_cage_ring_clearance = 0.2 + m_ball_ring_clearance + m_ball_cage_clearance;

// Bearing parameters.

m_radial_gauge    = ( radial_gauge >= C_MIN_GAUGE ) ? radial_gauge : C_MIN_GAUGE;
m_axial_gauge     = ( axial_gauge >= C_MIN_GAUGE ) ? axial_gauge : C_MIN_GAUGE; 
m_bore            = ( bore >= 0.0 ) ? bore : 0.0;
m_outer_diameter  = ( outer_diameter >= m_bore + 4.0*( 1.0 + m_radial_gauge + C_MIN_GAUGE ) ) ? outer_diameter : m_bore + 4.0*( 1.0 + m_radial_gauge + C_MIN_GAUGE );
m_shoulder_height = clip ( shoulder_height, 0.0, ( ( m_outer_diameter/2.0 - m_radial_gauge ) - ( m_bore/2.0 + m_radial_gauge ) )/2.0 - 2.0*m_ball_ring_clearance );
m_ball_diameter   = ( m_outer_diameter - m_bore )/2.0 - 2.0*m_radial_gauge;
m_width           = m_ball_diameter + 2.0*m_axial_gauge;
m_pitch_radius    = m_bore/2.0 + ( m_outer_diameter - m_bore )/4.0;
m_max_ball_count  = max_ball_count ( m_pitch_radius, m_ball_diameter );
m_ball_count      = clip ( ball_count, C_MIN_BALL_COUNT, m_max_ball_count );

// Cage parameters.

m_access_port_diameter = clip ( cage_access_port_diameter, 0.0, ( ( m_outer_diameter/2.0 - m_radial_gauge - m_shoulder_height ) - ( m_bore/2.0 + m_radial_gauge + m_shoulder_height ) )/2.0 - 2.0*m_cage_ring_clearance );

// Feature parameters. knurling

m_inner_chamfer_size       = clip ( inner_chamfer_size, 0.0, m_radial_gauge + m_shoulder_height );
m_outer_chamfer_size       = clip ( outer_chamfer_size, 0.0, m_radial_gauge + m_shoulder_height );

m_inner_knurling_count     = ( inner_knurling_count >= C_MIN_KNURLING_COUNT ) ? inner_knurling_count : C_MIN_KNURLING_COUNT;
m_inner_knurling_depth     = clip ( inner_knurling_depth, 0.0, m_radial_gauge - C_MIN_GAUGE );
m_inner_knurling_cut_ratio = clip ( inner_knurling_cut_ratio, 0.0, 1.0 );

m_outer_knurling_count     = ( outer_knurling_count >= C_MIN_KNURLING_COUNT ) ? outer_knurling_count : C_MIN_KNURLING_COUNT;
m_outer_knurling_depth     = clip ( outer_knurling_depth, 0.0, m_radial_gauge - C_MIN_GAUGE );
m_outer_knurling_cut_ratio = clip ( outer_knurling_cut_ratio, 0.0, 1.0 );

// Model options.

m_resolution        = ( resolution >= C_MIN_RESOLUTION ) ? resolution : C_MIN_RESOLUTION;
m_sphere_resolution = 3.0*m_resolution/5.0;
m_default_color     = default_color;
m_inner_ring_color  = inner_ring_color;
m_outer_ring_color  = outer_ring_color;
m_ball_color        = ball_color;
m_cage_color        = cage_color;


// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Display data to console.
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

if ( C_CONSOLE_LOG_ENABLED )
{
    echo ( cage_ring_clearance  = m_cage_ring_clearance );
    echo ( ball_diameter        = m_ball_diameter - m_ball_ring_clearance );
    echo ( width                = m_width );
    echo ( bore                 = m_bore );
    echo ( pitch_radius         = m_pitch_radius );
    echo ( outer_diameter       = m_outer_diameter );
    echo ( ball_count           = m_ball_count );
    echo ( shoulder_height      = m_shoulder_height );
    echo ( access_port_diameter = m_access_port_diameter );
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Main
// Module Type: Model
//
// Description:
//
// - Program entry point.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

main();

module main ()
{
    // Initialize model resolution.
    
    $fn = m_resolution;
        
    // Generate model.

    if ( m_inner_ring_enabled ) component_inner_ring ();
    if ( m_outer_ring_enabled ) component_outer_ring ();
    if ( m_balls_enabled )      component_ball_array ( m_ball_count, m_ball_diameter, m_ball_ring_clearance );
    if ( m_cage_enabled )       component_cage ();
        
    // Debugging code.
    
    if ( C_BALL_TEMPLATE_ENABLED ) profile_ball_template ();       
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Ball Array
// Module Type: Component
//
// Description:
//
// - Creates a circular array of ball bearings.
// - This is used both for the purpose of generating the actual array of ball bearings, as well as for the 
//   purpose of creating a cutting tool to cut out space for the balls in the cage.
//
// Parameters:
//
// - count
//   Number of balls to create. Note, this module does not check for minimum or maximum ball counts.
//
// - diameter
//   The diameter for each balls.
//
// - clearance
//   Reduction in the radius of each ball, to accommodate component clearance.
//   Note: clearance reduces the radius by clearance mm, not the diameter.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module component_ball_array ( count, diameter, clearance )
{
    // Retrieve class member data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    radial_gauge    = m_radial_gauge;
    bore            = m_bore;
    component_color = ( m_colors_enabled ) ? m_ball_color : m_default_color;
    
    // Generate ball array.
    
    color ( component_color )
    
    if ( C_EXTRUDE_ENABLED )
    {
        // Compute ball diameter, reduced by ball-ring clearance.
        
        d = diameter - 2.0*clearance;
        
        // Compute the radial translation of the ball array. i.e. the bearing pitch.
        
        tx = ( bore + d ) / 2 + radial_gauge + clearance;
        ty = 0.0;
        tz = 0.0;
        
        // Compute the angular translation between each ball, relative to the ball count.
            
        tr = 360 / count;
        
        // Generate the ball array.
        
        for ( i = [ 0 : count ] )
        {    
            tri = tr * i;
            rotate ( [ 0, 0, tri ] ) translate ( [ tx, ty, tz ] ) sphere ( d = d, $fn = m_sphere_resolution );
        }
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Inner Ring
// Module Type: Component
//
// Description:
//
// - Creates the inner ring.
//
// Parameters:
//
// - N/A
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module component_inner_ring ()
{   
    if ( C_EXTRUDE_ENABLED )
    {
        component_color = ( m_colors_enabled ) ? m_inner_ring_color : m_default_color;
        
        color ( component_color )
        difference ()
        {
            // Extrude the 3D object.
            
            rotate_extrude()
            profile_inner_ring ();
            
            // Cut knurling.
            
            if ( m_inner_ring_knurling_enabled )
            {
                cutting_tool_inner_knurling ();
            }
        }
        
    }
    else
    {
        // Sow only the profile for debugging purposes.
        
        profile_inner_ring ();
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Outer Ring.
// Module Type: Component
//
// Description:
//
// - Creates the outer ring.
//
// Parameters:
//
// - N/A
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module component_outer_ring ()
{   
    if ( C_EXTRUDE_ENABLED )
    {
        component_color = ( m_colors_enabled ) ? m_outer_ring_color : m_default_color;
        
        color ( component_color )
        difference ()
        {        
            // Extrude the 3D object.
            
            rotate_extrude()
            profile_outer_ring ();

            // Cut Knerling;
            
            if ( m_outer_ring_knurling_enabled )
            {
                cutting_tool_outer_knurling ();
            }
        }        
    }
    else
    {
        // Sow only the profile for debugging purposes.
        
        profile_outer_ring ();
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Cage.
// Module Type: Component
//
// Description:
//
// - Creates the bearing cage.
//
// Parameters:
//
// - N/A
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module component_cage ()
{   
    // Retrieve class member data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    ball_count          = m_ball_count;    
    ball_diameter       = m_ball_diameter;
    ball_ring_clearance = m_ball_ring_clearance;
    ball_cage_clearance = m_ball_cage_clearance;
    component_color     = ( m_colors_enabled ) ? m_cage_color : m_default_color;
    
    // Generate component.
    
    if ( C_EXTRUDE_ENABLED )
    {
        // Compute relative cage clearance.
        
        ball_cut_diameter = ball_diameter - ball_ring_clearance;
        clearance         = -ball_cage_clearance;
        
        // Loft the 3D object.
        
        color ( component_color )
        difference ()
        {
            // Cage frame.
            
            rotate_extrude()
            profile_cage ();
            
            // Ball enclusure.
            
            component_ball_array ( ball_count, ball_cut_diameter, clearance );
            
            // Access ports.
                
            cutting_tool_access_port_array ();
        }
    }
    else
    {
        // Sow only the profile for debugging purposes.
        
        profile_cage ();
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Access port array cutting tool.
// Module Type: Cutting tool.
//
// Description:
//
// - Creates a cutting tool used to cut access ports into the cage.
//
// Parameters:
//
// - N/A
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module cutting_tool_access_port_array ()
{
    // Retrieve class member data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    width                            = m_width;
    access_port_diameter             = m_access_port_diameter;
    pitch_radius                   = m_pitch_radius;
    ball_count                       = m_ball_count;
    bottom_cage_access_ports_enabled = m_bottom_cage_access_ports_enabled;
    top_cage_access_ports_enabled    = m_top_cage_access_ports_enabled;
    
    // Configure access port dimensions.
    
    e  = C_EXCESS;
    ah = width / 2.0 + e;
    ar = access_port_diameter;    
    
    // Compute cutting tool component translations.
    
    tx0 = pitch_radius;
    ty0 = 0.0;
    tz0 = -ah;
    
    tx1 = pitch_radius;
    ty1 = 0.0;
    tz1 = 0.0;
    
    // Compute the angular translation between each cutting tool component, relative to the ball count.
            
    tr = 360 / ball_count;
        
    // Generate the cutting tool array.
        
    for ( i = [ 0 : ball_count ] )
    {    
        tri = tr * i;
        rotate ( [ 0, 0, tri ] )
        {
            // Generate bottom access port cutting tool components.
            
            if ( bottom_cage_access_ports_enabled )
            {
                translate ( [ tx0, ty0, tz0 ] ) cylinder ( h = ah, r = ar, center = false );
            }
            
            // Generate top access port cutting tool components.
            
            if ( top_cage_access_ports_enabled )
            {
                translate ( [ tx1, ty1, tz1 ] ) cylinder ( h = ah, r = ar, center = false );
            }            
        }
    }        
}


// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Inner knurling cutting tool.
// Module Type: Cutting tool.
//
// Description:
//
// - Creates a cutting tool to cut knurling notches into the inner ring.
//
// Parameters:
//
// - N/A
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module cutting_tool_inner_knurling ()
{
    // Retrieve global parameters.
    
    e = C_EXCESS;                   // Extra length used to eliminate floating point difference errors during boolean operations.
    n = m_inner_knurling_count;     // Number of knurling cuts.
    d = m_inner_knurling_depth + e; // Cut depth.
    k = 360.0 / n;                  // Arc length in degrees.
    p = m_inner_knurling_cut_ratio; // Knurling cut ratio.
    w = m_width + 2.0*e;            // Bearing width.
    
    // Generate cutting tool.
    
    for ( i = [ 0 : n-1 ] )
    {
        // Compute rotation and cut ratio angles.
        
        t = i*k;
        a = p*k;
        
        // Compute radial translation.
        
        tx = m_bore/2.0 - e;
        ty = -w/2.0;
                
        // Generate cutting tool parts.
        
        tz = t - a/2.0;
        
        rotate ( [ 0.0, 0.0, tz ] )
        {
            cylinder_sector
            (
                inner_radius = tx,
                outer_radius = tx + d,
                height       = w,
                angle        = a,
                tessellation = m_resolution,
                center       = true
            );
        }        
    }
}       

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Outer knurling cutting tool.
// Module Type: Cutting tool.
//
// Description:
//
// - Creates a cutting tool to cut knurling notches into the outer ring.
//
// Parameters:
//
// - N/A
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module cutting_tool_outer_knurling ()
{
    // Retrieve global parameters.
    
    e = C_EXCESS;                   // Extra length used to eliminate gloating point difference errors during boolean operations.
    n = m_outer_knurling_count;     // Number of knurling cuts.
    d = m_outer_knurling_depth + e; // Cut depth.
    k = 360.0 / n;                  // Arc length in degrees.
    p = m_outer_knurling_cut_ratio; // Knurling cut ratio.
    w = m_width + 2.0*e;            // Bearing width.
    
    // Generate cutting tool.
    
    for ( i = [ 0 : n-1 ] )
    {
        // Compute rotation and cut ratio angles.
        
        t = i*k;
        a = p*k;
        
        // Compute radial translation.
        
        tx = m_outer_diameter/2.0 - d + e;
        ty = -w/2.0;
        
        // Generate cutting tool parts.
        
        tz = t - a/2.0;
        
        rotate ( [ 0.0, 0.0, tz ] )
        {
            cylinder_sector
            (
                inner_radius = tx,
                outer_radius = tx + d,                    
                height       = w,
                angle        = a,
                tessellation = m_resolution,
                center       = true
            );
        }        
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Inner ring.
// Module Type: Profile.
//
// Description:
//
// - Creates the 2D extrusion profile of the inner ring.
//
// Parameters:
//
// - N/A
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module profile_inner_ring ()
{
    // Retrieve class member data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    bore                       = m_bore;
    inner_ring_chamfer_enabled = m_inner_ring_chamfer_enabled;
    inner_chamfer_size         = m_inner_chamfer_size;
    
    // Compute translation.
    
    tx = bore / 2.0;
    ty = 0.0;
    tz = 0.0;
    
    // Generate profile.
    
    translate ( [ tx, ty, tz ] ) profile_ring ( inner_ring_chamfer_enabled, inner_chamfer_size );
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Outer ring.
// Module Type: Profile.
//
// Description:
//
// - Creates the 2D extrusion profile of the outer ring.
//
// Parameters:
//
// - N/A
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module profile_outer_ring ()
{
    // Retrieve class member data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    bore                       = m_bore;
    radial_gauge               = m_radial_gauge;
    ball_diameter              = m_ball_diameter;    
    outer_ring_chamfer_enabled = m_outer_ring_chamfer_enabled;
    outer_chamfer_size         = m_outer_chamfer_size;
    
    // Compute translation.
    
    tx = m_outer_diameter/2.0;

    // Generate profile.

    translate ( [ tx, 0.0, 0.0 ] ) rotate ( [ 0.0, 0.0, 180 ] ) profile_ring ( outer_ring_chamfer_enabled, outer_chamfer_size );
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Ring.
// Module Type: Profile.
//
// Description:
//
// - Creates the general 2D extrusion profile for the inner and outer rings.
//
// Parameters:
//
// - chamfer_enabled
//   Include chamfer profile if true, else exclude chamfer.
//
// - chamfer_size
//   Specify the orthogonal size of the chamfer. 
//   This will only be used in the event that chamfer_enabled is true.
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module profile_ring ( chamfer_enabled, chamfer_size )
{
    // Retrieve class member data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    radial_gauge    = m_radial_gauge;
    shoulder_height = m_shoulder_height;
    width           = m_width;
    ball_diameter   = m_ball_diameter;
    
    // Compute ring geometry.
    
    rsx = radial_gauge + shoulder_height;
    rsy = width;
    
    // Compute ring translation.
    
    rtx = rsx / 2.0;
    rty = 0.0;
    rtz = 0.0;    
    
    // Compute ball raceway geometry.
    
    bsd = ball_diameter;
    
    // Compute ball raceway translation.
    
    btx = bsd / 2.0 + radial_gauge;
    bty = 0.0;
    btz = 0.0;
    
    // Compute chamfer geometry;
    
    cr = 2*chamfer_size;
    cs = sqrt ( ( cr * cr ) / 2.0 );
    
    // Compute chamfer translation.
    
    ctx = 0.0;
    cty = width / 2.0;
    ctz = 0.0;
    
    // Generate profile.
    
    difference ()
    {
        // Target = uncut inner ring profile.
        
        translate ( [ rtx, rty, rtz ] ) rectangle ( rsx, rsy, center = true );
        
        // Cut away raceway.
        
        translate ( [ btx, bty, btz ] ) circle    ( d = bsd );
        
        // Cut away left and right side chamfers.
        
        if ( chamfer_enabled )
        {
            translate ( [ ctx,  cty, ctz ] ) rotate ( [ 0, 0, 45 ] ) square ( size = cs, center = true );
            translate ( [ ctx, -cty, ctz ] ) rotate ( [ 0, 0, 45 ] ) square ( size = cs, center = true );
        }
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Cage.
// Module Type: Profile.
//
// Description:
//
// - Creates the profile used to extrude the bearing cage.
//
// Parameters:
//
// - N/A
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module profile_cage ()
{
    // Retrieve class member data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    ball_diameter       = m_ball_diameter;
    shoulder_height     = m_shoulder_height;
    cage_ring_clearance = m_cage_ring_clearance;
    width               = m_width;
    ball_diameter       = m_ball_diameter;
    cage_ring_clearance = m_cage_ring_clearance;
    pitch_radius        = m_pitch_radius;
    
    // Compute cage geometry.
    
    csx = ball_diameter - 2.0*( shoulder_height + cage_ring_clearance );
    csy = width;
    
    // Compute ball enclosure geometry.
    
    bd = ball_diameter - 2.0*cage_ring_clearance;
    
    // Compute cage translation.
    
    tx = pitch_radius;
    ty = 0.0;
    tz = 0.0;    
    
    // Generate profile.
    
    translate ( [ tx, ty, tz ] )
    {
        union ()
        {
            rectangle ( csx, csy, center = true );        
            circle    ( d = bd );
        }
    }
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Debugging and design ball template.
// Module Type: Profile.
//
// Description:
//
// - This is a 2D profile of a ball, used for debugging and designing the rings and cage.
// - The ball template may be turned on by setting the global constant C_BALL_TEMPLATE_ENABLED, to C_TRUE.
//
// Parameters:
//
// - N/A
//
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module profile_ball_template ()
{
    // Retrieve class member data.
    // - We do this to make it easier to change member variable names more easily if we have to in the future.
    // - This also helps us quickly see which global variables we need to access for this module.
    // - Also neatens up our computation a bit, by removing the "m_" from the local module variable names.
    
    ball_diameter       = m_ball_diameter;
    ball_ring_clearance = m_ball_ring_clearance;
    bore                = m_bore;
    radial_gauge        = m_radial_gauge;
    ball_ring_clearance = m_ball_ring_clearance;
    
    // Generate 2D ball template.


    d = m_ball_diameter - 2*m_ball_ring_clearance;
    
    tx = ( m_bore + d ) / 2 + m_radial_gauge + m_ball_ring_clearance;
    ty = 0.0;
    tz = 0.0;
    
    translate ( [ tx, ty, tz ] ) circle ( d = d );
    
}

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
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
// -------------------------------------------------------------------------------------------------------------------------------------------------------------

module rectangle ( w, h, center )
{
    scale ( [ w, h ] ) square ( size = 1.0, center = center );
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
// Module:      Cylinder sector.
// Module Type: 2D Shape.
//
// Description:
//
// - Creates a cylindrical sector object.
//
// Parameters:
//
// - radius:
//   Radius of the cylinder sector.
//
// - height:
//   Height of the cylinder sector.
//
// - angle:
//   The central angle (angular distance) of the cylinder sector, measured in degrees.
// 
// - tessellation:
//   The tessellation factor is the dynamically adjusted polygon side count.
//   - For example, given a central angle of 360 degrees (i.e. a complete cylinder), and a tessellation of 8, the
//     module will generate a cylindrical solid with 8 sides.
//   - Given a central angle of 180 degrees (i.e. a half disk cylinder), and again a tessellation of 8, the 
//     module will generate a cylindrical solid with the number of sides dynamically adjusted to 4 sides in 
//     order to keep the tessellation resolution consistent. 
//   
// - center:
//   Boolean flag used to set the geometric center of the object.
//   - If true, the geometric center of the object is located about the origin, (0,0,0).
//   - If false, the base of the cylinder is located about the origin, (0,0,0).
//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------

module cylinder_sector ( inner_radius, outer_radius, height, angle, tessellation, center )
{   
    // Local Constants
    
    DEBUG_ENABLED    = false;
    TESSELLATION_MAX = 4;
    ANGLE_MIN        = 0;
    ANGLE_MAX        = 360;
    HEIGHT_MIN       = 0;
    E                = 0.01;    // Inner vs. outer radius tolerance, used when inner radius equals outer radius.       
    
    // Clip parameters and initialize local variables.
    
    t  = ( angle        <  ANGLE_MIN        ) ? ANGLE_MIN        : ( angle > ANGLE_MAX ) ? ANGLE_MAX : angle;
    h  = ( height       <  HEIGHT_MIN       ) ? HEIGHT_MIN       : height;
    ri = ( inner_radius <  ANGLE_MIN        ) ? ANGLE_MIN        : inner_radius;
    ro = ( outer_radius <= inner_radius     ) ? inner_radius + E : outer_radius;
    tn = ( tessellation <  TESSELLATION_MAX ) ? TESSELLATION_MAX : tessellation;    
    
    // Compute dynamicly adjusted tessellation.
    
    n  = ceil ( tn * t / ANGLE_MAX );     
    
    // Generate 2D geometry
    
    i = 0;      // Point index. Initialize to zero.    
    v = [];     // Empty vector from which to recursively build output vectors.
    
    points_inner = arc_vector ( ri, t, n, i, v );
    points_outer = arc_vector ( ro, t, n, i, v );    
    points       = concat ( points_inner, points_outer );
    
    // Compile index sequence.
    
    indices_inner = index_vector ( n + 1,   i,     v );
    indices_outer = index_vector ( 2*n + 2, n + 1, v );
    indices       = [ concat ( indices_inner, vector_reverse ( indices_outer, len ( indices_outer ) ) ) ];
    
    // Generate 3D object.

    linear_extrude ( height = h, center = center )
    polygon ( points, indices );
    
    // Debug.
    
    if ( DEBUG_ENABLED )
    {
        echo ( t  = t );
        echo ( h  = h );
        echo ( ri = ri );
        echo ( ro = ro );
        echo ( tn = tn );
        echo ( n  = n );
    }
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
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
//--------------------------------------------------------------------------------------------------------------------------------------------------------------

function clip ( x, x_min, x_max ) = ( x < x_min ) ? x_min : ( x > x_max ) ? x_max : x;

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
// Function: Compute maximum ball count.
//
// Description:
// 
// - Computes the maximum ball count, based on the ball pitch radius and the ball diameter.
//
//       2*PI*r
//   n = ------
//         d
//
// - Note:
//   This equation treats the ball array as a linear array of balls, and does not accommodate the actual angular 
//   contact points between the balls.
//
// Parameters:
//
// - r
//   Ball pitch radius.
//   
// - d
//   Ball radius.
//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------

function max_ball_count ( r, d ) = floor ( 2.0*PI*r/d );

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
// Function: Vector reverse.
//
// Description:
//
// - Recursive vector reverse function.
//
// Parameters:
//
// - v
//   The vector to be reversed.
//
// - length
//   The length of the vector to be reversed. Initialize to, len ( v ).
//
// Example:
//
//   x = [ 1, 2, 3, 4 ];
//   y = reverse ( x, len ( x ) );
//   echo ( y = y );
//
//   ECHO: y = [4, 3, 2, 1]
//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------
    
function vector_reverse ( v, length ) =
(
    length <= 0

    // Recursive terminating condition:
    //   Return an empty vector.

    ? []
    
    // Recursive general condition:
    //   Append the reverse of everything up to the last element, to the last element.        
    
    : concat ( v [ length - 1 ], vector_reverse ( v, length - 1 ) )
);

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
// Function: Generate and index vector.
//
// Description:
//
// - Recursive function that generates an n dimensional vector of integers, in the range [0..n-1].
//
// Parameters:
//
// - n
//   Number of elements in the vector.
//
// - i
//   Element index. Initialize to zero.
//
// - v
//   Vector to be populated with sequence. Initialize with an empty vector, [].
//
// Example:
//
//   n = 8;
//   i = 0;
//   v = [];
//   x = count_loop ( n, i, v );
//   echo ( x = x );
//  
//   ECHO: x = [0, 1, 2, 3, 4, 5, 6, 7 ]
//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------

function index_vector  ( n, i, v ) =
(
    i >= n
    
    // Recursive terminating condition:
    //   Just return the input vector unchanged.
    
    ? v
    
    // Recursive general condition:
    //   Add the next index to the input vector.
    
    : index_vector  ( n, i + 1, concat ( v, [ i ] ) )
);

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
// Function: Generate an arc vector point array.
//
// Description:
//
// - Recursive function to generate an array of 2D points on an arc.
//
// Parameters:
//
// - r
//   Pie slice radius. Initialize to the radius of the pie slice.
//
// - t
//   Arc angle.
//
// - n
//   Tessellation factor. Initialize to the number of arc segments.
//
// - i
//   Point index. Initialize to zero.
//
// - v
//   Vector that will be populated with geometry points. Initialize to empty vector, [].
//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------

function arc_vector ( r, t, n, i, v ) =
(
    i>n

    // Recursive terminating condition:
    //   Return an empty vector.

    ? concat ( v, [] )

    // Recursive general condition:
    //   Compute the next angular point of the pie slice.
    //   x = r*cos(i*t/n), where i is the point index, t is the arc angle, and n is the tessellation factor.
    //   y = r*sin(i*t/n), where i is the point index, t is the arc angle, and n is the tessellation factor.

    : arc_vector ( r, t, n, i + 1, concat ( v, [ [ r*cos ( i*t/n ), r*sin ( i*t/n ) ] ] ) )
);

// -------------------------------------------------------------------------------------------------------------------------------------------------------------
// 
// -------------------------------------------------------------------------------------------------------------------------------------------------------------
