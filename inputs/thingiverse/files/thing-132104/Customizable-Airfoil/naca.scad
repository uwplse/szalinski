// Parametric NACA 00xx airfoil.
// See http://en.wikipedia.org/wiki/NACA_airfoil

// preview[view:south, tilt:top diagonal]

WINGS = 2; // [2:Dual Wings, 1:Single Wing]

// Wing chord (leading edge to trailing edge)
CHORD = 50;

// Wing length (root to tip)
LENGTH = 150;

// Max wing thickness (as percentage of chord length)
t = 15;

// Scale proportion of wing tip vs. wing root
TAPER = 0.5;

// Sweep back angle of wing
SWEEP_ANGLE = 20;

/* [Hidden] */
E = 0.01;

function y(x) = t / 20.0 *
         (.2969 * sqrt(x)
          -0.1260 * x
          -0.3516 * pow(x, 2)
          +0.2843 * pow(x, 3)
          -0.1015 * pow(x, 4));

// Argh!  No for loop initializer in open scad!
a = [[0.0, y(0.0)],
     [0.005, y(0.005)],
     [0.01, y(0.01)],
     [0.02, y(0.02)], [0.04, y(0.04)], [0.06, y(0.06)], [0.08, y(0.08)],
     [0.1, y(0.1)],
     [0.2, y(0.2)],
     [0.3, y(0.3)],
     [0.4, y(0.4)],
     [0.5, y(0.5)],
     [0.6, y(0.6)],
     [0.7, y(0.7)],
     [0.8, y(0.8)],
     [0.9, y(0.9)],
     [1.0, 0.0],
     [0.9, -y(0.9)],
     [0.8, -y(0.8)],
     [0.7, -y(0.7)],
     [0.6, -y(0.6)],
     [0.5, -y(0.5)],
     [0.4, -y(0.4)],
     [0.3, -y(0.3)],
     [0.2, -y(0.2)],
     [0.1, -y(0.1)],
     [0.08, -y(0.08)], [0.06, -y(0.06)], [0.04, -y(0.04)], [0.02, -y(0.02)],
     [0.01, -y(0.01)],
     [0.005, -y(0.005)],
     [0.0, -y(0.0)]
     ];

module naca_2d(chord) {
  scale([chord, chord, 1])
    polygon(points=a);
}

module naca_25d(chord) {
  linear_extrude(height=E) naca_2d(chord);
}

module reflect_z() {
  multmatrix(m=[[1, 0, 0, 0],
                [0, 1, 0, 0],
                [0, 0, -1, 0],
                [0, 0, 0, 1]])
    child(0);
}

module naca(chord, length, taper=1, sweep_ang=0) {
  sweep = sin(sweep_ang);
  multmatrix(m=[ [1, 0, sweep, 0],
                 [0, 1, 0, 0],
                 [0, 0, 1, 0],
                 [0, 0, 0, 1]
               ])
   hull() {
     naca_25d(chord);
     translate([0, 0, length - E])
       scale([taper, taper, 1])
         naca_25d(chord);
  }
}

naca(CHORD, LENGTH, taper=TAPER, sweep_ang=SWEEP_ANGLE);
if (WINGS == 2) {
  reflect_z()
    naca(CHORD, LENGTH, taper=TAPER, sweep_ang=SWEEP_ANGLE);
}
