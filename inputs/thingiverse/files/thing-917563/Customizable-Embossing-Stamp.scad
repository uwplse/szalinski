// Copyright 2015 Arthur Davis (thingiverse.com/artdavis)
// This file is licensed under a Creative Commons Attribution 4.0
// International License.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

// Embossing Emblem stamp.
// Uploaded image should be high contrast and 150px x 150px.
// The black values will be low points and the white values will
// be ridges.
// Units are in mm

/* [Global] */
// Grayscale image. Black values are low points and white is high.
image_file = "emboss-surface.dat"; // [image_surface:150x150]
// Stamp width
part_width = 26.0; // [12.0:1.0:50.0]
// Stamp height
part_height = 26.0; // [12.0:1.0:50.0]
// Embossing ridge thickness
ridge_thick = 3.0; // [1.0:1.0:10.0]
// Length of the punch body
punch_length = 15.0; // [5.0:1.0:50.0]

/* [Hidden] */
// Special variables for arc generation:
$fa = 0.1; // minimum fragment angle
$fs = 0.2; // minimum fragment size
//  Logo image width
image_width = 150; // [50:1:150]
// Logo image height
image_height = 150; // [50:1:150]

translate(v = [0, 0, punch_length])
//scale(v = [width / image_width, height / image_height, ridge_thick / 255])
scale(v = [part_width / image_width, part_height / image_height, ridge_thick])
surface(file=image_file);

cube(size = [part_width, part_height, punch_length]);

