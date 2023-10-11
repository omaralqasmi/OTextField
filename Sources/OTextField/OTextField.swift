//
import UIKit
public enum OTextFieldPreImage{
    case none
    case username
    case email
    case text
    case password
    case phone
    case country
    case bio
    case image
    case custom_requires_customPreImage
}
public class OTextField: UIView {

    
    
    @IBOutlet weak var vwContentContainer: UIView!
    @IBOutlet weak var vwBorderLineView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var imgPreIcon: UIImageView!
    @IBOutlet weak public var txtInputField: UITextField!
    @IBOutlet weak var imgPostIcon: UIImageView!
    @IBOutlet weak var btnPasswordVisibility: UIButton!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    var successColor: UIColor = .green
    var errorColor: UIColor = .red
    var titleColor: UIColor = .gray
    var messageColor: UIColor = .gray
    var borderColor: UIColor = .lightGray
    var message: String? = nil
    var selfHideTitleWhenNoTextEntered: Bool = true
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    public func commonInit() {
        Bundle.module.loadNibNamed("OTextField", owner: self, options: nil)
        self.backgroundColor = .clear
        vwContentContainer.fixInViewOTextField(self)
    }

    public func initText(
        preImage: OTextFieldPreImage,
        customPreImage: UIImage? = nil,
        title: String,
        placeHolder: String,
        hideTitleWhenNoTextEntered: Bool = true,
        text: String = "",
        message: String? = nil,
        textFieldViewHeight: CGFloat = 55,
        borderColor: UIColor = .lightGray,
        iconsColor: UIColor = .lightGray,
        messageColor: UIColor = .gray,
        titleColor: UIColor = .gray,
        successColor: UIColor = .green,
        errorColor: UIColor = .red
        
    ){
        selfHideTitleWhenNoTextEntered = hideTitleWhenNoTextEntered
        lblTitle.text = title
        txtInputField.text = text
        txtInputField.keyboardType = .default
        txtInputField.textContentType = .none
        constraintHeight.constant = textFieldViewHeight
        vwBorderLineView.backgroundColor = borderColor
        imgPreIcon.tintColor = iconsColor
        imgPostIcon.tintColor = iconsColor
        self.borderColor = borderColor
        self.successColor = successColor
        self.errorColor = errorColor
        self.messageColor = messageColor
        self.titleColor = titleColor
        self.message = message
        lblTitle.textColor = titleColor

        messageLabel(message: message)
        
        btnPasswordVisibility.isHidden = true
        imgPostIcon.isHidden = true
        txtInputField.isSecureTextEntry = false

        switch preImage {
        case .none:
            imgPreIcon.isHidden = true

        case .username:
            imgPreIcon.isHidden = false
            imgPreIcon.image = UIImage.init(named: "OTextField_person.fill", in: .module, compatibleWith: nil)!
            txtInputField.keyboardType = .default
            txtInputField.textContentType = .username

        case .email:
            imgPreIcon.isHidden = false
            imgPreIcon.image = UIImage.init(named: "OTextField_envelope.fill", in: .module, compatibleWith: nil)!
            txtInputField.keyboardType = .emailAddress
            txtInputField.textContentType = .emailAddress

        case .text:
            imgPreIcon.isHidden = false
            imgPreIcon.image = UIImage.init(named: "OTextField_square.and.pencil", in: .module, compatibleWith: nil)!
            txtInputField.keyboardType = .default
            txtInputField.textContentType = .none

        case .password:
            imgPreIcon.isHidden = false
            imgPreIcon.image = UIImage.init(named: "OTextField_lock.fill", in: .module, compatibleWith: nil)!
            txtInputField.keyboardType = .asciiCapable
            txtInputField.textContentType = .password
            btnPasswordVisibility.isHidden = false
            imgPostIcon.isHidden = false
            txtInputField.isSecureTextEntry = true

        case .phone:
            imgPreIcon.isHidden = false
            imgPreIcon.image = UIImage.init(named: "OTextField_phone.fill", in: .module, compatibleWith: nil)!
            txtInputField.keyboardType = .asciiCapableNumberPad
            txtInputField.textContentType = .telephoneNumber

        case .country:
            imgPreIcon.isHidden = false
            imgPreIcon.image = UIImage.init(named: "OTextField_globe.europe.africa.fill", in: .module, compatibleWith: nil)!
            txtInputField.keyboardType = .asciiCapable
            txtInputField.textContentType = .countryName

        case .bio:
            imgPreIcon.isHidden = false
            imgPreIcon.image = UIImage.init(named: "OTextField_globe.europe.africa.fill", in: .module, compatibleWith: nil)!
            txtInputField.keyboardType = .default
            txtInputField.textContentType = .countryName

        case .image:
            imgPreIcon.isHidden = false
            imgPreIcon.image = UIImage.init(named: "OTextField_photo", in: .module, compatibleWith: nil)!
            txtInputField.keyboardType = .default
            txtInputField.textContentType = .none

        case .custom_requires_customPreImage:
            imgPreIcon.isHidden = false
            if customPreImage != nil {
                imgPreIcon.isHidden = false
                imgPreIcon.image = customPreImage

            }else{
                imgPreIcon.isHidden = true
            }
            txtInputField.keyboardType = .default
            txtInputField.textContentType = .none

        }
        txtInputField.delegate = self
        txtInputField.placeholder = placeHolder
        imgPostIcon.image = UIImage.init(named: "OTextField_eye.slash", in: .module, compatibleWith: nil)!
        txtInputField.placeholder = placeHolder

        if selfHideTitleWhenNoTextEntered {
            if txtInputField.text == "" {
                lblTitle.isHidden = true
            }else{
                lblTitle.isHidden = false
            }
        }else{
            lblTitle.isHidden = false
        }

        self.layoutSubviews()

    }
    @IBAction func btnActionPasswordVisibilty(_ sender: Any) {
        txtInputField.isSecureTextEntry = !txtInputField.isSecureTextEntry
        if txtInputField.isSecureTextEntry {
            imgPostIcon.image = UIImage.init(named: "OTextField_eye.slash", in: .module, compatibleWith: nil)!

        }else{
            imgPostIcon.image = UIImage.init(named: "OTextField_eye", in: .module, compatibleWith: nil)!
        }
    }
    
    public func getText() -> String {
        return txtInputField.text ?? ""
    }
    public func failure(withMessage: String? = nil) {
        lblTitle.textColor = errorColor
        vwBorderLineView.backgroundColor = errorColor
        if withMessage != nil {
            lblMessage.isHidden = false
            lblMessage.text = withMessage
            lblMessage.textColor = errorColor
        }else{
            messageLabel(message: self.message)

        }

    }
    public func success(withMessage: String? = nil){
        lblTitle.textColor = successColor
        vwBorderLineView.backgroundColor = successColor
        if withMessage != nil {
            lblMessage.isHidden = false
            lblMessage.text = withMessage
            lblMessage.textColor = successColor
        }else{
            messageLabel(message: self.message)

        }

    }
    public func clearMessage(){
        lblTitle.textColor = titleColor
        vwBorderLineView.backgroundColor = borderColor
        messageLabel(message: self.message)

    }
    func messageLabel(message: String?){
        if message != nil && message != "" {
            lblMessage.textColor = messageColor
            lblMessage.isHidden = false
            lblMessage.text = message
        }else{
            lblMessage.isHidden = true
        }

    }

}
extension UIView
{
    func fixInViewOTextField(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
extension OTextField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        superDelegateFunc(range: range, string: string)
        return true
    }
    public func superDelegateFunc(range: NSRange, string: String){
        clearMessage()
        if selfHideTitleWhenNoTextEntered {
            if txtInputField.text == "" || (range.location == 0 && string == ""){
                lblTitle.isHidden = true
            }else{
                lblTitle.isHidden = false
            }
        }else{
            lblTitle.isHidden = false
        }
    }
}
