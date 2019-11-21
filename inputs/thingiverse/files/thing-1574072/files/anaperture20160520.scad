/*  anaperture20160520.scad

    This OpenSCAD program creates anaglph aperture mask plates
    that loosely fit against the filter thread of a host lens.
    What does that mean?  Read on....

    Would you like to be able to capture "3D" images using your
    current film or digital, still or movie, camera? Got $1? The
    anaperture CGI is an interactive WWW tool for creation of
    the special dual-aperture discs proposed for single-lens
    anaglyph capture.

    An anaglyph is a type of stereo image in which the left and
    right sides are encoded in a single image by assigning
    approximately non-overlapping colors to each side. Although
    many color assignments can be used, the most common are
    red/cyan and green/magenta. To see depth, you use viewing
    glasses that have color filters causing each eye to see only
    the colors assigned to that side's view.

    Normally, two separate images are captured and then
    processed together to form the anaglyph. Instead, we can
    directly capture the image as an anaglyph by using filters
    cut from cardboard-frame viewing glasses of the same colors
    used for viewing. This will wreck a pair of glasses, but
    they cost no more than $1. Alternatively, you can use
    photographic or stage lighting gel filters; stage lighting
    gel samples are cheap and generally come with graphs of the
    measured spectral transmission.

    The two colors normally would be placed in front of two
    separate lenses, however, it suffices to create two optical
    paths within a single lens. This is done by a type of dual
    Waterhouse Stop -- a fancy name for a piece of dark paper or
    cardboard with two holes in it. If the holes are sized and
    placed correctly, and the appropriate filter is placed over
    each, capturing an anaglyph image is as simple as placing
    this new stop in front of the lens and pressing the shutter
    button.

    The hole size and placement are critical, and depend on some
    properties of the lens. Note that many lenses have
    inaccurate markings (e.g., marked as f/3.5 might really be
    f/3.8) and zoom lenses may need multiple stops due to having
    different properties at different focal lengths. The
    anaperture tool, http://aggregate.org/anaperture, accepts a
    few key parameters, computes the ideal stop design, and
    generates a Scalable Vector Graphic (SVG) image of the stop
    for printing. Laser or inkjet print the stop, tape color
    filters over the holes, cut it out, stick it in front of
    your lens, and capture some anaglyphs!

    However, now that many of us have 3D printers, it's even
    easier to just print the anaglyph mask plate... so this
    OpenSCAD Customizer program creates ready-to-print designs.
    Note that you still have the minor issue of how to get the
    filter material mounted on the 3D-printed design. You can
    either tape/glue it to the bottom or, if you set two_piece,
    it will make the piece in two parts so you can sandwich the
    filter material between them.

    2016 by Hank Dietz
*/

// What is the lens filter thread major diameter (size)?
thread_size = 490; // [240:24mm,250:25mm,270:27mm,300:30mm.305:30.5mm,340:34mm,355:35.5mm,365:36.5mm,370:37mm,375:37.5mm,390:39mm,405:40.5mm,430:43mm,460:46mm,480:48mm,490:49mm,520:52mm,530:53mm,550:55mm,580:58mm,620:62mm,670:67mm,720:72mm,770:77mm,820:82mm,860:86mm (86M or 86C),940:94mm (94C),950:95mm (95C),1050:105mm (105C),1070:107mm (107 or 107C),1100:110mm,1120:112mm,1125:112.5mm,1250:125mm (125C),1270:127mm,1380:138mm,1450:145mm]

// Actual lens focal length in mm?
focal_length = 50;

// Widest f/number of the lens * 100 (e.g., f/1.4 is 140)?
f_number = 140;

// Desired f/stop * 100 (use 0 to automatically set)?
f_number_wanted = 1100;

// Desired stereo baseline in microns (e.g., 8mm is 8000 microns; use 0 to automatically set)?
stereo_baseline = 8000;

// Thickness of the aperture plate in microns
plate_thickness = 1000;

// Height of the tab above the plate in microns
tab_height = 5000;

// Angle covered by tab in degrees (0 is no tab)
tab_angle = 45;

// Make the cap in one or two pieces?
two_piece = 1; // [0:Make in one piece, 1:Make separate top/bottom to sandwich filters]

// How do you want the cap labeled?
label_part = 1; // [0:No markings, 1:Label with dimensions]

// Tolerance in microns, generally between extrusion height and nozzle diameter
tolerance = 250;

// The name of the font to use for labels is:
my_font = "MgOpen Modata:style=Bold";


/* [Hidden] */

$fn = 180;

// scaling to real values
thread = thread_size / 10;
length = focal_length;
fnum = f_number / 100;
fstop = f_number_wanted / 100;
base = stereo_baseline / 1000;
plate = plate_thickness / 1000;
tab = tab_height / 1000;
tol = tolerance / 1000;
POSERR = tol; // worst-case positioning error for extrusion
THDEEP = 1 - tol; // thread depth allowance for firm fit

// Widths...
fnwide = length / fnum;
fswide = length / fstop;

// If aperture is greater than thread, aperture becomes limited to thread
if0 = ((thread - (2 * THDEEP)) < fnwide);
fnwide0 = (if0 ? (thread - (2 * THDEEP) - POSERR) : fnwide);
fnum0 = (if0 ? (length / fnwide0) : fnum);

// Space of field
field = thread + 2.0;
center = (field / 2.0);

// Compute positions...
fstop0 = ((fstop < fnum0) ? fnum0 : fstop);

// Compute maximum possible base allowing for position error
if1 = ((base <= 0) || (base > fnwide));
base0 = (if1 ? (fnwide - (POSERR + (2 * fswide)) + fswide) : base);

// Overlap? Reduce fstop...
if2 = (base0 < (POSERR + fswide));
fswide1 = (if2 ? ((fnwide - (3 * POSERR)) / 2) : fswide);
fstop1 = (if2 ? (length / fswide1) : fstop0);
base1 = (if2 ? (fnwide - (POSERR + (2 * fswide1)) + fswide1) : base0);

echo(str("Lens filter thread is ", thread, ", pattern reduced to ", (thread - THDEEP), " to fit inside thread"));
echo(str("Lens focal length is ", length));
echo(str("Widest f/number of lens is f/", fnum, ", or a diameter of ", fnwide, "mm"));
echo(str("Generated f/stop is f/", fstop1, ", or a diameter of ", fswide1, "mm"));
echo(str("Stereo baseline is ", base1, "mm, with an optimal near subject distance around ", (base1*30/1000), "m"));
echo(str("Plate is ", plate, "mm thick, with tab extending ", tab, "mm taller"));

module wholething()
{
    difference() {
        union() {
            // Base plate
            cylinder(d=(thread-THDEEP), h=plate);
            // Add optional tab
            if (tab_angle > 0) {
                difference() {
                    intersection() {
                        cylinder(d=(thread-THDEEP), h=plate+tab);
                        hull()
                        for (a=[-tab_angle/2:tab_angle/2])
                        rotate([0, 0, 90+a])
                        translate([(thread-THDEEP)/2, 0, 0])
                        cube([thread-THDEEP, plate, 3*(plate+tab)], center=true);
                    }
                    // 45-degree lead-in to tab
                    translate([0, 0, plate])
                    cylinder(d1=(thread-THDEEP)-4*plate, d2=(thread-THDEEP)-2*plate, h=plate);
                    // tab
                    translate([0, 0, plate*2])
                    cylinder(d=(thread-THDEEP)-2*plate, h=3*(plate+tab));
                }
            }
            // Add optional labeling
            if (label_part) {
                toplab = str("f=", round(length), "mm");
                botlab = str("f/", round(fstop1*10)/10, "-", round(base1*10)/10, "mm");
                mlen = max(len(toplab), len(botlab));
                // font magnification guessed to fit
                fmag = 3.5 * (thread / 49) / mlen;
                translate([0, ((thread-THDEEP)/2-(fswide1/2))/2, 0])
                scale([fmag, fmag, 1])
                linear_extrude(height=2*tol+plate, convexity = 10, $fn=15)
                text(text=toplab, halign="center", valign="center", font=my_font);
                translate([0, -((thread-THDEEP)/2-(fswide1/2))/2, 0])
                scale([fmag, fmag, 1])
                linear_extrude(height=2*tol+plate, convexity = 10, $fn=15)
                text(text=botlab, halign="center", valign="center", font=my_font);
            }
        }
        
        // The apertures
        for (lr=[0,1])
        mirror([lr, 0, 0])
        translate([base1/2, 0, 0])
        union() {
            // Straight hole
            cylinder(d=fswide1, h=3*plate, center=true);
            // With 45-degree edge
            translate([0, 0, 2*tol])
            cylinder(d1=fswide1, d2=fswide1+2*plate, h=plate);
        }
    }
}

if (two_piece) {
    union() {
        // bottom half
        translate([-(thread/2+1), 0, 0])
        difference() {
            wholething();
            translate([0, 0, 2*tol])
            cylinder(d=(thread-THDEEP)-4*plate, h=3*(plate+tab));
        }
        // top half (tol smaller, to fit inside)
        translate([(thread/2+1), 0, -2*tol])
        intersection() {
            wholething();
            translate([0, 0, 2*tol])
            cylinder(d=(thread-THDEEP)-4*plate-tol, h=3*(plate+tab));
        }
    }
} else {
    wholething();
}
