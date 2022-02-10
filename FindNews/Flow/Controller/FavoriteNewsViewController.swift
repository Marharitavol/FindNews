//
//  FavoriteNewsViewController.swift
//  FindNews
//
//  Created by Rita on 09.02.2022.
//

import UIKit
import RealmSwift
import SnapKit

class FavoriteNewsViewController: UIViewController {

    let tableView = UITableView()
    let repository = Repository()
    private var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifierCell)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        repository.fetchFavorite { (article) in
            guard let article = article else { return }
            self.articles = article
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension FavoriteNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifierCell) as? TableViewCell else { return UITableViewCell() }
        let article = articles[indexPath.row]
        cell.configure(article: article)
        return cell
    }
}
