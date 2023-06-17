# OTextField
An improved text field with simple features but essentials, includes  pre image, failure and success messages, and password eye ready

![DEMO0](https://user-images.githubusercontent.com/36946797/246603431-b857c47a-6121-4081-b02c-4c168b995a7b.png)
![DEMO1](https://user-images.githubusercontent.com/36946797/246602624-a8617d05-dd9b-449a-81f9-d5e2fe4491b9.png)
![DEMO2](https://user-images.githubusercontent.com/36946797/246602630-6271b8f3-f920-43bf-90d1-7c92300fd652.png)
![DEMO3](https://user-images.githubusercontent.com/36946797/246602632-342e11d4-e07a-4766-8fdb-3349b155af97.png)

## Installiation
To use this package, import `https://github.com/omaralqasmi/OTextField.git` in Swift Package Manager


## Usage Example

### Step 1. add a UIView to your viewController ad give it hieght constraint with low priority
![OTEXTFIELD](https://user-images.githubusercontent.com/36946797/246602661-e70e35d8-53ed-4b27-83ee-56c831c08cf6.png)
### Step 2. change the class of your UIView controller to OTextField and the module to OTextField
![OTEXTFIELD](https://user-images.githubusercontent.com/36946797/246602669-86194d68-a4f4-4e75-814f-cf3addf46b1f.png)
### Step 3. Connect your UIView outlet to your viewController class
### Step 4. import OTextField
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
![OTEXTFIELD](https://user-images.githubusercontent.com/36946797/246602673-7eb74ddf-4a1e-4ef4-850a-f451d55cc6ae.png)
