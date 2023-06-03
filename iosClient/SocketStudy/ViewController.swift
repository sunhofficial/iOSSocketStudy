//
//  ViewController.swift
//  SocketStudy
//
//  Created by 235 on 2023/06/03.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    let socketViewModel = SocketViewModel()
    lazy var textfield : UITextField = {
        let textfield = UITextField()
        textfield.text = "Server에 데이터를 보내봐요!"
        textfield.textColor = .systemGray2
        textfield.borderStyle = .roundedRect
//        textfield.clearButtonMode = .whileEditing
        textfield.delegate = self
        return textfield
    }()
    lazy var messageLabel : UILabel = {
        let label  = UILabel()
        label.textColor = .blue
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setviewcomponet()
        setupSocketEventHandlers()
        socketViewModel.sendMessage("hello server areyou listening?")
    }
    private func setviewcomponet(){
        [textfield, messageLabel].forEach {
            self.view.addSubview($0)
        }
        textfield.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().offset(100)
        }
        messageLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(30)
           $0.top.equalTo(textfield.snp.bottom).offset(20)
        }
    }
}
extension ViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Server에 데이터를 보내봐요!"{
            textField.text = nil
            textField.textColor = .black
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        socketViewModel.sendMessage(textField.text!)
        return true
    }
}

extension ViewController {
    // Socket 이벤트 수신 처리
    func setupSocketEventHandlers() {
        socketViewModel.socket.on("message") { [weak self] data, ack in
            if let message = data.first as? String {
                self?.updateMessageLabel(with: message)
            }
        }
    }
    func updateMessageLabel(with message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.messageLabel.text = message
        }
    }
}
