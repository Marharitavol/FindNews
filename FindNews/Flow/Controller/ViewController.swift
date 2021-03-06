//
//  ViewController.swift
//  FindNews
//
//  Created by Rita on 20.01.2022.

import UIKit
import SnapKit
import SafariServices

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let repository = Repository()
    var articles = [Article]()
    var url = "https://newsapi.org/v2/top-headlines?country=ua&apiKey=4a2d5b1d317f49938cd13e2f6c8d76d1"
    let secondVC = FilterViewController()
    let myRefreshControl = UIRefreshControl()
    var fetchingMore = false
    var newUrl = ""
    var page = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        fetchData(url: url)
        setupScreen()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(favoriteTapped))
        myRefreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        reloadView()
        title = "News App"
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        fetchData(url: url)
        sender.endRefreshing()
    }
    
    func fetchData(url: String) {
        repository.fetchData(url: url) { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(articles)
            }
        }
    }
    
    func showArticle(url: String) {
        if let url = URL(string: url) {
//            let config = SFSafariViewController.Configuration()
//            let vc = SFSafariViewController(url: url, configuration: config)
            let vc = NewsDetailViewController(url: url)
//            present(vc, animated: true)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func addTapped() {
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @objc func favoriteTapped() {
        let favorite = FavoriteNewsViewController()
        navigationController?.pushViewController(favorite, animated: true)
    }
    
    private func reloadView() {
        secondVC.callback = { url in
            self.url = url
            self.fetchData(url: url)
            self.newUrl = url
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupScreen() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifierCell)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifierCell) as! TableViewCell
        let article = articles[indexPath.row]
        cell.configure(article: article)
        
        cell.faviriteTapped = {
            self.repository.saveArticleToBD(article)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        showArticle(url: article.url)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            //fetchingMore = true
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        page += 1
        var url = self.newUrl
        url += "&page=\(self.page)"
        repository.fetchData(url: url) { (articles) in
            self.articles.append(contentsOf: articles)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.fetchingMore = false
            }
        }
    }
}

