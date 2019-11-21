// ---------- variables ----------

baseLength = 60;
baseWidth = 44;
baseHeight = 4.5;

strapChannelWidth = 21;
strapChannelDepth = 1.5;

// ---------- base ----------

difference () {
    $fn=60;
    minkowski()
    {
        sphere(d=baseHeight/2, $fn=60);
        cube([baseLength-baseHeight/2,baseWidth-baseHeight/2,baseHeight/2], center=true);
    }

    // the strapChannel itself
    translate([0,0,(baseHeight-strapChannelDepth)/2])
        cube([baseLength,strapChannelWidth,strapChannelDepth], center=true);
    
    // strap slopes
    translate([0,-(strapChannelWidth/2),baseHeight/2-strapChannelDepth])
    rotate([-90,0,0])
    linear_extrude(strapChannelWidth)
        polygon([[13,0],[13,-strapChannelDepth],[baseLength/2,-strapChannelDepth],[baseLength/2,(baseHeight-strapChannelDepth)/2]]);
    
    translate([0,(strapChannelWidth/2),(baseHeight/2)-strapChannelDepth])
    rotate([-90,0,180])
    linear_extrude(strapChannelWidth)
        polygon([[13,0],[13,-strapChannelDepth],[baseLength/2,-strapChannelDepth],[baseLength/2,(baseHeight-strapChannelDepth)/2]]);
}

// ---------- clip ----------

union () {
    translate([0,14.50,(baseHeight/2)+4.5])
    linear_extrude(2)
        polygon([[-12.799999,-0.239987],[-9.650000,-3.089988],[9.650002,-3.089988],[12.799999,-0.239987],[11.748001,3.389988],[-11.752001,3.389988]]);

    translate([0,14.50,0])
    linear_extrude((baseHeight/2)+6.5)
        polygon([[-12.799999,-0.239987],[12.799999,-0.239987],[11.748001,3.389988],[-11.752001,3.389988]]);
    
    translate([-11.75,17.8,6.5])
    rotate([0,90,0])
    linear_extrude(23.5)
        polygon([[-(baseHeight/2),0],[6.5,0],[6.5,(baseWidth/2)-17.9]]);
}

mirror([0,1,0])
union () {
    translate([0,14.50,(baseHeight/2)+4.5])
    linear_extrude(2)
        polygon([[-12.799999,-0.239987],[-9.650000,-3.089988],[9.650002,-3.089988],[12.799999,-0.239987],[11.748001,3.389988],[-11.752001,3.389988]]);

    translate([0,14.50,0])
    linear_extrude((baseHeight/2)+6.5)
        polygon([[-12.799999,-0.239987],[12.799999,-0.239987],[11.748001,3.389988],[-11.752001,3.389988]]);
    
    translate([-11.75,17.8,6.5])
    rotate([0,90,0])
    linear_extrude(23.5)
        polygon([[-(baseHeight/2),0],[6.5,0],[6.5,(baseWidth/2)-17.9]]);
}