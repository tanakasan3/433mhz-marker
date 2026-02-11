// 433MHz Marker - Square prism with center hole and text on all faces
// Dimensions: 8mm x 8mm x 10mm with 4mm center hole

$fn = 64; // Smooth circles

// Parameters
side = 8;           // Square side length
height = 10;        // Total height
hole_diameter = 4;  // Center hole diameter
text_depth = 0.5;   // How deep the text is engraved
text_size = 4;      // Font size
label_text = "433"; // Text to engrave on faces
edge_radius = 0.8;  // Radius for rounded edges

// Module for rounded cube using hull of spheres at corners
module rounded_cube(size, radius) {
    sx = size[0];
    sy = size[1];
    sz = size[2];
    hull() {
        for (x = [-1, 1], y = [-1, 1], z = [-1, 1]) {
            translate([
                x * (sx/2 - radius),
                y * (sy/2 - radius),
                z * (sz/2 - radius)
            ])
            sphere(r = radius);
        }
    }
}

difference() {
    // Main body - rounded square prism centered at origin
    translate([0, 0, height/2])
        rounded_cube([side, side, height], edge_radius);
    
    // Center hole through the entire height
    translate([0, 0, -1])
        cylinder(d=hole_diameter, h=height+2);
    
    // Text on all 4 faces - engraved vertically
    
    // Face 1: +X side
    translate([side/2 - text_depth + 0.01, 0, height/2])
        rotate([90, -90, 90])
            linear_extrude(text_depth + 0.1)
                text(label_text, size=text_size, halign="center", valign="center", font="Liberation Sans:style=Bold");
    
    // Face 2: -X side
    translate([-(side/2 - text_depth + 0.01), 0, height/2])
        rotate([90, -90, -90])
            linear_extrude(text_depth + 0.1)
                text(label_text, size=text_size, halign="center", valign="center", font="Liberation Sans:style=Bold");
    
    // Face 3: +Y side
    translate([0, side/2 - text_depth + 0.01, height/2])
        rotate([90, -90, 180])
            linear_extrude(text_depth + 0.1)
                text(label_text, size=text_size, halign="center", valign="center", font="Liberation Sans:style=Bold");
    
    // Face 4: -Y side
    translate([0, -(side/2 - text_depth + 0.01), height/2])
        rotate([90, -90, 0])
            linear_extrude(text_depth + 0.1)
                text(label_text, size=text_size, halign="center", valign="center", font="Liberation Sans:style=Bold");
}
