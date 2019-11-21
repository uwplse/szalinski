// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Title:        Parametric Butt Hinge
// Version:      3.5.2
// Release Date: 2017-05-26 (ISO)
// Author:       Rohin Gosling
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
//
// Description:
//
// - Parametric butt hinge, designed to be printed in one step.
//
// - While the entire working hinge may be printed in one step, it is also possible to disabled the internal fused pin, and leave a shaft
//   which may be used in the case where an external pin is desired.
//
// Release Notes:
//
// - Version 3.5.2
//   * Removed extended ASCII characters to make the source code compatible with the UTF-8 encoding required by the Thingiverse Customizer.
//
// - Version 3.5
//   * For hexagonal counterbores, the hexagonal cut has been rotated 90 degrees, to reduce the need for support material.
//     The overhang angle for hexagonal counterbore is 60 degrees.
//
// - Version 3.4
//   * Added support for linear and parabolic gusset curves.
//   * Factored out all SCG (Solid Constructive Geometry) overlap constants, and consolidated them into one global constant, "SCG_OVERLAP".
//
// - Version 3.3
//   * Placed pin shaft parameters into their own parameter group in the Thingiverse Customizer.
//
// - Version 3.2
//   * Added support for independently configurable top and bottom pin shaft counterbores.
//   * Added an assembly option to flip the model about the z-axis. 
//     Usefull for viewing the top and bottom pin shaft counterbores.
//   * Configured the hinge throw angle Thingiverse Customizer parameter step size, to 5 degrees.
//
// - Version 3.1
//   * Added a counterbore feature for the pin shaft.
//     - While this feature may be enabled for one piece hinges that have the fused pin enabled, it is primarily designed for use with two
//       piece configurations that have their pin disabled. For instance, when the hinge is to be assembled using an external pin.
//     - In the case where a hinge is to be assembled using an external pin, it may be desired to have a pin shaft counterbore, where the end
//       caps of the knuckle joint array are counterbored, in order to allow the pin or bolt heads of the pin shaft, to be set flush with the
//       top and bottom edges of the hinge leaves.
//     - To accommodate both hexagonal and square bolt heads and nuts, the counterbore may be set to any one of circular, square or hexagonal.
//   * Added private text feature.
//     - A public parameter for the Thingiverse Customizer has not been added yet, however, users may set the 'text_enabled' local variable
//       in the 'leaf' module to 'true', which will enable a single row of inscribed text on each leaf.
//     - By default this feature will only work when exactly 4 fastener holes have been selected via the 'fastener_count' parameter, simply
//       because there is a nice open space available between the fastener holes for placing text, when 4 fastener holes are chosen.
//     - Text for the male and female leaves may be specified independently.
//
// - Version 3.0
//   * Added a parameter to disable the hinge pin, for when users would like to assemble with an external pin.
//   * Changed the main Thingiverse Customizer parameter group name from "Hinge Options", to "Assembly Options".
//   * Added a parameter to set the hinge throw angle.
//     Users can now set the throw angle, either for analysis and visualisation purposes, or for when the hinge is to be printed vertically
//     standing up on edge, in which case a throw angle of 120 degrees may be used to help keep the hinge stable on the build plate.
//   * Corrected spelling errors in the comments.
//
// - Version 2.9
//   * Added support for parabolic knuckle gussets to strengthen the knuckle joints.
//     Knuckle gussets may now be toggled on and off with the 'enable_knuckle_gusset' parameter.
//
// - Version 2.8
//   * Added the parameter, 'fastener_column_count', to enable single column fastener arrangements, that can be used for
//     piano hinge style fastener arrangements.
//
// - Version 2.7
//   * Rewrote the knuckle cutter module using mode generic math, that enables more parametizable control over knuckle joint 
//     dimensions and configuration.
//
// - Version 2.6
//   * Added support for countersunk fastener holes. Now users can select either counterbore or countersunk. 
//     dimensions and configuration.
//   * Started tracking release updates.
//
// - Version 1.0 - 2.5
//   * N/A - Release updates not tracked.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Constants:
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

// System constants.

C_CONSTANT = 0 + 0;     // Used to hide constant values from Thingiverse. Add to other constants to hide them as well.
C_NONE     = C_CONSTANT + 0;

// Leaf gender.

C_FEMALE   = C_CONSTANT + 0;
C_MALE     = C_CONSTANT + 1;

// SCG constants.

SCG_OVERLAP = C_CONSTANT + 0.01;    // Used for overlapping Boolean operations in order to avoid Boolean edge artefacts.
C_NEGATIVE  = C_CONSTANT + 0;       // Used for subtractive Boolean tools.
C_POSITIVE  = C_CONSTANT + 1;       // Used for additive Boolean tools.

// Bolt head shapes.

C_CIRCULAR  = C_CONSTANT + 0;
C_SQUARE    = C_CONSTANT + 1;
C_HEXAGONAL = C_CONSTANT + 2;

// Curve Type

C_FUNCTION_LINEAR    = C_CONSTANT + 1;      //   y = a*x + b
C_FUNCTION_CIRCULAR  = C_CONSTANT + 2;      // r^2 = x^2 + y^2 
C_FUNCTION_PARABOLIC = C_CONSTANT + 3;      //   y = (a^2)*(x - j)^2 + k    ...Vertex form.

// Minimum and maximum constraints.

C_MIN_HINGE_WIDTH                          = C_CONSTANT + 1.0;
C_MIN_HINGE_HEIGHT                         = C_CONSTANT + 1.0;
C_MIN_LEAF_GAUGE                           = C_CONSTANT + 1.0;
C_MIN_COMPONENT_CLEARENCE                  = C_CONSTANT + 0.1;
C_MAX_COMPONENT_CLEARENCE                  = C_CONSTANT + 1.0;
C_MIN_KNUCKLE_COUNT                        = C_CONSTANT + 3;
C_MAX_KNUCKLE_COUNT                        = C_CONSTANT + 15;
C_MIN_KNUCKLE_GUSSET_WIDTH                 = C_CONSTANT + 1.0; 
C_MIN_FASTENER_MARGIN                      = C_CONSTANT + 1.0; 
C_MIN_PIN_DIAMETER                         = C_CONSTANT + 1.0; 
C_MIN_COUNTER_SINK_DEPTH_STOP              = C_CONSTANT + 1.0; 
C_MIN_FASTENER_THREAD_DIAMETER             = C_CONSTANT + 0.0; 
C_MIN_FASTENER_COUNT                       = C_CONSTANT + 3; 
C_MIN_FASTENER_COLUMN_COUNT                = C_CONSTANT + 1; 
C_MAX_FASTENER_COLUMN_COUNT                = C_CONSTANT + 2; 
C_MIN_TESSELLATION                         = C_CONSTANT + 32; 
C_MAX_TESSELLATION                         = C_CONSTANT + 256;
C_MIN_THROW_ANGLE                          = C_CONSTANT + -90;
C_MAX_THROW_ANGLE                          = C_CONSTANT + 180;
C_DEFAULT_THROW_ANGLE                      = C_CONSTANT + 0;
C_MIN_PIN_SHAFT_COUNTERBORE_DIAMETER       = C_CONSTANT + 0.1;
C_MIN_PIN_SHAFT_COUNTERBORE_WALL_THICKNESS = C_CONSTANT + 0.3;
C_MIN_PIN_SHAFT_COUNTERBORE_DEPTH          = C_CONSTANT + 0.0;


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
//   Thingiverse, vs. the ordering of variables used internally by the model.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

/* [Assembly Options] */

enable_male_leaf             = 1;     // [ 0:No, 1:Yes ]
enable_female_leaf           = 1;     // [ 0:No, 1:Yes ]
enable_fillet                = 1;     // [ 0:No, 1:Yes ]
// Turn this off to omit the hinge pin from the female leaf.
enable_pin                   = 1;     // [ 0:No, 1:Yes ]
// Turn this off to set a custom pin diameter. Auto pin size is equal to the leaf gauge.
enable_auto_pin_size         = 1;     // [ 0:No, 1:Yes ]
enable_pin_shaft_counterbore = 0;     // [ 0:No, 1:Yes ]
enable_fasteners             = 1;     // [ 0:No, 1:Yes ]
knuckle_gusset_type          = 0;     // [ 0:None, 1:Linear, 2:Circular, 3:Parabolic ]
// From +180 degrees fully closed, to -90 degrees fully opened. Default = 0 (ie. Opened flat).
throw_angle                  = 0.0;   // [ -90 : 5 : 180 ]
// Rotates the model 180 degrees about the z-axis.
flip_model                   = 0;     // [ 0:No, 1:Yes ]
// Recommended value is 64 or greater.
resolution                   = 128;
component_color              = "Silver";

/* [Hinge Parameters] */

hinge_width                           = 65.0;
leaf_height                           = 60.0;
// Leaf and knuckle thickness. Values greater than 3mm recommended.
leaf_gauge                            = 5.0;
// Recomended values between 0.3 and 4.0. Better quality below 3.0, tough to loosen.
component_clearance                   = 0.4;
knuckle_count                         = 7;               // [3:2:31]
// Manual pin diameter setting. Only has effect, if "Enable Auto Pin Size" is set to "No".
pin_diameter                          = 3.0;
parametric_pin_diameter               = ( enable_auto_pin_size == 1 ) ? leaf_gauge : pin_diameter;

/* [Pin Shaft Parameters] */

top_pin_shaft_counterbore_diameter    = 6.5;
top_pin_shaft_counterbore_depth       = 2.5;
top_pin_shaft_counterbore_shape       = 0;            // [ 0:Circular, 1:Square, 2:Hexagonal ]
bottom_pin_shaft_counterbore_diameter = 6.0;
bottom_pin_shaft_counterbore_depth    = 2.5;
bottom_pin_shaft_counterbore_shape    = 2;            // [ 0:Circular, 1:Square, 2:Hexagonal ]

/* [Fastener Parameters] */

// For countersunk, the chamfer angle may be adjusted using the other parameters.
fstener_head_type                = 0;   // [ 0:Counterbored, 1:Countersunk ]
counter_sink_depth               = 2.5;
fastener_thread_diameter         = 3.5;
// Add 0.5mm to 1.0mm to the fastener head diameter, to allow for head clearance. 
fastener_head_diameter           = 7.0;
fastener_count                   = 6;   // [3:32]
fastener_column_count            = 2;   // [1,2]
// Distance from the edge of the head diameter, to the edges of the leaves.
fastener_margin                  = 3;


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

// Model Options.

m_male_leaf_enabled             = ( enable_male_leaf              == 1 ) ? true : false;
m_female_leaf_enabled           = ( enable_female_leaf            == 1 ) ? true : false;
m_leaf_fillet_enabled           = ( enable_fillet                 == 1 ) ? true : false;
m_pin_enabled                   = ( enable_pin                    == 1 ) ? true : false;
m_pin_auto_size_enabled         = ( enable_auto_pin_size          == 1 ) ? true : false;
m_pin_shaft_counterbore_enabled = ( enable_pin_shaft_counterbore  == 1 ) ? true : false;
m_fasteners_enabled             = ( enable_fasteners              == 1 ) ? true : false;
m_knuckle_gusset_type           = knuckle_gusset_type;
m_flip_model                    = ( flip_model                    == 1 ) ? true : false;
m_throw_angle                   = clip ( throw_angle, C_MIN_THROW_ANGLE, C_MAX_THROW_ANGLE );

// Leaf Parameters.

m_hinge_width = ( hinge_width <= C_MIN_HINGE_WIDTH ) ? C_MIN_HINGE_WIDTH : hinge_width;
m_leaf_width  = m_hinge_width / 2.0;
m_leaf_height = ( leaf_height <= C_MIN_HINGE_HEIGHT ) ? C_MIN_HINGE_HEIGHT : leaf_height;
m_leaf_gauge  = clip ( leaf_gauge, C_MIN_LEAF_GAUGE, m_leaf_width/2.0 );

// Mechanical Properties.

m_component_clearance  = clip ( component_clearance, C_MIN_COMPONENT_CLEARENCE, C_MAX_COMPONENT_CLEARENCE );
m_knuckle_outer_radius = m_leaf_gauge * 2.0;
m_knuckle_count        = clip ( knuckle_count, C_MIN_KNUCKLE_COUNT, C_MAX_KNUCKLE_COUNT );
m_fastener_margin      = clip ( fastener_margin, C_MIN_FASTENER_MARGIN, ( m_leaf_width - m_leaf_gauge - fastener_head_diameter )/2.0  );
m_knuckle_gusset_width = clip ( m_fastener_margin, C_MIN_KNUCKLE_GUSSET_WIDTH, m_leaf_width - m_leaf_gauge - m_component_clearance );

// Pin Parameters.

m_pin_diameter                          = clip ( pin_diameter, C_MIN_PIN_DIAMETER, 2.0*m_leaf_gauge - C_MIN_PIN_DIAMETER );
m_parametric_pin_diameter               = ( m_pin_auto_size_enabled == true ) ? m_leaf_gauge : m_pin_diameter;
m_top_pin_shaft_counterbore_diameter    = clip ( top_pin_shaft_counterbore_diameter, C_MIN_PIN_SHAFT_COUNTERBORE_DIAMETER, 2.0*m_leaf_gauge - C_MIN_PIN_SHAFT_COUNTERBORE_WALL_THICKNESS );
m_top_pin_shaft_counterbore_depth       = clip ( top_pin_shaft_counterbore_depth, C_MIN_PIN_SHAFT_COUNTERBORE_DEPTH, 0.66*( m_leaf_height / ( m_knuckle_count + m_component_clearance )) );
m_top_pin_shaft_counterbore_shape       = top_pin_shaft_counterbore_shape;
m_bottom_pin_shaft_counterbore_diameter = clip ( bottom_pin_shaft_counterbore_diameter, C_MIN_PIN_SHAFT_COUNTERBORE_DIAMETER, 2.0*m_leaf_gauge - C_MIN_PIN_SHAFT_COUNTERBORE_WALL_THICKNESS );
m_bottom_pin_shaft_counterbore_depth    = clip ( bottom_pin_shaft_counterbore_depth, C_MIN_PIN_SHAFT_COUNTERBORE_DEPTH, 0.8*( m_leaf_height / m_knuckle_count) );
m_bottom_pin_shaft_counterbore_shape    = bottom_pin_shaft_counterbore_shape;

// Fastener parameters.

m_fstener_head_type        = fstener_head_type;
m_counter_sink_depth       = clip ( counter_sink_depth, 0.0, m_leaf_gauge - C_MIN_COUNTER_SINK_DEPTH_STOP );
m_fastener_head_diameter   = clip ( fastener_head_diameter, fastener_thread_diameter, m_leaf_width - m_leaf_gauge - m_component_clearance - 2.0*m_fastener_margin );
m_fastener_thread_diameter = clip ( fastener_thread_diameter, C_MIN_FASTENER_THREAD_DIAMETER, m_fastener_head_diameter );
m_fastener_column_count    = clip ( fastener_column_count, C_MIN_FASTENER_COLUMN_COUNT, C_MAX_FASTENER_COLUMN_COUNT );
m_fastener_count           = clip ( fastener_count, C_MIN_FASTENER_COUNT, m_fastener_column_count*( m_leaf_height - 2.0*m_fastener_margin )/(m_fastener_head_diameter + m_component_clearance));
m_leaf_fillet_radius       = m_fastener_head_diameter / 2.0 + m_fastener_margin;

// Model parameters.

m_resolution      = clip ( resolution, C_MIN_TESSELLATION, C_MAX_TESSELLATION );
m_component_color = component_color;

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// DEBUG: Console Output. 
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

C_DEBUG_ENABLED = false;

if ( C_DEBUG_ENABLED )
{
    echo ( m_hinge_width                    = m_hinge_width );
    echo ( m_leaf_width                     = m_leaf_width );
    echo ( absolute_leaf_width              = m_leaf_width - m_leaf_gauge );
    echo ( m_leaf_height                    = m_leaf_height );
    echo ( m_leaf_gauge                     = m_leaf_gauge );
    echo ( m_component_clearance            = m_component_clearance );
    echo ( m_knuckle_outer_radius           = m_knuckle_outer_radius );
    echo ( m_knuckle_count                  = m_knuckle_count );
    echo ( m_knuckle_gusset_width           = m_knuckle_gusset_width );
    echo ( m_leaf_fillet_radius             = m_leaf_fillet_radius );
    echo ( m_fastener_margin                = m_fastener_margin );
    echo ( m_pin_diameter                   = m_pin_diameter );
    echo ( m_parametric_pin_diameter        = m_parametric_pin_diameter );
    echo ( absolute_pin_diameter            = m_parametric_pin_diameter - m_component_clearance / 2.0 );    
    echo ( m_pin_shaft_counterbore_diameter = m_pin_shaft_counterbore_diameter );
    echo ( m_pin_shaft_counterbore_depth    = m_pin_shaft_counterbore_depth );    
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
    
    rotate ( [ 0.0, 0.0, ( m_flip_model ) ? 180.0 : 0.0 ] )
    {
        if ( m_female_leaf_enabled ) rotate ( [ 0.0, -m_throw_angle, 0.0 ] ) leaf ( C_FEMALE );
        if ( m_male_leaf_enabled )   leaf ( C_MALE );     
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      leaf.
// Module Type: Component.
//
// Description:
//
// - Creates a hinge leaf component, whose gender may be selected through the gender argument.
//
// - Note:
//   The text option is not made public to the Thingiverse Customizer at this time. 
//   However, you can add and configure text here in the code.
//
// Parameters:
//
// - gender:
//   The gender (male, female), of the leaf. The female leaf holds the pin.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module leaf ( gender )
{  
    // Text configuration.
    
    text_enabled          = false;
    text_string_female    = "0.4";
    text_string_male      = "RG";
    text_female_font_size = 8;
    text_male_font_size   = 8;
    
    // Compute the gender angle.
    // - 0 degrees for female, and 180 degrees for male.
    // - In other words, we leave the female leaf un-rotated, but we rotate the male leaf 180 degrees, to place it at an 
    //   opposing orientation to the female.
    
    gender_angle = ( gender == C_FEMALE ) ? 0 : 180;
    
    // Create leaves.
    
    rotate ( [ 0, 0, gender_angle ] )
    {
        color ( m_component_color )
        difference ()
        {
            // Cut pin hole.
            
            workpiece_leaf_knuckle_pin ( gender );   
            
            // Cut fstener holes.
            
            if ( m_fasteners_enabled )
            {
                tool_cutter_fastener_set ( m_fastener_count, m_fastener_column_count, 0 );                
            }
            
            // Cut pin shaft counterbore into female leaf.
            
            if ( m_pin_shaft_counterbore_enabled && gender == C_FEMALE )
            {
                tool_cutter_pin_shaft_counterbore
                (
                    diameter_top    = m_top_pin_shaft_counterbore_diameter, 
                    depth_top       = m_top_pin_shaft_counterbore_depth, 
                    shape_top       = m_top_pin_shaft_counterbore_shape,
                    diameter_bottom = m_bottom_pin_shaft_counterbore_diameter, 
                    depth_bottom    = m_bottom_pin_shaft_counterbore_depth, 
                    shape_bottom    = m_bottom_pin_shaft_counterbore_shape
                );
            }
            
            // Cut text.
            // -  We will only cut text into the leaves, if we are using exactly 4 fasteners per leaf.
            // -  All other leaf counts will not leave enough space for the text to fit easily. So we only add text, if we are using 4 fasteners.
            
            if ( text_enabled && m_fastener_count == 4 )
            {
                if ( gender == C_FEMALE ) tool_cutter_text ( text_string_female, text_female_font_size );
                if ( gender == C_MALE )   tool_cutter_text ( text_string_male,   text_male_font_size );
            }
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      workpiece_leaf_knuckle_pin
// Module Type: Workpiece.
//
// Description:
//
// - This module creates the workpiece used to construct either a male or female leaves.
//
// Parameters:
//
// - gender:
//   The gender (male, female), of the leaf. The female leaf holds the pin.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module workpiece_leaf_knuckle_pin ( gender )
{   
    // Initialize local variables.
    
    d = m_parametric_pin_diameter;
    c = m_component_clearance;
    e = SCG_OVERLAP; 

    // Combine pin with leaf and knuckle.
    
    if ( gender == C_FEMALE )
    {
        if ( m_pin_enabled )
        {
            // Fuse the pin to the female leaf by default.
            
            union ()
            {                           
                dc = d - c/2.0;
                
                workpiece_leaf_knuckle ( C_FEMALE );            
                pin ( dc, m_leaf_height - e );
            }
        }
        else
        {
            // Cut a hole for an external pin if selected by the user.
            
            difference ()
            {                           
                dc = d + c/2.0; 
                
                workpiece_leaf_knuckle ( C_FEMALE );            
                pin ( dc, m_leaf_height + e );
            }
        }
    }
    else
    {
        // Cut a hole for the pin to pass throug in the male leaf.
        
        difference ()
        {   
            dc = d + c/2.0;            
            
            workpiece_leaf_knuckle ( C_MALE );            
            pin ( dc, m_leaf_height + e );
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      pin
// Module Type: Component.
//
// Description:
//
// - Hinge pin component.
//
// Parameters:
//
// - diameter:
//   Diameter of the cylinder used to create the pin.
//
// - length:
//   Length of the cylinder used to create the pin.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module pin ( diameter, length )
{
    rotate ( [ 90, 0, 0 ] )
    {   
        // Initialize pin dimensions.
        
        tx = 0;
        ty = 0;
        tz = -length/2;
        
        // Create pin.
        
        translate ( [ tx, ty, tz ] )
        {
            cylinder ( d = diameter, h = length );
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      workpiece_leaf_knuckle
// Module Type: Workpiece.
//
// Description:
//
// - Workpiece used to cut away knuckle structures.
//
// Parameters:
//
// - gender:
//   The gender (male, female), of the leaf. The female leaf holds the pin.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module workpiece_leaf_knuckle ( gender )
{
    // Initialize local variables.
    
    gender_flipped = ( gender == C_MALE ) ? C_FEMALE : C_MALE;
    
    w = m_leaf_width;
    l = m_leaf_height;
    h = m_leaf_gauge;
    r = m_leaf_fillet_radius;
    d = m_knuckle_outer_radius;
    
    // Create workpiece.
    
    difference ()
    {
        difference ()
        {
            // leaf and knuckle work piece.
            
            translate ( [ 0, -l/2, 0 ] )
            {        
                union ()
                {                    
                    // Leaf.
                          
                    workpiece_leaf ( w, l, h, r );
                                    
                    // Knuckle.
                    
                    rotate ( [ -90, 0, 0 ] ) cylinder ( d = d, h = l );
                    
                    // Gusset array.
                    
                    if ( m_knuckle_gusset_type != C_NONE ) 
                    {
                        translate ( [ 0, l/2, 0 ] )                        
                        workpiece_gusset_array
                        (
                            gender                   = gender, 
                            curve                    = m_knuckle_gusset_type, 
                            scg_type                 = C_POSITIVE, 
                            fill_component_clearance = false
                        );
                    }
                }
            }
                
            // Cut knuckle gaps.
            
            tool_cutter_knuckle_array
            (
                gender                   = gender, 
                fill_component_clearance = true, 
                size                     = 2.0*m_leaf_gauge + m_component_clearance
            );
        }
        
        // Cut opposing gusset groves.
     
        if ( m_knuckle_gusset_type != C_NONE )
        {
            workpiece_gusset_array
            (
                gender                   = gender_flipped,
                curve                    = m_knuckle_gusset_type,
                scg_type                 = C_NEGATIVE,
                fill_component_clearance = true
            );
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      workpiece_leaf
// Module Type: Workpiece.
//
// Description:
//
// - Workpiece used to cut away leaf structures.
//
// Parameters:
//
// - w:
//   Width of a single leaf.
//
// - l:
//   Length of the leaf.
//
// - h:
//   Height of the leaf.
//
// - r:
//   Radius of the hinge knuckle.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module workpiece_leaf ( w, l, h, r )
{
    translate ( [ 0, 0, -h ] )
    {   
        union ()
        {
            if ( m_leaf_fillet_enabled )
            {
                // Leaf.
            
                cube ( [ w-r, l, h] );
                translate ( [  0, r, 0 ] ) cube ( [ w, l-2*r, h] );
            
                // Fillet corcers.            
            
                translate ( [  w - r, r,   0 ] ) cylinder ( r = r, h = h );
                translate ( [  w - r, l-r, 0 ] ) cylinder ( r = r, h = h );
            }
            else
            {
                // Leaf.
            
                cube ( [ w, l, h] );
            }
        }
    }  
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      workpiece_gusset_array
// Module Type: Workpiece.
//
// Description:
//
// - Create an array of cutting blocks. Mostly used to cut gusset workpiece into individual gusset positives or negatives.
//
// Parameters:
//
// - gender:
//   Specifies the number of knuckle joints based on hinge leaf gender.   
//
// - scg_type:
//   Solid Constructive Geometry type.
//   If C_POSITIVE, then add to the base work piece.
//   If C_NAGATIVE, then subtract from the base workpiece.
//
// - fill_component_clearance:
//   If true, then create wide cutting blocks that fill in the component clearance.
//   If false, then create narrow cutting blocks that leave space for the component clearance.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module workpiece_gusset_array ( gender, curve, scg_type, fill_component_clearance )
{   
    // Compute cutting block size.
    
    cutting_block_size = m_leaf_gauge + m_knuckle_gusset_width;
    leaf_height        = ( scg_type == C_NEGATIVE ) ? m_leaf_height + SCG_OVERLAP : m_leaf_height; 
    
    // Compute cutting block translation.
    
    xt = cutting_block_size/2.0;
    yt = 0.0;
    zt = 0.0;
    
    // Create gusset array.
    
    difference ()
    {
        // Create a solid cylindrical gusset cylinder.
        
        workpiece_gusset
        (
            width         = m_knuckle_gusset_width, 
            height        = leaf_height, 
            knuckle_radus = m_leaf_gauge, 
            curve         = curve,
            scg_type      = scg_type
        );
        
        // Use the knuckle array cutter tool, to cut knuckle gaps into the gusset to match the dimensions of the knuckles.
        
        translate ( [ xt, yt, zt ] )
        tool_cutter_knuckle_array
        (
            gender                   = gender,
            fill_component_clearance = !fill_component_clearance,
            size                     = cutting_block_size
        );
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      workpiece_gusset
// Module Type: Workpiece
//
// Description:
//
// - Knuckle gusset used to strengthen the knuckle joints.
//
// Parameters:
//
// - width
//   The length of the gusset, as measured from the edge of the knuckle.
//   We name it "width", in order to maintain dimension naming consistency with the rest of the hinge dimensions.
//
// - height
//   The thickness of the gusset.
//   We name this "height", in order to maintain dimension naming consistency with the rest of the hinge dimensions.
//
// - knuckle_radus
//   Outer radius of the knuckles. This is also the same value as the leaf gauge.
//
// - curve
//   The mathematical function used to describe the shape of the gusset.
//   - Linear
//   - Parabolic
//   - Circular
//
// - scg_type
//   Solid Constructive Geometry (SCG) mode.
//   - If set to 0 or C_NEGATVE, to create the version of the component used for cutting away from the leaves.
//   - If set to 1 or C_POSITIVE, to create the version of the component used for adding to the leaves and knuckles.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module workpiece_gusset ( width, height, knuckle_radus, curve, scg_type )
{
    if      ( curve == C_FUNCTION_LINEAR    ) workpiece_gusset_linear    ( width, height, knuckle_radus, scg_type );
    else if ( curve == C_FUNCTION_CIRCULAR  ) workpiece_gusset_circular  ( width, height, knuckle_radus, scg_type );
    else if ( curve == C_FUNCTION_PARABOLIC ) workpiece_gusset_parabolic ( width, height, knuckle_radus, scg_type );
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      workpiece_gusset_linear
// Module Type: Workpiece
//
// Description:
//
// - Linear knuckle gusset, called by workpiece_gusset.
//
// Parameters:
//
// - width
//   The length of the gusset, as measured from the edge of the knuckle.
//   We name it "width", in order to maintain dimension naming consistency with the rest of the hinge dimensions.
//
// - height
//   The thickness of the gusset.
//   We name this "height", in order to maintain dimension naming consistency with the rest of the hinge dimensions.
//
// - knuckle_radus
//   Outer radius of the knuckles. This is also the same value as the leaf gauge.
//
// - scg_type
//   Solid Constructive Geometry (SCG) mode.
//   - If set to 0 or C_NEGATVE, to create the version of the component used for cutting away from the leaves.
//   - If set to 1 or C_POSITIVE, to create the version of the component used for adding to the leaves and knuckles.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module workpiece_gusset_linear ( width, height, knuckle_radus, scg_type )
{
    CENTER        = true;
    DEBUG_ENABLED = true;
    
    // Initialize input values.
    
    w = width;          // Gusset width.
    h = height;         // Hinge leaf height.
    r = knuckle_radus;  // Knuckle radius is equal to the leaf gauge.
    s = w + r;          // Cartesian position of the point where the gusset curve merges with the leaf.
    g = m_leaf_gauge;   // Leaf gauge.
    c = SCG_OVERLAP;    // Amount to overlap unions in order to prevent Boolean anomalies.
    
    // Compute gusset tangent curve.
    
    x = r*r/s;
    y = sqrt ( r*r - x*x );
    a = y/( x - s );
    b = -a*s;
    
    // Compute work piece translation and dimensions.
    
    wp_xd = 0;                  // Work piece origin x.
    wp_yd = 0;                  // Work piece origin y.
    wp_zd = -g + c;             // Work piece origin z.
    
    wp_w = s;                   // Work piece width (x axis length).
    wp_g = g + y - c;           // Work piece gauge (y access length. i.e. thickness).
    wp_h = h;                   // Work piece height (y axis length).
    
    // Compute cutting tool translation and dimensions.
    
    ct_xd  = 0;
    ct_yd  = 0;
    ct_zd  = 0;
            
    ct_w0 = x;
    ct_w1 = s;
    ct_g0 = y;
    ct_g1 = 0;
    ct_h  = h + 2*c;
          
    // Compute and configure orientation.
    
    test_yd = 0;
    
    zs = ( scg_type == C_POSITIVE ) ? 1.0 : -1.0;
    scale ( [ 1.0, -1.0, zs ] )
    difference()
    {
        translate ( [ wp_xd, wp_yd + test_yd, wp_zd ] ) rotate ( [ 90, 0, 0 ] )
        {
            linear_extrude ( height = wp_h, center = CENTER ) rectangle ( w = wp_w, h = wp_g );
        }
     
        translate ( [ ct_xd, ct_yd + test_yd, ct_zd ] ) rotate ( [ 90, 0, 0 ] )
        {
            linear_extrude ( height = ct_h, center = CENTER ) triangle ( [ [ ct_w0, ct_g0 ],[ ct_w1+c, ct_g0+c ],[ ct_w1, ct_g1 ] ] );
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      workpiece_gusset_circular
// Module Type: Workpiece
//
// Description:
//
// - Linear knuckle gusset, called by workpiece_gusset.
//
// Parameters:
//
// - width
//   The length of the gusset, as measured from the edge of the knuckle.
//   We name it "width", in order to maintain dimension naming consistency with the rest of the hinge dimensions.
//
// - height
//   The thickness of the gusset.
//   We name this "height", in order to maintain dimension naming consistency with the rest of the hinge dimensions.
//
// - knuckle_radus
//   Outer radius of the knuckles. This is also the same value as the leaf gauge.
//
// - scg_type
//   Solid Constructive Geometry (SCG) mode.
//   - If set to 0 or C_NEGATVE, to create the version of the component used for cutting away from the leaves.
//   - If set to 1 or C_POSITIVE, to create the version of the component used for adding to the leaves and knuckles.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module workpiece_gusset_circular ( width, height, knuckle_radus, scg_type )
{
    CENTER = true;
    
    // Initialize input values.
    
    w = width;          // Gusset width.
    g = knuckle_radus;  // Knuckle radius is equal to the leaf gauge.
    c = SCG_OVERLAP;    // Amount to overlap unions in order to prevent Boolean anomalies.
    
    // Compute gusset radius. The radius of the circle, that is tangential to the knuckle cylinder.
    
    r = ( 2.0*g*w + w*w ) / ( 2.0*g );

    // Compute gusset height. The point of intersection between the knuckle cylinder and the gusset cutter.
    
    h = ( g*r ) / sqrt ( g*g + 2.0*g*w + r*r + w*w );
    
    // Compute intersection point between knuckle and gusset cutting tool, using gusset height.
    // The coordinate of the intersection point is, p(x,h), where h is the vertical value of the coordinate.
    
    x = h*( g + w ) / r;
        
    // Compute gusset cutting tool translation.
    
    ctxd = g + w;
    ctyd = c;
    ctzd = r;
    ctt  = height + 2.0*x;
    
    // Compute gusset work piece translation and dimensions.
    
    wpw  = g + w -x;
    wph  = h + c;    
    wpxd = x;
    wpyd = 0.0;
    wpzd = 0.0 - c;
    wpt  = height;
    
    // Initialize cutting plane and component scaling.
    
    xr = 90.0;
    yr = 0.0;
    zr = 0.0;
    
    xs =  1.0;
    ys = -1.0;
    zs =  ( scg_type == C_POSITIVE ) ? 1.0 : -1.0;
   
    // Generate gusset.
    
    color ( "silver" )
    scale ( [ xs, ys, zs ] )
    difference ()
    {
        translate ( [ wpxd, wpyd, wpzd ] ) rotate ( [ xr, yr, zr ] ) linear_extrude ( height = wpt, center = CENTER ) rectangle ( w = wpw, h = wph );
        translate ( [ ctxd, ctyd, ctzd ] ) rotate ( [ xr, yr, zr ] ) linear_extrude ( height = ctt, center = CENTER ) circle    ( r = r );            
    }
}


// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      workpiece_gusset_parabolic
// Module Type: Workpiece
//
// Description:
//
// - Parabolic knuckle gusset, called by workpiece_gusset.
// 
// Parameters:
//
// - width
//   The length of the gusset, as measured from the edge of the knuckle.
//   We name it "width", in order to maintain dimension naming consistency with the rest of the hinge dimensions.
//
// - height
//   The thickness of the gusset.
//   We name this "height", in order to maintain dimension naming consistency with the rest of the hinge dimensions.
//
// - knuckle_radus
//   Outer radius of the knuckles. This is also the same value as the leaf gauge.
//
// - scg_type
//   Solid Constructive Geometry (SCG) mode.
//   - If set to 0 or C_NEGATVE, to create the version of the component used for cutting away from the leaves.
//   - If set to 1 or C_POSITIVE, to create the version of the component used for adding to the leaves and knuckles.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module workpiece_gusset_parabolic ( width, height, knuckle_radus, scg_type )
{
    CENTER        = true;
    DEBUG_ENABLED = true;
    RESOLUTION    = m_resolution / C_MIN_TESSELLATION;
    
    // Initialize input values.
    
    w = width;          // Gusset width.
    h = height;         // Hinge leaf height.
    r = knuckle_radus;  // Knuckle radius is equal to the leaf gauge.
    s = w + r;          // Cartesian position of the point where the gusset curve merges with the leaf.
    g = m_leaf_gauge;   // Leaf gauge.
    c = SCG_OVERLAP;    // Amount to overlap unions in order to prevent Boolean anomalies.    
    
    // Compute parabolic point of contact with the knuckle cylinder.
    
    i  = sqrt ( 8.0*r*r + s*s );    // Common root.
    x  = ( i - s )/2.0;             // x intercept.
    y  = sqrt ( r*r - x*x );        // y intercept.
    
    // Compute coefficient 'a' of vertex form parabola.
    // y = a^2*(x-s)^2*
    
    an = root4 ( 2.0 ) * root4 ( s*( i - s ) - 2.0*r*r );   // Numerator.
    ad = sqrt ( s*( 5.0*s - 3.0*i ) + 4.0*r*r );                            // Denominator.
    a  = an / ad;                                                           // Coefficient 'a' of, y = (a^2)*(x-s)^2
    
    // Compute work piece translation and dimensions.
    
    wp_xd = 0;                  // Work piece origin x.
    wp_yd = 0;                  // Work piece origin y.
    wp_zd = -g + c;             // Work piece origin z.
    
    wp_w = s;                   // Work piece width (x axis length).
    wp_g = g + y - c;           // Work piece gauge (y access length. i.e. thickness).
    wp_h = h;                   // Work piece height (y axis length).
    
    // Compute cutting tool translation and dimensions.
    
    ct_xd = 0;
    ct_yd = 0;
    ct_zd = 0;
            
    ct_w0 = x;
    ct_w1 = s;
    ct_g0 = y;
    ct_g1 = 0;
    ct_h  = h + 2*c;
          
    // Compute positive or negative tool orientation. We flip the tool by using a negative unit scale.
    
    test_yd = 0;    
    zs = ( scg_type == C_POSITIVE ) ? 1.0 : -1.0;
    scale ( [ 1.0, -1.0, zs ] )
    
    // Create gusset work piece.
    
    difference()
    {
        // Work piece.
        
        translate ( [ wp_xd, wp_yd + test_yd, wp_zd ] ) rotate ( [ 90, 0, 0 ] )
        {
            linear_extrude ( height = wp_h, center = CENTER ) rectangle ( w = wp_w, h = wp_g );
        }
        
        // Parabolic cutting tool.
        
        translate ( [ ct_xd, ct_yd + test_yd, ct_zd ] ) rotate ( [ 90, 0, 0 ] )
        {                
            linear_extrude ( height = ct_h, center = CENTER ) parabolic_conic_section ( a, s, 0, s, RESOLUTION );
        }
    }
}


// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_cutter_fastener
// Module Type: Cutting Tool.
//
// Description:
//
// - Cutting tool used to cut fastener holes into leaf workpiece.
//
// Parameters:
//
// - z_offset:
//   Depth of the cut.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_cutter_fastener ( z_offset,  )
{   
    // Initialize local variables.
        
    id     = m_fastener_thread_diameter;            // Inner diameter.
    od     = m_fastener_head_diameter;              // Outer diameter.
    t      = m_fstener_head_type;                   // 0 = Fillister (Pan head), 1 = flat countersunk.
    d      = m_counter_sink_depth;                  // Depth of head counter sink.
    z0     = z_offset - m_leaf_gauge;               // Vertical position of head.
    z1     = z_offset - m_counter_sink_depth;       // Vertical position of thread.
    h0     = m_leaf_gauge;                          // Height of head.
    h1     = m_counter_sink_depth;                  // Height of thread.
    c      = SCG_OVERLAP;
    
    // Create cutting tool.
    
    union ()
    {
        // Thread
        
        translate ( [ 0, 0, z0 - c ] )
        {
            cylinder ( d = id, h = h0 + 2.0*c );            
        }
        
        // Head.
        
        union ()
        {
            // Fastener head.
            
            translate ( [ 0, 0, z1 ] )
            {   
                // Fillister (Pan head).
                
                if ( t == 0 )
                {
                    d_top    = od;
                    d_bottom = od;
                    h        = h1 + c;
                    cylinder ( d2 = d_top, d1 = d_bottom, h = h );
                }
                
                // Flat countersunk.
                
                if ( t == 1 )
                {
                    d_top    = od + c;
                    d_bottom = id;
                    h        = h1 + c;
                    cylinder ( d2 = d_top, d1 = d_bottom, h = h );
                }
            }
            
            // Cutting tool extension.
            
            translate ( [ 0, 0, c ] )
            {   
                cylinder ( d = od, h = m_leaf_gauge );
            }
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_cutter_fastener_set
// Module Type: Cutting Tool.
//
// Description:
//
// - Cutting tool used to cut fastener holes into leaf workpiece.
//
// Parameters:
//
// - fastener_count:
//   Number of fastener holes to be cut into a single leaf.
//   The total number of fastener holes on the whole hinge, will be twice the value of fastener_count.
//   i.e. 'fastener_count' holes, on each leaf.
//
// - fastener_column_count:
//   Number of fastener column per leaf. This value can be either 1, or 2.
//
// - z_offset:
//   Depth of the cut.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_cutter_fastener_set ( fastener_count, fastener_column_count, z_offset )
{
    // Relative origin.
    
    xo = m_leaf_gauge + m_component_clearance/2 + m_fastener_head_diameter/2 + m_fastener_margin;
    yo = -m_leaf_height/2 + m_fastener_head_diameter/2 + m_fastener_margin;
    
    // Column offsets.
    
    col0 = 0;
    col1 = m_leaf_width - m_fastener_head_diameter/2 - m_fastener_margin - xo;
    
    // Loop configuration.
    
    even = ( fastener_count % 2 ) ? false : true;
    n1   = fastener_count - 1;    
    n2   = round ( fastener_count / 2 ) - 1;
    k1   = ( m_leaf_height - m_fastener_head_diameter - 2*m_fastener_margin ) / n1;
    k2   = ( m_leaf_height - m_fastener_head_diameter - 2*m_fastener_margin ) / n2;
            
    // Generate fastener cutting tool.
    
    // One column of fastener holes, if we have selected one fastener hole column.
    
    if ( fastener_column_count == 1 )
    {
        for ( row = [ 0 : n1 ] )
        {
            cx = ( col0 + col1 ) / 2.0;
            tx = xo + cx;
            ty = yo + row * k1;
            tz = 0;                
                            
            translate ( [ tx, ty, tz ] ) tool_cutter_fastener ( z_offset );
        }
    }
    
    // Two columns of fastener holes, if we have selected two fastener hole column.
    
    if ( fastener_column_count == 2 )
    {
        for ( col = [ 0 : 1 ] )
        {  
            // Column 0, offset translation when we have an odd number of fasteners.
            
            if ( col == 0 )
            {
                m = ( even ) ? 0 : 1;
                
                for ( row = [ 0 : n2 - m ] )
                {        
                    cx = ( col == 0 ) ? col0 : col1;
                    tx = xo + cx;
                    ty = ( even ) ? yo + row * k2 : yo + row * k2 + k2/2;
                    tz = 0;                
                                    
                    translate ( [ tx, ty, tz ] ) tool_cutter_fastener ( z_offset );
                }
            }
            
            // Column 1.
            
            if ( col == 1 )
            {
                for ( row = [ 0 : n2 ] )
                {        
                    cx = ( col == 0 ) ? col0 : col1;
                    tx = xo + cx;
                    ty = yo + row * k2;
                    tz = 0;                
                    
                    translate ( [ tx, ty, tz ] ) tool_cutter_fastener ( z_offset );
                }
            }                    
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_cutter_text.
// Module Type: Tool cutter.
//
// Description:
//
// - Inscribes a string of text onto a surface.
//
// Parameters:
//
// - string:
//   The string of text we would like to inscribes.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_cutter_text ( string, size )
{   
    // create text cutter.

    font   = "Ariel:style=Bold";    
    height = 0.15*6.0;
    xd     = 20.0;
    yd     = 0.0;
    zd     = height;
    
    translate ( [ xd, yd, -zd ] )
    {
        rotate ( [ 0.0, 0.0, -90.0 ] )
        {
            linear_extrude ( height = height + SCG_OVERLAP )
            {
                text ( string, font = font, size = size, valign = "center", halign = "center" );                
            }
        }
    }
}



// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_cutter_knuckle_array
// Module Type: Cutting tool.
//
// Description:
//
// - Create an array of cutting blocks. Mostly used to cut gusset workpiece into individual gusset positives or negatives.
//
// Parameters:
//
// - gender:
//   Specifies the number of knuckle joints based on hinge leaf gender.
//
// - fill_component_clearance:
//   If true, then create wide cutting blocks that fill in the component clearance.
//   If false, then create narrow cutting blocks that leave space for the component clearance.
//
// - size:
//   Specifies the dimension used for the x and z axes.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_cutter_knuckle_array ( gender, fill_component_clearance, size )
{   
    // Initialize local variables.
    
    n = m_knuckle_count;
    h = m_leaf_height;
    c = m_component_clearance;
    e = SCG_OVERLAP;
    
    // Compute knuckle width and segment width.
    
    k = ( h + c )/n - c;
    s = ( fill_component_clearance ) ? k + 2.0*c : k;
    
    // Compute segment offset.
    
    o = ( fill_component_clearance ) ? c : 0.0;
    
    // Generate block array.
    
    a = 0;
    b = ( gender == C_MALE ) ? n/2 : n/2-1;
    g = ( gender == C_MALE ) ? 0.0 : k + c;
    
    for ( i = [ a : b ] )
    {
        // Compute translation index.
        
        ki = g + 2.0*i*(k + c ) - h/2.0 - o;
        
        // Initialize translation.
        
        xt = -size/2.0;
        yt = ki;
        zt = -size/2.0;
        
        // Initialize cutting block dimensions.
    
        cube_x = size;
        cube_y = s;
        cube_z = 2.0*size;
        
        // Create cutting block.
        
        color ( "red" )
        translate ( [ xt, yt, zt ] )        
        cube ( [ cube_x, cube_y, cube_z ] );
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      tool_cutter_pin_shaft_counterbore
// Module Type: Cutting tool.
//
// Description:
//
// - Cuts a counterbore into the end caps of the pin shaft.
// - If the model is being printed in its default orientation, open and flat on the build plate, then support material may be required
//   for the counterbore.
//
// Parameters:
//
// - diameter:
//   Specifies the diameter of the counterbore.
//   For square and hexagonal counterbore shapes, the diameter refers to the inscribed circle of those shapes.
//
// - depth:
//   Specifies the depth of the cut.
//
// - shape:
//   The shame of the counterbore. 
//   - Circular
//   - Square
//   - Hexagonal
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module tool_cutter_pin_shaft_counterbore ( diameter_top, depth_top, shape_top, diameter_bottom, depth_bottom, shape_bottom )
{
    // Local constants.
    
    TOP_COUNTER_BORE_ENABLED    = true;
    BOTTOM_COUNTER_BORE_ENABLED = true;    
    
    // Initialize local variables.
    
    d0 = diameter_bottom;
    d1 = diameter_top;
    h0 = depth_bottom + SCG_OVERLAP;
    h1 = depth_top    + SCG_OVERLAP;
    
    // Compute diameter of polygon, inscribed by a circle of radius d/2.

    s  = 6;                         // Polygon sides.
    a  = 360.0/(2.0*s);             // Half the angle between each point of the polygon.
    
    x0 = d0/2.0;                    // Bottom: Run of the right angle triangle who hypotenuse is equal to half the radius of our new circle.
    y0 = x0*tan ( a );              // Bottom: Rise of the right angle triangle who hypotenuse is equal to half the radius of our new circle.
    r0 = sqrt ( x0*x0 + y0*y0 );    // Bottom: Hypotenuse of the right angle triangle who hypotenuse is equal to half the radius of our new circle.
    
    x1 = d1/2.0;                    // Top: Run of the right angle triangle who hypotenuse is equal to half the radius of our new circle.
    y1 = x1*tan ( a );              // Top: Rise of the right angle triangle who hypotenuse is equal to half the radius of our new circle.
    r1 = sqrt ( x1*x1 + y1*y1 );    // Top: Hypotenuse of the right angle triangle who hypotenuse is equal to half the radius of our new circle.
        
    // Compute cutting tool translation.

    xd  = 0.0;
    yd0 =  ( h0 - m_leaf_height )/2.0 - SCG_OVERLAP;
    yd1 = -( h1 - m_leaf_height )/2.0 + SCG_OVERLAP;
    zd  = 0.0;
    
    // Compute polygon rotation angle.
    
    rx = 90.0;
    ry = ( s%2 == 0 ) ? a+90 : -a/2.0;  
    rz = 0.0;
  
    // Create top counterbore cutting tool.
    
    if ( BOTTOM_COUNTER_BORE_ENABLED )
    {
        color ( "red" )
        if ( shape_bottom == C_CIRCULAR )
        {
            translate ( [ xd, yd0, zd ] ) rotate ( [ rx, ry, rz ] ) cylinder ( h = h0, r = d0/2.0, center = true );
        }
        else if ( shape_bottom == C_SQUARE )
        {
            translate ( [ xd, yd0, zd ] ) cube ( [ diameter_bottom, h0, diameter_bottom ], center = true );
        }
        else if ( shape_bottom == C_HEXAGONAL )
        {   
            translate ( [ xd, yd0, zd ] ) rotate ( [ rx, ry+90, rz ] ) cylinder ( h = h0, r = r0, center = true, $fn = s );        
        }
    }
    
    // Create bottom counterbore cutting tool.
    
    if ( TOP_COUNTER_BORE_ENABLED )
    {        
        color ( "red" )
        if ( shape_top == C_CIRCULAR )
        {
            translate ( [ xd, yd1, zd ] ) rotate ( [ rx, ry, rz ] ) cylinder ( h = h1, r = d1/2.0, center = true );
        }
        else if ( shape_top == C_SQUARE )
        {
            translate ( [ xd, yd1, zd ] ) cube ( [ diameter_top, h1, diameter_top ], center = true );
        }
        else if ( shape_top == C_HEXAGONAL )
        {   
            translate ( [ xd, yd1, zd ] ) rotate ( [ rx, ry, rz ] ) cylinder ( h = h1, r = r1, center = true, $fn = s );        
        }
    }
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      parabolic_conic_section.
// Module Type: 2D Shape.
//
// Description:
//
// - Creates a parabolic conic section object.
//
// Parameters:
//
// - radius:
//   Radius of the cylinder sector.
//
// - a:
//   Coefficient of the vertex form parabola, y = (a^2)*(x-b)^2.
//
// - x:
//   x Coordinate of parabola turning point.
//   Note:
//   For the sake of simplifying the actual parabolic function used in the recursive
//   function "parabolic_vector", we use a call to "translate" to set the vertex, rather than the parabolic function its self.
// 
// - y:
//   y Coordinate of parabola turning point.
//   Note:
//   For the sake of simplifying the actual parabolic function used in the recursive
//   function "parabolic_vector", we use a call to "translate" to set the vertex, rather than the parabolic function its self.
//
// - domain:
//   The input domain x, over which to compute the parabolic function.
//   
// - resolution:
//   The input domain step size, is used to control the resolution of the shape. 
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module parabolic_conic_section ( a, x, y, domain, resolution )
{
    // Generate 2D geometry
    
    t = 0.0;
    n = resolution;
    i = 0;
    d = domain;
    v = [];
    
    points = parabolic_vector ( a, t, n, i, d, v );
    
    // Generate 3D object.

    translate ( [ x, y, 0 ] )    
    polygon ( points );
}

// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------
// Module:      triangle.
// Module Type: 2D Shape.
//
// Description:
//
// - Creates a 2D triangle from three vertices.
//
// Parameters:
//
// - x0, x1, x2
//   x coordinates of vertices 0 through 2.
//
// - y0, y1, y2
//   y coordinates of vertices 0 through 2.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

module triangle ( v )
{
    polygon ( points = v );
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
// Function: root4
//
// Description:
//
// - Compute the 4th root of x.
//
// Return Value:
//
// - Return the 4th root of x.
// 
// Parameters:
//
// - x
//   Input value.
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

function root4 ( x ) = ( x >= 0 ) ? sqrt ( sqrt ( x ) ) : 0;


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
// Function: Generate a parabolic vector point array.
//
// Description:
//
// - Recursive function to generate an array of 2D points on a parabolic curve. 
//
// - The parabolic vertex form is used. 
//   
//     y = (a^2)*(x-b)^2
//
//   Where, 
//
//     a is the horizontal scale of the parabola.
//     (b,c) is the Cartesian position of the turning point.
//   
//
// Parameters:
//
// - a
//   Horizontal scale of the parabola.
//
// - x
//   Horizontal input domain.
//
// - n
//   Tessellation factor. Number of points to compute for each half of the parabola object, with both halves sharing the turning point. 
//   For example:
//   - A tessellation factor of 1, will compute 3 points in total. Two for each half, with one out of the two on each half being the 
//     Shared turning point.
//   - A tessellation factor of 2, with compute 5 points in total, 3 for each half with a shared turning point.
//
// - i
//   Point index. Initialize to zero.
//
// - d
//   Input domain. The x range over which to compute the function. 
//   -d <= x <= d
//
// - v
//   Vector that will be populated with geometry points. Initialize to empty vector, [].
//
// -------------------------------------+---------------------------------------+---------------------------------------+---------------------------------------

function parabolic_vector ( a, x, n, i, d, v ) =
(
    i > 2.0*d*n

    // Recursive terminating condition:
    //   Return an empty vector.

    ? concat ( v, [] )

    // Recursive general condition:
    //   Compute the next point on the parabolic path.
    //   x = i/n - 1
    //   y = a^2*(i/n - 1)^2*

    : parabolic_vector ( a, x, n, i + 1, d, concat ( v, [ [ i/n - d, a*a*(i/n - d)*(i/n - d) ] ] ) )
);

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

