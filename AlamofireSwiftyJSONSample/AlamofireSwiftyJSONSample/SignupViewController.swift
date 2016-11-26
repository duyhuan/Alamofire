//
//  SignupViewController.swift
//  AlamofireSwiftyJSONSample
//
//  Created by huan huan on 11/17/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignupViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var btnSignup: UIButton!
    @IBOutlet var lblSignin: UILabel!
    var json: JSON = nil
    var error: String? = nil
    
    var moreString: NSAttributedString? = nil
    var attributedText: NSMutableAttributedString? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignup.layer.cornerRadius = 5
        lblSignin.isUserInteractionEnabled = true
        
        customLabel()
    }
    
    func alert(title1: String, title2: String, message: String) {
        let alert = UIAlertController(title: title1, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: title2, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        if password.text == confirmPassword.text {
            let parameters: Parameters = [
                "email": self.email.text ?? "",
                "password": self.password.text ?? "",
                ]
            Alamofire.request(Router.createUser(parameters: parameters)).responseJSON{(response) in
                guard let data = response.result.value else{
                    self.lblSignin.text = "Request failed"
                    return
                }
                self.json = JSON(data)
                self.error = String(describing: self.json["error"])
                if self.json["error"] == nil {
                    self.alert(title1: "", title2: "OK", message: "Sign Up success")
                } else {
                    self.alert(title1: "", title2: "OK", message: self.error!)
                }
            }
        } else {
            alert(title1: "", title2: "OK", message: "Password different Confirm Password")
        }
    }
    
    func customLabel() {
        lblSignin.font = UIFont.systemFont(ofSize: 16)
        lblSignin.center = self.view.center
        attributedText = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)])
        moreString = NSAttributedString(string: "Sign In", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.white])
        attributedText?.append(moreString!)
        let paragraphStyle = NSMutableParagraphStyle()
        attributedText?.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, (attributedText?.string.characters.count)!))
        lblSignin.attributedText = attributedText
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.tapResponse(_:)))
        lblSignin.addGestureRecognizer(tapGesture)
        lblSignin.isUserInteractionEnabled =  true
        lblSignin.numberOfLines = 0
        lblSignin.textAlignment = .center
    }
    
    func tapResponse(_ recognizer: UITapGestureRecognizer) {
        let moreStringRange = attributedText?.string.range(of: (moreString?.string)!)
        let nsra = attributedText?.string.nsRange(from: moreStringRange!)
        if recognizer.didTapAttributedTextInLabel(label: lblSignin, inRange: nsra!) {
            let signinVC = storyboard?.instantiateViewController(withIdentifier: "SigninVC")
            present(signinVC!, animated: true, completion: nil)
        }
    }
}
