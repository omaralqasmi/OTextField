import UIKit

public class OTextField: UIView {

    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var vwBorderLine: UIView!
    @IBOutlet weak var txtFieldInput: UITextField!
    @IBOutlet weak var imgPRE: UIImageView!
    @IBOutlet weak var lblStatusMessage: UILabel!
    @IBOutlet weak var imgPOST: UIImageView!
    @IBOutlet weak var btnShowAndHidePassword: UIButton!
    
    
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
        vwContainer.fixInViewOTextField(self)
    }

    public func initText(preImage:UIImage?, placeHolder:String?, isPassword:Bool){
        vwBorderLine.backgroundColor = .lightGray
        txtFieldInput.delegate = self
        imgPRE.isHidden = true
        lblStatusMessage.isHidden = true
        lblStatusMessage.textColor = .gray
        txtFieldInput.placeholder = placeHolder
        imgPRE.image = UIImage.init(named: "OTextField_envelope.fill", in: .module, compatibleWith: nil)!
        imgPOST.image = UIImage.init(named: "OTextField_eye.slash", in: .module, compatibleWith: nil)!

        if preImage != nil {
            imgPRE.isHidden = false
            imgPRE.image = preImage

        }else{
            imgPRE.isHidden = true
        }
        if placeHolder != nil {
            txtFieldInput.placeholder = placeHolder
        }else{
            txtFieldInput.placeholder = ""
            
        }
        if isPassword {
            btnShowAndHidePassword.isHidden = false
            imgPOST.isHidden = false
            txtFieldInput.isSecureTextEntry = true
        }else{
            btnShowAndHidePassword.isHidden = true
            imgPOST.isHidden = true
            txtFieldInput.isSecureTextEntry = false

        }

    }
    @IBAction func btnActionShowOrHidePassword(_ sender: Any) {
        txtFieldInput.isSecureTextEntry = !txtFieldInput.isSecureTextEntry
        if txtFieldInput.isSecureTextEntry {
            imgPOST.image = UIImage.init(named: "OTextField_eye.slash", in: .module, compatibleWith: nil)!

        }else{
            imgPOST.image = UIImage.init(named: "OTextField_eye", in: .module, compatibleWith: nil)!
        }

    }
    public func getText() -> String {
        return txtFieldInput.text ?? ""
    }
    public func failure(withMessage: String? = nil) {
        vwBorderLine.backgroundColor = .red
        if withMessage != nil {
            lblStatusMessage.isHidden = false
            lblStatusMessage.text = withMessage
            lblStatusMessage.textColor = .red
        }else{
            lblStatusMessage.isHidden = true
            lblStatusMessage.textColor = .gray

        }

    }
    public func success(withMessage: String? = nil){
        vwBorderLine.backgroundColor = .green
        if withMessage != nil {
            lblStatusMessage.isHidden = false
            lblStatusMessage.text = withMessage
            lblStatusMessage.textColor = .green
        }else{
            lblStatusMessage.isHidden = true
            lblStatusMessage.textColor = .gray

        }

    }
    public func clearMessage(){
        vwBorderLine.backgroundColor = .lightGray
        lblStatusMessage.isHidden = true
        lblStatusMessage.textColor = .gray

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
