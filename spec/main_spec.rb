describe "motion-blitz gem" do

  it "has defaults" do
    Motion::Blitz.background_color.is_a?(UIColor).should == true
    Motion::Blitz.foreground_color.is_a?(UIColor).should == true
    Motion::Blitz.corner_radius.should == 14.0
    Motion::Blitz.ring_thickness.should == 2.0
    Motion::Blitz.font.should == UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
  end

  it "can set defaults" do
    Motion::Blitz.background_color = UIColor.redColor
    Motion::Blitz.background_color.should == UIColor.redColor

    Motion::Blitz.foreground_color = UIColor.blueColor
    Motion::Blitz.foreground_color.should == UIColor.blueColor

    # Uncomment test when setCornerRadius method is released in cocoapod version
    # Motion::Blitz.corner_radius = 5.0
    # Motion::Blitz.corner_radius.should == 5.0

    # Setting ring thickness in actual cocoapod doesn't work.
    # Motion::Blitz.ring_thickness = 5.0
    # Motion::Blitz.ring_thickness.should == 5.0

    font = UIFont.fontWithName('Courier', size: 10.0)
    Motion::Blitz.font = font
    Motion::Blitz.font.should == font
  end

end
