//
//  WebViewNewsTableViewCell.swift
//  MamNon
//
//  Created by Truong Thang on 22/09/2022.
//

import UIKit
import WebKit

class WebViewNewsTableViewCell: UITableViewCell, WKNavigationDelegate {
    @IBOutlet weak var viewWebView: UIView!
    var newsModel:NewsModel?
    var updateHeightLoadWebView:(()-> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(newsModel:NewsModel?) {
        self.newsModel = newsModel
        self.loadWebviewHtml()
    }
    
    func loadWebviewHtml() {
        if self.newsModel?.height ?? 0 > 0 {
            
        }else {
            let config = WKWebViewConfiguration()
            let webView = WKWebView(frame: .zero, configuration: config)
            webView.translatesAutoresizingMaskIntoConstraints = false
            webView.navigationDelegate = self
            webView.scrollView.isScrollEnabled = false
            self.viewWebView.addSubview(webView)
            NSLayoutConstraint.activate([
                webView.leadingAnchor.constraint(equalTo: viewWebView.leadingAnchor),
                webView.topAnchor.constraint(equalTo: viewWebView.topAnchor),
                webView.rightAnchor.constraint(equalTo: viewWebView.rightAnchor),
                webView.bottomAnchor.constraint(equalTo: viewWebView.bottomAnchor)
            ])
            webView.backgroundColor = .clear
            webView.scrollView.backgroundColor = .clear
            webView.isOpaque = false
            webView.loadHTMLString(self.newsModel?.detail ?? "", baseURL: nil)
        }
           
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            let height = webView.scrollView.contentSize.height
            self.newsModel?.height = height + 40
            self.updateHeightLoadWebView?()
        }
    }
    
}
