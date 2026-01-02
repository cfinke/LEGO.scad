use <../LEGO.scad>;

block(
    width=6,
    length=7,
    height=1/3,
    type="wing",
    wing_type="full",
    wing_base_length=3,
    wing_end_width=2,
    stud_notches=true
);

// wing_base_length doesn't match what is actually generated. It should be 2.