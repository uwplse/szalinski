/**
 * List of available fonts
 * 
 * Based on ~/fonts/conf.d/45-latin.conf
 * 
 * @Author  Wilfried Loche
 * @Created May 3rd, 2017
 */

$fn = 50;

fonts = ["Bitstream Vera Serif", "Cambria", "Constantia", "DejaVu Serif", "Elephant", "Garamond", "Georgia", "Liberation Serif", "Luxi Serif", "MS Serif", "Nimbus Roman No9 L", "Nimbus Roman", "Palatino Linotype", "Thorndale AMT", "Thorndale", "Times New Roman", "Times", "Albany AMT", "Albany", "Arial Unicode MS", "Arial", "Bitstream Vera Sans", "Britannic", "Calibri", "Candara", "Century Gothic", "Corbel", "DejaVu Sans", "Helvetica", "Haettenschweiler", "Liberation Sans", "MS Sans Serif", "Nimbus Sans L", "Nimbus Sans", "Luxi Sans", "Tahoma", "Trebuchet MS", "Twentieth Century", "Verdana", "Andale Mono", "Bitstream Vera Sans Mono", "Consolas", "Courier New", "Courier", "Cumberland AMT", "Cumberland", "DejaVu Sans Mono", "Fixedsys", "Inconsolata", "Liberation Mono", "Luxi Mono", "Nimbus Mono L", "Nimbus Mono", "Terminal", "Bauhaus Std", "Cooper Std", "Copperplate Gothic Std", "Impact", "Comic Sans MS", "ITC Zapf Chancery Std", "Zapfino"];


ids = [0 : len(fonts) - 1];

for (id = ids) {
    translate([0, id*12, 0])
    linear_extrude(height = 2)
    text(text = fonts[id], halign = "center", font = fonts[id]);
    echo (id);
}
