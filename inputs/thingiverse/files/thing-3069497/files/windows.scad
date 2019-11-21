// run
run = "microsoft"; // [microsoft, animated, background,print]

run(run);

module run(run) {
    if (run == "microsoft") {
        windowslogo();
    }
    else if (run == "animated") {
        animated();
    }
    else if (run == "background") {
        background();
    }
    else if (run == "print") {
        linear_extrude(5) offset(10) square([40,40],true);
    }
}

module animated() {
    rotate([0,$t*360,0]) windowslogo();
}

module background() {
    for (x = [0:16]) {
        for (y = [0:8]) {
           translate([x*200,y*200,0]) rotate([180,180,0]) rotate([x*22.5,y*45,0]) windowslogo();
        }
    }
}

module windowslogo() {
    color("yellow") linear_extrude(5) translate([40,-40,0]) offset(10) square([40,40],true);
    color("lightblue") linear_extrude(5) translate([-40,-40,0]) offset(10) square([40,40],true);
    color("lightgreen") linear_extrude(5) translate([40,40,0]) offset(10) square([40,40],true);
    color("OrangeRed") linear_extrude(5) translate([-40,40,0]) offset(10) square([40,40],true);
}