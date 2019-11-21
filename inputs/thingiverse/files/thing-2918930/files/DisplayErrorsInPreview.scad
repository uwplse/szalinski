// preview[view:east, tilt:bottom]

// DisplayErrorsInPreview by kickahaota (https://www.thingiverse.com/thing:2918930)
// Brief usage instructions:
//      * Set 'assertions' vector to include the tests you want to be sure are true, and the error messages that should
//        appear if they aren't
//      * Change the main drawing code for your object to:
//        if (anyassertionsfailed()
//            rotate([45,0,45]) showfailedassertions();
//        else
//            doyournormaldrawingcode();
//      * The rotate above is correct for the default "view:south east, tilt:top diagonal" Thingiverse Customizer
//        preview orientation. If you're changing the preview orientation, you'll want to change the rotate so that
//        the text is correctly positioned.
//        Suggested: rotate([x,0,z]), where:
//                   Tilt=            x=          View=       z= 
//                 * top                0       * south east   45
//                 * top diagonal      45       * south         0         
//                 * side              90       * south west  315         
//                 * bottom diagonal  135       * west        270         
//                 * bottom           180       * north west  225         
//                                              * north       180
//                                              * north east  135
//                                              * east         90
//        So for view:east, tilt:bottom, you would use rotate([180,0,90]).

// [* Options *]
// How many sides should the figure have? (Must be an odd number.)
figure_sides = 6;
// What should the approximate diameter of the figure be? (Must be between 2.5 and 100 millimeters.)
diameter_in_millimeters = 70.0;
// How tall should the figure be? (Must be between 1 and 50 millimeters. Diameter plus height cannot exceed 120 millimeters.)
height_in_millimeters = 40.0;

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
sides = aoritoi(figure_sides);
diameter = aorftof(diameter_in_millimeters);
height = aorftof(height_in_millimeters);

// DisplayErrorsInPreview code by kickahaota (https://www.thingiverse.com/thing:2918930)
// Assertions we want to verify before making the real object
function isdef(x) = (x != undef);
function isnumeric(x) = isdef(x) && ( x + 0 == x);
function isinteger(x) = isdef(x) && ( floor(x) == x) ;
assertions = [
    [ isinteger(sides), "Figure Sides must be an integer" ] ,
    [ sides > 2, "Figure must have at least 3 sides" ] ,
    [ sides % 2 == 1, "Figure must have an odd number of sides" ],
    [ isnumeric(diameter), "Diameter must be a number" ] ,
    [ diameter >= 2.5, "Diameter must be at least 2.5 millimeters" ] ,
    [ diameter <= 100.0, "Diameter cannot exceed 100 millimeters" ],
    [ isnumeric(height), "Height must be a number" ] ,
    [ height >= 1.0, "Height must be at least 1 millimeter" ] , 
    [ height <= 50, "Height cannot exceed 50 millimeters" ] ,
    [diameter + height < 120, "Diameter plus height cannot exceed 120 millimeters" ]
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

if (anyassertionfailed())
{
    rotate([180,0,90]) showfailedassertions();
}
else
{
    cylinder(r = diameter / 2, h = height, $fn = sides);
}
