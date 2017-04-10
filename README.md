# Lab 6 : Programmatic Design #

## Due Date ##
Tuesday, April 11th at 11:59 pm

## Overview ##

In today's lab, you'll be creating a very simple login screen programmatically (*no Storyboard!*). By the end of this lab, you will have walked through the steps of setting up Xcode for apps without storyboards and will have become familiar with the basics of programmatic design. Below is an example of what we are looking for in your submissions.

![](/README-images/README-1.png)

## Getting Started ##

To begin the lab, clone the repository onto your personal computer.
	
	git clone https://github.com/YOUR-USERNAME/ios-decal-lab6

To push your changes for the lab, run the following commands in your lab-6 folder.

	git add .
	git commit -m "Finished lab 5"
	git push origin master
	
Once you have done this, you can view the files you pushed at https://github.com/YOUR-USERNAME/ios-decal-lab6. You can then use this repository to submit via Gradescope when you are finished (see the **Submission** section below).

## Part 1: Removing Main.storyboard ##

Since we will be creating this application programmatically, first delete **Main.storyboard** from your project files. If you run your application at this point, your app will crash with the following error

      2017-04-05 10:51:49.034 Login[12514:596835] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', 
      reason: 'Could not find a storyboard named 'Main' in bundle NSBundle </Users/paige/Library/Developer/CoreSimulator/Devices/
      17EEA772-3B18-4D40-9A9A-4C97A7E5034B/data/Containers/Bundle/Application/684846F7-9231-4F40-9541-19C090E49415/Login.app>

To fix this, **open up your app's Info.plist, and delete the key** `Main storyboard file base name` (since we do not have a Storyboard file for our application, this key is not valid). Your app should now run without errors, but will not display anything yet, because we have not specified the initial view controller.

## Part 2: Setting the Initial View ##
Since we are not using a storyboard, we now need to programmatically set the initial view controller of our application. To do this, **edit the method `application(_ application: UIApplication, didFinishLaunchingWithOptions` found in AppDelegate.swift** so that our initial view we see when opening the app is the LoginViewController. Check out the [Lecture 8 Programmatic Design Slides](http://iosdecal.com/Lectures/Lecture8.pdf#page=50) for an example of how to do this.

Once you have completed this part, you should be see a blue screen (your blank LoginViewController) appear on your simulator.

## Part 3: Customizing your View ##

### Requirements for Part 3 ###
Now that we've got our project all set up, you can now begin designing the UI for the login screen. You do not have to copy the design provided exactly, but **your view must contain the following elements:**

![](/README-images/README-2.png)

- A `UILabel` at the top of the view
- A `UIView` with the following subviews
    - A `textfield` for the user to input their berkeley.edu account name
    - A `textfield` for the user to input their password
    - A Login `UIButton`
  
Also, **your implementation must satisfy the following requirements**

- The UIView containing the text fields and button must have a width equal to 90% of the width of the user's device
- The vertical spacing between the login button and text field's must be uniform
- Tapping the login button must trigger an IBAction that checks if the user's e-mail and password combination is valid. You will find the method `authenticateUser` helpful for this part. You can test that your implementation works by trying to log in with your own berkeley.edu account, using your first name as the password (oh, how secure!).

Any other design choices (color, extra UI elements, fonts) are optional, but we'll be awarding extra credit to students who go beyond the given requirements. You **are not** required to support landscape mode orientations or iPad devices (we'll be testing on the iPhone 7 simulator).

### Tips and Tricks for Part 3 ###

As for the implementation of the design, you may use either method of programmatic design introduced during lecture (that is, you can either use frames or NSLayoutConstraints).

If you decide to go ahead with **Frame-based layout**, you may want to use some of the code examples below
	
	// initializer for CGRect. This returns a rectangle with the given size and 
	// position that can be used to set the frame of your UI elements.
	CGRect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) - 
	
	// returns the size of the user's screen (you can use this to get the width and height of the screen)
	UIScreen.main.bounds.size
	
	// returns the center x coordinate of the user's screen (CGFloat)
	UIScreen.main.bounds.midX
	
	// returns the center y coordinate of the user's screen (CGFloat)
	UIScreen.main.bounds.midY
	
	// returns the CGPoint at the center of "view" (remember, ViewControllers have a 
	// default "view" associated with them. This is the white (or blue in our app) background 
	// that you see when the View Controller appears on the screen). Since this view is the same
	// size as the device's screen, you may use it instead of UIScreen.main to get the sizing information you need.
	view.center
	
If you instead decide to implement your layout with **AutoLayout** (`NSLayoutAnchor` and `NSLayoutConstraint`), you'll find the following methods helpful. I'll just be using `widthAnchor` for these examples, but keep in mind that this can be replaced with `heightAnchor`, `leadingAnchor`, `trailingAnchor`, `centerXAnchor`, etc.)
	
	// sets the width of view 1 equal to someCGFloat
	view1.widthAnchor.constraint(equalToConstant: someCGFloat)
	
	// sets the width of view 1 equal to the width of view 2
	view1.widthAnchor.constraint(equalTo: view2.widthAnchor)
	
	// sets the width of view 1 equal to the multiplier * (width of view 2)
	view1.widthAnchor.constraint(equalTo: view2.widthAnchor, multiplier: someCGFloat) 
	
	// sets the width of view 1 equal to the width of view 2 + constant
	view1.widthAnchor.constraint(equalTo: view2.widthAnchor, constant: someCGFloat) 
	
	// sets the width of view 1 equal to the width of view 2 + constant
	view1.widthAnchor.constraint(equalTo: view2.widthAnchor, constant: someCGFloat)
	
	// Tells Xcode not to add autoresizing constraints (if you get NSLayout Conflicting Constraints 
	// warning that includes an "AutoResizing" Constraint, it's probably because you have not 
	// set this property to false for your view
	view1.translatesAutoresizingMaskIntoConstraints = false

Keep in mind that if you use AutoLayout, you should be looking at your console regularly to resolve conflicting constraints.

You may also want to refer to the demo code from last lecture, for examples of [Frame Based Layout](https://github.com/paigeplan/lec8/blob/master/Programmatic%20Design%20Demo/MainViewController.swift) and [Programmatic AutoLayout](https://github.com/paigeplan/lec8/blob/master/Programmatic%20Design%20Demo/SecondViewController.swift). 

## Grading ##
Once you have finished, please submit your files to [Gradescope](https://gradescope.com/courses/5482). You will need to submit files EVEN if you are being checked off. We have enabled group submission for this assignment, so make sure to include your partner's name if you only worked on one computer.

To submit, please upload your code to either GitHub or Bitbucket, and use the "Github" or "Bitbucket" submission feature on Gradescope. Please check out the [slides in Lecture 3](http://iosdecal.com/Lectures/Lecture3.pdf) for step-by-step submission instructions if you're confused about how to do this (or ask a TA!)

Checkoff Form for  Akilesh's Lab - https://goo.gl/forms/0x2P8vpGRWar7nIX2

Checkoff Form for Paige's Lab - https://goo.gl/forms/Jn8riB5xl0WQWAYQ2
