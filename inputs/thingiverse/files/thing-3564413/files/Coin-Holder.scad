/*********************************************************************
 *                                                                   *
 *                     Parameterised Coin Holder                     *
 *                     =========================                     *
 *                                                                   *
 * Author: Steve Morgan                                              *
 * Project Source: https://github.com/smorgo/3DDesigns               *
 *                                                                   *
 * License: Creative Commons - Attribution - Non Commercial          *
 *                                                                   *
 * 3D printable design for a coin holder.                            *
 *                                                                   *
 * This design is initially configured to hold a full set of UK      *
 * coins from 1p to £2. You can also print versions for other        *
 * coins, simply by specifying the currency. Or you can change the   *
 * set of coins to suit your own needs.                              *
 *                                                                   *
 * The design cleverly calculates the correct overall diameter for   *
 * the coin holder, based on the coins that it's configured to hold. *
 * Much of the calculation must be credited to my daughter, Alice    *
 * Morgan who, by applying her A-Level maths skills, gave me a       *
 * solution that was evading me.                                     *
 *                                                                   *
 *********************************************************************/
 
$fn=60; // Reasonably high quality

/* Quick note: I've not tested the US, EU or CA currencies, but took the 
 * dimensions from Wikipedia. If they're wrong, please let me know
 * so that I can fix any errors in a future version. */
 
currency = "JP"; // "UK", "US", "EU", "CA", "JP"
overall_height = 50; // Height in mm.

// The following tables define the dimensions of UK coins

// UK, US, EU and CA coins are included, buy you can readily modify the
// list if your using a different currency (maybe let me know what you 
// used so I can include it in a later version).

// You can change existing entries, adding new ones or remove unneeded ones
// (note: if you add or remove, make sure that each coin, except the last 
// one, has a comma "," after it. If you know OpenSCAD, you'll know this, anyway.

// Each coin entry is made up of three values, text, diameter and thickness
// e.g.
// ["1",20.3,1.65] defines a UK 1 penny piece
// where: "1" is the text printed on the base
//        20.3 is the diameter of the coin in mm
//        1.65 is the thickness of the coin in mm

// Note: the design doesn't use the thickness, at the moment. Maybe a later version will.

coins = (currency == "UK") ? [
    ["1",20.3,1.65],
    ["2",25.9,2.03],
    ["5",18,1.89],
    ["10",24.5,2.05],
    ["20",21.4,1.7],
    ["50",27.3,1.78],
    ["£1",23.43,2.8],
    ["£2",28.4,2.5]
    ] :
    (currency == "US") ? [
    ["1",19.05,1.55],
    ["5",21.209,1.95],
    ["10",17.907,1.35],
    ["25",24.257,1.75],
    ["50",30.607,2.15],
    ["$1",26.5,2]
    ] :
    (currency == "EU") ? [
    ["1",16.25,1.67],
    ["2",18.75,1.67],
    ["5",21.25,1.67],
    ["10",19.75,1.93],
    ["20",22.25,2.14],
    ["50",24.25,2.38],
    ["€1",23.25,2.33],
    ["€2",25.75,2.2]
    ] :
    (currency == "CA") ? [
    ["5",21.2,1.76],
    ["10",18.03,1.22],
    ["25",23.88,1.58],
    ["50",27.13,1.95],
    ["$1",26.5,1.75],
    ["$2",28,1.8]
    ] :
    (currency == "JP") ? [
    ["1",20,1.5],
    ["5",22,1.5],
    ["10",23.5,1.5],
    ["50",21,1.7],
    ["100",22.6,1.7],
    ["500",26.5,2]
    ] : [];

clearance = 0.4; // How much space around each coin
coin_spacing = 0.8; // Spacing between coin slots
trim_radius = 3; // We trim off a little from the outside to allow room for a finger
base_thickness = 2; // Thickness of the base in mm
text_size = 10; // Change this if the text, embossed in each tube, is too big or too small

pillars = len(coins);

module main() {
    r = find_r(); // Recursively find the correct sized circle to contain all the coins
    echo("r = ", r);
    
    coin_holder(r);
}

module coin_holder(r) {
    intersection() {
        body(r);
        chamfer_cylinder(r = r-trim_radius, h = overall_height, center=true, chamfer=2);
    }
}

module body(r) {
    
    e = pillars -1;
    all_d = [ for(i = [0:1:e]) coins[i][1] ];
    max_d = max(all_d);

    difference() {
        cylinder(r = r, h = overall_height, center=true);
        translate([0,0,base_thickness]) cylinder(r = r-max_d / 1.8, h = overall_height, center=true);
        translate([0,0,base_thickness]) {
            for(n = [0:1:e]) {
                rn = (coins[n][1])/2;
                m = (n-1) < 0 ? e : (n-1);
                tth = total_theta(r,m);
                echo("tth = ",tth);
                rotate([0,0,tth]) {
                    translate([r-rn,0,0]) {
                        translate([0,0,-overall_height/2]) {
                            rotate([0,0,90]) {
                                linear_extrude(height = base_thickness, center=true) {
                                    text(coins[n][0], valign="center", halign="center", size=text_size);
                                }
                            }
                        }
                        cylinder(r = rn+coin_spacing * 2,h=overall_height,center=true);
                    }
                }
            }
        }
    }
    
    translate([0,0,0]) {
        for(n = [0:1:e]) {
            rn = (coins[n][1])/2;
            m = (n-1) < 0 ? e : (n-1);
            tth = total_theta(r,m);
            echo("tth = ",tth);
            rotate([0,0,tth]) {
                translate([r-rn,0,0]) {
                    difference() {
                        cylinder(r = rn+coin_spacing * 2,h=overall_height,center=true);
                        translate([0,0,0.1]) {
                            cylinder(r = rn+clearance,h=overall_height+0.2,center=true);
                        }
                    }
                }
            }
        }
    }    
}

module chamfer_cylinder(r,h,center=false,chamfer=2) {
    hull() {
        translate([0,0,-chamfer/2]) cylinder(r = r, h = h - chamfer, center = center);
        translate([0,0,chamfer/2]) {
            cylinder(r = r-chamfer, h = h-chamfer, center=center);
        }
    }
}

function find_r(r = 10,rl = 0,rh = 200) = 
    let(t = total_theta(r,pillars-1))
    (t != t || (t > 360.001)) ? find_r((r+rh)/2,r,rh) : ((t < 359.999) ? find_r((r+rl)/2,rl,r) : r);
    
function sum(v, i = 0, r = 0) = i < len(v) ? sum(v, i + 1, r + v[i]) : r;

function total_theta(r,n) = 
    sum( [ for(i=[0:n]) coin_theta(r,i, (i+1) == pillars ? 0 : (i+1)) ]);
        
function coin_theta(r,n,m) =
    theta(r, (coins[n][1])/2 + coin_spacing, (coins[m][1])/2 + coin_spacing);

function theta(r,rn,rm) =
    acos(((r-rn)*(r-rn)+(r-rm)*(r-rm)-(rn+rm)*(rn+rm))/(2 * (r-rn) * (r-rm)));

main();
