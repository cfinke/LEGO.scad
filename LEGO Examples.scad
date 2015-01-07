use <LEGO.scad>;

rotate([0, 0, 180]) union() {    
    // Zeroth row
    color( "green" ) translate([0, (3 * 4) + (-6.5 * 8), 0]) translate([24, 16, 0]) block(
        width=2,
        length=3,
        brand="duplo",
        reinforcement=true,
        stud_type="hollow"
    );

    // Zeroth row
    color( "blue" ) translate([48, (3 * 4) + (-6.5 * 8), 0]) translate([24, 16, 0]) rotate([0, 0, 180]) block(
        width=2,
        length=2,
        brand="duplo",
        reinforcement=true,
        stud_type="hollow",
        type="curve"
    );
    
        // Zeroth row
    color( "yellow" ) translate([-24, (3 * 4) + (-11.5 * 8) + 88, 0]) rotate([0, 0, 270]) block(
        width=2,
        length=6,
        brand="duplo",
        type="curve",
        curve_type="convex",
        curve_stud_rows=4
    );
    
    // First row.
    color( "red" ) translate([0, 0 * (8 * 2), 0]) translate([36, 8, 0]) block(
        width=2,
        length=9,
        height=2,
        reinforcement=true
    );

    // Second row.
    color( "blue" ) translate([(0 * 4) + (0 * 8), (1 * 4) + (2 * 8), 0]) translate([8, 8, 0]) block(
        width=2,
        length=2,
        stud_type="hollow"
    );

    color( "yellow" ) translate([(1 * 4) + (2 * 8), (1 * 4) + (2 * 8), 0]) translate([8, 8, 0]) block(
        width=2,
        length=2,
        height=1/3,
        vertical_axle_holes=true
    );

    color( "gray" ) translate([(2 * 4) + (4 * 8), (1 * 4) + (2 * 8), 0]) translate([8, 8, 0]) block(
        width=2,
        length=2,
        height=1/3,
        smooth=true
    );

    // Third row.
    color( "white" ) translate([0, (2 * 4) + (4 * 8), 0]) translate([36, 16, 0]) block(
        width=4,
        length=9,
        height=1/3,
        type="wing",
        stud_notches=true
    );

    // Fourth row.
    color( "yellow" ) translate([0, (3 * 4) + (8 * 8), 0]) translate([32, 4, 0]) block(
        width=1,
        length=8,
        horizontal_holes=true
    );

    // Fifth row.
    color( "black" ) translate([0, (3 * 4) + (10 * 8), 0]) translate([16, 4, 0]) rotate([0, 0, 180]) block(
        width=2,
        length=4,
		type="slope"
    );
}