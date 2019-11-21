// CUSTOMIZER VARIABLES
// GREP pattern for CSV spreadsheet: (.*),(.*),(.*)\r     ->     \1\:\\2 US \/ \3 UK\, 

// Ring Size
ring_size = 19.76; // [  9.91:000 US, 10.72:00 US, 11.63:0 US, 11.84:0.25 US, 12.04:0.5 US / A UK, 12.24:0.75 US / A.5 UK, 12.45:1 US / B UK, 12.65:1.25 US / B.5 UK, 12.85:1.5 US / C UK, 13.06:1.75 US / C.5 UK, 13.26:2 US / D UK, 13.46:2.25 US / D.5 UK, 13.67:2.5 US / E UK, 13.87:2.75 US / E.5 UK, 14.07:3 US / F UK, 14.27:3.25 US / F.5 UK, 14.48:3.5 US / G UK, 14.68:3.75 US / G.5 UK, 14.88:4 US / H UK, 15.09:4.25 US / H.5 UK, 15.29:4.5 US / I UK, 15.49:4.75 US / J UK, 15.7:5 US / J.5 UK, 15.9:5.25 US / K UK, 16.1:5.5 US / K.5 UK, 16.31:5.75 US / L UK, 16.51:6 US / L.5 UK, 16.71:6.25 US / M UK, 16.92:6.5 US / M.5 UK, 17.12:6.75 US / N UK, 17.32:7 US / N.5 UK, 17.53:7.25 US / O UK, 17.73:7.5 US / O.5 UK, 17.93:7.75 US / P UK, 18.14:8 US / P.5 UK, 18.34:8.25 US / Q UK, 18.54:8.5 US / Q.5 UK, 18.75:8.75 US / R UK, 18.95:9 US / R.5 UK, 19.15:9.25 US / S UK, 19.35:9.5 US / S.5 UK, 19.56:9.75 US / T UK, 19.76:10 US / T.5 UK, 19.96:10.25 US / U UK, 20.17:10.5 US / U.5 UK, 20.37:10.75 US / V UK, 20.57:11 US / V.5 UK, 20.78:11.25 US / W UK, 20.98:11.5 US / W.5 UK, 21.18:11.75 US / X UK, 21.39:12 US / X.5 UK, 21.59:12.25 US / Y UK, 21.79:12.5 US / Z UK, 22:12.75 US / Z.5 UK, 22.19:13 US, 22.4:13.25 US / Z1 UK, 22.61:13.5 US / Z2 UK, 22.81:13.75 US, 23.01:14 US / Z3 UK, 23.22:14.25 US, 23.42:14.5 US / Z4 UK, 23.62:14.75 US, 23.83:15 US / Z5 UK, 24.03:15.25 US, 24.23:15.5 US / Z6 UK, 24.43:15.75 US, 24.64:16 US / Z7 UK, 25.02:16.5 US / Z8 UK, 25.43:17 US / Z9 UK, 25.85:17.5 US, 26.26:18 US, 26.64:18.5 US, 27.06:19 US, 27.47:19.5 US, 27.88:20 US ]

// Ring Thickness, in mm
ring_thickness = 2.0;   // [1.0:0.1:20]

// Ring Height, in mm
ring_height = 6.0;    // [1.0:0.1:30]

// Quality/Polygons
quality = 250;  // [ 50:Draft, 100:Low, 250:Medium, 600:High, 1500:Extreme, 4000:Insane ]

// Edge Style
edge_style = 0;     // [0:Square, 1:Round, 2:Triangle, 3:Hex, 4:Extended Square, 5:Extended Round ]

// Extended Edge Thickness, in mm
extended_thickness = 0.3;       // [0.1:0.1:10]

// Extended Edge Height, in mm
extended_height = 0.8;    // [0.1:0.1:10]

//CUSTOMIZER VARIABLES END


// TODO - edge styles: rope


translate([0, 0, ring_height/2])
    ring();


module ring() {
	
    inside_radius = ring_size / 2;
    outside_radius = inside_radius + ring_thickness;
    extended_radius = outside_radius + extended_thickness;
    
    rounding_diameter = ring_thickness;
    rounding_radius = rounding_diameter / 2;
    
    cyl_height = ring_height - ((edge_style != 0 && edge_style < 4) ? 2*rounding_radius: 0);
    

    difference() {
        union() {
            cylinder( cyl_height, outside_radius, outside_radius, $fn = quality, center = true );
            
            // Extended Square
            if (edge_style == 4) {
               translate([0, 0, (cyl_height-extended_height)/2])
                  cylinder( extended_height, extended_radius, extended_radius, $fn = quality, center = true );
        
                translate([0, 0, -(cyl_height-extended_height)/2])
                  cylinder( extended_height, extended_radius, extended_radius, $fn = quality, center = true );
            }
            
            // Extended Round
            if (edge_style == 5) {
                translate([0, 0, (cyl_height-extended_height)/2])
                  rotate_extrude(convexity = 10, $fn = quality)
                    translate([inside_radius+ring_thickness, 0, 0])
                      scale([1,(extended_height/(extended_thickness*2)),1])    // scale on Y to get height
                        circle(r = extended_thickness, $fn = quality/5);
        
                translate([0, 0, -(cyl_height-extended_height)/2])
                  rotate_extrude(convexity = 10, $fn = quality)
                    translate([inside_radius+ring_thickness, 0, 0])
                      scale([1,(extended_height/(extended_thickness*2)),1])    // scale on Y to get height
                        circle(r = extended_thickness, $fn = quality/5);
            }
        }

        cylinder( ring_height+2, inside_radius, inside_radius, $fn = quality, center = true );
    }
    
    
    // Edge decoration added after
    
    // Round
    if (edge_style == 1) {
        translate([0, 0, cyl_height/2])
          rotate_extrude(convexity = 10, $fn = quality)
            translate([inside_radius+(ring_thickness/2), 0, 0])
              circle(r = rounding_radius, $fn = quality/5);
     
        translate([0, 0, -cyl_height/2])
          rotate_extrude(convexity = 10, $fn = quality)
            translate([inside_radius+(ring_thickness/2), 0, 0])
              circle(r = rounding_radius, $fn = quality/5);
    }
    
    // Triangle
    if (edge_style == 2) {
        translate([0, 0, cyl_height/2])
          rotate_extrude(convexity = 10, $fn = quality)
            translate([inside_radius, 0, 0])
              polygon( points=[[0,0],[ring_thickness/2,rounding_radius],[ring_thickness,0]] );
     
        translate([0, 0, -cyl_height/2])
          rotate_extrude(convexity = 10, $fn = quality)
            translate([inside_radius, 0, 0])
              polygon( points=[[0,0],[ring_thickness/2,-rounding_radius],[ring_thickness,0]] );
    }
    
    // Hex
    if (edge_style == 3) {
        translate([0, 0, cyl_height/2])
          rotate_extrude(convexity = 10, $fn = quality)
            translate([inside_radius+(ring_thickness/2), 0, 0])
              circle(r = rounding_radius, $fn = 6);
     
        translate([0, 0, -cyl_height/2])
          rotate_extrude(convexity = 10, $fn = quality)
            translate([inside_radius+(ring_thickness/2), 0, 0])
              circle(r = rounding_radius, $fn = 6);
    }
    
    
}
