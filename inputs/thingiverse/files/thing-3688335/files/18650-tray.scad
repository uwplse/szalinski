$fn = 60;
batDia = 18; // adjust for shrinkage if needed. standard 18650 dimension
batSpacing = 2;

bankColumns = 5;
bankRows = 3;

stripWidth = 5;
stripHeight = 1;

batStopLip = 2; // lip that restrains the battery from falling through the big hole. didnt know what else to call it


difference(){
//translate ([-batDia/2-batSpacing/2,-batDia/2-batSpacing/2,-.5]) cube([bankRows*(batDia+batSpacing),bankColumns*(batDia+batSpacing),5]);
    
//uncomment above and recomment below if you dont want rounded corners    
translate ([-batDia/2-batSpacing/2,-batDia/2-batSpacing/2,-.5]) rcube([bankRows*(batDia+batSpacing),bankColumns*(batDia+batSpacing),5],2);    
    
union(){
translate ([0,0,stripHeight/2])rectangular_array( rows=bankRows,cols=bankColumns,distance=batDia+batSpacing) cylinder(h=5, r=batDia/2);
translate ([0,0,-stripHeight/2])rectangular_array( rows=bankRows,cols=bankColumns,distance=batDia+batSpacing) cylinder(h=5, r=batDia/2-batStopLip);

rectangular_array( rows=bankRows,cols=bankColumns,distance=batDia+batSpacing) cube([batDia+batSpacing,stripWidth,stripHeight],true);
rectangular_array( rows=bankRows,cols=bankColumns,distance=batDia+batSpacing) cube([stripWidth,batDia+batSpacing,stripHeight],true);
}

}

module rectangular_array( rows,cols, distance) {
    for ( i= [0:1:rows-1])  {
        for ( j= [0:1:cols-1]) {
            translate([distance*i,distance*j,0,]) 
            children();
        }
    }
}

module rcube(size, radius) {
    hull() {
        translate([radius, radius]) cylinder(r = radius, h = size[2]);
        translate([size[0] - radius, radius]) cylinder(r = radius, h = size[2]);
        translate([size[0] - radius, size[1] - radius]) cylinder(r = radius, h = size[2]);
        translate([radius, size[1] - radius]) cylinder(r = radius, h = size[2]);
    }
}