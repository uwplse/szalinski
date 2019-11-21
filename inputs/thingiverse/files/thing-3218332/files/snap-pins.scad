// Updated pin connectors
// Modified from https://www.thingiverse.com/thing:213310 by Emmett Lalishe
// Creative Commons - Attribution - Share Alike License
// http://creativecommons.org/licenses/by-sa/3.0/

/* [Global] */
// Add a point to the pin and socket
pointed = 1; // [1:yes, 0:no]
// Put fins on socket to help with printing strength, does not affect pin
fins = 1; // [1:yes, 0:no]
// Pulls the snaps together on the pin to ensure a tight coupling, does not affect socket
preload = 0.2;
// Clearance gap between the pin and the socket opening, does not affect socket
clearance = 0.2;
// Make printable, with pin flat, and sockets set into a cylinder
printable = 1; // [1:yes, 0:no]
// Show shadow of socket over pin
shadow_socket = 1; // [1:yes, 0:no]
// Separation between objects
spacing = 20;
// Thickness of cylinder wall around socket when printable
cylinder_thickness = 2;

// Part to display
part = "all"; // [pin:Pin only, socket_free:Socket with rotation, socket_fixed:Fixed Socket, socket_both:Both Sockets, all:Pin with both sockets]

/* [Preconfigured Sizes] */
// Size of snap pin
size = "standard"; // [tiny:Tiny, small:Small, standard:Standard size, custom:Set sizes in Custom tab]

/* [Custom Size] */
// Depth of socket hole. Pin is twice this length. Does not include point if set
custom_length = 10.8;
// Diameter of socket hole opening. Pin will be smaller if clearance is set
custom_diameter = 7;
// Height of snap nubs
custom_snap = 0.5;
// Depth the snap nubs are into the socket
custom_snap_depth = 1.8;
// Thicker makes the pin stiffer, does not affect socket
custom_thickness = 1.8;

/* [Hidden] */
$fn = 40;

if (size == "standard") {
  echo("Standard size");
  render(
    part = part,
    length = 10.8,
    diameter = 7,
    snap = 0.5,
    snapDepth = 1.8,
    thickness = 1.8,
    pointed = pointed,
    fins = fins,
    preload = preload,
    clearance = clearance,
    printable = printable,
    shadowSocket = shadow_socket,
    spacing = spacing,
    cylinderThickness = cylinder_thickness
  );
} else if (size == "tiny") {
  echo("Tiny size");
  render(
    part = part,
    length = 4,
    diameter = 2.5,
    snap = 0.25,
    snapDepth = 0.9,
    thickness = 0.8,
    pointed = pointed,
    fins = fins,
    preload = preload,
    clearance = clearance,
    printable = printable,
    shadowSocket = shadow_socket,
    spacing = spacing,
    cylinderThickness = cylinder_thickness
  );
} else if (size == "small") {
  echo("Small size");
  render(
    part = part,
    length = 6,
    diameter = 3.2,
    snap = 0.4,
    snapDepth = 1.2,
    thickness = 1.0,
    pointed = pointed,
    fins = fins,
    preload = preload,
    clearance = clearance,
    printable = printable,
    shadowSocket = shadow_socket,
    spacing = spacing,
    cylinderThickness = cylinder_thickness
  );
} else { // custom
  echo("Custom size");
  render(
    part = part,
    length = custom_length,
    diameter = custom_diameter,
    snap = custom_snap,
    snapDepth = custom_snap_depth,
    thickness = custom_thickness,
    pointed = pointed,
    fins = fins,
    preload = preload,
    clearance = clearance,
    printable = printable,
    shadowSocket = shadow_socket,
    spacing = spacing,
    cylinderThickness = cylinder_thickness
  );
}

module render(part, radius, length, snapDepth, snap, thickness, pointed, fins, preload, clearance, printable, shadowSocket, spacing, cylinderThickness) {
  echo("length", length);
  echo("diameter", diameter);
  echo("snap", snap);
  echo("snapDepth", snapDepth);
  echo("thickness", thickness);

  radius = diameter / 2;
  cylinderRadius = radius + snap + cylinderThickness;
  cylinderHeight = length + cylinderThickness;

  if (part == "pin") {
    showPin(radius = radius, length = length, snapDepth = snapDepth, snap = snap, thickness = thickness, clearance = clearance, preload = preload, pointed = pointed, printable = printable, shadowSocket = shadowSocket);
  } else if (part == "socket_free") {
    showSocket(radius = radius, length = length, snapDepth = snapDepth, snap = snap, thickness = thickness, pointed = pointed, fixed = 0, fins = fins, printable = printable, cylinderRadius = cylinderRadius, cylinderHeight = cylinderHeight);
  } else if (part == "socket_fixed") {
    showSocket(radius = radius, length = length, snapDepth = snapDepth, snap = snap, thickness = thickness, pointed = pointed, fixed = 1, fins = fins, printable = printable, cylinderRadius = cylinderRadius, cylinderHeight = cylinderHeight);
  } else if (part == "socket_both") {
    translate([-spacing / 2, 0, 0]) {
      showSocket(radius = radius, length = length, snapDepth = snapDepth, snap = snap, thickness = thickness, pointed = pointed, fixed = 0, fins = fins, printable = printable, cylinderRadius = cylinderRadius, cylinderHeight = cylinderHeight);
    }
    translate([spacing / 2, 0, 0]) {
      showSocket(radius = radius, length = length, snapDepth = snapDepth, snap = snap, thickness = thickness, pointed = pointed, fixed = 1, fins = fins, printable = printable, cylinderRadius = cylinderRadius, cylinderHeight = cylinderHeight);
    }
  } else if (part == "all") {
    translate([0, -spacing * printable, 0]) {
      showPin(radius = radius, length = length, snapDepth = snapDepth, snap = snap, thickness = thickness, clearance = clearance, preload = preload, pointed = pointed, printable = printable, shadowSocket = shadowSocket);
      translate([-spacing, 0, 0]) {
        showSocket(radius = radius, length = length, snapDepth = snapDepth, snap = snap, thickness = thickness, pointed = pointed, fixed = 0, fins = fins, printable = printable, cylinderRadius = cylinderRadius, cylinderHeight = cylinderHeight);
      }
      translate([spacing, 0, 0]) {
        showSocket(radius = radius, length = length, snapDepth = snapDepth, snap = snap, thickness = thickness, pointed = pointed, fixed = 1, fins = fins, printable = printable, cylinderRadius = cylinderRadius, cylinderHeight = cylinderHeight);
      }
    }
    if (printable) {
      translate([0, spacing, 0]) {
        showPin(radius = radius, length = length, snapDepth = snapDepth, snap = snap, thickness = thickness, clearance = clearance, preload = preload, pointed = pointed, printable = printable, shadowSocket = shadowSocket);
        translate([-spacing, 0, 0]) {
          showSocket(radius = radius, length = length, snapDepth = snapDepth, snap = snap, thickness = thickness, pointed = pointed, fixed = 1, fins = fins, printable = printable, cylinderRadius = cylinderRadius, cylinderHeight = cylinderHeight);
        }
        translate([spacing, 0, 0]) {
          showSocket(radius = radius, length = length, snapDepth = snapDepth, snap = snap, thickness = thickness, pointed = pointed, fixed = 1, fins = fins, printable = printable, cylinderRadius = cylinderRadius, cylinderHeight = cylinderHeight);
        }
      }
    }
  }
}

module showPin(radius, length, snapDepth, snap, thickness, clearance, preload, pointed, printable, shadowSocket) {
  pin(r = radius, l = length, d = snapDepth, nub = snap, t = thickness, space = clearance, preload = preload, pointed = pointed, flat = printable);
  if (shadowSocket && !printable) {
    %pinsocket(r = radius, l = length, nub = snap, d = snapDepth, fixed = 0, pointed = pointed, fins = 0);
  }
}

module showSocket(radius, length, snapDepth, snap, thickness, pointed, fixed, fins, printable, cylinderRadius, cylinderHeight) {
  if (printable) {
    cylinderShoulder = cylinderHeight - cylinderRadius * (pointed ? .5 : .75);
    difference() {
      intersection() {
        union() {
          translate([0, 0, cylinderShoulder]) {
            if (pointed) {
              cylinder(r1 = cylinderRadius, r2 = 0, h = cylinderRadius);
            } else {
              sphere(r = cylinderRadius);
            }
          }
          cylinder(r = cylinderRadius, h = cylinderShoulder);
        }
        cylinder(r = cylinderRadius, h = cylinderHeight );
        if (fixed) {
          cube([2 * cylinderRadius, 1.8 * cylinderRadius, 2 * (cylinderHeight + cylinderRadius)], center = true);
        }
      }
      pinsocket(r = radius, l = length, nub = snap, d = snapDepth, fixed = fixed, pointed = pointed, fins = fins);
    }
  } else {
    pinsocket(r = radius, l = length, nub = snap, d = snapDepth, fixed = fixed, pointed = pointed, fins = fins);
  }
}

module nub(r, nub, h) {
  union() {
    l = h / 4;
	translate([0, 0, -nub / 2]) {
      cylinder(r1 = r, r2 = r + nub, h = nub);
    }
	translate([0, 0, (nub + l) / 2]) {
      cylinder(r = r + nub, h = l + 0.02, center = true);
    }
	translate([0, 0, (nub / 2) + l]) {
      cylinder(r1 = r + nub, r2 = r, h = (h - (l + nub / 2)));
    }
  }
}

module slot(l, r, t, d, nub, depth, stretch) {
  rotate([-90, 0, 0]) {
    intersection() {
      translate([t, 0, d + t / 4]) {
        scale([1, 4, 1]) {
          nub(r = r + t, nub = nub, h = l - (d + t / 4));
        }
      }
      translate([-t, 0, d + t / 4]) {
        scale([1, 4, 1]) {
          nub(r = r + t, nub = nub, h = l - (d + t / 4));
        }
      }
    }
  }
  cube([2 * r, 2 * l, depth], center = true);
  translate([0, l, 0]) {
    scale([1, stretch, 1]) {
      cylinder(r = r, h = depth, center = true);
    }
  }
}

module pinhalf(r, l, d, nub, t, space, preload, pointed, flat) {
  // First calculate the dimensions as if the clearance space was 0
  rPointInitial = r / sqrt(2);
  stretchInitial = sqrt(2);
  pinTipRound = stretchInitial * r;
  pinTipPointed = stretchInitial * 2 * rPointInitial;
  pinTip = pointed ? pinTipPointed : pinTipRound; // Length of the pin tip adjusted for the point if necessary

  lStraight = l - (pinTipRound + preload); // Length without tips, include room for the preloading
  lPin = lStraight + pinTip;

  rInner = r - space;
  rPoint = rInner / sqrt(2);

  pinTipRoundUnstretched = rInner;
  pinTipPointedUnstretched = 2 * rPoint;
  pinTipUnstretched = pointed ? pinTipPointedUnstretched : pinTipRoundUnstretched; // Length of the pin tip adjusted for the point if necessary
 
  stretch = pinTip / pinTipUnstretched;
  translate(flat * [0, 0, r / sqrt(2) - space]) {
    rotate((1 - flat) * [90, 0, 0]) {
      difference() {
        rotate([-90, 0, 0]) {
          intersection() {
            difference() {
              union() {
                translate([0, 0, -0.01]) {
                  cylinder(r = rInner, h = lStraight + 0.02);
                }
                translate([0, 0, lStraight]) {
                  scale([1, 1, stretch]) {
                    sphere(r = rInner);
                    if (pointed) {
                      translate([0, 0, rPoint]) {
                        cylinder(r1 = rPoint, r2 = 0, h = rPoint);
                      }
                    }
                  }
                }
                translate([0, 0, d - preload]) {
                  scale([1, 0.9, 1]) {
                    nub(r = rInner, nub = nub + space / 2, h = lStraight - (d - preload));
                  }
                }
              }
            }
            cube([3 * (max(r, r + nub)), r * sqrt(2) - 2 * space, 2 * l + 3 * r], center = true);
          }
        }
        slot(l = lStraight, r = rInner - t, t = t, d = d - preload, nub = nub, depth = 2 * r + 0.02, stretch = stretch);
      }
    }
  }
}

module pinsocket(r, l, d, nub, fixed, pointed, fins) {
  stretch = sqrt(2);

  tipRound = r;
  pinTipRound = stretch * tipRound;

  rPoint = r / sqrt(2);
  tipPointed = 2 * rPoint;
  pinTipPointed = stretch * tipPointed;

  tip = pointed ? tipPointed : tipRound; // Length of the socket tip adjusted for the point if necessary
  pinTip = pointed ? pinTipPointed : pinTipRound; // Length of the pin tip adjusted for the point if necessary

  lPin = l - pinTipRound + pinTip;

  lStraight = lPin - tip; // length to the shoulder

  intersection() {
	union() {
      translate([0, 0, -0.1]) {
        cylinder(r = r, h = lStraight + 0.1);
      }
      translate([0, 0, lStraight]) {
        sphere(r = r);
        if (pointed) {
          translate([0, 0, rPoint]) {
            cylinder(r1 = rPoint, r2 = 0, h = rPoint);
          }
        }
      }
      translate([0, 0, d]) {
        nub(r = r, nub = nub, h = lStraight - d);
      }
      if (fins) {
        translate([0, 0, lStraight]) {
          cube([2 * r, 0.01, 2 * tip], center = true);
          cube([0.01, 2 * r, 2 * tip], center = true);
        }
      }
	}
	if (fixed) {
      cube([3 * (max(r, r + nub)), r * sqrt(2), 3 * lPin + 3 * r], center = true);
    }
  }
}

module pin(r, l, d, nub, t, space, preload, pointed, flat) {
  union() {
	pinhalf(r = r, l = l, d = d, nub = nub, t = t, space = space, preload = preload, pointed = pointed, flat = flat);
	mirror([0, flat ? 1 : 0, flat ? 0 : 1]) {
      pinhalf(r = r, l = l, d = d, nub = nub, t = t, space = space, preload = preload, pointed = pointed, flat = flat);
    }
  }
}
