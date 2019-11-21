/* Extension tray for wireless charging pad by Ryan Huang, written on 13/10/2019, Thingiverse ID: yyh1002
*/

//diameter of wireless charger
chargerDiameter = 85; 

//height of wireless charger
chargerHeight = 15; 

//diagonal of phone
phoneDiagonal = 175; 

//roof thickness of extension pad
roofThickness = 1;

//height of wall
wallHeight = 4;

//chamfer size between wall and roof
chamfer = 2;

//width of USB adapter openning
adapterWidth = 12;

wallThickness = 3;

chamferSmall = 0.6;

chamferBottom = chargerHeight * 0.4;

beamHeight = wallThickness;

$fn=256;

roofProfilePts = [
    [0,chargerHeight],
    [0,chargerHeight+roofThickness],
    [phoneDiagonal/2-min(chamfer,wallHeight-chamferSmall),chargerHeight+roofThickness],
    [phoneDiagonal/2,chargerHeight+roofThickness+min(chamfer,wallHeight-chamferSmall)],
    [phoneDiagonal/2,chargerHeight+roofThickness+wallHeight-chamferSmall],
    [phoneDiagonal/2+chamferSmall,chargerHeight+roofThickness+wallHeight],
    [phoneDiagonal/2+wallThickness-chamferSmall,chargerHeight+roofThickness+wallHeight],
    [phoneDiagonal/2+wallThickness-chamferSmall,chargerHeight+roofThickness+wallHeight],
    [phoneDiagonal/2+wallThickness,chargerHeight+roofThickness+wallHeight-chamferSmall],
    [phoneDiagonal/2+wallThickness,chargerHeight]
    ];
edgeProfilePts = [
    [phoneDiagonal/2+wallThickness,chargerHeight],
    [phoneDiagonal/2+wallThickness,chargerHeight*0.75],
    [phoneDiagonal/2+wallThickness-chamferBottom,0],
    [phoneDiagonal/2-chamferBottom,0],
    [phoneDiagonal/2-chamferBottom,chargerHeight]
    ];

cutoutPts = [
    [0,adapterWidth/2],
    [phoneDiagonal/2+wallThickness,adapterWidth/2],
    [phoneDiagonal/2+wallThickness,-adapterWidth/2],
    [0,-adapterWidth/2]
    ];

supportPts = [
    [chargerDiameter/2+wallThickness/2,wallThickness/2],
    [phoneDiagonal/2,wallThickness/2],
    [phoneDiagonal/2,-wallThickness/2],
    [chargerDiameter/2+wallThickness/2,-wallThickness/2]
    ];

module roofMesh (){
    rotate_extrude(convexity = 10)
    polygon(roofProfilePts);
}

module edgeMesh (){
    difference (){
        rotate_extrude(convexity = 10)
        polygon(edgeProfilePts);
        cutoutMeshOutside ();
    }
}

module coreProfile (){
    difference (){
        circle(r = chargerDiameter/2+wallThickness);
        circle(r = chargerDiameter/2);
    }
}

module coreMesh (){
    difference (){
        linear_extrude(height = chargerHeight)
        coreProfile ();
        cutoutMeshInside ();
    }
}

module cutoutProfile (){
    intersection (){
    difference (){
        circle (r = phoneDiagonal/2+wallThickness);
        circle (r = chargerDiameter/2-wallThickness);
    }
    polygon(cutoutPts);
}
}

module cutoutMeshInside (){
    linear_extrude (chargerHeight)
    cutoutProfile ();
}

module cutoutMeshOutside (){
    linear_extrude (chargerHeight*0.75)
    cutoutProfile ();
}

module adapterWallProfile (){
    intersection (){
        union (){
            translate ([0,adapterWidth/2+wallThickness/2,0])
            polygon(supportPts);
            translate ([0,-adapterWidth/2-wallThickness/2,0])
            polygon(supportPts);
        }
        difference (){
            circle (r = phoneDiagonal/2-chamferBottom);
            circle (r = chargerDiameter/2+wallThickness);
        }
    }
}

module adapterWallMesh (){
    linear_extrude (chargerHeight)
    adapterWallProfile ();
}

module supportProfile (){
    intersection (){
        union (){
            rotate ([0,0,45])
            polygon(supportPts);
            rotate ([0,0,90])
            polygon(supportPts);
            rotate ([0,0,135])
            polygon(supportPts);
            rotate ([0,0,180])
            polygon(supportPts);
            rotate ([0,0,-45])
            polygon(supportPts);
            rotate ([0,0,-90])
            polygon(supportPts);
            rotate ([0,0,-135])
            polygon(supportPts);
        }
        difference (){
            circle (r = phoneDiagonal/2-chamferBottom);
            circle (r = chargerDiameter/2+wallThickness);
        }
    }
}

module supportMesh (){
    translate ([0,0,max(0,chargerHeight-beamHeight)])
    linear_extrude (min(chargerHeight,beamHeight))
    supportProfile ();
}

union (){
    roofMesh ();
    edgeMesh ();
    coreMesh ();
    adapterWallMesh ();
    supportMesh ();
}


