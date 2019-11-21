
// [* Options *]
// What approximate size should the test object be, in millimeters? (This will be the width and height of the object if you use a maximum overhang of 85 and a minimum overhang of 0. With more typical overhangs, it will be somewhat smaller.)
size = 40; // [40:5:100]
// What should be the maximum overhang angle, in degrees?
maximum_overhang = 70; // [30:5:85]
// How thick should the first test curve be, in millimeters?
curve_1_thickness = 4.8; // [2.0:0.1:5.0]
// How thick should the second test curve be, in millimeters? (This can be set to zero if you want to print only one test curve.)
curve_2_thickness = 3.6; // [0.0:0.1:5.0]
// How thick should the third test curve be, in millimeters? (This can be set to zero if you want to print only one or two test curves.)
curve_3_thickness = 2.4; // [0.0:0.1:5.0]

// [* Hidden *]

// Convert strings to floating point for compatibility with Customizer
// Conversion code by jesse (https://www.thingiverse.com/thing:2247435)
function atoi(str, base=10, i=0, nb=0) =
	i == len(str) ? (str[0] == "-" ? -nb : nb) :
	i == 0 && str[0] == "-" ? atoi(str, base, 1) :
	atoi(str, base, i + 1,
		nb + search(str[i], "0123456789ABCDEF")[0] * pow(base, len(str) - i - 1));

function substr(str, pos=0, len=-1, substr="") =
	len == 0 ? substr :
	len == -1 ? substr(str, pos, len(str)-pos, substr) :
	substr(str, pos+1, len-1, str(substr, str[pos]));
    
function atof(str) = len(str) == 0 ? 0 : let( expon1 = search("e", str), expon = len(expon1) ? expon1 : search("E", str)) len(expon) ? atof(substr(str,pos=0,len=expon[0])) * pow(10, atoi(substr(str,pos=expon[0]+1))) : let( multiplyBy = (str[0] == "-") ? -1 : 1, str = (str[0] == "-" || str[0] == "+") ? substr(str, 1, len(str)-1) : str, decimal = search(".", str), beforeDecimal = decimal == [] ? str : substr(str, 0, decimal[0]), afterDecimal = decimal == [] ? "0" : substr(str, decimal[0]+1) ) (multiplyBy * (atoi(beforeDecimal) + atoi(afterDecimal)/pow(10,len(afterDecimal)))); 

function aorftof(numorstr) = (numorstr + 1 == undef) ? atof(numorstr) : numorstr;
function aoritoi(numorstr) = (numorstr + 1 == undef) ? atoi(numorstr) : numorstr;

// Customizer may have converted numeric parameters into strings; turn them back into numbers
xy_size = aoritoi(size);
overhang_max = aoritoi(maximum_overhang);
curve1_thickness = aorftof(curve_1_thickness);
curve2_thickness = aorftof(curve_2_thickness);
curve3_thickness = aorftof(curve_3_thickness);

// Non-customizable parameters
backing_thickness = 2.0 + 0;
backing_label_depth = 0.8 + 0;
base_thickness = 2.0 + 0;
eachcurve_width = 6.0 + 0;
curvegap_width = 2.0 + 0;

// DisplayErrorsInPreview code by kickahaota (https://www.thingiverse.com/thing:2918930)
// Assertions we want to verify before making the real object
function isdef(x) = (x != undef);
function isnumeric(x) = isdef(x) && ( x + 0 == x);
function isinteger(x) = isdef(x) && ( floor(x) == x) ;
assertions = [
    [ size >= 40, "Size must be at least 40 millimeters"] ,
    [ size <= 100, "Size cannot be greater than 100 millimeters"] ,
    [ overhang_max >= 30, "Maximum Overhang must be at least 30 degrees" ] ,
    [ overhang_max <= 85, "Maximum Overhang cannot exceed 85 degrees" ] ,
    [ curve1_thickness > 0, "Curve 1 Thickness must be greater than zero" ],
    [ curve1_thickness <= 5.0, "Curve 1 Thickness cannot be greater than 5 millimeters" ],
    [ curve2_thickness >= 0, "Curve 2 Thickness cannot be negative" ],
    [ curve2_thickness <= 5.0, "Curve 2 Thickness cannot be greater than 5 millimeters" ],
    [ curve3_thickness >= 0, "Curve 3 Thickness cannot be negative" ],
    [ curve3_thickness <= 5.0, "Curve 3 Thickness cannot be greater than 5 millimeters" ],
    [ (curve3_thickness == 0) || (curve2_thickness > 0), "Curve 3 Thickness cannot be nonzero if Curve 2 Thickness is zero" ],
];

module showfailedassertions() {
    translate([0,0,0]) linear_extrude(height=1) text(text="Please make these parameter changes:");
    for(idx = [0 : len(assertions)-1]) {
        if (!assertions[idx][0]) {
            translate([0, -12*idx, 0]) linear_extrude(height=1) text(text=assertions[idx][1]);
        }
    }
}

function anyassertionfailed(idx = len(assertions)-1) = (!(assertions[idx][0]) ? 1 : (idx <= 0) ? 0 : anyassertionfailed(idx-1)); 

function arccoords(startangle, step, endangle, xy_size)
    = ((step > 0 && startangle > endangle) || (step < 0 && startangle < endangle))
        ? []
        : concat([[xy_size * sin(startangle), xy_size * cos(startangle)]],
                 arccoords(startangle+step, step, endangle, xy_size)); 

module filledarc(enddeg, xy_size, xy_thickness, z_thickness)
{
    arcpoly = concat([[0,0]],
                     arccoords(0, 0.5, enddeg, xy_size),
                     arccoords(enddeg, -0.5, 0, xy_size - xy_thickness));
    rotate([0,0,90])
        linear_extrude(height=z_thickness)
            polygon(arcpoly);
}

module testcurve(thickness)
{
    filledarc(overhang_max, xy_size, thickness, eachcurve_width);
    translate([-(xy_size), 0, -curvegap_width - 0.001])
    {
        difference()
        {
            cube([max(xy_size / 4, 25), base_thickness, eachcurve_width + curvegap_width + 0.002]);
            translate([7,base_thickness - backing_label_depth, curvegap_width + (eachcurve_width / 2)])
                rotate([270,0,0])
                    linear_extrude(height=backing_label_depth + 0.001)
                        text(text=str(thickness, "mm"), font="Helvetica:Bold", size=4, valign="center", halign="left");
        }
                
    } 
}

module backing()
{
    difference()
    {
        filledarc(overhang_max, xy_size, xy_size * 3 / 4, backing_thickness);
        for (labeldeg = [10 : 10 : (overhang_max - 1)])
        {
            rotate(180 - labeldeg)
            {
                translate([xy_size * 3 / 4, 0, backing_thickness - backing_label_depth])
                    cube([xy_size / 4, 0.8, backing_label_depth + 0.001]);
                translate([(xy_size * 3 / 4) - 2, 0, backing_thickness - backing_label_depth])
                    rotate([0,0,180])
                        linear_extrude(height = backing_label_depth + 0.001)
                            text(text=str(labeldeg), font="Helvetica:Bold", size=4, valign="center", halign="left");
            }
        }
    }
}

    
module wholething()
{
    translate([xy_size / 2, 0, 0])
        rotate([90, 0, 0])
        {
            backing();
            translate([0, 0, backing_thickness + curvegap_width])
            {
                testcurve(curve_1_thickness);
                if (curve_2_thickness > 0)
                {
                    translate([0, 0, eachcurve_width + curvegap_width])
                    {
                        testcurve(curve_2_thickness);
                        if (curve_3_thickness > 0)
                        {
                            translate([0, 0, eachcurve_width + curvegap_width])
                            {
                                testcurve(curve_3_thickness);
                            }
                        }
                    }
                }
            }
        }
}    

if (anyassertionfailed())
{
    rotate([45,0,45]) showfailedassertions();
}
else
{
    wholething();
}
