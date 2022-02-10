//
//  FilterViewController.swift
//  FindNews
//
//  Created by Rita on 22.01.2022.
//

import UIKit
import SnapKit

class FilterViewController: UIViewController {
    
    var pickerCategory = UIPickerView()
    var categoryLabel = UILabel()
    var pickerCountry = UIPickerView()
    var countryLabel = UILabel()
    let button = UIButton(type: .system)
    var callback: ((String) -> Void)?
    
    let country = ["cz","pl","ua","us","ru","za"]
    let category = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    lazy var selectedCategory = category.first
    lazy var selectedCountry = country.first
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setup()
        pickerCategory.delegate = self
        pickerCategory.dataSource = self
        
        pickerCountry.delegate = self
        pickerCountry.dataSource = self
        
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc func searchButtonTapped() {
        guard let country = selectedCountry, let category = selectedCategory else { return }
        callback?("https://newsapi.org/v2/top-headlines?country=\(country)&category=\(category)&sortBy=publishedAt&apiKey=4a2d5b1d317f49938cd13e2f6c8d76d1")
        navigationController?.popViewController(animated: true)
    }
    
    
    func setup() {
        let stackView = UIStackView(arrangedSubviews: [categoryLabel, pickerCategory, countryLabel, pickerCountry, UIView()])
        stackView.axis = .vertical
        stackView.spacing = 8
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(100)
        }
        categoryLabel.text = "category"
        countryLabel.text = "country"
        
        pickerCategory.snp.makeConstraints { (make) in
            make.height.equalTo(150)
        }
        pickerCountry.snp.makeConstraints { (make) in
            make.height.equalTo(150)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
        }
        countryLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
        }
        
        view.addSubview(button)
        button.setTitle("Search", for: .normal)
        button.layer.backgroundColor = CGColor(gray: 0.50, alpha: 0.50)
        button.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(45)
            make.height.equalTo(65)
            make.width.equalToSuperview()
        }
        
        
    }
}

extension FilterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerCategory {
            return category.count
        } else {
            return country.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerCategory {
            return category[row]
        } else {
            return country[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == pickerCategory {
            selectedCategory = category[row]
        } else {
            selectedCountry = country[row]
        }
    }
}
