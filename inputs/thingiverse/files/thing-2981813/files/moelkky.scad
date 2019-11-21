// Schräge, auf welcher die Zahl steht
winkel = 45;

// Innendurchmesser
durchmesser = 56;

// Höhe
hoehe = 70;

// Schriftart
font = "Stencil";

// Schriftgröße
fontsize = 33;

// Wandstärke
HullSize = 1;

// Y-Offset der Schrift
YOffset = -3;

drawAll();

// -------------------------------------------------------------------------------------------

module drawAll() {
    for(i=[1:12]) {
        translate([0, (i-1)*(durchmesser+5), 0]) {
            difference() {
                drawHull();

                drawChunk();
                drawText(str(i));
            }
        }
    }
}

// -------------------------------------------------------------------------------------------

module drawHull() {
    hull() {
        cylinder(r=durchmesser/2+HullSize, h=1, $fn = 64);
        translate([0, 0, hoehe-((durchmesser)/2)*tan(winkel) + HullSize/cos(winkel)])
            rotate([0, winkel, 0]) resize([(durchmesser+HullSize*2)/cos(winkel), durchmesser+HullSize]) 
                cylinder(r=durchmesser/2+HullSize, h=0.0001, center=true, $fn = 64);
    }
}

// -------------------------------------------------------------------------------------------

module drawChunk() {
    hull() {
        cylinder(r=durchmesser/2, h=1, $fn = 64);
        translate([0, 0, hoehe-(durchmesser/2)*tan(winkel)])
            rotate([0, winkel, 0]) resize([durchmesser/cos(winkel), durchmesser]) 
                cylinder(r=durchmesser/2, h=0.0001, center=true, $fn = 64);
    }
}

// -------------------------------------------------------------------------------------------

module drawText(text) {
    translate([0, YOffset, hoehe-(durchmesser/2)*tan(winkel)])   // verschiebung auf Y wegen spacing des textes notwendig.
        rotate([winkel, 0, 90]) 
            color("gray")
                     linear_extrude(height=5) 
                        text(text=text, font=font, size=fontsize, valign="center", halign="center", height=3, spacing=0.8);
}
