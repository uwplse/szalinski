character1="3";
character2="D";

intersection() {
rotate([90,0,0]) linear_extrude(height = 100, center=true) text(character1, font = "arial:style=Bold", "center", size = 10, valign="center", halign="center");

rotate([90,0,90]) linear_extrude(height = 100, center=true) text(character2, font = "arial:style=Bold", "center", size = 10, valign="center", halign="center");
}