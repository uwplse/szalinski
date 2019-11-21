/* [Main Options] */

// Miniature base size
baseSize = 1; // [0.5:Tiny, 1: Small, 1:Medium, 2:Large, 3:Huge, 4:Gargantuan, 6:Colossal]

// Pregenerated text options. Set to 'Custom' to use the custom text field below.
text = "Custom"; // [Custom, Blinded, Charmed, Deafened, Exhausted, Frightened, Grappled, Incapacitated, Invisible, Paralyzed, Petrified, Poisoned, Prone, Restrained, Stunned, Unconscious] 

// The word(s) on the ring. Overriden by the text selector above.
customText = "customisable";

// Whether to repeat the word(s) around the ring
textDuplication = 1; //[0:Single, 1:Multiple]

/* [Ring Options] */

// Difference between inner and outer radius in mm
ringThickness = 2; // [0.8:0.4:12]

// Height in mm
ringHeight = 3.6; // [1:0.2:21.6]

// Gap between base and ring inner surface
baseSizeTolerance = 0.1; // [0:0.1:2]

/* [Text Options] */

// Whether the text faces inwards or outwards
textOrientation = 1; // [1:Outwards, -1:Inwards]

// Override the number of times the text is placed around the ring, set to non-zero to enforce
textInstanceCount = 0; // [0:5]

// Height of the individual letters in mm. Letter widths are based on this value.
textHeight = 4; // [2:2:12]

// Offset from the top of the ring to the top of the text in mm
textExtrusionHeight = 1.2; // [0:0.2:7.2]

/* [Advanced] */

// Set to non-zero to set the inner ring diameter in mm, overriding base size and ignoring base size tolerance
ringDiameterOverride = 0;

// Stroke thickness of the text, ratio to text height. Ensure that stroke thickness in mm exceeds your nozzle diameter.
textStrokeThickness = 0.2;

// The depth of the words that overlaps the ring in mm
textOverlap = 0.2;

// Ratio to text stroke thickness
letterSpacing = 0.8;

// Controls word spacing. Distance between words in mm is (this + 3x stroke width) * text height.
spaceWidth = 0.4;

/* [Hidden] */

computedText = text == "Custom" ? customText : text;

computedInnerRingRadius = ringDiameterOverride == 0 ? (baseSize * 25.4) / 2 + baseSizeTolerance : ringDiameterOverride / 2; // in mm

outerRingRadius = computedInnerRingRadius + ringThickness;

$fa = 7.5;
$fs = (textHeight * textStrokeThickness * PI) / 12;

union() {
    linear_extrude(ringHeight)
        difference() {
            circle(outerRingRadius);
            circle(computedInnerRingRadius);
        }

    linear_extrude(ringHeight + textExtrusionHeight)
        text(toUpper(computedText), textHeight, (outerRingRadius - textOverlap) * textOrientation, textStrokeThickness);
}

module text(string, size = 1, radius = 0, textStrokeRatio = 0.2) {
    eIndex = len(string) - 1;
    r = radius + (sign(radius) * size / 2);
    
    widths = [for (i = [0:eIndex]) size * (getLetterWidth(string[i]) + textStrokeRatio)];
        
    spacing = size * (textStrokeRatio * letterSpacing);
    
    offsets = concat([0], accumulate([for (i = [1:eIndex]) widths[i - 1] / 2 + spacing + widths[i] / 2]));
        
    totalWidth = widths[0] / 2 + offsets[eIndex] + widths[eIndex] / 2;
    totalAngle = abs(arcAngle(totalWidth, r));
    
    minDuplicateGap = abs(arcAngle(1.2 * size, r));
    minTriplicateGap = abs(arcAngle(4 * size, r));
    
    wordsCount = textDuplication == 0 ? 1
        : textInstanceCount > 0 ? textInstanceCount
            : (totalAngle + minTriplicateGap) * 3 < 360 ? 3
                : (totalAngle + minDuplicateGap) * 2 < 360 ? 2
                    : 1;
    
    union() {
        for (i = [0:wordsCount - 1])
            rotate((360 / wordsCount) * i)
                words(string, size, r, widths, offsets,
                    totalWidth, textStrokeRatio);
    }
}

module words(string, size = 1, radius = 0, widths, offsets, totalWidth, textStrokeRatio = 0.2) {
    eIndex = len(string) - 1;
    
    angles = [for (i = [0:eIndex]) arcAngle(offsets[i], radius)];
    
    translations = [for (i = [0:eIndex]) [radius == 0 ? offsets[i] : 0, -radius]];
    
    centreOffset = totalWidth / 2 - widths[0] / 2;
    centreRotatation = -arcAngle(centreOffset, radius);
    centreTranslation = [radius == 0 ? -centreOffset : 0, 0];
    
    rotate(centreRotatation)
    translate(centreTranslation)
    union() {
        for(i = [0:eIndex])
            rotate(angles[i])
            translate(translations[i])
                letter(string[i], size, textStrokeRatio);
    }
}

module letter(char, size = 1, textStrokeRatio = 0.2) {
    features = getLetter(char) * size;
    slotWidth = textStrokeRatio * size;
    
    union() {
        if (len(features) > 0)
            for(i = [0:len(features) - 1])
                for (j = [0:len(features[i]) - 1])
                    slot(features[i][j], slotWidth);
    }
}

module slot(params, width) {
    start = params[0];
    end = params[1];
    centre = (len(params) > 2) ? params[2] : undef;
    
    union() {
        centreSection(start, end, centre, width);
        translate(start)
            circle(width / 2);
        translate(end)
            circle(width / 2);
    }
}

module centreSection(start, end, centre, width) {
    if (centre == undef) {
        dir = normd(end - start);
        offset = perp(dir) * width / 2;
        
        polygon([
            start + offset, end + offset,
            end - offset, start - offset
        ]);
    }
    else {
        radius = mag(diff(centre, start));
        
        angles = [angle0to360(normd(diff(start, centre))),
            angle0to360(normd(diff(end, centre)))];
        
        translate(centre)
            arc(radius, angles, width);
    }
}

module arc(centre_radius, angles, width) {
    difference() {
        sector(centre_radius + width / 2, angles);
        circle(centre_radius - width / 2);
    }
}

module sector(radius, angles) {
    n=($fn>0?($fn>=3?$fn:3):ceil(max(min(360/$fa,radius*2*PI/$fs),5)));
    r = radius / cos(180 / n);
    step = -360 / n;
    
    modifier = angles[1] > angles[0] ? 360 : 0;
    
    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - modifier]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]),
            r * sin(angles[1])]]
    );

    difference() {
        circle(radius);
        polygon(points);
    }
}

function sub(num1, num2) = abs(num1 - num2) > 1e-5 ? num1 - num2 : 0;

function diff(vec1, vec2) = [sub(vec1[0], vec2[0]), sub(vec1[1], vec2[1])];

function mag(vec) = norm(vec);

function normd(vec) = vec/mag(vec);

function perp(dir) = [-1 * dir[1], dir[0]];

function angle0to360(vec) = acos(vec[0]) * (sign(vec[1]) < 0 ? -1 : 1) + (sign(vec[1]) < 0 ? 360 : 0);

function signeddot(vec) = acos(vec[0]) * (sign(vec[1]) < 0 ? -1 : 1);

function arcAngle(length, radius) = radius != 0 ? 360 * length / (2 * PI * radius) : 0;

function isnum(var) = var >= 0 || var <= 0;

function subvec(vec, pos = 0, len = -1, subvec = []) = len == 0 ? subvec : len == -1 ? subvec(vec, pos, len(vec) - pos, subvec) : subvec(vec, pos + 1, len - 1, concat(subvec, [vec[pos]]));

function last(vec) = vec[len(vec) - 1];

function cumulativeAppend(vec, value) = concat(vec, [last(vec) + value]);

function accumulate(vec) = (len(vec) > 1) ? cumulativeAppend(accumulate(subvec(vec, 0, len(vec) - 1)), last(vec)) : vec;

function toVector(angle, length) = [cos(angle) * length, sin(angle) * length];

// Uses ord(x) when using an up to date version of OpenSCAD, else uses my implementation
function ordFix(char) = version_num() >= 20190500 ? ord(char) : myOrd(char);

asciiCodes = [for(i=[ /* SPACE */ 32 : ( /* LOWERCASE Z */ 97 + 25) + 4]) i];
ascii = chr(asciiCodes);

function myOrd(char) =
    str(char) != char ? undef :
    let (res = search(char, ascii)[0])
    res != undef ? asciiCodes[res] : undef;

function toUpper(string) = 
	chr([for (i = [0:len(string)-1])
        let(code = ordFix(string[i]))
        code + (code >= 97 && code <= 122 ? -97+65 : 0)]);

function getLetter(char) =
	char == "A" ?
	[[[[-0.35000000000000003, -0.39999999999999997], [-0.05882381258703795, 0.39999999999999997]],
	[[-0.05882381258703795, 0.39999999999999997], [0.05882381258703812, 0.39999999999999997]],
	[[0.05882381258703812, 0.39999999999999997], [0.35000000000000003, -0.39999999999999997]]],
	[[[-0.24080892700834966, -0.09999999254941959], [0.24080892700834955, -0.09999999254941905]]]] :
	char == "B" ?
	[[[[-0.29999103546142575, 0.014000000000000056], [0.09300899732112881, 0.014000000000000056]],
	[[0.09300899732112881, -0.39999999999999997], [0.09300899732112881, 0.014000000000000056], [0.09300899732112881, -0.19299999999999998]],
	[[0.09300899732112881, -0.39999999999999997], [-0.29999103546142575, -0.39999999999999997]],
	[[-0.29999103546142575, -0.39999999999999997], [-0.29999103546142575, 0.39999999999999997]],
	[[-0.29999103546142575, 0.39999999999999997], [0.06100896453857416, 0.39999999999999997]],
	[[0.06100896453857416, 0.014000000000000411], [0.06100896453857416, 0.39999999999999997], [0.06100896453857416, 0.20700000000000018]]]] :
	char == "C" ?
	[[[[0.2974744946030249, 0.2999999999999996], [0.052525520324707024, 0.39999999999999997], [0.052525520324707024, 0.049999999999999996]],
	[[0.052525520324707024, 0.39999999999999997], [-0.29747447967529295, 0.049999999999999996], [0.052525520324707024, 0.049999999999999996]],
	[[-0.29747447967529295, 0.049999999999999996], [-0.29747447967529295, -0.049999999999999996]],
	[[-0.29747447967529295, -0.049999999999999996], [0.052525520324707024, -0.39999999999999997], [0.052525520324707024, -0.049999999999999996]],
	[[0.052525520324707024, -0.39999999999999997], [0.2974744946030253, -0.2999999999999999], [0.052525520324707024, -0.049999999999999996]]]] :
	char == "D" ?
	[[[[-0.3, 0.39999999999999997], [-0.049999999999999996, 0.39999999999999997]],
	[[0.3, 0.05000000000000017], [-0.049999999999999996, 0.39999999999999997], [-0.049999999999999996, 0.05000000000000017]],
	[[0.3, 0.05000000000000017], [0.3, -0.04999999999999982]],
	[[-0.049999999999999996, -0.3999999999999998], [0.3, -0.04999999999999982], [-0.049999999999999996, -0.04999999999999982]],
	[[-0.049999999999999996, -0.3999999999999998], [-0.3, -0.39999999999999997]],
	[[-0.3, -0.39999999999999997], [-0.3, 0.39999999999999997]]]] :
	char == "E" ?
	[[[[0.25, -0.3999999999999302], [-0.24999999999993036, -0.3999999999997561]],
	[[-0.24999999999993036, -0.3999999999997561], [-0.24999999999965183, 0.3999999999999303]],
	[[-0.24999999999965183, 0.3999999999999303], [0.24999999999996658, 0.3999999999997563]]],
	[[[-0.2499999999997911, 8.704148513061227e-14], [0.1499999999999666, -4.654054919228656e-14]]]] :
	char == "F" ?
	[[[[-0.25, -0.39999999999999997], [-0.25, 0.39999999999999997]],
	[[-0.25, 0.39999999999999997], [0.25, 0.39999999999999997]]],
	[[[-0.25, 0.0], [0.15, 0.0]]]] :
	char == "G" ?
	[[[[0.2699489742783186, 0.3], [0.024999999999999998, 0.39999999999999997], [0.024999999999999998, 0.049999999999999996]],
	[[0.024999999999999998, 0.39999999999999997], [-0.325, 0.049999999999999996], [0.024999999999999998, 0.049999999999999996]],
	[[-0.325, 0.049999999999999996], [-0.325, -0.049999999999999996]],
	[[-0.325, -0.049999999999999996], [0.024999999999999998, -0.39999999999999997], [0.024999999999999998, -0.049999999999999996]],
	[[0.024999999999999998, -0.39999999999999997], [0.32500010803341867, -0.23027738399460132], [0.024999999999999998, -0.049999999999999996]],
	[[0.32500010803341867, -0.23027738399460132], [0.32500010803341867, -0.024999999999999998]],
	[[0.32500010803341867, -0.024999999999999998], [0.1250001050531864, -0.024999999999999998]]]] :
	char == "H" ?
	[[[[-0.3, -0.39999999999999997], [-0.3, 0.39999999999999997]]],
	[[[-0.3, 0.0], [0.3, 0.0]]],
	[[[0.3, -0.39999999999999997], [0.3, 0.39999999999999997]]]] :
	char == "I" ?
	[[[[0.0, 0.39999999999999997], [0.0, -0.39999999999999997]]]] :
	char == "J" ?
	[[[[-0.2249998491257372, -0.3], [-0.024999855831259764, -0.3999999910593029], [-0.024999855831259764, -0.14999999105930292]],
	[[-0.024999855831259764, -0.3999999910593029], [0.22500014416874023, -0.14999999105930292], [-0.024999855831259764, -0.14999999105930292]],
	[[0.22500014416874023, -0.14999999105930292], [0.22500014416873737, 0.40000000000000036]],
	[[0.22500014416873737, 0.40000000000000036], [-0.02499985583126261, 0.4000000000000007]]]] :
	char == "K" ?
	[[[[-0.27499984204769135, 0.40000002086162567], [-0.27499984204769135, -0.3999999910593033]]],
	[[[-0.27499984204769135, -0.0799999862909317], [0.22500016540288925, 0.40000002086162567]]],
	[[[-0.12530235897523312, 0.0637095974586277], [0.2750001661479473, -0.3999999910593033]]]] :
	char == "L" ?
	[[[[-0.25, 0.39999999999999997], [-0.25, -0.39999999999999997]],
	[[-0.25, -0.39999999999999997], [0.25, -0.39999999999999997]]]] :
	char == "M" ?
	[[[[-0.35000000000000003, -0.39999999999999997], [-0.35000000000000003, 0.39999999999999997]],
	[[-0.35000000000000003, 0.39999999999999997], [-0.25, 0.39999999999999997]],
	[[-0.25, 0.39999999999999997], [-9.896862138702999e-08, -0.20000023752450102]],
	[[-9.896862138702999e-08, -0.20000023752450102], [0.2500001880029771, 0.39999999999999997]],
	[[0.2500001880029771, 0.39999999999999997], [0.35000000000000003, 0.39999999999999997]],
	[[0.35000000000000003, 0.39999999999999997], [0.35000000000000003, -0.39999999999999997]]]] :
	char == "N" ?
	[[[[-0.3, -0.39999999999999997], [-0.3, 0.39999999999999997]],
	[[-0.3, 0.39999999999999997], [0.3, -0.39999999999999997]],
	[[0.3, -0.39999999999999997], [0.3, 0.39999999999999997]]]] :
	char == "O" ?
	[[[[0.0, 0.39999999999999997], [-0.35000000000000003, 0.049999999999999996], [0.0, 0.049999999999999996]],
	[[0.35000000000000003, 0.049999999999999996], [0.0, 0.39999999999999997], [0.0, 0.049999999999999996]],
	[[0.35000000000000003, 0.049999999999999996], [0.35000000000000003, -0.049999999999999996]],
	[[0.0, -0.39999999999999997], [0.35000000000000003, -0.049999999999999996], [0.0, -0.049999999999999996]],
	[[-0.35000000000000003, -0.049999999999999996], [0.0, -0.39999999999999997], [0.0, -0.049999999999999996]],
	[[-0.35000000000000003, -0.049999999999999996], [-0.35000000000000003, 0.049999999999999996]]]] :
	char == "P" ?
	[[[[-0.2999916076660156, -0.39999999999999997], [-0.2999916076660156, 0.39999999999999997]],
	[[-0.2999916076660156, 0.39999999999999997], [0.10000839233398437, 0.39999999999999997]],
	[[0.10000839233398437, 0.0], [0.10000839233398437, 0.39999999999999997], [0.10000839233398437, 0.19999999999999998]],
	[[0.10000839233398437, 0.0], [-0.2999916076660156, 0.0]]]] :
	char == "Q" ?
	[[[[0.0, 0.39999999999999997], [-0.35000000000000003, 0.049999999999999996], [0.0, 0.049999999999999996]],
	[[0.35000000000000003, 0.049999999999999996], [0.0, 0.39999999999999997], [0.0, 0.049999999999999996]],
	[[0.35000000000000003, 0.049999999999999996], [0.35000000000000003, -0.049999999999999996]],
	[[0.0, -0.39999999999999997], [0.35000000000000003, -0.049999999999999996], [0.0, -0.049999999999999996]],
	[[-0.35000000000000003, -0.049999999999999996], [0.0, -0.39999999999999997], [0.0, -0.049999999999999996]],
	[[-0.35000000000000003, -0.049999999999999996], [-0.35000000000000003, 0.049999999999999996]]],
	[[[0.12434171307712916, -0.17434147171199915], [0.35000025779008864, -0.3999999910593033]]]] :
	char == "R" ?
	[[[[-0.3, -0.39999999999999997], [-0.3, 0.39999999999999997]],
	[[-0.3, 0.39999999999999997], [0.09999999999999999, 0.39999999999999997]],
	[[0.09944164747950593, 7.793953511026075e-07], [0.09999999999999999, 0.39999999999999997], [0.09999999999999999, 0.19999999999999998]],
	[[0.09944164747950593, 7.793953511026075e-07], [-0.3, -1.3719268322276434e-06]]],
	[[[-0.1666655260607399, -6.538108987541591e-07], [0.3, -0.39999999999999997]]]] :
	char == "S" ?
	[[[[-0.2949489742783129, -0.2999999999999998], [-0.049999999999999996, -0.39999999999999647], [-0.049999999999999996, -0.05000000000000017]],
	[[-0.049999999999999996, -0.39999999999999647], [0.11967795721333233, -0.39999999999999647]],
	[[0.11967795721333233, -0.39999999999999647], [0.17517565869139276, -0.05847635537096796], [0.11967795721333233, -0.22472898056577256]],
	[[0.17517565869139276, -0.05847635537096796], [-0.17514280865403292, 0.058465375324756326]],
	[[-0.11964332278642473, 0.3999999992498031], [-0.17514280865403292, 0.058465375324756326], [-0.11964332278642473, 0.22472334516528622]],
	[[-0.11964332278642473, 0.3999999992498031], [0.049999999999999996, 0.3999999992498031]],
	[[0.2949489742783129, 0.2999999989497292], [0.049999999999999996, 0.3999999992498031], [0.049999999999999996, 0.049999999999999996]]]] :
	char == "T" ?
	[[[[0.3, 0.40000000000000036], [-0.2999999999999801, 0.40000000000000036]]],
	[[[1.9895196601282807e-14, 0.40000000000000036], [0.0, -0.39999999999999997]]]] :
	char == "U" ?
	[[[[-0.3, 0.39888341426849366], [-0.3, -0.0988834351494667]],
	[[-0.3, -0.0988834351494667], [0.0, -0.39888343514946667], [0.0, -0.0988834351494667]],
	[[0.0, -0.39888343514946667], [0.3, -0.0988834351494667], [0.0, -0.0988834351494667]],
	[[0.3, -0.0988834351494667], [0.3, 0.39888341426849366]]]] :
	char == "V" ?
	[[[[-0.3, 0.39999999999999997], [0.0, -0.39999999999999997]],
	[[0.0, -0.39999999999999997], [0.3, 0.39999999999999997]]]] :
	char == "W" ?
	[[[[-0.39999999999999997, 0.39999999999999997], [-0.19999999999999998, -0.39999999999999997]],
	[[-0.19999999999999998, -0.39999999999999997], [0.0, 0.19999999999999998]],
	[[0.0, 0.19999999999999998], [0.19999999999999998, -0.39999999999999997]],
	[[0.19999999999999998, -0.39999999999999997], [0.39999999999999997, 0.39999999999999997]]]] :
	char == "X" ?
	[[[[-0.3, 0.39999999999999997], [0.3, -0.39999999999999997]]],
	[[[0.3, 0.39999999999999997], [-0.3, -0.39999999999999997]]]] :
	char == "Y" ?
	[[[[-0.3, 0.39999999999999997], [0.0, 0.0]],
	[[0.0, 0.0], [0.3, 0.39999999999999997]]],
	[[[0.0, -0.39999999999999997], [0.0, 0.0]]]] :
	char == "Z" ?
	[[[[-0.3, 0.39999999999999997], [0.3, 0.39999999999999997]],
	[[0.3, 0.39999999999999997], [-0.3, -0.39999999999999997]],
	[[-0.3, -0.39999999999999997], [0.3, -0.39999999999999997]]]] :
    char == " " ?
    [] :
    []; //Unsupported char

function getLetterWidth(char) =
	char == "A" ?
	0.7000000000000001 :
	char == "B" ?
	0.5999820709228515 :
	char == "C" ?
	0.5949489593505859 :
	char == "D" ?
	0.6 :
	char == "E" ?
	0.5 :
	char == "F" ?
	0.5 :
	char == "G" ?
	0.65 :
	char == "H" ?
	0.6 :
	char == "I" ?
	0.0 :
	char == "J" ?
	0.44999999999999996 :
	char == "K" ?
	0.5499999999999999 :
	char == "L" ?
	0.5 :
	char == "M" ?
	0.7000000000000001 :
	char == "N" ?
	0.6 :
	char == "O" ?
	0.7000000000000001 :
	char == "P" ?
	0.5999832153320312 :
	char == "Q" ?
	0.7000000000000001 :
	char == "R" ?
	0.6 :
	char == "S" ?
	0.589898681640625 :
	char == "T" ?
	0.6 :
	char == "U" ?
	0.6 :
	char == "V" ?
	0.6 :
	char == "W" ?
	0.7999999999999999 :
	char == "X" ?
	0.6 :
	char == "Y" ?
	0.6 :
	char == "Z" ?
	0.6 :
    char == " " ?
    spaceWidth :
    0; //Unsupported char