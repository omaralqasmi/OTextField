//
import UIKit
public enum OTextFieldPreImage{
    case none
    case username
    case email
    case text
    case custom_requires_customPreImage
}
public class OTextField: UIView {

    
    
    @IBOutlet weak var vwContentContainer: UIView!
    @IBOutlet weak var vwBorderLineView: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var imgPreIcon: UIImageView!
    @IBOutlet weak var txtInputField: UITextField!
    @IBOutlet weak var imgPostIcon: UIImageView!
    @IBOutlet weak var btnPasswordVisibility: UIButton!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    var successColor: UIColor = .green
    var errorColor: UIColor = .red
    var messageColor: UIColor = .gray
    var borderColor: UIColor = .lightGray
    var message: String? = nil
    public var oTextField: UITextField?
    
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
        placeHolder: String,
        isPassword: Bool,
        message: String? = nil,
        textFieldViewHeight: CGFloat = 55,
        borderColor: UIColor = .lightGray,
        iconsColor: UIColor = .lightGray,
        messageColor: UIColor = .gray,
        successColor: UIColor = .green,
        errorColor: UIColor = .red
        
    ){
        oTextField = txtInputField
        constraintHeight.constant = textFieldViewHeight
        vwBorderLineView.backgroundColor = borderColor
        imgPreIcon.tintColor = iconsColor
        imgPostIcon.tintColor = iconsColor
        self.borderColor = borderColor
        self.successColor = successColor
        self.errorColor = errorColor
        self.messageColor = messageColor
        self.message = message
        messageLabel(message: message)
        switch preImage {
        case .none:
            imgPreIcon.isHidden = true

        case .username:
            imgPreIcon.isHidden = false
            imgPreIcon.image = UIImage.init(named: "OTextField_person.fill", in: .module, compatibleWith: nil)!

        case .email:
            imgPreIcon.isHidden = false
            imgPreIcon.image = UIImage.init(named: "OTextField_envelope.fill", in: .module, compatibleWith: nil)!

        case .text:
            imgPreIcon.isHidden = false
            imgPreIcon.image = UIImage.init(named: "OTextField_square.and.pencil", in: .module, compatibleWith: nil)!

        case .custom_requires_customPreImage:
            imgPreIcon.isHidden = false
            if customPreImage != nil {
                imgPreIcon.isHidden = false
                imgPreIcon.image = customPreImage

            }else{
                imgPreIcon.isHidden = true
            }
        }
        txtInputField.delegate = self
        txtInputField.placeholder = placeHolder
        imgPostIcon.image = UIImage.init(named: "OTextField_eye.slash", in: .module, compatibleWith: nil)!
        txtInputField.placeholder = placeHolder
        if isPassword {
            btnPasswordVisibility.isHidden = false
            imgPostIcon.isHidden = false
            txtInputField.isSecureTextEntry = true
        }else{
            btnPasswordVisibility.isHidden = true
            imgPostIcon.isHidden = true
            txtInputField.isSecureTextEntry = false

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
        clearMessage()
        return true
    }
}
