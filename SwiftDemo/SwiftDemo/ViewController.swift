//
//  ViewController.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/20.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactiveSwift

class ViewController: UIViewController {

    var clickBtn: UIButton?
    let disposeBag = DisposeBag()
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!

    @objc dynamic var message = "hangge.com"
    //用于标记是奇数、还是偶数
    var isOdd = true

    //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
    var factory: Observable<Int>?

    override func viewDidLoad() {
        super.viewDidLoad()
        clickBtn = UIButton.init(frame: CGRect.init(x: 0, y: 100, width: 100, height: 100))
        clickBtn?.addTarget(self, action: #selector(test), for: .touchUpInside)
        clickBtn?.backgroundColor = UIColor.red
        guard let btn = clickBtn else {
            return
        }
        view.addSubview(btn)

        // 按钮点击序列
//        let taps: Observable<Void> = btn.rx.tap.asObservable()
//
//        // 每次点击后弹出提示框
//        taps.subscribe(onNext: {
//            print("asdf")
//        })

    }

    @objc fileprivate func test() {
        test12()
    }
    var primes: Set<Int>?
    private func test12() {
        primes = [2, 3, 5, 7]
         let x = 5
        guard let vs = primes else {
            return
        }
        if vs.contains(x) {
            print("\(String(describing: primes)) is prime!")
         } else {
            print("\(String(describing: primes)). Not prime.")
         }
         // Prints "5 is prime!"
    }
    private func test11() {
        let mutableProperty = MutableProperty(1)
        mutableProperty.producer.startWithValues({ (value) in
            print("didSetValue+\(value)")
        })

        print(mutableProperty.withValue {$0})
        mutableProperty.value = 99
        print(mutableProperty.value)
    }

    private func test10() {
        let mutableProperty = MutableProperty(1)
        mutableProperty.signal.observeValues { (value) in
            print("didSetValue+\(value)")
        }

        print(mutableProperty.withValue {$0})
        mutableProperty.value = 99
        print(mutableProperty.value)
    }
    private func test9() {

        textField.rx.text.orEmpty
            .subscribe(onNext: { text in
                if text == "" {
                    print("show empty")
                }
                print("-----")
                print(text)
                print("-----")
            }).disposed(by: self.disposeBag)

    }
    let str: Variable<String?> = Variable(nil)
    private func test8() {
        str.asObservable().filter({ (str) -> Bool in
            return str == "alexluan"
        }).map {(str: String?) -> String? in
            guard let a = str else {
                return "888"
            }
            return a + a
            }.subscribe { (str) in
                print(str)
        }
        str.value = "alexluan"
        //        test7()
    }
    private func test7() {
        let disposeBag = DisposeBag()
        let subject = BehaviorSubject(value: "🔴")

        subject
            .subscribe { print("Subscription: 1 Event:", $0) }
            .disposed(by: disposeBag)

        subject.onNext("🐶")
        subject.onNext("🐱")
    }

    private func test6() {
        let disposeBag = DisposeBag()
        let subject = AsyncSubject<String>()

        subject
            .subscribe { print("Subscription: 1 Event:", $0) }
            .disposed(by: disposeBag)

        subject.onNext("🐶")
        subject.onNext("🐱")
        subject.onNext("🐹")
        subject.onCompleted()
    }
    private func test5() {
        let disposeBag = DisposeBag()

        //第1个Observable，及其订阅
        let observable1 = Observable.of("A", "B", "C")
        observable1.subscribe { event in
            print(event)
            }.disposed(by: disposeBag)

        //第2个Observable，及其订阅
        let observable2 = Observable.of(1, 2, 3)
        observable2.subscribe { event in
            print(event)
            }.disposed(by: disposeBag)

    }

    private func test4() {
        let observable = Observable.of("A", "B", "C")

        //使用subscription常量存储这个订阅方法
        let subscription = observable.subscribe { event in
            print(event)
        }

        //调用这个订阅的dispose()方法
        subscription.dispose()

    }

    private func test3() {
        //观察者
        let observer: AnyObserver<String> = AnyObserver { (event) in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }

        let observable = Observable.of("A", "B", "C")
        observable.subscribe(observer)

    }

    private func test2odd() {
         factory = Observable.deferred {

            //让每次执行这个block时候都会让奇、偶数进行交替
            self.isOdd = !self.isOdd

            //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
            if self.isOdd {
                return Observable.of(1, 3, 5, 7)
            } else {
                return Observable.of(2, 4, 6, 8)
            }
        }

        //第1次订阅测试
        factory?.subscribe { event in
            print(Thread.current)
            print("\(self.isOdd)", event)
        }
        //第2次订阅测试
        factory?.subscribe { event in
            print(Thread.current)
            print("\(self.isOdd)", event)
        }

    }

    private func test1() {
//        //5秒种后发出唯一的一个元素0
//        let observable = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
//        observable.subscribe { event in
//            print(event)
//        }
        //延时5秒种后，每隔1秒钟发出一个元素
        let observable = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
        observable.subscribe { event in
            print(event)
        }

    }

    private func test0() {
    //当一个订阅者订阅这个Observable对象的时候，就会将订阅者作为参数传入这个block来执行一些内容
    let observable = Observable<String>.create {observer in
    //对订阅者发出了.next事件，且携带了一个数据"hangge.com"
    observer.onNext("hangge.com")
    //对订阅者发出了.completed事件
    observer.onCompleted()
    //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
    return Disposables.create()
    }

    //订阅测试
    observable.subscribe { (str)in
    print(str)
    print(str)
    }
    }

}
