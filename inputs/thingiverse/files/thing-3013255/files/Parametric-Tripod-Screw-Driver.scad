// Width of Screwdriver Blade
blade_width = 10;

// Thickness of Screwdriver Blade
blade_thickness = 2.2;

// Length of Screwdriver Blade
blade_length = 2;

// Length of Screwdriver Edge 45 Degrees Taper
blade_taper = 0.4;

// Use this to correct for your printer's oversizing. Set to 0 to get STL file exactly as designed.
printer_oversizing = 0.5;

// Length of Hexagonal Shaft near Blade
hexagonal_shaft_length = 30;

// Wrench Size in mm that fits on Hexagonal Shaft
hexagonal_shaft_wrench_width = 10;

// Size of Allen Key that can be inserted into Handle End
allen_key_width = 6;

// Length of Main Handle
handle_length = 25;

// Diameter of Main Handle
handle_diameter = 25;

// Number of Faces of Main Handle
handle_polygon_faces = 6;

// Length of Transitions between Blade/Hexagonal Shaft/Main Handle
transition_length = 5;

// Constant used for consistent meshing, should not normally be changed.
epsilon = 0.01;

tol = printer_oversizing;

th_blade = blade_thickness  - tol;
l_blade = blade_length - blade_taper;
taper = blade_taper;

l_hexshaft = hexagonal_shaft_length;
w_hexkey = hexagonal_shaft_wrench_width;
l_handle = handle_length;
l_transition = transition_length;
w_key = allen_key_width;

d_handle = handle_diameter;
faces_handle = handle_polygon_faces;

difference ()
{
    union ()
    {
        // Hex Shaft
        translate ([0, 0, -l_hexshaft - l_transition])
                cylinder (h = l_hexshaft, d = w_hexkey/cos (30) - tol, $fn = 6);
        
        // Hex Shaft/Handle Transition
        hull ()
        {
            translate ([0, 0, -l_hexshaft - l_transition])
                cylinder (h = epsilon, d = w_hexkey/cos (30) - tol, $fn = 6);
            
            translate ([0, 0, -l_hexshaft - 2 * l_transition])
                rotate ([0, 0, 180/faces_handle])
                    cylinder (h = epsilon, d = d_handle, $fn = faces_handle);
        }
        
        //Handle
        translate ([0, 0, -l_hexshaft - l_handle - 2 * l_transition])
            rotate ([0, 0, 180/faces_handle])
                cylinder (h = l_handle, d = d_handle, $fn = faces_handle);
        
        // Handle Chamfer
        translate ([0, 0, -l_hexshaft - l_handle - 2* l_transition - 1])
            rotate ([0, 0, 180/faces_handle])
                cylinder (h = 1, d1 = d_handle - 1, d2 = d_handle, $fn = faces_handle);
    }
    
    translate ([0, 0, -l_hexshaft - l_handle - 2 * l_transition - 1 - epsilon])
        cylinder (h = l_handle, d = w_key/cos (30) + tol, $fn = 6);
}

// Blade Chamfer
hull ()
{
    translate ([0, 0, -l_transition])
        cylinder (h = epsilon, d = w_hexkey/cos (30) - tol, $fn = 6);
    
    translate ([0, 0, 0])
        cube ([blade_width, th_blade, epsilon], center = true);
}

// Blade
hull ()
{
    translate ([0, 0, 0])
        cube ([blade_width, th_blade, epsilon], center = true);
    
    translate ([0, 0, l_blade])
        cube ([blade_width, th_blade, epsilon], center = true);
    
    translate ([0, 0, l_blade + taper])
        cube ([blade_width, th_blade - taper, epsilon], center = true);
}