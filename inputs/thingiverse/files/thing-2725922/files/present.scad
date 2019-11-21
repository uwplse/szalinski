/* [Parameters] */

parts = 3; // [3:both, 1:box_only, 2:lid_only]
width = 25;
height = 20;
depth = 25;

/* [Ribbons] */
bowRotation = 0;
ribbonPosY = 0.5;
ribbonPosX = 0.5;
ribbonWidth = 3;

/* [Hidden] */
ribbonThick = 0.8;
wallThick = 1.2;
clearance = 0.25;
fudge = 0.1;

module bowPath(h)
{
  scale([.1, .05, 3]) union()
  {
    linear_extrude(height=h)
      polygon([[-72.503724,38.556015],[-35.461921,38.475099],[-5.117411,38.004359],[8.356405,37.553620],[18.924846,36.918235],[25.124471,35.979263],[31.533352,34.284763],[37.939262,31.980477],[44.129972,29.212144],[49.893256,26.125505],[55.016886,22.866300],[59.288636,19.580270],[62.496276,16.413155],[65.324676,12.709976],[67.801789,8.651624],[69.852263,4.319713],[71.400746,-0.204147],[72.371884,-4.838345],[72.690326,-9.501268],[72.280717,-14.111305],[71.067706,-18.586845],[69.756597,-21.598936],[68.182893,-24.361622],[66.363266,-26.876196],[64.314387,-29.143955],[62.052929,-31.166192],[59.595562,-32.944203],[54.159790,-35.772724],[48.140444,-37.639875],[41.670898,-38.556015],[34.884524,-38.531502],[27.914696,-37.576695],[22.565933,-36.162339],[17.773468,-34.247880],[13.478266,-31.906696],[9.621297,-29.212162],[6.143526,-26.237656],[2.985921,-23.056553],[-2.604920,-16.368065],[-7.623490,-9.733710],[-12.542049,-3.740500],[-15.111407,-1.167766],[-17.832860,1.024552],[-20.765441,2.763078],[-23.968184,3.974435],[-33.600683,6.439524],[-41.284438,8.088342],[-52.094703,9.815595],[-58.976954,10.913058],[-61.750690,11.774639],[-64.509164,13.137595],[-66.281468,14.416025],[-67.784007,15.959765],[-70.065569,19.651223],[-71.525417,23.828058],[-72.335115,28.106360],[-72.666230,32.102218],[-72.690326,35.431720],[-72.503724,38.556015]]);
  }
}

module ribbonPath(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-1.889526,-28.390625],[-5.561401,-28.734375],[-9.114136,-28.496094],[-12.889526,-27.390625],[-14.835655,-25.912486],[-16.018724,-24.090613],[-16.764526,-21.890625],[-12.202026,-16.515625],[-7.694214,-12.187500],[-5.232300,-10.310547],[-2.764526,-8.890625],[-0.805879,-7.527573],[0.538709,-5.638889],[1.343336,-3.353986],[1.682100,-0.802276],[1.629098,1.886827],[1.258427,4.583912],[-0.139526,9.484375],[-2.065308,13.746094],[-4.108276,17.515625],[-6.389526,21.234375],[-5.952026,22.046875],[-4.764526,23.609375],[-4.053101,23.665527],[-2.799683,23.191406],[0.547974,21.296875],[5.110474,18.234375],[8.860474,27.484375],[9.485474,28.203125],[10.126099,28.644531],[10.860474,28.734375],[11.653442,28.160156],[12.422974,27.140625],[13.235474,25.734375],[15.219849,16.718750],[16.452271,8.173828],[16.764526,3.686768],[16.735474,-0.640625],[16.304840,-4.831084],[15.515014,-8.572587],[14.374969,-11.865976],[12.893676,-14.712091],[11.080108,-17.111773],[8.943237,-19.065862],[6.492035,-20.575199],[3.735474,-21.640625],[1.268677,-22.576660],[-0.412964,-23.644531],[-1.450073,-24.765137],[-1.983276,-25.859375],[-2.100464,-27.652344],[-1.889526,-28.390625]]);
  }
}




module bow()
{
    
    union() 
    {
        for (i=[0:5])
        {
            rotate([0,0,i*72])    
            translate([3.5,-1.5,2])    
            rotate([-90,0,0])
            scale([0.6,1.2,1])
            bowPath(1);
        }

        rotate([0,0,0])    
        translate([2.5,-7,0])
        ribbonPath(1.6);
        
        rotate([0,0,-30])
        scale([-1,1,1])
        translate([2.5,-7,0])    
        ribbonPath(1.6);
    }
}



module presentBottom(w, d, h)
{
    ribbonOffsetYExtents = d-ribbonWidth;
    ribbonOffsetY = -d/2 + (ribbonOffsetYExtents * ribbonPosY) + (ribbonWidth/2);
    
    ribbonOffsetXExtents = w-ribbonWidth;
    ribbonOffsetX = -w/2 + (ribbonOffsetXExtents * ribbonPosX) + (ribbonWidth/2);
    
    tabSize = w * 0.8;
    
    difference() {
    union() {
        translate([ribbonOffsetX,0,0])
        cube([ribbonWidth, d+(ribbonThick*2), h], center=true);
        
        translate([0,ribbonOffsetY,0])
        cube([w+(ribbonThick*2), ribbonWidth, h], center=true);
        cube([w,d,h], center=true);
        
        translate([0,d/2-(wallThick*1.5),wallThick/2])
        cube([tabSize, wallThick, h+wallThick], center=true);

        translate([0,-d/2+(wallThick*1.5),wallThick/2])
        cube([tabSize, wallThick, h+wallThick], center=true);
    }
    
    translate([0,0,wallThick])
    cube([w-(wallThick*2), d-(wallThick*4),h], center=true);
}
}

module presentTop(w, d, h)
{
    ribbonOffsetYExtents = d-ribbonWidth;
    ribbonOffsetY = -d/2 + (ribbonOffsetYExtents * ribbonPosY) + (ribbonWidth/2);
        
    ribbonOffsetXExtents = w-ribbonWidth;
    ribbonOffsetX = -w/2 + (ribbonOffsetXExtents * ribbonPosX) + (ribbonWidth/2);
    
    tabSlotSize = w * 0.8 + (clearance * 2);
    tabSlotThick = wallThick + (clearance * 2);
    tabSlotHeight = wallThick + (clearance * 3);
    
    difference() {
    difference() {
        union() {
            translate([ribbonOffsetX,0,0.2])
            cube([ribbonWidth, d+(ribbonThick*2), h+0.4], center=true);

            translate([0,ribbonOffsetY,0.2])
            cube([w+(ribbonThick*2), ribbonWidth, h+0.4], center=true);

            cube([w,d,h], center=true);
            
            rotate([0,0,bowRotation])
            translate([ribbonOffsetX,ribbonOffsetY,h/2])
            scale([0.7,0.7,0.8])
            bow();
        }
    
        translate([0,d/2-(wallThick*1.5), -h/2+tabSlotHeight/2-clearance])
        cube([tabSlotSize, tabSlotThick, tabSlotHeight], center=true);
    }
        //color([0,0,1])
        translate([0,-d/2+(wallThick*1.5), -h/2+tabSlotHeight/2-clearance])
        cube([tabSlotSize, tabSlotThick, tabSlotHeight], center=true);
}
}


module fullPresent(w, h, d, parts) {
    
    posOffset = 0.75 * w;
    
    if (parts > 0) {    
        if (parts % 2 == 1) {
            if (parts == 3) {
                translate([-posOffset,0,(h-5)/2])
                presentBottom(w, d, h-5);
            }
            else {
                translate([0,0,(height-5)/2])
                presentBottom(w, d, h-5);
            }
        }
        
        if (parts > 1) {
            if (parts == 3) {
                translate([posOffset,0,2.5])
                presentTop(w, d, 5);

            }
            else
            {
                translate([0,0,2.5])
                presentTop(w, d, 5);
            }
        }
    }
}

fullPresent(width, height, depth, parts);




