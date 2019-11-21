
//Select a base size in mm?
Base_Size = 20; // [5:5mm, 10:10mm, 15:15mm, 20:20mm, 24:24mm, 25:25mm, 28:28mm, 40:40mm, 50:50mm, 54:54mm, 108:108mm]

//Number of bases along front?
Figure_Width = 3; // [2:10]

//Number of figures deep?
Figure_Depth = 3; // [1:10] 

// How wide is the edge?
edge_width = 2; // [1:5]

// Edge height of tray?
edge_height = 4;  // [3:6]

//[Hidden]

tray_width = (Base_Size+1) * Figure_Width + edge_width*2-1;
tray_depth = (Base_Size+1) * Figure_Depth + edge_width; 

echo ($tray_width);
echo($tray_depth);

difference () {

difference () {

    cube ( [tray_width, tray_depth, edge_height], center=true ) ;

    translate ([0,edge_width,2]) {
            cube ( [tray_width-edge_width*2, tray_depth-(edge_width)/2, edge_height], center=true ) ;

    }

}

for ( x=[1: (Figure_Width-1)]){
     for (y=[1: (Figure_Depth-1)]){
        translate ([tray_width/2 - x*(Base_Size+1)-edge_width,
                            tray_depth/2 -  y*(Base_Size+1),
                            -0.5]){
             cube (1);
        }
     } 
}

}
