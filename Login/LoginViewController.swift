//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
        
        static let loginLabel = "Login View Controller";
        static let padding : CGFloat = 10;
        static let neighborPadding : CGFloat = 2;
    }
    
    class LoginTitle : UILabel {
        override init (frame : CGRect) {
            super.init(frame:frame);
            text = Constants.loginLabel;
            textColor! = UIColor.white;
            numberOfLines = 2;
            font = UIFont.init(name: "Helvetica", size: 70);
            textAlignment = .center;
            adjustsFontSizeToFitWidth = true;
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder:aDecoder);
        }
    }
    class AccountText : UITextField {
        override init (frame : CGRect) {
            super.init(frame:frame);
            placeholder = "berkeley.edu account";
            font = UIFont.init(name: "Helvetica", size: 24);
            adjustsFontSizeToFitWidth = true;
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder:aDecoder);
        }
    }
    class PasswordText : UITextField {
        override init (frame : CGRect) {
            super.init(frame:frame);
            placeholder = "Password";
            font = UIFont.init(name: "Helvetica", size: 24)
            adjustsFontSizeToFitWidth = true;
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder:aDecoder);
        }
    }
    class LoginButton : UIButton {
        let parent : LoginViewController;
        init (frame : CGRect, parent : LoginViewController) {
            self.parent = parent;
            super.init(frame:frame);
            backgroundColor = Constants.backgroundColor;
            setTitle("Login", for: .normal);
            titleLabel!.font = UIFont(name: "Helvetica", size: 24);
            setTitleColor(UIColor.white, for : .normal);
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            parent.loginButtonClick();
            //sendActions(for: UIControlEvents.touchUpInside);
        }
    }
    class LoginBox : UIView {
        let parent : LoginViewController;
        let accountText : AccountText;
        let passwordText : PasswordText;
        init (frame : CGRect, parent : LoginViewController) {
            self.parent = parent;
            let textHeight : CGFloat = (frame.height - Constants.padding*2 - Constants.neighborPadding*2)/3;
            accountText = AccountText(frame : CGRect(x: Constants.padding,
                                                     y: Constants.padding,
                                                     width: frame.width - Constants.padding*2,
                                                     height: textHeight));
            passwordText = PasswordText(frame : CGRect(x: Constants.padding,
                                                       y: Constants.padding + Constants.neighborPadding + textHeight,
                                                       width: frame.width - Constants.padding*2,
                                                       height: textHeight));
            super.init(frame:frame);
            backgroundColor = UIColor.white;
            addSubview(accountText);
            addSubview(passwordText);
            addSubview(LoginButton(frame : CGRect(x: Constants.padding + (frame.width - Constants.padding*2)/6,
                                                  y: Constants.padding + Constants.neighborPadding*2 + textHeight*2,
                                                  width: 2*(frame.width - Constants.padding*2)/3,
                                                  height: textHeight), parent : parent));
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        let firstHeight : CGFloat = (view.frame.height - Constants.padding * 4 - Constants.neighborPadding * 10)/3;
        let loginTitle : LoginTitle = LoginTitle(frame : CGRect(
            x: view.frame.minX + Constants.padding,
            y: view.frame.minY + Constants.padding*3,
            width: view.frame.width - Constants.padding * 2,
            height: firstHeight));
        let loginBox : LoginBox = LoginBox(frame : CGRect(
            x: view.frame.minX + Constants.padding,
            y: view.frame.minY + firstHeight + Constants.neighborPadding * 10,
            width: view.frame.width - Constants.padding * 2,
            height: firstHeight), parent : self);
        view.addSubview(loginTitle);
        view.addSubview(loginBox);
        self.loginTitle = loginTitle;
        self.loginBox = loginBox;
    }
    
    var loginTitle : LoginTitle?
    var loginBox : LoginBox?;
    
    func loginButtonClick () {
        if (loginTitle != nil && loginBox != nil) {
            let acctTxt = loginBox!.accountText.text;
            let pswdTxt = loginBox!.passwordText.text;
            authenticateUser(username: acctTxt, password: pswdTxt);
        }
    }
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
