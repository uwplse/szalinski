// Facets
$fn=50;  // [10:100]

// Left Side Number
l = 0; // [0:6]
// Right Side Number
r = 0; // [0:6]

pickr(l,r);

module pickr(l,r) {
    if ( l == 0 && r == 0) {
        blankblank();
    }
    else if ( l == 0 && r == 1) {
        oneblank();
    }
    else if ( l == 1 && r == 0) {
        oneblank();
    }
    else if ( l == 1 && r == 1) {
        oneone();
    }
    else if ( l == 2 && r == 1) {
        twoone();
    }
    else if ( l == 1 && r == 2) {
        onetwo();
    }
    else if ( l == 3 && r == 1) {
        threeone();
    }
    else if ( l == 1 && r == 3) {
        onethree();
    }
    else if ( l == 4 && r == 1) {
        fourone();
    }
    else if ( l == 1 && r == 4) {
        onefour();
    }
    else if ( l == 5 && r == 1) {
        fiveone();
    }
    else if ( l == 1 && r == 5) {
        onefive();
    }
    else if ( l == 6 && r == 1) {
        sixone();
    }
    else if ( l == 1 && r == 6) {
        onesix();
    }
    else if ( l == 0 && r == 2) {
        twoblank();
    }
    else if ( l == 2 && r == 0) {
        twoblank();
    }
    else if ( l == 1 && r == 2) {
        onetwo();
    }
    else if ( l == 2 && r == 1) {
        twoone();
    }
    else if ( l == 2 && r == 2) {
        twotwo();
    }
    else if ( l == 2 && r == 2) {
        twotwo();
    }
    else if ( l == 3 && r == 2) {
        threetwo();
    }
    else if ( l == 2 && r == 3) {
        twothree();
    }
    else if ( l == 4 && r == 2) {
        fourtwo();
    }
    else if ( l == 2 && r == 4) {
        twofour();
    }
    else if ( l == 5 && r == 2) {
        fivetwo();
    }
    else if ( l == 2 && r == 5) {
        twofive();
    }
    else if ( l == 6 && r == 2) {
        sixtwo();
    }
    else if ( l == 2 && r == 6) {
        twosix();
    }
    else if ( l == 0 && r == 3) {
        threeblank();
    }
    else if ( l == 3 && r == 0) {
        threeblank();
    }
    else if ( l == 1 && r == 3) {
        onethree();
    }
    else if ( l == 3 && r == 1) {
        threeone();
    }
    else if ( l == 2 && r == 3) {
        twothree();
    }
    else if ( l == 3 && r == 2) {
        threetwo();
    }
    else if ( l == 3 && r == 3) {
        threethree();
    }
    else if ( l == 3 && r == 3) {
        threethree();
    }
    else if ( l == 4 && r == 3) {
        fourthree();
    }
    else if ( l == 3 && r == 4) {
        threefour();
    }
    else if ( l == 5 && r == 3) {
        fivethree();
    }
    else if ( l == 3 && r == 5) {
        threefive();
    }
    else if ( l == 6 && r == 3) {
        sixthree();
    }
    else if ( l == 3 && r == 6) {
        threesix();
    }
    else if ( l == 0 && r == 4) {
        fourblank();
    }
    else if ( l == 4 && r == 0) {
        fourblank();
    }
    else if ( l == 1 && r == 4) {
        onefour();
    }
    else if ( l == 4 && r == 1) {
        fourone();
    }
    else if ( l == 2 && r == 4) {
        twofour();
    }
    else if ( l == 4 && r == 2) {
        fourtwo();
    }
    else if ( l == 3 && r == 4) {
        threefour();
    }
    else if ( l == 4 && r == 3) {
        fourthree();
    }
    else if ( l == 4 && r == 4) {
        fourfour();
    }
    else if ( l == 5 && r == 4) {
        fivefour();
    }
    else if ( l == 4 && r == 5) {
        fourfive();
    }
    else if ( l == 6 && r == 4) {
        sixfour();
    }
    else if ( l == 4 && r == 6) {
        foursix();
    }
    else if ( l == 0 && r == 5) {
        fiveblank();
    }
    else if ( l == 5 && r == 0) {
        fiveblank();
    }
    else if ( l == 1 && r == 5) {
        onefive();
    }
    else if ( l == 5 && r == 1) {
        fiveone();
    }
    else if ( l == 2 && r == 5) {
        twofive();
    }
    else if ( l == 5 && r == 2) {
        fivetwo();
    }
    else if ( l == 3 && r == 5) {
        threefive();
    }
    else if ( l == 5 && r == 3) {
        fivethree();
    }
    else if ( l == 4 && r == 5) {
        fourfive();
    }
    else if ( l == 5 && r == 4) {
        fivefour();
    }
    else if ( l == 5 && r == 5) {
        fivefive();
    }
    else if ( l == 6 && r == 5) {
        sixfive();
    }
    else if ( l == 5 && r == 6) {
        fivesix();
    }
    else if ( l == 0 && r == 6) {
        sixblank();
    }
    else if ( l == 6 && r == 0) {
        sixblank();
    }
    else if ( l == 1 && r == 6) {
        onesix();
    }
    else if ( l == 6 && r == 1) {
        sixone();
    }
    else if ( l == 2 && r == 6) {
        twosix();
    }
    else if ( l == 6 && r == 2) {
        sixtwo();
    }
    else if ( l == 3 && r == 6) {
        threesix();
    }
    else if ( l == 6 && r == 3) {
        sixthree();
    }
    else if ( l == 4 && r == 6) {
        foursix();
    }
    else if ( l == 6 && r == 4) {
        sixfour();
    }
    else if ( l == 5 && r == 6) {
        fivesix();
    }
    else if ( l == 6 && r == 5) {
        sixfive();
    }
    else if ( l == 6 && r == 6) {
        sixsix();
    }
}

module blankblank() {
	difference() {
		color("white") hull() {
			cube([1,18,8]);
			translate([.5,0,0]) sphere(1);
			translate([.5,18,0]) sphere(1);
			translate([.5,0,8]) sphere(1);
			translate([.5,18,8]) sphere(1);
		}
		color("black") hull() {
			translate([0,9,6]) sphere(.75);
			translate([0,9,2]) sphere(.75);
		}
	}
}

module oneblank() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
	}
}

module oneone() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
	}
}

module onetwo() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
	}
}

module onethree() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
	}
}

module onefour() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module onefive() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module onesix() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,13.5,2]) sphere(.75);
		color("black") translate([0,13.5,6]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module twoblank() {
	difference() {
		blankblank();
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
	}
}

module twoone() {
	difference() {
		blankblank();
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
	}
}

module twotwo() {
	difference() {
		blankblank();
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
	}
}

module twothree() {
	difference() {
		blankblank();
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
	}
}

module twofour() {
	difference() {
		blankblank();
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module twofive() {
	difference() {
		blankblank();
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module twosix() {
	difference() {
		blankblank();
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,13.5,2]) sphere(.75);
		color("black") translate([0,13.5,6]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module threeblank() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
	}
}

module threeone() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
	}
}

module threetwo() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
	}
}

module threethree() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
	}
}

module threefour() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module threefive() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module threesix() {
	difference() {
		blankblank();
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,13.5,2]) sphere(.75);
		color("black") translate([0,13.5,6]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module fourblank() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
	}
}

module fourone() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
	}
}

module fourtwo() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
	}
}

module fourthree() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
	}
}

module fourfour() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module fourfive() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module foursix() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,13.5,2]) sphere(.75);
		color("black") translate([0,13.5,6]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module fiveblank() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
	}
}

module fiveone() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
	}
}

module fivetwo() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
	}
}

module fivethree() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
	}
}

module fivefour() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module fivefive() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module fivesix() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,4]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,13.5,2]) sphere(.75);
		color("black") translate([0,13.5,6]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module sixblank() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,4,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,2]) sphere(.75);
	}
}

module sixone() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,4,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
	}
}

module sixtwo() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,4,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,2]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
	}
}

module sixthree() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,4,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,2]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
	}
}

module sixfour() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,4,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,2]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module sixfive() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,4,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,2]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,13.5,4]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}

module sixsix() {
	difference() {
		blankblank();
		color("black") translate([0,6,2]) sphere(.75);
		color("black") translate([0,4,6]) sphere(.75);
		color("black") translate([0,2,2]) sphere(.75);
		color("black") translate([0,2,6]) sphere(.75);
		color("black") translate([0,6,6]) sphere(.75);
		color("black") translate([0,4,2]) sphere(.75);
		color("black") translate([0,11.5,2]) sphere(.75);
		color("black") translate([0,15.5,6]) sphere(.75);
		color("black") translate([0,15.5,2]) sphere(.75);
		color("black") translate([0,13.5,2]) sphere(.75);
		color("black") translate([0,13.5,6]) sphere(.75);
		color("black") translate([0,11.5,6]) sphere(.75);
	}
}