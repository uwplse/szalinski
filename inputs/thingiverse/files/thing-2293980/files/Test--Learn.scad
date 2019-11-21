/**
 * Text banner
 * 
 * @Author  Wilfried Loche
 * @Created May 3rd, 2017
 * @Updated May 8th, 2017: Added underline_percent parameter
 */

$fn = 50;

/* Text to display */
text = "Test & Learn";
/* % of underline length. 0% = no underline, 100% = same length as the text */
underline_percent = 94; // [0:100]

/* Font to use */
font = "Cooper Std"; // ["Bitstream Vera Serif", "Cambria", "Constantia", "DejaVu Serif", "Elephant", "Garamond", "Georgia", "Liberation Serif", "Luxi Serif", "MS Serif", "Nimbus Roman No9 L", "Nimbus Roman", "Palatino Linotype", "Thorndale AMT", "Thorndale", "Times New Roman", "Times", "Albany AMT", "Albany", "Arial Unicode MS", "Arial", "Bitstream Vera Sans", "Britannic", "Calibri", "Candara", "Century Gothic", "Corbel", "DejaVu Sans", "Helvetica", "Haettenschweiler", "Liberation Sans", "MS Sans Serif", "Nimbus Sans L", "Nimbus Sans", "Luxi Sans", "Tahoma", "Trebuchet MS", "Twentieth Century", "Verdana", "Andale Mono", "Bitstream Vera Sans Mono", "Consolas", "Courier New", "Courier", "Cumberland AMT", "Cumberland", "DejaVu Sans Mono", "Fixedsys", "Inconsolata", "Liberation Mono", "Luxi Mono", "Nimbus Mono L", "Nimbus Mono", "Terminal", "Bauhaus Std", "Cooper Std", "Copperplate Gothic Std", "Impact", "Comic Sans MS", "ITC Zapf Chancery Std", "Zapfino"]

//--- Text with a slight zoom effect
resize([100,0,0], auto=true) 
linear_extrude(height = 6, scale=[1, 1.4], slices=20)
text(text = text, halign = "center", font = font);

//--- Underline (to glue the letters)
translate([-45, 0, 0])
cube([underline_percent, 1, 1]);
