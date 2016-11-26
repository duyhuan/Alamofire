//
//  ViewController.swift
//  AlamofireSwiftyJSONSample
//
//  Created by huan huan on 11/15/16.
//  Copyright © 2016 Duy Huan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SigninViewController: UIViewController {
    
    @IBOutlet var sView: UIView!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var lblSignup: UILabel!
    @IBOutlet var lblCP: UILabel!
    var json: JSON = nil
    var error: String? = nil
    
    var moreString1: NSAttributedString? = nil
    var moreString2: NSAttributedString? = nil
    var more3String1: NSAttributedString? = nil
    var attributedText: NSMutableAttributedString? = nil
    var attributedText1: NSMutableAttributedString? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 5
        lblSignup.isUserInteractionEnabled = true
        lblCP.isUserInteractionEnabled = true
        
        customLabel()
    }
    
    func alert(title1: String, title2: String, message: String) {
        let alert = UIAlertController(title: title1, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: title2, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func customLabel() {
        lblSignup.font = UIFont.systemFont(ofSize: 16)
        lblSignup.center = self.view.center
        attributedText = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)])
        moreString1 = NSAttributedString(string: "Sign Up", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.white])
        attributedText?.append(moreString1!)
        let paragraphStyle = NSMutableParagraphStyle()
        attributedText?.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, (attributedText?.string.characters.count)!))
        lblSignup.attributedText = attributedText
        let tapGesture1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SigninViewController.tapResponse1(_:)))
        lblSignup.addGestureRecognizer(tapGesture1)
        lblSignup.isUserInteractionEnabled =  true
        lblSignup.numberOfLines = 0
        lblSignup.textAlignment = .center
        
        lblCP.font = UIFont.systemFont(ofSize: 16)
        lblCP.center = self.view.center
        attributedText1 = NSMutableAttributedString(string: "By creating an account, you accept ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)])
        moreString2 = NSAttributedString(string: "Company's Term of Use ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.white])
        attributedText1?.append(moreString2!)
        let more2String1 = NSAttributedString(string: "and ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)])
        attributedText1?.append(more2String1)
        more3String1 = NSAttributedString(string: "Privacy Policy", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.white])
        attributedText1?.append(more3String1!)
        let paragraphStyle1 = NSMutableParagraphStyle()
        attributedText1?.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle1, range: NSMakeRange(0, (attributedText1?.string.characters.count)!))
        lblCP.attributedText = attributedText1
        let tapGesture2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SigninViewController.tapResponse2(_:)))
        lblCP.addGestureRecognizer(tapGesture2)
        lblCP.isUserInteractionEnabled =  true
        lblCP.numberOfLines = 0
        lblCP.textAlignment = .center
    }
    
    func tapResponse1(_ recognizer: UITapGestureRecognizer) {
        let moreStringRange = attributedText?.string.range(of: (moreString1?.string)!)
        let nsra = attributedText?.string.nsRange(from: moreStringRange!)
        if recognizer.didTapAttributedTextInLabel(label: lblSignup, inRange: nsra!) {
            let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignupVC")
            present(signupVC!, animated: true, completion: nil)
        }
    }
    
    func tapResponse2(_ recognizer: UITapGestureRecognizer) {
        let moreStringRange = attributedText1?.string.range(of: (moreString2?.string)!)
        let nsra = attributedText1?.string.nsRange(from: moreStringRange!)
        let moreStringRange1 = attributedText1?.string.range(of: (more3String1?.string)!)
        let nsra1 = attributedText1?.string.nsRange(from: moreStringRange1!)
        if recognizer.didTapAttributedTextInLabel(label: lblCP, inRange: nsra!) {
            let termsVC = storyboard?.instantiateViewController(withIdentifier: "TermsVC")
            present(termsVC!, animated: true, completion: nil)
        } else if recognizer.didTapAttributedTextInLabel(label: lblCP, inRange: nsra1!) {
            let privacyPolicyVC = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC")
            present(privacyPolicyVC!, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        let parameters: Parameters = [
            "email" : self.email.text ?? "",
            "password" : self.password.text ?? ""
        ]
        Alamofire.request(Router.login(parameters: parameters)).responseJSON { (response) in
            guard let data = response.result.value else{
                self.lblSignup.text = "Request failed"
                return
            }
            self.json = JSON(data)
            self.error = String(describing: self.json["error"])
            if self.json["error"] == nil {
                self.alert(title1: "", title2: "OK", message: "Sign In success")
            } else {
                self.alert(title1: "", title2: "OK", message: self.error!)
            }
        }
    }
    
    //    func customLabel(str: String, label: UILabel){
    //        let str = str
    //        let strPieces = str.components(separatedBy: "#")
    //        var ptWordLocation = CGPoint(x: 0.0, y: 0.0)
    //        if (strPieces.count > 1) {
    //            //Loop the parts of the string
    //            for s in strPieces{
    //                //Check for empty string
    //                if (s.isEmpty == false) {
    //                    let lbl = UILabel()
    //                    lbl.textAlignment = .center
    //                    lbl.textColor = UIColor(colorLiteralRed: 111/255, green: 126/255, blue: 148/255, alpha: 1)
    //                    lbl.isUserInteractionEnabled = s.contains("<li>")
    //                    lbl.text = s.replacingOccurrences(of: "<li>", with: "")
    //                    if (s.contains("<li>")) {
    //                        lbl.textColor = UIColor.white
    //                        //Set tap gesture for this clickable text:
    //                        if label == lblSignup {
    //                            let gesture = UILongPressGestureRecognizer(target: self, action: #selector(SigninViewController.tapOnToShowSignup(_:)))
    //                            gesture.minimumPressDuration = 0.001
    //                            lbl.addGestureRecognizer(gesture)
    //                        } else {
    //                            let gesture = UILongPressGestureRecognizer(target: self, action: #selector(SigninViewController.tapOnToShowTerms(_:)))
    //                            gesture.minimumPressDuration = 0.001
    //                            lbl.addGestureRecognizer(gesture)
    //                        }
    //                    } else {
    //                        lbl.isUserInteractionEnabled = s.contains("<lu>")
    //                        lbl.text = s.replacingOccurrences(of: "<lu>", with: "")
    //                        if (s.contains("<lu>")) {
    //                            lbl.textColor = UIColor.white
    //                            //Set tap gesture for this clickable text:
    //                            let gesture = UILongPressGestureRecognizer(target: self, action: #selector(SigninViewController.tapOnToShowPrivacyPolicy(_:)))
    //                            gesture.minimumPressDuration = 0.001
    //                            lbl.addGestureRecognizer(gesture)
    //                        }
    //                    }
    //                    lbl.sizeToFit()
    //                    //Lay out the labels so it forms a complete sentence again
    //                    if (self.view.frame.width < ptWordLocation.x + lbl.bounds.size.width) {
    //                        ptWordLocation.x = 0.0
    //                        ptWordLocation.y += lbl.frame.size.height;
    //                        lbl.text = lbl.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    //                    }
    //                    lbl.frame = CGRect(x: ptWordLocation.x, y: ptWordLocation.y, width: lbl.frame.size.width, height: lbl.frame.size.height)
    //                    lbl.textAlignment = .center
    //                    label.addSubview(lbl)
    //                    //Update the horizontal width
    //                    ptWordLocation.x += lbl.frame.size.width
    //                }
    //            }
    //        }
    //    }
    //
    //    func tapOnToShowSignup(_ recognizer : UILongPressGestureRecognizer){
    //        if let label = recognizer.view as? UILabel {
    //            if recognizer.state == .began {
    //                label.textColor = UIColor.lightGray
    //                let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignupVC")
    //                present(signupVC!, animated: true, completion: nil)
    //            }
    //            if recognizer.state == .ended {
    //                //label.textColor = UIColor.white
    //            }
    //        }
    //    }
    //
    //    func tapOnToShowTerms(_ recognizer : UILongPressGestureRecognizer){
    //        if let label = recognizer.view as? UILabel {
    //            if recognizer.state == .began {
    //                label.textColor = UIColor.lightGray
    //                let termsVC = storyboard?.instantiateViewController(withIdentifier: "TermsVC")
    //                present(termsVC!, animated: true, completion: nil)
    //            }
    //            if recognizer.state == .ended {
    //                //label.textColor = UIColor.white
    //            }
    //        }
    //    }
    //
    //    func tapOnToShowPrivacyPolicy(_ recognizer : UILongPressGestureRecognizer){
    //        if let label = recognizer.view as? UILabel {
    //            if recognizer.state == .began {
    //                label.textColor = UIColor.lightGray
    //                let privacyPolicyVC = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC")
    //                present(privacyPolicyVC!, animated: true, completion: nil)
    //            }
    //            if recognizer.state == .ended {
    //                //label.textColor = UIColor.white
    //            }
    //        }
    //    }
}
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset =  CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                           y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
extension String {
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
}
