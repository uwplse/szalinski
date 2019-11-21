// Width of the tray as it faces the enemy?
tray_width = 107; // [50:1000]
// Depth of the tray away from the enemy?
tray_depth = 53; // [25:500]
// Edge height of tray?
edge_height = 3;  // [2:5]
// How wide is the edge?
edge_width = 2; // [1:5]

difference () {

    cube ( [tray_width, tray_depth, edge_height], center=true ) ;

    translate ([0,edge_width,1]) {
        cube ( [tray_width-edge_width*2, tray_depth-edge_width+1, edge_height], center=true ) ;
    }
}