// [* Basics *]
// Please be aware that the STL object file will not have any instructions to change the temperature of your printer during printing; you will need to process the generated object to add this, as described in the documentation. Choose 'I understand' to continue.
do_you_understand = 0; // [ 0:I don't get it, 1:I understand ]
// Number of stories in the tower
tower_stories = 7;
// Temperature value to print on the first (bottommost) story of the tower
tower_first_story_temperature = 190;
// Temperature change for each story of the tower above the first -- for example, 5 if each story's printed temperature should be 5 degrees higher than the story below it, or -10 if each story's printed temperature should be 10 degrees lower than the story below it. 
tower_per_story_temperature_change = 5; // [ 10, 5, -5, -10]

// [* Advanced *]
// Total height of each 'story' in the tower, in millimeters. BE CAREFUL WHEN CHANGING THIS, because the instructions and scripts people use for temperature towers almost always assume 10 millimeters per story.
tower_story_height = 10; 
// Number of bridges built for each story, in millimeters.
bridge_count = 2; // [ 1, 2, 3, 4]
// Thickness of the bridge on each story, in millimeters
bridge_thickness = 1; // [1, 1.5, 2, 2.5]
// Width of the longest bridge on each story (from support platform edge to edge), in millimeters. The other bridges will be proportionately shorter -- for example, if the longest bridge is 60mm and there are three bridges, the bridges will be 60mm, 40mm, and 20mm. If there are two bridges, they will be 60mm and 30mm.
bridge_unsupported_length = 30;
// Width of each bridge, in millimeters.
bridge_width = 4.0;
// Overhang angle used for the triangular support to the left of the bridges. Used to test printers' ability to print unsupported overhangs. Most printers can support somewhere between 45 and 60 degrees of overhang under good conditions.
bridge_left_support_overhang_angle = 45; // [ 30, 35, 40, 45, 50, 55, 60, 65]
// Overhang angle used for the triangular support to the right of the bridges. Used to test printers' ability to print unsupported overhangs. Most printers can support somewhere between 45 and 60 degrees of overhang under good conditions.
bridge_right_support_overhang_angle = 60; // [ 30, 35, 40, 45, 50, 55, 60, 65]
// Longest unsupported length of the unsupported bridge planks hanging to the left of the rightmost support tower. You can set this to zero to omit the overhang planks.
overhang_plank_length = 1.6;

// [* Hidden *]
// BEGIN BOILERPLATE CODE: Parameter conversion
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
// END BOILERPLATE CODE: Parameter conversion

// Customizer may have converted numeric parameters into strings; turn them back into numbers
// Stories in the tower
story_count = aoritoi(tower_stories);
// Height of each story in the tower, in millimeters
story_zsize = aorftof(tower_story_height);
// First story temperature
first_story_temp = aoritoi(tower_first_story_temperature);
// Per-story temperature change
temp_delta = aoritoi(tower_per_story_temperature_change);
// Thickness of each bridge
eachbridge_zsize = aorftof(bridge_thickness);
// Width of each bridge
eachbridge_ysize = aorftof(bridge_width);
// Number of bridges
bridges = aoritoi(bridge_count);
// Width of the unsupported portion of the longest bridge
longestbridge_unsupportedxsize = aoritoi(bridge_unsupported_length);
// Unsupported length of the longest overhang plank
longestoverhangplank_unsupportedxsize = aorftof(overhang_plank_length);
overlap = 0.0001 + 0; // Make most parts ever-so-slightly bigger than they really should be, so that things overlap rather than just touching, avoiding discontinuities in the object caused by rounding errors
base_zsize = 2 + 0; // Thickness of the tower's base
base_xyprotrusion = 4 + 0; // Amount by which the tower's base should stick out beyond the tower stories
eachbridge_supportedxsize = 8 + 0; // Amount of bridge that should be supported on each end by platforms
eachbridge_leftgap = 4 + 0; // Size of gap between the left support block and the bridge
longestbridge_rightgap = 8 + 0; // Size of gap between the right support block and the bridge
overhangplanks = (longestoverhangplank_unsupportedxsize <= 0) ? 0 : max(1, bridges-1);

// Positions and sizes of story objects
// NOTE: Each story's coordinate space runs from [0, 0, 0] to [story_xsize, story_ysize, story_zsize) -- nothing can go outside this area

// Position and size of the left support block
leftsupportblock_xoffset = 0 + 0; 
leftsupportblock_xsize = 12.0 + 0; 

// Position and size of the bridge support platform on the right side of the left support block
leftsupportblock_rightplatform_xoffset = leftsupportblock_xoffset + leftsupportblock_xsize;
leftsupportblock_rightplatform_zoffset = base_zsize;
leftsupportblock_rightplatform_zsize = story_zsize - eachbridge_zsize - base_zsize;
leftsupportblock_rightplatform_supportangle = aorftof(bridge_left_support_overhang_angle);
leftsupportblock_rightplatform_xsize = leftsupportblock_rightplatform_zsize * tan(leftsupportblock_rightplatform_supportangle);

eachbridge_ygapsize = 1.2 + 0; // Gap between multiple bridges on each story
// The total y-size of the tower
story_ysize = (eachbridge_ysize * max(bridges,2)) + (eachbridge_ygapsize * (bridges - 1));
// Position and size of the bridges
function bridge_xoffset(idxbridge) = leftsupportblock_xoffset + leftsupportblock_xsize + eachbridge_leftgap;
function bridge_xsize(idxbridge) = (2 * eachbridge_supportedxsize) + (longestbridge_unsupportedxsize * (1 + idxbridge) / bridges);
function bridge_yoffset(idxbridge) = (bridges == 1) ? (story_ysize - eachbridge_ysize) : ((eachbridge_ysize + eachbridge_ygapsize) * idxbridge);
function bridge_ysize(idxbridge) = eachbridge_ysize;
function bridge_zoffset(idxbridge) = leftsupportblock_rightplatform_zoffset + leftsupportblock_rightplatform_zsize;
function bridge_zsize(idxbridge) = eachbridge_zsize;
longestbridge_xoffset = bridge_xoffset(bridges-1);
longestbridge_xsize = bridge_xsize(bridges-1);

// Position and size of the shorter bridges' end support tower
function shortbridgesupport_xoffset(idxbridge) = bridge_xoffset(idxbridge) + bridge_xsize(idxbridge) - eachbridge_supportedxsize;
function shortbridgesupport_xsize(idxbridge) = eachbridge_supportedxsize;

// Position and size of the bridge support platform on the left side of the right support block
rightsupportblock_leftplatform_xoffset = longestbridge_xoffset + longestbridge_xsize - eachbridge_supportedxsize;
rightsupportblock_leftplatform_zoffset = base_zsize;
rightsupportblock_leftplatform_zsize = story_zsize - eachbridge_zsize - base_zsize;
rightsupportblock_leftplatform_supportangle = aorftof(bridge_right_support_overhang_angle);
rightsupportblock_leftplatform_xsize = rightsupportblock_leftplatform_zsize * tan(rightsupportblock_leftplatform_supportangle);

// Position and size of overhang planks
function overhangplank_unsupportedxsize(idxplank) = longestoverhangplank_unsupportedxsize * (overhangplanks - idxplank) / overhangplanks;
function overhangplank_xsize(idxplank) = overhangplank_unsupportedxsize(idxplank) + eachbridge_supportedxsize;
function overhangplank_xoffset(idxplank) = rightsupportblock_leftplatform_xoffset - overhangplank_unsupportedxsize(idxplank);
function overhangplank_yoffset(idxplank) = (bridges == 1) ? 0 : bridge_yoffset(idxplank);
function overhangplank_ysize(idxplank) = eachbridge_ysize;
function overhangplank_zoffset(idxplank) = bridge_zoffset(idxplank);
function overhangplank_zsize(idxplank) = eachbridge_zsize;


// Position and size of the right support block
rightsupportblock_xoffset = rightsupportblock_leftplatform_xoffset + rightsupportblock_leftplatform_xsize;
rightsupportblock_xsize = 12.0 + 0;

// Position and size of the right support block's platform for the cone test area
// Note that each story's cone is actually printed on the platform from the story below it (or on the base for the first story)
rightsupportblock_rightplatform_xoffset = rightsupportblock_xoffset + rightsupportblock_xsize;
rightsupportblock_rightplatform_zoffset = 5 + 0;
rightsupportblock_rightplatform_zsize = story_zsize - rightsupportblock_rightplatform_zoffset;
rightsupportblock_rightplatform_supportangle = 60.0 + 0; // Not customizable at this point since it can mess with the cone test
rightsupportblock_rightplatform_xsize = rightsupportblock_rightplatform_zsize * tan(rightsupportblock_rightplatform_supportangle);

// The total x-size of the tower
story_xsize = rightsupportblock_rightplatform_xoffset + rightsupportblock_rightplatform_xsize;

// Position and size of the test cone 
testcone_diameter = 2.4 + 0;
testcone_zsize = 6.0 + 0;
testcone_xcenter = story_xsize - (testcone_diameter / 2) - 0.8; // Leave 0.8mm between edge of cone and edge of platform
testcone_ycenter = story_ysize / 2;
testcone_zoffset = 0 + 0;

supportblock_smallbasezsize = 0.8 + 0; // This many millimeters of each story support block's base should be smaller than the rest of the block
supportblock_smallbasexyinset = 0.8 + 0; // Each story support block's base should be this much smaller than the rest of the block on all four sides

// BEGIN: Calculated/converted variables

// END: Calculated/converted variables

// BEGIN BOILERPLATE CODE: Assertion checking and error message display
// DisplayErrorsInPreview code by kickahaota (https://www.thingiverse.com/thing:2918930)
// Assertions we want to verify before making the real object
function isdef(x) = (x != undef);
function isnumeric(x) = isdef(x) && ( x + 0 == x);
function isinteger(x) = isdef(x) && ( floor(x) == x) ;
module showfailedassertions() {
    for(idx = [0 : len(assertions)-1]) {
        if (!assertions[idx][0]) {
            translate([0, -12*idx, 0]) linear_extrude(height=1) text(text=assertions[idx][1]);
        }
    }
}

function anyassertionfailed(idx = len(assertions)-1) = (!(assertions[idx][0]) ? 1 : (idx <= 0) ? 0 : anyassertionfailed(idx-1)); 
// END BOILERPLATE CODE: Assertion checking and error message display

// Conditions that must be met for the tower to be printed
assertions = [
    [ isnumeric(story_xsize), "Tower size can't be calculated -- something is wrong with the script" ] ,
    [ isinteger(story_count), "Story count must be an integer" ] ,
    [ ((story_count >= 3) && (story_count <= 30)), "Story count must be between 3 and 30" ] ,
    [ isnumeric(story_zsize), "Story height must be a number" ] ,
    [ story_zsize >= 8, "Story height must be at least 8 millimeters" ] ,
    [ isinteger(first_story_temp), "First story temperature must be an integer" ] ,
    [ first_story_temp >=100, "First story temperature must be at least 100 degrees" ] ,
    [ isinteger(temp_delta), "Per-story temperature change must be an integer" ] ,
    [ temp_delta != 0, "Per-story temperature change must be nonzero" ] ,
    [ isinteger(bridges), "Bridge count must be a number" ] ,
    [ ((bridges >= 1) && (bridges <= 4)), "Bridge count must be 1, 2, 3, or 4" ] ,
    [ isinteger(longestbridge_unsupportedxsize), "Bridge unsupported length must be an integer" ] ,
    [ longestbridge_unsupportedxsize >= 10.0, "Bridge unsupported length must be at least 10 millimeters" ] ,
    [ isnumeric(eachbridge_ysize), "Bridge width must be a number" ] ,
    [ eachbridge_ysize >= 1.0, "Bridge must be at least 1 millimeter wide" ] ,
    [ eachbridge_ysize <= 10.0, "Bridge cannot be wider than 10 millimeters" ] ,
    [ isnumeric(eachbridge_zsize), "Bridge thickness must be a number" ] ,
    [ eachbridge_zsize >= 1.0, "Bridge must be at least 1 millimeter thick" ] ,
    [ eachbridge_zsize <= (story_zsize - 5), "Each story must be at least 5 millimeters higher than the bridge's thickness" ] ,
    [ isnumeric(leftsupportblock_rightplatform_supportangle), "Left bridge support angle must be a number" ] ,
    [ ((leftsupportblock_rightplatform_supportangle >= 30) && (leftsupportblock_rightplatform_supportangle <= 65)), "Left bridge support angle must be between 30 and 65" ],
    [ isnumeric(rightsupportblock_leftplatform_supportangle), "Right bridge support angle must be a number" ] ,
    [ ((rightsupportblock_leftplatform_supportangle >= 30) && (rightsupportblock_leftplatform_supportangle <= 65)), "Right bridge support angle must be between 30 and 65" ],
    [ isnumeric(longestoverhangplank_unsupportedxsize), "Unsupported length of overhang plank must be a number" ] ,
    [ longestoverhangplank_unsupportedxsize >= 0, "Unsupported length of overhang plank cannot be negative" ] ,
    
    [ do_you_understand == 1, "Please read the instructions in the customizer to begin" ]
];

// Produces a single support block for a tower story. Assumes that we're translated so that
// the support block should occupy the space from ([xoffset,0,0]) to ([xoffset+xsize, ysize, zsize]).
module supportblock(xoffset, xsize, ysize, zsize, labeltext)
{
    // Produce the smaller bottom portion of the block
    translate([xoffset + supportblock_smallbasexyinset, supportblock_smallbasexyinset, 0])
    {
        cube([xsize - (2 * supportblock_smallbasexyinset), ysize - (2 * supportblock_smallbasexyinset), supportblock_smallbasezsize + overlap]);
    }
    // Produce the rest of the block
    render() difference()
    {
        translate([xoffset, 0, supportblock_smallbasezsize])
            cube([xsize, ysize, zsize - supportblock_smallbasezsize + overlap]);
        translate([xoffset + (xsize / 2), 1, zsize/2])
            rotate([90,0,0])
                linear_extrude(height=1 + overlap)
                    text(text=str(labeltext), size=4, halign="center", valign="center");
    }
}

module leftsupportblock(temp)
{
    supportblock(leftsupportblock_xoffset, leftsupportblock_xsize, story_ysize, story_zsize, str(temp));
}    

module rightsupportblock()
{
     supportblock(rightsupportblock_xoffset, rightsupportblock_xsize, story_ysize, story_zsize, "");
}

// Produces a platform to the right of a support block
module rightsupportplatform(xoffset, xsize, yoffset, ysize, zoffset, zsize)
{
    translate([xoffset - overlap, yoffset+ysize, zoffset])
        rotate([90,0,0])
            linear_extrude(height=ysize) 
                polygon([[0,0], [xsize + (2 * overlap), zsize + overlap], [0, zsize + overlap]]);
}

// Produces a platform to the left of a support block
module leftsupportplatform(xoffset, xsize, yoffset, ysize, zoffset, zsize)
{
    translate([xoffset-overlap, yoffset+ysize, zoffset])
        rotate([90,0,0])
            linear_extrude(height=ysize) 
                polygon([[xsize + (2 * overlap), 0], [0, zsize + overlap], [xsize, zsize + overlap]]);
}

// Produces one bridge for a story of the tower,
module bridge(idxbridge)
{
    translate([bridge_xoffset(idxbridge), bridge_yoffset(idxbridge), bridge_zoffset(idxbridge)])
        cube([bridge_xsize(idxbridge) + overlap, bridge_ysize(idxbridge) + overlap, bridge_zsize(idxbridge) + overlap]);
}

// Produces all bridges for a story of the tower.
module allbridges()
{
    for (idxbridge = [0 : bridges-1])
    {
        bridge(idxbridge);
    }
}

// Produces one short bridge support tower for a story of the tower.
module shortbridgesupport(idxbridge)
{
    translate([shortbridgesupport_xoffset(idxbridge), bridge_yoffset(idxbridge), 0])
    cube([shortbridgesupport_xsize(idxbridge) + overlap, bridge_ysize(idxbridge) + overlap, story_zsize + overlap]);
}

// Produces all short bridge support towers for a story of the tower.
module allshortbridgesupports()
{
    if (bridges > 1)
    {
        for (idxbridge = [0 : bridges-2]) // Longest bridge doesn't need a tower
        {
            shortbridgesupport(idxbridge);
        }
    }
}

// Produces one overhang plank for a story of the tower,
module overhangplank(idxplank)
{
    translate([overhangplank_xoffset(idxplank), overhangplank_yoffset(idxplank), overhangplank_zoffset(idxplank)])
        cube([overhangplank_xsize(idxplank) + overlap, overhangplank_ysize(idxplank) + overlap, overhangplank_zsize(idxplank) + overlap]);
}

// Produces all overhang planks for a story of the tower.
module alloverhangplanks()
{
    if (overhangplanks > 0)
    {
        for (idxplank = [0 : overhangplanks-1])
        {
            overhangplank(idxplank);
        }
    }
}

module testcone(ycenter)
{
    translate([testcone_xcenter, ycenter, testcone_zoffset])
    {
        cylinder(h = testcone_zsize, r1 = testcone_diameter / 2, r2 = 0.2);
    }
}

module testcones()
{
    if ((testcone_diameter > 0) && (testcone_zsize > 0))
    {
        conesthatfit = floor(story_ysize / testcone_diameter);
        if (conesthatfit > 0)
        {
            // First cone goes at the front of the tower
            testcone(testcone_diameter / 2);
            if (conesthatfit > 1)
            {
                // Second cone goes at the back of the tower
                testcone(story_ysize - (testcone_diameter / 2));
                if (conesthatfit > 2)
                {
                    // Third cone goes in between, closer to front
                    remainingymin = testcone_diameter;
                    remainingymax = story_ysize - testcone_diameter;
                    remainingcone_ycenter = (remainingymin + remainingymin + remainingymax) / 3;
                    testcone(remainingcone_ycenter);
                }
            }
        }
    }
}


// Produces a single story of the tower. Assumes that we're translated so that the story 
// should occupy the space from ([0,0,0] to [+story_xsize, +story_ysize, +story_zsize]).
module story(temp)
{
    leftsupportblock(temp);
    rightsupportplatform(leftsupportblock_rightplatform_xoffset, leftsupportblock_rightplatform_xsize, 
                         0, story_ysize,
                         leftsupportblock_rightplatform_zoffset, leftsupportblock_rightplatform_zsize);
    allbridges();
    allshortbridgesupports();
    alloverhangplanks();
    leftsupportplatform(rightsupportblock_leftplatform_xoffset, rightsupportblock_leftplatform_xsize,
                        0, story_ysize,
                        rightsupportblock_leftplatform_zoffset, rightsupportblock_leftplatform_zsize);
    rightsupportblock();
    rightsupportplatform(rightsupportblock_rightplatform_xoffset, rightsupportblock_rightplatform_xsize, 
                         0, story_ysize,
                         rightsupportblock_rightplatform_zoffset, rightsupportblock_rightplatform_zsize);
    testcones();
}

module allstories()
{
    for (idxstory = [0 : story_count - 1])
    {
        translate([-(story_xsize / 2), -(story_ysize/2) , (idxstory * story_zsize)])
        {
             story(first_story_temp + (temp_delta * idxstory));
        }
    }
}
module base()
{
    base_xsize = story_xsize + (2 * base_xyprotrusion);
    base_ysize = story_ysize + (2 * base_xyprotrusion);
    // Note that the base will overwrite the bottommost few millimeters of the first story of 
    // the tower. This is intentional. It makes the tower look slightly less tidy than other
    // versions, but it means that the base doesn't add height to the tower -- and that means 
    // that if you run the resulting tower's gcode through a 'modify the tower's temperature
    // every story_zsize millimeters' script, the points at which the temperature changes will
    // actually match the story boundaries on the tower, which is kind of the point. :)
    translate([-(base_xsize / 2) , -(base_ysize/2), 0])
    {
        cube([base_xsize, base_ysize, base_zsize]);
    }
}

module wholetower()
{
    base();
    allstories();
}

// Actually render the thing, or explain why we can't
if (anyassertionfailed())
{
    showfailedassertions();
}
else
{
    wholetower();
}
