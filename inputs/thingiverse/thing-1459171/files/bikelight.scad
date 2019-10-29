$fn = 50;

thick=2;

switchlen=12;
switchwid=9;
batterylen=70;
batterywid=9;
airflowlen=6;
airflowwid=10;
pcblen=1;
pcbwid=10;
ledlen=6;
ledwid=12;
lenslen=2;
lenswid=12;

wiredia=1;

notchlen=1;
notchwid=1;

function width() = max(switchwid,batterywid,airflowwid,pcbwid,ledwid,lenswid)+thick;
function length() = thick+switchlen+thick+batterylen+thick+airflowlen+notchlen+pcblen+notchlen+ledlen+notchlen+lenslen+notchlen;

rotate([-90,0,0]) {
  difference() {
    // The outer body
    cylinder(h=length(), r=width());

    // Switch Opening
    translate([-3,-2,0]) {
      cube([6,4,thick]);
    }

    // Switch compartment
    translate([0,0,thick]) {
      cylinder(h=switchlen, r=switchwid);
    }

    // Wire hole
    translate([-wiredia,-wiredia/2,thick+switchlen]) {
      cube([2*wiredia,wiredia,thick]);
    }

    // Battery compartment
    translate([0,0,thick+switchlen+thick]) {
      cylinder(h=batterylen, r=batterywid+wiredia);
    }

    // Wire hole
    translate([-wiredia,-wiredia/2,thick+switchlen+thick+batterylen]) {
      cube([2*wiredia,wiredia,thick]);
    }

    // LED airflow compartment
    translate([0,0,thick+switchlen+thick+batterylen+thick]) {
      cylinder(h=airflowlen, r=airflowwid);
    }

    // PCB
    translate([0,0,thick+switchlen+thick+batterylen+thick+airflowlen]) {
      cylinder(h=1, r=pcbwid-notchwid);
    }
    translate([0,0,thick+switchlen+thick+batterylen+thick+airflowlen+notchlen]) {
      cylinder(h=pcblen, r=pcbwid);
    }
    translate([0,0,thick+switchlen+thick+batterylen+thick+airflowlen+notchlen+pcblen]) {
      cylinder(h=1, r=pcbwid-notchwid);
    }

    // LED compartment
    translate([0,0,thick+switchlen+thick+batterylen+thick+airflowlen+notchlen+pcblen+notchlen]) {
      cylinder(h=ledlen, r=ledwid);
    }

    // Lens
    translate([0,0,thick+switchlen+thick+batterylen+thick+airflowlen+notchlen+pcblen+notchlen+ledlen]) {
      cylinder(h=1, r=lenswid-notchwid);
    }
    translate([0,0,thick+switchlen+thick+batterylen+thick+airflowlen+notchlen+pcblen+notchlen+ledlen+notchlen]) {
      cylinder(h=lenslen, r=lenswid);
    }
    translate([0,0,thick+switchlen+thick+batterylen+thick+airflowlen+notchlen+pcblen+notchlen+ledlen+notchlen+lenslen]) {
      cylinder(h=1, r=lenswid-notchwid);
    }

    // Cleave it in twain
    translate([-width(),0,0]) {
      cube([2*width(),width(),length()]);
    }
  }
}

echo();
echo("***");
echo("STATS:");
echo(str("Final length = ", length(), "mm"));
echo(str("Final width = ", 2*width(), "mm"));
echo("***");
echo();
