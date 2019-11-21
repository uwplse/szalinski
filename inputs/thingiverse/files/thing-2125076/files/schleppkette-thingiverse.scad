$fa = 1; // min angle
$fn = 360; // number of fragments (circle)

e = 0.01; // "epsilon"
tol = 0.2;      // tolerance 
tol180 = 0.05;  // tolerance for 180° angle

function sum(array, idx = 0) = idx >= len(array) - 1 ? array[idx] : sum(array, idx + 1) + array[idx];
function subArray(arr, range) = [for (i = range) arr[i]];

// a angle
// d diameter
// r radius
module pie (a, d, r) {
    function getR (d, r) = d ? d/2 : r;
    
    r = getR(d, r);

    // a angle
    module halfSquare(a = 0) {
        rotate(a) translate([0, -r, 0]) scale([0.5, 1, 1]) square(r*2);
    }
    
    if (a % 360 <= 180) {
        mirror([1, 0, 0]) mirror([0, 1, 0])
            difference () {
                circle(r);
                halfSquare();
                halfSquare(180-a);
            }
    } else {
        mirror([1, 0, 0])
        rotate(-(180-a))
        difference() {
            circle(r);
            mirror([1, 0, 0]) mirror([0, 1, 0])
                difference () {
                    circle(r+1);
                    halfSquare();
                    halfSquare(180-a);
                }
        }
    }
}

function chainBottomMaxLengthInXDirection(height, wallsize) = (height / 2) - sqrt((height - wallsize) * wallsize);

function radiusFromChainLinkDistanceAndLinkToLinkAngle(linkDistance, linkToLinkAngle) = linkDistance / (2 * sin(linkToLinkAngle / 2));

module wall (h, l, wallsize, right) {
    difference () {
        union () { 
            // mittelstück wand
            translate([h/2, 0, 0]) cube([l - h, wallsize, h]);
            // rundung mit loch
            translate([l - h/2, wallsize, h/2]) rotate([90, 0, 0])  cylinder(wallsize, r = h/2, true); 
            // nach innen versetzte rundung mit clip
            translate([h/2, (right) ? 0 : wallsize * 2, h/2]) rotate([90, 0, 0])  cylinder(wallsize, r = h/2, true); 
            // zwischenstück
            translate([h/2, (right) ? -wallsize : wallsize, 0]) cube([wallsize, wallsize, h]); 
            // nach innen versetzte rundung innen
            translate([h/2 + wallsize, (right) ? 0 : wallsize * 2, h/2]) rotate([90, 0, 0])  cylinder(wallsize, r = h/2, true); 
        }
        // wird in chainLink noch einmal durchgeführt, daher zur Zeit überflüssig
        //translate([h/2, (right) ? wallsize + 1 : wallsize + tol, h/2]) rotate([90, 0, 0])  cylinder(wallsize+1+tol, r = h/2 + tol, true);
    }
}

module capClip(capLen, capXStart, capClipHeight) {
    rotate([0, 90, 0]) linear_extrude(capLen) polygon([[0,0], [capClipHeight, 0], [capClipHeight, 1], [capClipHeight-1.5, 1.5], [capClipHeight-1.5, 1], [0, 1]]);
}

module capClipGuide(capXStart, wss, oh, capClipHeight, capGuideWidth, capLen) {   
    difference () {
        cube([capLen, capGuideWidth, capClipHeight]);
        translate([0, 0, capClipHeight]) rotate(45, [0, 1, 0]) translate([0, -0.5 * capGuideWidth, -capClipHeight]) cube([capClipHeight * 2, capGuideWidth * 2, capClipHeight]);
    }    
}

// cables - from left to right, bottom to top, distanc between walls, biggest vertical value is vertical value for column
module chainLink (l = 65, ow = 40, oh = 30, angle = 30, clipdiam = 8, cables) {
    wsb = 2; // wall size bottom
    wst = 1.5; // wall size top
    wss = 2; // wall size sides
    //clipdiam = 8;
    capClipHeight = wst + 3;
    x = chainBottomMaxLengthInXDirection(oh, capClipHeight);
    capXStart = oh/2 + wss/2 + (oh/2 - x); // abstand 0 bis beginn der kappe
    capXEnd = oh/2 + wss/2 + (oh/2 - x); // abstand ende kappe bis ende kettenglied
    capLen = l - capXStart - capXEnd; // länge der kappe
    capGuideWidth = 1.5;
    x2 = chainBottomMaxLengthInXDirection(oh, wsb);
    minHeight = 1;
    x3 = chainBottomMaxLengthInXDirection(oh, minHeight);
    exportCapZOffset = 20;
    exportInsertXOffset = 40;
    
    function arrayPush(array, elem) = [for (i = [0:len(array)]) i == len(array) ? elem : array[i]];
    
    // for insert
    insertBorder = 1.5;
    wsi = 2;
    verticalWallsMaxY = [for(i=[0:len(cables)-1]) max(cables[i])];

    difference() {
        union() {
            // kettenkörper
            difference() {
                union () {
                    difference () {
                        union () {
                            // vorn / links
                            wall(oh, l, wss, false); 
                            // hinten / rechts
                            translate([0, ow-wss, 0]) wall(oh, l, wss, true); 
                            // boden
                            translate([oh/2, 0, 0]) cube([l - (oh * 1.5 - (x2 - tol)), ow, wsb]); 
                            translate([x2, wss + tol, 0]) cube([oh/2 - x2, ow - 2 * wss - 2 * tol, wsb]);
                            // winkelanschlag vorn / links
                            translate([l - oh, wss, 0]) cube([clipdiam/2 - tol, wss, oh/2]);
                            // winkelanschlag hinten / rechts
                            translate([l - oh, ow - 2 * wss, 0]) cube([clipdiam/2 - tol, wss, oh/2]);
                            // winkelanschlat 180° vorn / links
                            translate([l - oh + clipdiam/2 - tol180, wss, 0]) cube([oh/2 - clipdiam/2 - (oh/2 - x2), wss, clipdiam/2]);
                            // winkelanschlag 180° hinten / rechts
                            translate([l - oh + clipdiam/2 - tol180, ow - 2 * wss, 0]) cube([oh/2 - clipdiam/2 - (oh/2 - x2), wss, clipdiam/2]);
                        }
                        
                        // loch in rundung
                        translate([l - oh/2, -1, oh/2]) rotate([-90]) cylinder(ow+2, d = clipdiam + tol * 2, true);
                        // freischnitt am ende mit clip für das gegenstück
                        // vorn / links    
                        translate([oh/2, 0, oh/2])
                        rotate([0, angle, 0])
                        translate([-oh/2, 0, -oh/2])
                        union () {
                            translate([oh/2, wss + tol, oh/2]) rotate([90, 0, 0]) cylinder(wss+e+tol, r = oh/2 + tol, true);
                            translate([-tol, -e, -tol]) cube([oh/2 + 2 * tol, wss + tol + e, oh + 2 * tol]);
                        }
                        // hinten / rechts
                        translate([oh/2, 0, oh/2])
                        rotate([0, angle, 0])
                        translate([-oh/2, 0, -oh/2])
                        union () {
                            translate([oh/2, ow + e, oh/2]) rotate([90, 0, 0]) cylinder(wss+e+tol, r = oh/2 + tol, true);
                            translate([-tol, ow - wss - tol, -tol]) cube([oh/2 + 2 * tol, wss + tol + e, oh + 2 * tol]);
                        }
                        
                        // ausschnitte für deckel clip
                        union () {
                            // brücke
                            translate([capXStart - tol, -e, oh - wst - tol]) cube([capLen + 2 * e + 2 * tol, ow + 2 * e, wst + tol + e]);
                            // clip vorn / links
                            translate([capXStart - tol, -e, oh]) capClip(capLen + 2 * tol, capXStart, capClipHeight); 
                            // clip hinten / rechts
                            translate([capXStart - tol, ow + e, oh]) mirror([0, 1, 0]) capClip(capLen + 2 * tol, capXStart, capClipHeight);
                        }
                        
                        // begrenzung der abrundung vorn mittig unten
                        translate([x2, 2 * wss, 0]) cube([wsb/2, ow - 4 * wss, wss + e]);
                        // begrenzung der abrundung vorn vorn / links unten
                        translate([oh/2 + tol, -e, -e]) cube([(oh/2 - x3) + tol, wss + tol + e, minHeight + e]);
                        // begrenzung der abrundung vorn hinten / rechts unten
                        translate([oh/2 + tol, ow - wss - tol, -e]) cube([(oh/2 - x3) + tol, wss + tol + e, minHeight + e]);
                        
                        // begrenzung der abrundung vorn vorn / link oben
                        // steigung: -tan(angle)
                        // verschiebung: (x = oh/2 + cos(90-a) * (oh/2 + tol)) * -tan(a) + b == oh/2 + sin(90-a) * (oh/2 + tol)
                        // ==>                                                             b == (oh/2 + sin(90-a) * (oh/2 + tol))/((oh/2 + cos(90-a) * (oh/2 + tol)) * -tan(a))
                        // wa ==> b = 1/2 (h tan((π a)/180) + h sec((π a)/180) + 2 t sec((π a)/180) + h)
                        // ==> f(x) = x * -tan(a) + 1/2 (h tan(a) + h sec(a) + 2 t sec(a) + h)
                        // schnitt: x * -tan(a) + 1/2 (h tan(a) + h sec(a) + 2 t sec(a) + h) == h - m
                        // x = 1/2 (-cot(a) (h - 2 m) + csc(a) (h + 2 t) + h)
                        // x = 1/2 (-(1/tan(a)) * (h - 2 * m) + (1/sin(a)) * (h + 2 * t) + h)
                        // schnitt mit gerade
                        x4 = 1/2 * (-(1/tan(angle)) * (oh - 2 * minHeight) + (1/sin(angle)) * (oh + 2 * tol) + oh);
                        // schnitt mit kreis r = oh/2 + tol
                        x5 = oh/2 + sqrt(minHeight * (oh + 2 * tol - minHeight));
                        x6 = oh/2 + cos(90-angle) * (oh/2 + tol);
                        x7 = x6 > x5 ? x4 : x5;
                        translate([oh/2, -e, oh - minHeight]) cube([x7 - oh/2, wss + tol + e, minHeight + e]);
                        // begrenzung der abrundung vorn hinten / rechts oben
                        translate([oh/2, ow - wss - tol, oh - minHeight]) cube([x7 - oh/2, wss + tol + e, minHeight + e]);
                    }
                    
                    difference () {
                        // clips auf rundung
                        translate([oh/2, 0, oh/2]) rotate([-90]) cylinder(ow, d = clipdiam, true); 
                        // freiraum zwischen den clips in der kette
                        translate([oh/2, 1.5 * wss, oh/2]) rotate([-90]) cylinder(ow - 4 * wss + wss, d = clipdiam + tol * 2 + 1, true);
                        // abschrägung der clips
                        // vorn / links
                        translate([oh/2, 0, oh/2]) rotate([0, -0, 0]) translate([-oh/2, 0, -oh/2]) translate([oh/2 - clipdiam / 2, 0, 0]) linear_extrude(oh) polygon([[-tol - e,-e], [clipdiam / 2, -e], [-tol - e, wss]]);
                        // hinten / rechts
                        translate([0, ow, 0]) mirror([0,1,0]) translate([oh/2 - clipdiam / 2, 0, 0]) linear_extrude(oh) polygon([[-tol - 0.1,-0.1], [clipdiam / 2, -0.1], [-tol - 0.1, wss]]);             
                    }            
                }
                
                // winkelanschlag vorn / links
                difference () {
                    translate([oh/2, 2 * wss + e, oh/2]) rotate([90, 180]) linear_extrude(2 * wss) pie(angle+90, d=oh + 2*e);
                    translate([oh/2, 2 * wss, oh/2]) rotate([90, 180]) linear_extrude(2 * wss + 2*e) pie(angle+90, d=oh - clipdiam);
                    translate([x2,  wss + tol, 0]) cube([oh/2 - x2, wss - tol, oh/2]);
                }
                // winkelanschlag hinten / rechts
                difference () {
                    translate([oh/2, ow-e, oh/2]) rotate([90, 180]) linear_extrude(2 * wss) pie(angle+90, d=oh + 2*e);
                    translate([oh/2, ow-e, oh/2]) rotate([90, 180]) linear_extrude(2 * wss + 2*e) pie(angle+90, d=oh - clipdiam);
                    translate([x2, ow - 2 * wss, 0]) cube([oh/2 - x2, wss - tol, oh/2]);
                }
                
                // abrundung vorn
                difference () {
                    translate([-tol, wss * 2, -tol]) cube([oh / 2 + tol, ow - wss * 4, oh / 2 + tol]);
                    translate([0, wss * 2, oh/2]) rotate([-90, 0 , 0]) translate([oh/2, 0, -e]) cylinder(ow + 2*e - wss * 4, d = oh);
                }
            }
            
            // deckel
            translate([0,0,exportCapZOffset]) color("seagreen") union () {
                // brücke
                translate([capXStart, 0, oh - wst]) cube([capLen, ow, wst]);
                // clip vorn / links
                translate([capXStart, 0, oh]) capClip(capLen, capXStart, capClipHeight - tol);
                // clip hinten / rechts
                translate([capXStart, ow, oh]) mirror([0, 1, 0]) capClip(capLen, capXStart, capClipHeight - tol);
                // deckelführung vorn / links
                translate([capXStart, wss, oh - capClipHeight]) capClipGuide(capXStart, wss, oh, capClipHeight, capGuideWidth, capLen);
                // deckelführung hinten / rechts
                translate([capXStart, ow - wss - capGuideWidth, oh - capClipHeight]) capClipGuide(capXStart, wss, oh, capClipHeight, capGuideWidth, capLen);
            }
        } // union kettenglied + deckel
         
        // ausschnitte für inserts
        if (cables != "special") {
          for (y = [0:len(cables)-2]) {       
                translate([capXStart, 2 * wss + sum(subArray(verticalWallsMaxY, [0:y])) + wsi * y, 0]) 
                    translate([insertBorder, 0, -e]) cube([capLen - 2 * insertBorder, wsi, oh + exportCapZOffset + 2*e]);  
            }
        } else if (cables == "special") { // auschnitte für inserts für mittlere kette
            translate([capXStart, 2 * wss + 7, 10.8 + wsi + wsb]) 
                translate([insertBorder, 0, -e]) cube([capLen - 2 * insertBorder, wsi, oh + exportCapZOffset + 2*e - (10.8 + wsb + wsi)]);
            translate([capXStart, 2 * wss + 7 + wsi + 6.7, 10.8 + wsi + wsb]) 
                translate([insertBorder, 0, -e]) cube([capLen - 2 * insertBorder, wsi, oh + exportCapZOffset + 2*e - (10.8 + wsb + wsi)]);
            translate([capXStart, 2 * wss + 12, 0]) 
                translate([insertBorder, 0, -e]) cube([capLen - 2 * insertBorder, wsi, oh + exportCapZOffset + 2*e - (7.2 + wst + wsi)]);
        }
    }      
    
    // inserts
    if (cables != "special") {
        translate([exportInsertXOffset, 0, 0]) color("deepskyblue") union() {
            for (y = [0:len(cables)-1]) {
                if (y <= len(cables)-2) {
                    translate([capXStart, 2 * wss + sum(subArray(verticalWallsMaxY, [0:y])) + wsi * y, 0]) 
                        union () {
                            translate([insertBorder + tol, 0, wsb]) cube([capLen - insertBorder - tol, wsi, oh - wsb - wst]); 
                            translate([insertBorder + tol, tol, 0]) cube([capLen - 2 * insertBorder - 2*tol, wsi - 2*tol, oh]);                     
                        }
                }
                for (x = [0:len(cables[y])-2]) {
                   translate([capXStart + insertBorder + tol, ((y == 0) ? tol : 0) + 2 * wss + (y > 0 ? sum(subArray(verticalWallsMaxY, [0:y-1])) : 0) + wsi * y, wsb + sum(subArray(cables[y], [0:x])) + wsi * x]) cube([capLen - insertBorder - tol, (y == len(cables)-1 ? ow - tol - 4 * wss - sum(subArray(verticalWallsMaxY, [0:y-1])) - y * wsi : verticalWallsMaxY[y]), wsi]);
                }
            }
        }
    } else if (cables == "special") {
        color("deepskyblue") union() {
            translate([capXStart, 2 * wss + 12, 0]) union () {
                translate([insertBorder + tol, 0, wsb]) cube([capLen - insertBorder - tol, wsi, 10.8]);
                translate([insertBorder + tol, tol, 0]) cube([capLen - 2 * insertBorder - 2 * tol, wsi - 2 * tol, wsb + 10.8]);
            }        
            translate([capXStart, 2 * wss + 7, wsb + 10.8 + wsi]) union () {
                translate([insertBorder + tol, tol, 0]) cube([capLen - 2 * insertBorder - 2 * tol, wsi - 2 * tol, 7.2 + wst]);
                translate([insertBorder + tol, 0, 0]) cube([capLen - insertBorder - tol, wsi, 7.2]);
            }        
            translate([capXStart, 2 * wss + 7 + wsi + 6.7, wsb + 10.8 + wsi]) union () {
                translate([insertBorder + tol, tol, 0]) cube([capLen - 2 * insertBorder - 2 * tol, wsi - 2 * tol, 7.2 + wst]);
                translate([insertBorder + tol, 0, 0]) cube([capLen - insertBorder - tol, wsi, 7.2]);
            } 
            translate([capXStart + insertBorder + tol, 2 * wss + tol, wsb + 10.8]) cube([capLen - insertBorder - tol, ow - 4 * wss - 2 * tol, wsi]);
        }
    }
}

length = 38.5;
outerWidth = 28;
outerHeight = 16;
angle = 20;
clipdiam = 5;
cables = [10.8, 7.15];

bendRadius = 100;

linkToLinkLength = length - outerHeight;
resBendRadius = radiusFromChainLinkDistanceAndLinkToLinkAngle(linkToLinkLength, angle);
a = (2 * resBendRadius - sqrt(4 * pow(resBendRadius, 2) - pow(linkToLinkLength, 2)))/2;

links = ceil(180 / angle);

singleLink = false;

difference () {
    union () {
        if (singleLink) {
            chainLink(length, outerWidth, outerHeight, angle, clipdiam);
            translate([length + 10, 0, 0]) chainLink(length, outerWidth, outerHeight, angle, clipdiam, cables);
        } else {
            
            // color([0.8, 0.8, 0.8, 0.5]) translate([length/2, 0, resBendRadius + outerHeight/2 - a]) rotate([90, 0, 0]) linear_extrude(0.1) circle(r = resBendRadius);
                    
            for (i = [0:links]) {
                translate([length/2, 0, resBendRadius + outerHeight/2 - a]) rotate([0, -i * angle, 0]) translate([-length/2, 0, -(resBendRadius + outerHeight/2 - a)]) chainLink(length, outerWidth, outerHeight, angle, clipdiam);
            }
        }
    }
    //translate([-e, -e, -5]) cube([200, outerWidth / 2, 100]);
}

echo ("resulting chain bend radius: ", resBendRadius, "mm");
echo ("resulting max chain height: ", (resBendRadius - a) * 2 + outerHeight, "mm");