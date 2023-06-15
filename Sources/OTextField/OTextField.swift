import UIKit

public class OTextField: UIView {

    
    
    @IBOutlet weak var vwContentContainer: UIView!
    @IBOutlet weak var vwBorderLineView: UIView!
    @IBOutlet weak var lblErrorMessage: UILabel!
    @IBOutlet weak var imgPreIcon: UIImageView!
    @IBOutlet weak var txtInputField: UITextField!
    @IBOutlet weak var imgPostIcon: UIImageView!
    @IBOutlet weak var btnPasswordVisibility: UIButton!
    
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
        vwContentContainer.fixInViewOTextField(self)
    }

    public func initText(preImage:UIImage?, placeHolder:String?, isPassword:Bool){
        vwBorderLineView.backgroundColor = .lightGray
        txtInputField.delegate = self
        imgPreIcon.isHidden = true
        lblErrorMessage.isHidden = true
        lblErrorMessage.textColor = .gray
        txtInputField.placeholder = placeHolder
        imgPreIcon.image = UIImage.init(named: "OTextField_envelope.fill", in: .module, compatibleWith: nil)!
        imgPostIcon.image = UIImage.init(named: "OTextField_eye.slash", in: .module, compatibleWith: nil)!

        if preImage != nil {
            imgPreIcon.isHidden = false
            imgPreIcon.image = preImage

        }else{
            imgPreIcon.isHidden = true
        }
        if placeHolder != nil {
            txtInputField.placeholder = placeHolder
        }else{
            txtInputField.placeholder = ""
            
        }
        if isPassword {
            btnPasswordVisibility.isHidden = false
            imgPostIcon.isHidden = false
            txtInputField.isSecureTextEntry = true
        }else{
            btnPasswordVisibility.isHidden = true
            imgPostIcon.isHidden = true
            txtInputField.isSecureTextEntry = false

        }

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
        vwBorderLineView.backgroundColor = .red
        if withMessage != nil {
            lblErrorMessage.isHidden = false
            lblErrorMessage.text = withMessage
            lblErrorMessage.textColor = .red
        }else{
            lblErrorMessage.isHidden = true
            lblErrorMessage.textColor = .gray

        }

    }
    public func success(withMessage: String? = nil){
        vwBorderLineView.backgroundColor = .green
        if withMessage != nil {
            lblErrorMessage.isHidden = false
            lblErrorMessage.text = withMessage
            lblErrorMessage.textColor = .green
        }else{
            lblErrorMessage.isHidden = true
            lblErrorMessage.textColor = .gray

        }

    }
    public func clearMessage(){
        vwBorderLineView.backgroundColor = .lightGray
        lblErrorMessage.isHidden = true
        lblErrorMessage.textColor = .gray

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
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        clearMessage()
    }
}
