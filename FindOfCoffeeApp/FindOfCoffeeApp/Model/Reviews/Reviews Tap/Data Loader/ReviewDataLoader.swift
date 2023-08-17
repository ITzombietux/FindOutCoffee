//
//  ReviewDataLoader.swift
//  FindOfCoffeeApp
//
//  Created by zombietux on 2020/12/15.
//

import Foundation
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift
import FirebaseCore

class ReviewDataLoader {
    private let db = Firestore.firestore()
    private let storage = Storage.storage()

    var notices: [Notice] = [
        Notice(id: "공지1",
               title: "꼭 읽어야 할 공지",
               secondaryTitle: "필독",
               subtitle: "후기를 적는 방법을 알아보세요!🙋",
               thumbnail: "공지8",
               text: "커피를 찾아서 후기를 적는 방법은?!\n후기를 어떻게 적고 사용자님들께 보여드리면 최고의 정보를 드릴 수 있을지 고민하다, 올바른 프로세스가 정립이 될 때 까지는 인생 커피를 찾은 사용자님들의 소중한 후기를 개발자인 제가 받아 확인 후 올리기로 했습니다.\n\n앞으로 사용자님들께서 사용하기 편한 앱을 만들기 위해 최선을 다하겠습니다. 귀엽게 봐주시고 새해 복 많이 받으세요!🙇‍♂🙇‍♂🙇‍♂"),
        Notice(id: "공지2",
               title: "이벤트 참여하고 쿠폰 받기",
               secondaryTitle: "이벤트",
               subtitle: "이벤트를 참여하고 별다방 쿠폰을?!🥤🥤🥤",
               thumbnail: "공지5",
               text: "커피를 찾아서에서 오픈 이벤트를 열었어요!\n\n소중한 후기를 5번 적어주시는 사용자님께 별다방 아메리카노 쿠폰을 보내드립니다. 후기를 적으실 때 양식의 사용자 카톡 아이디를 꼭!! 입력하셔서 소중한 후기 남기고 별다방 쿠폰을 받으세요!!🤩🤩"),
        Notice(id: "공지3",
               title: "우리 카페 후기도 등록하는 방법은?",
               secondaryTitle: "카페 등록",
               subtitle: "개발자가 직접 후기를 적습니다😎",
               thumbnail: "공지7",
               text: "우리나라에 있는 모든 카페의 정보를 다 담지 못한 점 죄송하게 생각합니다..😵\n\n앱 하단 더보기->우리 카페 등록 요청에서 간단한 정보를 개발자에게 보내주시면 빠른 시간 내에 등록을 해드리고 멀지 않은 곳이라면 개발자가 직접 커피를 찾아 떠나는 시간을 갖도록 할게요. 많은 사장님들의 요청 기다릴게요!!"),
    ]
    var cafes: [Cafe] = [
        Cafe(id: "스타벅스", title: "스타벅스", subtitle: "커피가 아니라 문화를 판다", thumbnail: "스타벅스"),
        Cafe(id: "이디야커피", title: "이디야커피", subtitle: "젊음의 느낌표 '이디야'", thumbnail: "이디야커피"),
        Cafe(id: "투썸", title: "투썸", subtitle: "나만의 즐거움을 만나다", thumbnail: "투썸"),
        Cafe(id: "빽다방", title: "빽다방", subtitle: "커피를 쏠 수 있는 즐거움", thumbnail: "빽다방"),
        Cafe(id: "매머드", title: "매머드", subtitle: "brain needs special coffee", thumbnail: "매머드"),
        Cafe(id: "커피베이", title: "커피베이", subtitle: "당신의 일상을 작은 커피 여행으로", thumbnail: "커피베이"),
        Cafe(id: "탐앤탐스", title: "탐앤탐스", subtitle: "활력과 감성을 충전한다", thumbnail: "탐앤탐스"),
        Cafe(id: "파스쿠찌", title: "파스쿠찌", subtitle: "이탈리안 초콜릿의 진한 맛", thumbnail: "파스쿠찌"),
        Cafe(id: "할리스커피", title: "할리스커피", subtitle: "Holiday in Hollys", thumbnail: "할리스커피"),
        Cafe(id: "커피에반하다", title: "커피에반하다", subtitle: "커피에반하다", thumbnail: "커피에반하다"),
        Cafe(id: "엔제리너스", title: "엔제리너스", subtitle: "천사처럼 부드럽고 달콤함 커피", thumbnail: "엔제리너스"),
        Cafe(id: "요거프레소", title: "요거프레소", subtitle: "요거트와 커피의 만남", thumbnail: "요거프레소"),
        Cafe(id: "더벤티", title: "더벤티", subtitle: "합리적인 가격에 맛있는 한 잔", thumbnail: "더벤티"),
        Cafe(id: "커피나무", title: "커피나무", subtitle: "커피행 열차를 탈 준비를 하시죠", thumbnail: "커피나무"),
//        Cafe(id: "셀렉토커피", title: "셀렉토커피", subtitle: "Select Your Americano", thumbnail: "셀렉토커피"),
        Cafe(id: "메가커피", title: "메가커피", subtitle: "더 크고, 더 맛있다!", thumbnail: "메가커피"),
        Cafe(id: "토프레소", title: "토프레소", subtitle: "No.1 FRESH COFFEE", thumbnail: "토프레소"),
        Cafe(id: "공차", title: "공차", subtitle: "Blended Happiness With Tea", thumbnail: "공차"),
        Cafe(id: "커피빈", title: "커피빈", subtitle: "Coffee Bean & Tea Leaf", thumbnail: "커피빈"),
//        Cafe(id: "폴바셋", title: "폴바셋", subtitle: "Cup to Seed", thumbnail: "폴바셋"),
    ]
    var tastes: [Taste] = [
        Taste(id: "1", title: "에스프레소", subtitle: "#신속#향과맛", thumbnail: "에스프레소"),
        Taste(id: "2", title: "달달", subtitle: "#달콤#부드러움", thumbnail: "달달"),
        Taste(id: "3", title: "과일", subtitle: "#새콤달콤#싱싱함", thumbnail: "과일"),
        Taste(id: "4", title: "콜드브루", subtitle: "#추출#깊은 맛", thumbnail: "콜드브루-1"),
        Taste(id: "5", title: "티바나", subtitle: "#유기농#건강", thumbnail: "티바나"),
        Taste(id: "6", title: "요거트", subtitle: "#깔끔한#달콤함", thumbnail: "요거트"),
        Taste(id: "7", title: "버블티", subtitle: "#톡특한#식감", thumbnail: "버블티")
    ]
}

