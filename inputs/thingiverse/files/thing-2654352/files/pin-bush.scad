// Written in 2017 by Matt Woodhead
//
// V1.0 - Original
// V1.1 - Added args to 'rotate_extrude' to increase STL precision

echo(version=version());

// Bush Internal Diameter (mm)
Bush_ID = 20; //

// Bush External Diameter (mm)
Bush_OD = 23; //

// Bush Length (mm) - Does not include flange thickness
Bush_Length = 20; //

Bush_Flange = "Yes"; // [Yes,No]

// Bush Flange Diameter (mm) - ignored if Bush_Flange = "No"
Bush_Flange_OD = 28; //

// Bush Flange Height (mm) - ignored if Bush_Flange = "No"
Bush_Flange_Height = 2; //

// Bush Flange Chamfer (mm) - ignored if Bush_Flange = "No"
Bush_Flange_Chamfer = 0.5; //

// Bush Top Chamfer (mm) - Set to zero for no chamfer
top_chamfer = 0.5;

// Bush Bottom Chamfer (mm) - Set to zero for no chamfer
Bottom_chamfer = 0.5;


if (Bush_Flange == "Yes") {
    color("red")
        rotate_extrude($fs = 0.5, $fa = 0.05)
            polygon( points=[[Bush_ID/2,Bottom_chamfer],
                             [(Bush_ID/2)+Bottom_chamfer,0],
                             [(Bush_Flange_OD/2)-Bottom_chamfer,0],
                             [Bush_Flange_OD/2,Bottom_chamfer],
                             [Bush_Flange_OD/2,Bush_Flange_Height],
                             [(Bush_OD/2) + Bush_Flange_Chamfer,Bush_Flange_Height],
                             [Bush_OD/2,Bush_Flange_Height + Bush_Flange_Chamfer],
                             [Bush_OD/2,Bush_Flange_Height + Bush_Length - top_chamfer],
                             [(Bush_OD/2) - top_chamfer,Bush_Flange_Height + Bush_Length],
                             [(Bush_ID/2) + top_chamfer,Bush_Flange_Height + Bush_Length],
                             [Bush_ID/2,Bush_Flange_Height + Bush_Length - top_chamfer],
                             ]);
} else {
    color("green")
        rotate_extrude($fs = 0.5, $fa = 0.05)
            polygon( points=[[Bush_ID/2,Bottom_chamfer],
                             [(Bush_ID/2)+Bottom_chamfer,0],
                             [(Bush_OD/2)-Bottom_chamfer,0],
                             [Bush_OD/2,Bottom_chamfer],
                             [Bush_OD/2,Bush_Length-top_chamfer],
                             [(Bush_OD/2)-top_chamfer,Bush_Length],
                             [(Bush_ID/2)+top_chamfer,Bush_Length],
                             [Bush_ID/2,Bush_Length-top_chamfer],
                             ]);
};




// Written in 2017 by Matt Woodhead