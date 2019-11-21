part = "il"; // ["us":United States (common),"us_all":United States (all),"eu",Euro, "il":Israel]

// Size of the gaps in coin tubes, in degrees.
gap = 30; // [0:180]

// Diameter of the coin tube wall.
d_wall = 2;

// The height of the base.
h_base = 4;
// Indent the base of the tubes so that trays are stackable
h_indent = 0;
// The height of the coin tube
h = 60; // [1:300]

// Tolerance added to the inner diameter of the coin tubes
tolerance = 0.5;

/* [Hidden] */

tol = tolerance;

r_us_coin = [(24.26 + tol) / 2,  // Quarter
             (21.21 + tol) / 2,  // Nickel
             (19.05 + tol) / 2,  // Penny
             (17.91 + tol) / 2]; // Dime

r_us_all_coin = [(30.61 + tol) / 2,  // Half dollar
                 (26.49 + tol) / 2,  // Dollar
                 r_us_coin[0],
                 r_us_coin[1],
                 r_us_coin[2],
                 r_us_coin[3]];

r_eu_coin = [(25.75 + tol) / 2,  // 2
             (24.25 + tol) / 2,  // .50
             (23.25 + tol) / 2,  // 1
             (22.25 + tol) / 2,  // .20
             (21.25 + tol) / 2,  // .05
             (19.75 + tol) / 2,  // .10
             (18.75 + tol) / 2,  // .02
             (16.25 + tol) / 2]; // .01

r_il_coin = [(26.0 + tol) / 2,  // 0.5
             (24.0 + tol) / 2,  // 5
             (23.0 + tol) / 2,  // 10
             (22.0 + tol) / 2,  // .10
             (21.6 + tol) / 2,  // 2
             (18.0 + tol) / 2]; // 1
             

r_coin = (part == "us"     ? r_us_coin :
          part == "us_all" ? r_us_all_coin :
          part == "il"	   ? r_il_coin
                           : r_eu_coin);

function uvec(theta) = [cos(theta), sin(theta)];

// Locals... locals would be so nice...
function tan_pt(c1, r1, c2, r2) =
    tan_pt_(c1, r1, c2, r2,
            h=norm(c2 - c1), dc=c2 - c1);

function tan_pt_(c1, r1, c2, r2, h, dc) =
    tan_pt__(c1, r1, c2, r2, h,
            theta_0=acos((r1 - r2) / h),
            theta_1=atan(dc[1] / dc[0]));

function tan_pt__(c1, r1, c2, r2, h, theta_0, theta_1) =
    c1 + r1 * uvec(theta_0 + theta_1);

function coin_offset(n) = r_coin[n] + (n == 0 ? 0
                                              : d_wall +
                                                r_coin[n - 1] +
                                                coin_offset(n - 1));

module thing() {
    o = [0, 0];
    fudge = 400;

    linear_extrude(height=h + 1)
        polygon([o,
                 o + fudge * uvec(0 - gap + $fudge_gap),
                 o + fudge * uvec(0 + gap - $fudge_gap)]);
}

$fudge_d = 0;
$fudge_gap = 0;

module coins(n) {
    translate([0, r_coin[n], 0]) {
        difference() {
            cylinder(r=r_coin[n] + d_wall, h=h, $fn=128);

            translate([0, 0, -0.1])
            cylinder(r=r_coin[n] - $fudge_d, h=h + 0.2, $fn=128);

            translate([0, 0, -0.1])
                union() {
                    thing();
                    mirror()
                        thing();
                }
        }

        if (n + 1 < len(r_coin)) {
            translate([0, r_coin[n] + d_wall, 0])
                coins(n + 1);
        }
    }
}

module coin_base(n) {
    translate([0, coin_offset(n), 0])
        cylinder(r=r_coin[n] + d_wall,
                 h=h_base, $fn=128);
}

ncoin = len(r_coin) - 1;

c1 = [0, coin_offset(0)];
c2 = [0, coin_offset(ncoin)];
v1 = tan_pt(c1=c1,
            c2=c2,
            r1=r_coin[0] + d_wall,
            r2=r_coin[ncoin] + d_wall);
v2 = tan_pt(c1=c2,
            c2=c1,
            r1=r_coin[ncoin] + d_wall,
            r2=r_coin[0] + d_wall);

difference() {
    union() {
        translate([0, 0, h_base])
            coins(0);

        coin_base(0);
        coin_base(len(r_coin) - 1);

        linear_extrude(height=h_base)
            polygon([v1, [-1 * v2[0], v2[1]],
                     v2, [-1 * v1[0], v1[1]]]);
    }

    if (h_indent) {
        assign($fudge_d=0.5, $fudge_gap=2) {
            translate([0, 0, -h + h_indent])
                coins(0);
        }
    }
}

// vim:se sts=4 sw=4 et:

