/**
 * Derived from http://www.thingiverse.com/thing:591
 */

// Width of the block, in studs
block_width = 2;

// Length of the block, in studs
block_length = 4;

// Height of the block. A ratio of "1" is a standard LEGO brick height; a ratio of "1/3" is a standard LEGO plate height.
block_height_ratio = 1; // [.33333333333:1/3, 1:1, 2:2, 3:3, 4:4, 5:5, 6:6, 7:7, 8:8]

// Should the block include axle holes?
include_axle_holes = "no"; // [no:No, yes:Yes]

// Should extra reinforcement be included to make printing on an FDM printer easier?
use_reinforcement = "no"; // [no:No, yes:Yes]

// What type of block should this be? A normal brick, or a smooth-topped tile?
block_type = "brick"; // [brick:Brick, tile:Tile]

// (foo * 1) is to prevent these from appearing in the Customizer.
knob_diameter=4.8 * 1;		//knobs on top of blocks
knob_height=2 * 1;
knob_spacing=8.0 * 1;
wall_thickness=1.45 * 1;
roof_thickness=1.05 * 1;
block_height=9.5 * 1;
pin_diameter=3 * 1;		//pin for bottom blocks with width or length of 1
post_diameter=6.5 * 1;
reinforcing_width=1.5 * 1;
axle_spline_width=2.0 * 1;
axle_diameter=5 * 1;
cylinder_precision=0.1 * 1;

block(width=block_width, length=block_length, height=block_height_ratio, axle_hole=(include_axle_holes=="yes"), reinforcement=(use_reinforcement=="yes"), smooth=(block_type == "tile"));

module block(width, length, height, axle_hole, reinforcement, smooth) {

    
    overall_length = (length-1)*knob_spacing+knob_diameter+wall_thickness*2;
    overall_width = (width-1)*knob_spacing+knob_diameter+wall_thickness*2;
    start = (knob_diameter/2+knob_spacing/2+wall_thickness);
    
    translate([-overall_length/2, -overall_width/2, 0]) // Comment to position at 0,0,0 instead of centered on X and Y.
            union() {
                    difference() {
                            union() {
                                    // The mass of the block.
                                    cube([overall_length, overall_width, height * block_height]);
                                    
                                    // The studs on top of the block (if it's not a tile).
                                    if ( ! smooth ) {
                                            translate([knob_diameter/2+wall_thickness,knob_diameter/2+wall_thickness,0]) {
                                                    for (ycount=[0:width-1]) {
                                                            for (xcount=[0:length-1]) {
                                                                    translate([xcount*knob_spacing,ycount*knob_spacing,0]) cylinder(r=knob_diameter/2,h=block_height*height+knob_height,$fs=cylinder_precision);
                                                            }
                                                    }
                                            }
                                    }
                            }
                            
                            translate([wall_thickness,wall_thickness,-roof_thickness]) cube([overall_length-wall_thickness*2,overall_width-wall_thickness*2,block_height*height]);
                            
                            if (axle_hole) {
                                    if (width > 1 && length > 1) {
                                            for (ycount = [ 1 : width - 1 ]) {
                                                    for (xcount = [ 1 : length - 1]) {
                                                            translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,-block_height/2]) axle(height+1);
                                                    }
                                            }
                                    }
                            }
                    }

                    if (reinforcement==true && width>1 && length>1)
                            difference() {
                                    for (ycount=[1:width-1])
                                            for (xcount=[1:length-1])
                                                    translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,0]) reinforcement(height);
                                    for (ycount=[1:width-1])
                                            for (xcount=[1:length-1])
                                                    translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,-0.5]) cylinder(r=post_diameter/2-0.1, h=height*block_height+0.5, $fs=cylinder_precision);
                            }

                    if (width>1 && length>1) for (ycount=[1:width-1])
                            for (xcount=[1:length-1])
                                    translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,0]) post(height,axle_hole);

                    if (width==1 && length!=1)
                            for (xcount=[1:length-1])
                                    translate([(xcount-1)*knob_spacing+start,overall_width/2,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);

                    if (length==1 && width!=1)
                            for (ycount=[1:width-1])
                                    translate([overall_length/2,(ycount-1)*knob_spacing+start,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);
            }
}

module post(height,axle_hole=false) {
	difference() {
		cylinder(r=post_diameter/2, h=height*block_height,$fs=cylinder_precision);
		if (axle_hole==true) {
			translate([0,0,-block_height/2])
				axle(height+1);
		} else {
			translate([0,0,-0.5])
				cylinder(r=knob_diameter/2, h=height*block_height+1,$fs=cylinder_precision);
		}
	}
}

module reinforcement(height) {
	union() {
		translate([0,0,height*block_height/2]) union() {
			cube([reinforcing_width,knob_spacing+knob_diameter+wall_thickness/2,height*block_height],center=true);
			rotate(v=[0,0,1],a=90) cube([reinforcing_width,knob_spacing+knob_diameter+wall_thickness/2,height*block_height], center=true);
		}
	}
}

module axle(height) {
	translate([0,0,height*block_height/2]) union() {
		cube([axle_diameter,axle_spline_width,height*block_height],center=true);
		cube([axle_spline_width,axle_diameter,height*block_height],center=true);
	}
}
