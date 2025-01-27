//
//  ViewController.swift
//  UIKitFrameDemo
//
//  Created by 김용해 on 1/24/25.
//

import UIKit

class ViewController: UIViewController {

    private let profileSize: CGFloat = 70
    private let totalWidthPadding: CGFloat = 30 // 전체 크기를 지정 여백을 어떻게 하는지 모르겠음
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // UIView
        let myProfile = UIView()
        myProfile.translatesAutoresizingMaskIntoConstraints = false
        myProfile.backgroundColor = .gray
        myProfile.alpha = 0.5
        myProfile.layer.cornerRadius = profileSize / 2
        
        // UIImage
        let myImageInProfile = UIImageView()
        myImageInProfile.image = UIImage(systemName: "person.fill")
        myImageInProfile.translatesAutoresizingMaskIntoConstraints = false
        myImageInProfile.tintColor = .white
        
        //test UIView
        let test1 = UIView()
        test1.translatesAutoresizingMaskIntoConstraints = false
        test1.backgroundColor = .green
        
        let test2 = UIView()
        test1.translatesAutoresizingMaskIntoConstraints = false
        test2.backgroundColor = .blue
        
        let test3 = UIView()
        test1.translatesAutoresizingMaskIntoConstraints = false
        test3.backgroundColor = .yellow
        
        
        // UIStackView
        let myHStackView = UIStackView()
        myHStackView.translatesAutoresizingMaskIntoConstraints = false
        myHStackView.axis = .horizontal
        myHStackView.alignment = .top
        myHStackView.distribution = .equalSpacing
        
        myHStackView.isLayoutMarginsRelativeArrangement = true
        
        // 내용물 구성
        myHStackView.addArrangedSubview(test1)
        myHStackView.addArrangedSubview(test2)
        myHStackView.addArrangedSubview(test3)

        
        // Collection View는 난이도가 너무 높음 UIStackView로 만들겠습니다
        let myMainGridView = UIStackView()
        myMainGridView.translatesAutoresizingMaskIntoConstraints = false
        myMainGridView.axis = .vertical
        myMainGridView.backgroundColor = .gray
        myMainGridView.distribution = .fillEqually
        
        // Layout Padding 부분입니다
        myMainGridView.isLayoutMarginsRelativeArrangement = true
        
        // 첫번째 Grid 안에 HStack
        let myFirstHStackView = UIStackView()
        myFirstHStackView.translatesAutoresizingMaskIntoConstraints = false
        myFirstHStackView.isLayoutMarginsRelativeArrangement = true
        myFirstHStackView.axis = .horizontal
        myFirstHStackView.backgroundColor = .brown
        myFirstHStackView.distribution = .fillEqually
        myFirstHStackView.spacing = 10
        myFirstHStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        //두번째
        let mySecondHStackView = UIStackView()
        mySecondHStackView.translatesAutoresizingMaskIntoConstraints = false
        mySecondHStackView.isLayoutMarginsRelativeArrangement = true
        mySecondHStackView.axis = .horizontal
        mySecondHStackView.backgroundColor = .yellow
        mySecondHStackView.distribution = .fillEqually
        mySecondHStackView.spacing = 10
        mySecondHStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // 세번째
        let myThirdHStackView = UIStackView()
        myThirdHStackView.translatesAutoresizingMaskIntoConstraints = false
        myThirdHStackView.isLayoutMarginsRelativeArrangement = true
        myThirdHStackView.axis = .horizontal
        myThirdHStackView.backgroundColor = .black
        myThirdHStackView.distribution = .fillEqually
        myThirdHStackView.spacing = 10
        myThirdHStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        
        // MainGridview 에 들어갈 Gridcell 입니다
        let testGridBox1 = UIView()
        testGridBox1.backgroundColor = .blue
        testGridBox1.translatesAutoresizingMaskIntoConstraints = false
        
        let testGridBox2 = UIView()
        testGridBox2.backgroundColor = .cyan
        testGridBox2.translatesAutoresizingMaskIntoConstraints = false
        
        myFirstHStackView.addArrangedSubview(testGridBox1)
        myFirstHStackView.addArrangedSubview(testGridBox2)
        
        let testGridBox3 = UIView()
        testGridBox3.backgroundColor = .darkGray
        testGridBox3.translatesAutoresizingMaskIntoConstraints = false
        let testGridBox4 = UIView()
        testGridBox4.backgroundColor = .lightGray
        testGridBox4.translatesAutoresizingMaskIntoConstraints = false
        
        mySecondHStackView.addArrangedSubview(testGridBox3)
        mySecondHStackView.addArrangedSubview(testGridBox4)
        
        let testGridBox5 = UIView()
        testGridBox5.backgroundColor = .purple
        testGridBox5.translatesAutoresizingMaskIntoConstraints = false
        let testGridBox6 = UIView()
        testGridBox6.backgroundColor = .blue
        testGridBox6.translatesAutoresizingMaskIntoConstraints = false
        
        myThirdHStackView.addArrangedSubview(testGridBox5)
        myThirdHStackView.addArrangedSubview(testGridBox6)
        
        // Navigation frame
        let myNavigationView = UIStackView()
        myNavigationView.translatesAutoresizingMaskIntoConstraints = false
        myNavigationView.axis = .horizontal
        myNavigationView.alignment = .center
        myNavigationView.distribution = .equalSpacing
        myNavigationView.backgroundColor = .green
        
        let testNaviCircle1 = UIView()
        testNaviCircle1.backgroundColor = .white
        testNaviCircle1.translatesAutoresizingMaskIntoConstraints = false
        testNaviCircle1.layer.cornerRadius = 20
        
        let testNaviCircle2 = UIView()
        testNaviCircle2.backgroundColor = .white
        testNaviCircle2.translatesAutoresizingMaskIntoConstraints = false
        testNaviCircle2.layer.cornerRadius = 20
        
        let testNaviCircle3 = UIView()
        testNaviCircle3.backgroundColor = .white
        testNaviCircle3.translatesAutoresizingMaskIntoConstraints = false
        testNaviCircle3.layer.cornerRadius = 20
        
        let testNaviCircle4 = UIView()
        testNaviCircle4.backgroundColor = .white
        testNaviCircle4.translatesAutoresizingMaskIntoConstraints = false
        testNaviCircle4.layer.cornerRadius = 20
        
        myNavigationView.addArrangedSubview(testNaviCircle1)
        myNavigationView.addArrangedSubview(testNaviCircle2)
        myNavigationView.addArrangedSubview(testNaviCircle3)
        myNavigationView.addArrangedSubview(testNaviCircle4)

        
        // addSubView
        myProfile.addSubview(myImageInProfile)
        self.view.addSubview(myProfile)
        self.view.addSubview(myHStackView)
        self.view.addSubview(myMainGridView)
        self.view.addSubview(myNavigationView)
        
        // add SubView 첫번째 HStack
        myMainGridView.addArrangedSubview(myFirstHStackView)
        myMainGridView.addArrangedSubview(mySecondHStackView)
        myMainGridView.addArrangedSubview(myThirdHStackView)

        // UIView AutoLayour
        NSLayoutConstraint.activate([
            myProfile.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            myProfile.widthAnchor.constraint(equalToConstant: profileSize),
            myProfile.heightAnchor.constraint(equalToConstant: profileSize),
            myProfile.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: self.view.frame.width / 3)
        ])
        
        // UIImageView
        NSLayoutConstraint.activate([
            myImageInProfile.widthAnchor.constraint(equalToConstant: 60),
            myImageInProfile.heightAnchor.constraint(equalToConstant: 60),
            myImageInProfile.topAnchor.constraint(equalTo: myProfile.topAnchor,constant: profileSize / 8),
            myImageInProfile.centerXAnchor.constraint(equalTo: myProfile.centerXAnchor)
        ])
        
        // UIStackView
        NSLayoutConstraint.activate([
            myHStackView.heightAnchor.constraint(equalToConstant: 40),
            myHStackView.topAnchor.constraint(equalTo: myProfile.topAnchor, constant: 100),
            myHStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            myHStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            myHStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            
            // testBox size 주는 Task
            test1.widthAnchor.constraint(equalToConstant: view.frame.width / 5),
            test1.heightAnchor.constraint(equalToConstant: 30),
            test2.widthAnchor.constraint(equalToConstant: view.frame.width / 4),
            test2.heightAnchor.constraint(equalToConstant: view.frame.height),
            test3.widthAnchor.constraint(equalToConstant: view.frame.width / 5),
            test3.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            myMainGridView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.5),
            myMainGridView.topAnchor.constraint(equalTo: myHStackView.topAnchor, constant: 60),
            myMainGridView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            myMainGridView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
        ])
        
        // Navigation AutoLayout
        NSLayoutConstraint.activate([
            myNavigationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            myNavigationView.heightAnchor.constraint(equalToConstant: 80),
            myNavigationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            myNavigationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        // NaviCircle AutoLayout
        NSLayoutConstraint.activate([
            testNaviCircle1.widthAnchor.constraint(equalToConstant: 40),
            testNaviCircle1.heightAnchor.constraint(equalToConstant: 40),
            
            testNaviCircle2.widthAnchor.constraint(equalToConstant: 40),
            testNaviCircle2.heightAnchor.constraint(equalToConstant: 40),
            
            testNaviCircle3.widthAnchor.constraint(equalToConstant: 40),
            testNaviCircle3.heightAnchor.constraint(equalToConstant: 40),
            
            testNaviCircle4.widthAnchor.constraint(equalToConstant: 40),
            testNaviCircle4.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}

#Preview {
    ViewController()
}


//import UIKit
//
//class YongHaeViewController: UIViewController {
//    
//    let myRedView: UIView = UIView()
//    let myBlueView: UIView = UIView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.view.backgroundColor = .systemBackground
//        
//        myRedView.backgroundColor = .red
//        myRedView.translatesAutoresizingMaskIntoConstraints = false
//        
//        myBlueView.backgroundColor = .blue
//        myBlueView.translatesAutoresizingMaskIntoConstraints = false
//        
//        self.view.addSubview(myRedView)
//        self.view.addSubview(myBlueView)
//        
//        //배 열 안 에 쉼 표 꼭 찍 을 것 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//        NSLayoutConstraint.activate([
//            //redview constraints
//            myRedView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
//            myRedView.heightAnchor.constraint(equalToConstant: 150),
//            myRedView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
//            myRedView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
//            
//            //blueview constraints
//            myBlueView.widthAnchor.constraint(equalTo: self.myRedView.widthAnchor, multiplier: 0.5),
//            myBlueView.heightAnchor.constraint(equalTo: self.myRedView.heightAnchor, multiplier: 2.0),
//            myBlueView.topAnchor.constraint(equalTo: self.myRedView.bottomAnchor),
//            myBlueView.leadingAnchor.constraint(equalTo: self.myRedView.leadingAnchor),
//        ])
//    }
//
//}
