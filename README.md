# OTextField
An improved text field with simple features but essentials, includes  pre image, failure and success messages, and password eye ready

## Installiation
To use this package, import `https://github.com/omaralqasmi/OTextField.git` in Swift Package Manager


## Usage Example

### Step 1. add a UIView to your viewController ad give it hieght constraint with low priority
### Step 2. change the class of your UIView controller to OTextField and the module to OTextField
### Step 3. Connect your UIView outlet to your viewController class
```swift
    @IBOutlet weak var oText: OTextField!
```
make sure the type is OTextField
### Step 4. initiate your oText in your viewDidLoad
```swift
    oText.initText(preImage: .text, placeHolder: "Enter your username", isPassword: false)
```
or using all parameter options
```swift
    oText.initText(preImage: .custom_requires_customPreImage, customPreImage: UIImage(systemName: "person"), placeHolder: "My Place holder", isPassword: true, message: "A message shown under the text field", textFieldViewHeight: 60, borderColor: .black, iconsColor: .blue, messageColor: .black, successColor: .green, errorColor: .red)
```
if you want to use textField delegate you can connect it here also
```swift
        oText.txtInputField.delegate = self
```
### To show error message:
```swift
        oText.failure()
```
or
```swift
        oText.failure(withMessage: "Please check your input")
```
### To show success message:
```swift
        oText.success()
```
or
```swift
        oText..success(withMessage: "Good to go")
```
### if you are using text field delegates make sure to call clear error message in your text will change otherwise it will not clear after an error
```swift
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        oText.clearMessage()
        return true
    }
```
