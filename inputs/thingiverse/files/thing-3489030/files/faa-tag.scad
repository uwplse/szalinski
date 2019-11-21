length = 30;
width = 7;
id_text = "FAXXXXXXXX";

difference() {
    cube([length, width, 1]);
    translate([1, width / 2, 0.5])
    linear_extrude(1, convexity = 4)
    resize([length - 2, 0], auto = [true,true,false])
    text(id_text, valign = "center");
}
