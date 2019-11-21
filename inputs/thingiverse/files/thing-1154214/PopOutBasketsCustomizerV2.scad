// Printing height of basket in mm
basketheight=12.7;
// Radius of basket in mm
basketradius=50;
// Length of the staight part of basket in mm, enter 0 to make a circle basket
straightlength=50;
// How many rings in basket, more will make it taller
numrings=6;
// distance between the rings in mm
spacing=3;
// ring resolution in degress, smaller is finer and slower
interval=10;
// Angle of virtual cutting blade, larger angle will cause a thicker cut
ringangle=3;
// Row overlap percent, smaller will couse the fit to be looser
overlap=25;
// Percent thicker to make cut at bottom so that the first few layers aren't squished
lowwidthpercent=50;
// how high in mm to make the wider cut
lowheight=0.8;
// Does the basket need a handle
handle=1; // [1:Yes, 2:No]
// How thick is the handle in mm
handlethickness=6.35;
// How far past the rivet should the handle go
handlestraight=5.85;
// How much distance between the handle and the basket where the rivet is.
handlespace=0.5;
// How much distance between the handle and the far edge
handleoffset=5;
// Radius of the thick part of the rivet
rivetout=3;
// Radius of the thin part of the rivet
rivetin=2;
// How much clearance between the basket handle and the rivet, smaller makes it tighter
rivetspace=0.25; 

/* [Hidden] */

scalefactor=1/360; // scale factor
maxrings=round(basketradius/spacing); // Max number of rings given size and spacing
end=(maxrings-2)*360; // end of rings
start=end-(numrings*360); // given the end where do we start
below=0; // Bottom of basket
above=basketheight; // top of basket
spheresize=((1-(overlap/100))*tan(ringangle)*basketheight)/2; // Thickness of cut
lowwidth=1+(lowwidthpercent/100);
ringspacebottom=scalefactor*spacing; // Value to base bottom cut from
topshift=tan(ringangle)*basketheight; // how much to move out the top layer
topshiftlow=tan(ringangle)*lowheight; // top layer for wider bottom

difference() {
    // Beginning of building the parts
    union() {
        // Basket blank
        hull() {
          translate([0,straightlength/2,0]) cylinder(h = basketheight, r = basketradius, center = false);
          translate([0,-straightlength/2,0]) cylinder(h = basketheight, r = basketradius, center = false);
        }
        // The handle and attachment
        if (handle==1) {
        union() {
            // The handle
            difference() {
              union() {
                // The round part of the handle
                translate([0,-handleoffset-straightlength/2,0]) difference() {
                    cylinder(h = basketheight, r = basketradius+handlethickness+handlespace, center = false);
                    translate([-(basketradius+handlethickness+handlespace),0,0]) cube([2*(basketradius+handlethickness+handlespace),basketradius+handlethickness+handlespace,basketheight]);
                }
                // The staight parts of the handle
                translate([basketradius+handlespace,-handleoffset-straightlength/2,0]) cube([handlethickness,handlestraight+handleoffset+straightlength/2,basketheight]);
                translate([-(basketradius+handlespace+handlethickness),-handleoffset-straightlength/2,0]) cube([handlethickness,handlestraight+handleoffset+straightlength/2,basketheight]);
                
              }
              // deleting the inner cylinder
              translate([0,-handleoffset-straightlength/2,0]) cylinder(h = basketheight, r = basketradius+handlespace, center = false);
              // Making space for the rivets
              translate([basketradius+handlespace,0,basketheight/2]) rotate([0,90,0]) cylinder($fn = 30, h = 12.7, r1 = rivetin+rivetspace, r2 = rivetout+rivetspace, center = true);
              translate([-(basketradius+handlespace),0,basketheight/2]) rotate([0,-90,0]) cylinder($fn = 30, h = 12.7, r1 = rivetin+rivetspace, r2 = rivetout+rivetspace, center = true);
            }
            // Adding the rivets
            translate([basketradius,0,basketheight/2]) rotate([0,90,0]) cylinder($fn = 30, h = (handlethickness+handlespace)*2, r1 = rivetin, r2 = rivetout, center = true);
            translate([-basketradius,0,basketheight/2]) rotate([0,-90,0]) cylinder($fn = 30, h = (handlethickness+handlespace)*2, r1 = rivetin, r2 = rivetout, center = true);
        }}
    }
    // The spriral slice
    for(i = [start : interval : end-0.001]) {
        straightadjust= (i%360)>=180 ? -straightlength/2 : straightlength/2 ; 
        hull() {
            translate([(ringspacebottom * i * cos(i)),straightadjust+(ringspacebottom * i * sin(i)),below]) sphere(spheresize);
            translate([(ringspacebottom * (i+interval) * cos((i+interval))),straightadjust+(ringspacebottom * (i+interval) * sin((i+interval))),below]) sphere(spheresize);
            translate([(ringspacebottom * i * cos(i))+(topshift*cos(i)),straightadjust+(ringspacebottom * i * sin(i))+(topshift*sin(i)),above]) sphere(spheresize);
            translate([(ringspacebottom * (i+interval) * cos((i+interval)))+(topshift*cos(i+interval)),straightadjust+(ringspacebottom * (i+interval) * sin((i+interval)))+(topshift*sin(i+interval)),above]) sphere(spheresize);
        }
    }
    // The straight pieces
    for(i = [start : 180 : end]) {
        hull() {
            translate([(ringspacebottom * i * cos(i)),straightlength/2+(ringspacebottom * i * sin(i)),below]) sphere(spheresize);
            translate([(ringspacebottom * (i) * cos((i))),-straightlength/2+(ringspacebottom * (i) * sin((i))),below]) sphere(spheresize);
            translate([(ringspacebottom * i * cos(i))+(topshift*cos(i)),straightlength/2+(ringspacebottom * i * sin(i))+(topshift*sin(i)),above]) sphere(spheresize);
            translate([(ringspacebottom * (i) * cos((i)))+(topshift*cos(i)),-straightlength/2+(ringspacebottom * (i) * sin((i)))+(topshift*sin(i)),above]) sphere(spheresize);
        }
    }
    // A second thicker spriral slice to deal with smooshed bottoms
    for(i = [start : interval : end-0.001]) {
        straightadjust= (i%360)>=180 ? -straightlength/2 : straightlength/2 ; 
        hull() {
            translate([(ringspacebottom * i * cos(i)),straightadjust+(ringspacebottom * i * sin(i)),below]) sphere(spheresize*lowwidth);
            translate([(ringspacebottom * (i+interval) * cos((i+interval))),straightadjust+(ringspacebottom * (i+interval) * sin((i+interval))),below]) sphere(spheresize*lowwidth);
            translate([(ringspacebottom * i * cos(i))+(topshiftlow*cos(i)),straightadjust+(ringspacebottom * i * sin(i))+(topshiftlow*sin(i)),lowheight]) sphere(spheresize);
            translate([(ringspacebottom * (i+interval) * cos((i+interval)))+(topshiftlow*cos(i+interval)),straightadjust+(ringspacebottom * (i+interval) * sin((i+interval)))+(topshiftlow*sin(i+interval)),lowheight]) sphere(spheresize);
        }
    }
    // Ditto for the straight pieces
    for(i = [start : 180 : end]) {
        hull() {
            translate([(ringspacebottom * i * cos(i)),straightlength/2+(ringspacebottom * i * sin(i)),below]) sphere(spheresize*lowwidth);
            translate([(ringspacebottom * (i) * cos((i))),-straightlength/2+(ringspacebottom * (i) * sin((i))),below]) sphere(spheresize*lowwidth);
            translate([(ringspacebottom * i * cos(i))+(topshiftlow*cos(i)),straightlength/2+(ringspacebottom * i * sin(i))+(topshiftlow*sin(i)),lowheight]) sphere(spheresize);
            translate([(ringspacebottom * (i) * cos((i)))+(topshiftlow*cos(i)),-straightlength/2+(ringspacebottom * (i) * sin((i)))+(topshiftlow*sin(i)),lowheight]) sphere(spheresize);
        }
    }
}
