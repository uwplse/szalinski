
/* [Configurations] */
Object_Height = 50; // [50:200]
Object_Size = 50; // [50: 50mm, 100: 100mm, 150: 150mm, 200: 200mm]
Object_Type = 3; // [1: Box, 2: cover, 3: all]
Cover_Height = 25;
Wall_Tickness = 2;// 5mm is good enough

/* [hidden] */
$fn = 50;
Cover_Spacing = 0.5;
Rounded_Corner = 5;
Connector_Tickness = 2;
Connector_Width = 10;
Connector_Depth = 5;
Object_Side = Object_Size - Connector_Depth * 2;
Border_Width = Connector_Width * 0.5 + Connector_Depth;
Total_Width = Connector_Depth * 2 + Object_Side;

print();

module print() {
    if  (Object_Type == 1) {
        caixa();
    }
    if  (Object_Type == 2) {
        translate([Connector_Depth ,Object_Side + Connector_Depth,Cover_Height]) rotate([180,0,0]) tampa(0);
    }
    if  (Object_Type == 3) {
        caixa();
        translate([Total_Width + 1,Object_Side,Cover_Height]) rotate([180,0,0]) tampa(0);
    }
}

module caixa(){
    translate([Connector_Depth, Connector_Depth, 0])
    difference(){
        roundedcube(Object_Side, Object_Side, Object_Height, Rounded_Corner,Rounded_Corner,Rounded_Corner,Rounded_Corner);
        translate([Wall_Tickness, Wall_Tickness, Wall_Tickness]) roundedcube(Object_Side - Wall_Tickness * 2, Object_Side - Wall_Tickness * 2, Object_Height + 1,Rounded_Corner, Rounded_Corner, Rounded_Corner, Rounded_Corner);
    // Recorte da tampa
        translate([0,-0,(Object_Height + 1) - Cover_Height + (Wall_Tickness * 2)]) tampa(Cover_Spacing);    
    }
    allConnectors();
}

module tampa(folga){
    difference(){
    translate([-folga/2,-folga/2,0]) roundedcube(Object_Side + folga, Object_Side + folga, Cover_Height, Rounded_Corner,Rounded_Corner,Rounded_Corner,Rounded_Corner);
    translate([(Wall_Tickness + folga)/2, (Wall_Tickness + folga) /2, -Wall_Tickness]) roundedcube(Object_Side - Wall_Tickness - folga, Object_Side - Wall_Tickness - folga, Cover_Height , Rounded_Corner, Rounded_Corner, Rounded_Corner, Rounded_Corner);
    }
}

module roundedcube(xdim ,ydim ,zdim,rdim1, rdim2, rdim3, rdim4){
    hull(){
        translate([rdim1,rdim1,0]) cylinder(r=rdim1, h=zdim);
        translate([xdim-rdim2,rdim2,0]) cylinder(r=rdim2, h=zdim);

        translate([rdim3,ydim-rdim3,0]) cylinder(r=rdim3, h=zdim);
        translate([xdim-rdim4,ydim-rdim4,0]) cylinder(r=rdim4, h=zdim);
    }
}

module mConnector() {
    linear_extrude((Object_Height + 1) - Cover_Height + (Wall_Tickness * 2))
    polygon(
        points = [
            [-Connector_Width / 2+ Connector_Tickness, 0],
            [Connector_Width / 2 - Connector_Tickness, 0],
            [Connector_Tickness / 2, Connector_Depth],
            [-Connector_Tickness / 2, Connector_Depth]
        ], center = true);
}

module fConnector() {
    difference() {
        cube([Connector_Width, Connector_Depth, (Object_Height + 1) - Cover_Height + (Wall_Tickness * 2)]);
        translate([Connector_Width / 2, 0, 0])
        scale(1.1)
        mConnector();
    }
}

module sideConnectors(pairs) {
    for (i = [0:pairs - 1]) {
        translate([Border_Width + Connector_Width + 50 * i, Connector_Depth, 0])
        rotate([0, 0, 180])
        fConnector();
        space_connectors = 10;
        translate([Border_Width + Connector_Width * 1.5 + space_connectors + 50 * i, 0, 0])
        mConnector();
    }
    
}

function pairQtt() =
    (Object_Size == 50) ? 1 :
        (Object_Size == 100) ? 2 :
            (Object_Size == 150) ? 3 : 4;

module allConnectors() {
    
    pairs = pairQtt();
    
    sideConnectors(pairs);
    translate([50 * pairs, 0, 0]) rotate([0, 0 , 90])
    sideConnectors(pairs);
    translate([0, 50 * pairs, 0]) rotate([0, 0 , -90])
    sideConnectors(pairs);
    translate([50  * pairs, 50  * pairs, 0]) rotate([0, 0 , 180])
    sideConnectors(pairs);
}

