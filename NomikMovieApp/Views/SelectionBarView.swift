//
//  SelectionBarView.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/12.
//

import UIKit
import Combine

class SelectionBarView: UIView {
    
    // MARK: - Variables
    var selectionBarTap = PassthroughSubject<String, Never>()
    
    //didset偵測selectTap變化 i與selectTap比對 TitleColor與isActive 做三元運算 再賦值
    private var selectTap: Int = 0 {
        didSet {
            for i in 0..<selectionButtons.count {
                UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut) { [weak self] in
                    self?.selectionButtons[i].setTitleColor((self?.selectTap == i ? .label : .secondaryLabel), for: .normal)
                    self?.leadingAnchors[i].isActive = (self?.selectTap == i ? true : false)
                    self?.trailingAnchors[i].isActive = (self?.selectTap == i ? true : false)
                    self?.layoutIfNeeded()

                }
            }
        }
    }
    
    private var selectionButtons: [UIButton] = ["Now Playing", "Upcoming", "Top Rated", "Popular"].map{ title in
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }
    
    //宣告leadingAnchors和trailingAnchors佈局的清單
    private var leadingAnchors: [NSLayoutConstraint] = []
    private var trailingAnchors: [NSLayoutConstraint] = []
    
    // MARK: - UI Components
    private lazy var selectionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: selectionButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private let bottomLineBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemOrange
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(selectionStackView)
        addSubview(bottomLineBar)
        
        configureUI()
        selectButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func selectButton() {
        for (index, button) in selectionStackView.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
            
            if index == selectTap {
                button.setTitleColor(.label, for: .normal)
            } else {
                button.setTitleColor(.secondaryLabel, for: .normal)
            }
            
            button.addTarget(self, action: #selector(didTapTab(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Selectors
    @objc private func didTapTab(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }
        
        //按鈕按下後觸發selectTap和selectionPublisher
        switch text {
        case "Now Playing":
            selectionBarTap.send("Now Playing")
            DispatchQueue.main.async {
                self.selectTap = 0
            }
        case "Upcoming":
            selectionBarTap.send("Upcoming")
            DispatchQueue.main.async {
                self.selectTap = 1
            }
        case "Top Rated":
            selectTap = 2
            selectionBarTap.send("Top Rated")
        default:
            selectTap = 3
            selectionBarTap.send("Popular")
        }
    }
        
    // MARK: - UI Setup
    private func configureUI() {
        
        //選單下方的bar的leadingAnchor和trailingAnchor 依照Button數量去儲存佈局到leadingAnchors和trailingAnchors的清單內
        for i in 0..<selectionButtons.count {
            let leadingAnchor = bottomLineBar.leadingAnchor.constraint(equalTo: selectionStackView.arrangedSubviews[i].leadingAnchor)
            let trailingAnchor = bottomLineBar.trailingAnchor.constraint(equalTo: selectionStackView.arrangedSubviews[i].trailingAnchor)
            leadingAnchors.append(leadingAnchor)
            trailingAnchors.append(trailingAnchor)
        }
        
        NSLayoutConstraint.activate([
            selectionStackView.topAnchor.constraint(equalTo: topAnchor),
            selectionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            selectionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            selectionStackView.heightAnchor.constraint(equalToConstant: 30),
            
            //選單下方的bar初始位置佈局
            leadingAnchors[0],
            trailingAnchors[0],
            bottomLineBar.topAnchor.constraint(equalTo: selectionStackView.arrangedSubviews[0].bottomAnchor),
            bottomLineBar.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
}
