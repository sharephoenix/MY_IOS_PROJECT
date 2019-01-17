//
//  RXTableViewController.swift
//  SwiftDemo
//
//  Created by phoenix on 2019/1/9.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class RXTableViewController: BaseViewController {

    //tableView对象
    private var tableView: UITableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)

    //歌曲列表数据源
    private let musicListViewModel = MusicListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RXTableView"
        tableView.backgroundColor = .groupTableViewBackground
        view.addSubview(tableView)
        tableView.register(MusicCell.self, forCellReuseIdentifier: "musicCell")
        //将数据源数据绑定到tableView上
        musicListViewModel.data
            .bind(to: tableView.rx.items(cellIdentifier: "musicCell")) { _, music, cell in
                cell.textLabel?.text = music.name
                cell.detailTextLabel?.text = music.singer
            }.disposed(by: disposeBag)

        //tableView点击响应
        tableView.rx.modelSelected(Music.self).subscribe(onNext: { music in
            print("你选中的歌曲信息【\(music)】")
        }).disposed(by: disposeBag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

class MusicCell: UITableViewCell {

}

//歌曲列表数据源
struct MusicListViewModel {
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树")
        ])
}

//歌曲结构体
struct Music {
    let name: String //歌名
    let singer: String //演唱者

    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

//实现 CustomStringConvertible 协议，方便输出调试
extension Music: CustomStringConvertible {
    var description: String {
        return "name：\(name) singer：\(singer)"
    }
}
