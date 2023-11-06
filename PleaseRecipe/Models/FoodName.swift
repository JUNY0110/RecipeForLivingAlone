//
//  FoodName.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/08.
//

import Foundation


enum FoodName: String, CustomStringConvertible {
    case sweetPotatoCreamCheeseGratin = "처치곤란 남은 고구마로 간편하게 만든 비주얼 메뉴! 고구마크림치즈그라탕"
    case eggplantPuffles = "간편하게 즐기는 가지부침개 레시피"
    case grilledBasilTomatoChickenBreast = "탄수화물 없는 그라탕 닭가슴살 듬뿍 넣어 만들어보세요, 바질토마토닭가슴살구이"
    case cabbageSaladBread = "아는 맛이라 더 무서운 양배추샐러드빵"
    case tofuPizza = "밀가루 없이 두부도우로 피자만들기, 두부피자"
    case cellophaneNoodlesStew = "돼지고기 듬뿍, 당면 듬뿍 초간단하게 끓이는 당면찌개"
    case spamDoenjang = "스팸+된장 조합 완전 강추! 스팸강된장 만들기"
    case chickenSteak = "쫄깃한 식감과 버터의 풍미가 느껴지는 닭고기스테이크"
    case spamKimchiFriedSushi = "간단하면서 든든한 스팸김치유부초밥"
    case seafoodBasilPasta = "맛있는 토마토 바질 소스로 해산물 바질 파스타를 만들어볼까요?(feat. 하인즈)"
    case springOnionPancakeWithWaterParsley = "봄날이 느껴지는 향긋함이 매력적인 미나리쪽파전"
    case stirFriedSquid = "[만개백과] EP. 51 쫄깃하고 매콤한 오징어볶음"
    
    case stirFriedPorkKimbap = "서진이네 보면서 침 흘리다 만든 제육김밥 (feat. 쌈장마요)"
    case eggRice = "[만개백과] EP. 52 영양가 있는 한그릇 요리, 계란밥"
    case riceWithPorkBellyAndSoySauce = "[만개백과] EP. 53 특별한 한그릇요리, 삼겹살간장덮밥"
    case seasonedRedBeanPasteSauce = "매일 먹어도 질리지 않는 대표 봄나물 취나물된장무침"
    case stirFriedSquidNoodleSoup = "[TV요리] 어남선생의 오징어볶음 황금레시피 칼국수면이랑 꼭 같이 드세요, 오징어볶음칼국수"
    case smokedDuckJell = "맛도 좋고 몸에도 좋은 부추와 환상궁합, 훈제오리주물럭"
    case kimchiFriedRice = "[만개백과] 반찬만들기 귀찮을 때 한끼 뚝딱! 김치볶음밥"
    case kimchiPilaf = "겨우내 보관한 맛있는 김치로 만든, 김치필라프 레시피 with LG 디오스 오브제컬렉션 김치톡톡"
    case ssamjangAndBraisedPorkBelly = "[삼겹살데이] 맛있는 삼겹살 더 맛있게 먹는 방법, 쌈장삼겹조림"
    case springWinterFreshKimchi = "빠르게 만들수록 맛있는 새콤달콜 봄동겉절이"
    case porkAndKimchiJjigae1 = "[만개백과] EP. 49 한국인이 사랑하는 돼지고기 김치찌개"
    case porkAndKimchiJjigae2 = "집밥백선생님의♥김치찌개"
    case jjageulTunaStew = "짜글짜글 소리가 맛깔나는구나! 짜글이참치찌개"
    case stirFriedRiceCake = "포장마차에서 그대로 가져온(듯한) 떡볶이"
    case beanCurdWithStirFriedKimchiAndSeafood = "통통한 해물과 김치의 환상조화! 해물두부김치"
    case steakRisotto = "스테이크 올라간 로제리조또, 연말 연인에게 꼭 해주세요. 스테이크 리조또"
    case grilledCurryChickenSticks = "파티에 로스트치킨이 빠질 수 없지, 에어프라이어 카레닭봉구이"
    case rolledOmeletRice = "주먹밥 이렇게 해주면 아이들한테 인기만점, 달걀말이밥"
    case riceWithBraisedShortRibs = "갈비찜을 밥 위에 얹어주세요~ 내가 제일 좋아하는 갈비찜덮밥"
    case spicyPorkBellySoup = "저탄고지 다이어트 얼큰삼겹탕"
    case curryToast = "초초초간단 신세계 토스트, 카레토스트"
    case yeopgiTteokbokki = "배달시키기 전에 이거 안 보면 손해, 전자레인지엽떡"
    case riceWithChiliTunaMayo = "참치마요보다 맛있는 고추참치마요덮밥"
    case cheeseRice = "맛없을 수 없는 초간단 전자레인지 치즈밥"
    case beanSproutSalad = "간단하게 만드는 콩나물무침"
    case cornCheeseTteokbokki = "떡볶이 속에 빠진 콘치즈, 콘치즈떡볶이"
    
    var description: String {
        switch self {
        case .sweetPotatoCreamCheeseGratin: "고구마크림치즈그라탕"
        case .eggplantPuffles: "가지부침개"
        case .grilledBasilTomatoChickenBreast: "바질토마토 닭가슴살구이"
        case .cabbageSaladBread: "양배추샐러드빵"
        case .tofuPizza: "두부피자"
        case .cellophaneNoodlesStew: "당면찌개"
        case .spamDoenjang: "스팸강된장"
        case .chickenSteak: "닭고기 스테이크"
        case .spamKimchiFriedSushi: "스팸김치 유부초밥"
        case .seafoodBasilPasta: "해산물 바질파스타"
        case .springOnionPancakeWithWaterParsley: "미나리쪽파전"
        case .stirFriedSquid: "오징어볶음"
        case .stirFriedPorkKimbap: "제육김밥"
        case .eggRice: "계란밥"
        case .riceWithPorkBellyAndSoySauce: "삼겹살간장덮밥"
        case .seasonedRedBeanPasteSauce: "취나물된장무침"
        case .stirFriedSquidNoodleSoup: "오징어볶음칼국수"
        case .smokedDuckJell: "훈제오리주물럭"
        case .kimchiFriedRice: "김치볶음밥"
        case .kimchiPilaf: "김치필라프"
        case .ssamjangAndBraisedPorkBelly: "쌈장삼겹조림"
        case .springWinterFreshKimchi: "봄동겉절이"
        case .porkAndKimchiJjigae1: "돼지고기김치찌개"
        case .porkAndKimchiJjigae2: "돼지고기김치찌개(집밥 백선생)"
        case .jjageulTunaStew: "짜글이참치찌개"
        case .stirFriedRiceCake: "포장마차 떡볶이"
        case .beanCurdWithStirFriedKimchiAndSeafood: "해물두부김치"
        case .steakRisotto: "스테이크 리조또"
        case .grilledCurryChickenSticks: "카레닭봉구이"
        case .rolledOmeletRice: "달걀말이밥"
        case .riceWithBraisedShortRibs: "갈비찜덮밥"
        case .spicyPorkBellySoup: "얼큰삼겹탕"
        case .curryToast: "카레토스트"
        case .yeopgiTteokbokki: "전자레인지 엽기떡볶이"
        case .riceWithChiliTunaMayo: "고추참치마요덮밥"
        case .cheeseRice: "치즈밥"
        case .beanSproutSalad: "콩나물무침"
        case .cornCheeseTteokbokki: "콘치즈떡볶이"
        }
    }
}

enum Seasoning: String, CustomStringConvertible {
    case salt = "소금"
    case grosSel = "굵은 소금"
    case refinedSalt = "가는 소금"
    case groundSesameMixedWithSalt = "깨소금"
    
    case sugar = "설탕"
    case honey = "꿀"
    case yolidang = "요리당"
    case oligosaccharide = "올리고당"
    case starchSyrup = "물엿"
    
    case cookingWine = "맛술"
    case cheongju = "청주"
    
    case soupSoy = "국간장"
    case thickSoy = "진간장"
    case fermentedSoySauce = "양조간장"
    case soy = "간장"
    
    case beefDashida = "소고기다시다"
    case dashida = "다시다"
    case saltedShrimp = "새우젓"
    case anchovyKelpPack = "멸치다시팩"
    case saltedAnchovies = "멸치액젓"
    case tunaLiquid = "참치액"
    case aekjeot = "액젓"
    case plumLiquid = "매실액"
    
    case cookingOil = "식용유"
    case oliveOil1 = "올리브유"
    case oliveOil2 = "올리브오일"
    case sesameOil = "참기름"
    case perillaOil = "들기름"

    case dryBisil = "건 바질"
    case bisil1 = "생바질"
    case bisil2 = "생 바질"
    case bisilPowder = "바질가루"
    
    case crushedGarlic1 = "다진 마늘"
    case crushedGarlic2 = "다진마늘"
    case groundGarlic = "간마늘"
    case mincedGinger1 = "다진생강"
    case mincedGinger2 = "다진 생강"
    
    case limeJuice = "라임즙"
    case wholeGrainMustard1 = "홀그레인 머스터드"
    case wholeGrainMustard2 = "홀그레인머스터드"
    case whiteWineVinegar = "화이트 와인 식초"
    case vinegar = "식초"
    
    case pepper = "후추"
    case pepperPowder1 = "후춧가루"
    case pepperPowder2 = "후추가루"
    
    case soybeanPaste = "된장"
    case chiliPepperPaste = "고추장"
    case chiliPowder1 = "고추가루"
    case chiliPowder2 = "고춧가루"
    case fineChiliPowder1 = "고운 고춧가루"
    case fineChiliPowder2 = "고운고춧가루"
    case thickChiliPowder1 = "굵은 고춧가루"
    case thickChiliPowder2 = "굵은고춧가루"
    
    case curryPowder1 = "카레가루"
    case curryPowder2 = "인스턴트 카레"
    
    case mayonnaise = "마요네즈"
    case butter = "버터"
    case srirachaSauce1 = "스리라차 소스"
    case srirachaSauce2 = "스리라차소스"
    case tomatoSauce1 = "토마토 소스"
    case tomatoSauce2 = "토마토소스"
    case tomatoPastaSauce = "토마토파스타소스"
    case kecap = "케찹"
    case mustard = "머스타드"
    
    case oysterSauce = "굴소스"
    case chickenStock = "치킨스톡"
    
    var description: String {
        switch self {
        case .salt: "소금"
        case .grosSel: "굵은 소금"
        case .refinedSalt: "가는 소금"
        case .groundSesameMixedWithSalt: "깨소금"
        
        case .sugar: "설탕"
        case .honey: "꿀"
        case .yolidang: "요리당"
        case .oligosaccharide: "올리고당"
        case .starchSyrup: "물엿"
        
        case .cookingWine: "맛술"
        case .cheongju: "청주"
        
        case .soupSoy: "국간장"
        case .thickSoy: "진간장"
        case .fermentedSoySauce: "양조간장"
        case .soy: "간장"
        
        case .beefDashida: "소고기다시다"
        case .dashida: "다시다"
            
        case .saltedShrimp: "새우젓"
        case .anchovyKelpPack: "멸치다시팩"
        case .saltedAnchovies: "멸치액젓"
        case .tunaLiquid: "참치액"
        case .aekjeot: "액젓"
        case .plumLiquid: "매실액"
        
        case .cookingOil: "식용유"
        case .oliveOil1, .oliveOil2: "올리브유"
        case .sesameOil: "참기름"
        case .perillaOil: "들기름"

        case .dryBisil: "건 바질"
        case .bisil1, .bisil2: "생 바질"
        case .bisilPowder: "바질가루"
        case .crushedGarlic1, .crushedGarlic2: "다진 마늘"
        case .groundGarlic: "간마늘"
        case .mincedGinger1, .mincedGinger2: "다진 생강"
            
        case .limeJuice: "라임즙"
        case .wholeGrainMustard1, .wholeGrainMustard2: "홀그레인 머스터드"
        case .whiteWineVinegar: "화이트 와인 식초"
        case .vinegar: "식초"
        
        case .pepper: "후추"
        case .pepperPowder1, .pepperPowder2: "후춧가루"
            
        case .soybeanPaste: "된장"
        case .chiliPepperPaste: "고추장"
        case .chiliPowder1, .chiliPowder2: "고추가루"
        case .fineChiliPowder1, .fineChiliPowder2: "고운 고춧가루"
        case .thickChiliPowder1, .thickChiliPowder2: "굵은 고춧가루"
        case .curryPowder1, .curryPowder2: "카레가루"
             
        case .mayonnaise: "마요네즈"
        case .butter: "버터"
        case .srirachaSauce1, .srirachaSauce2: "스리라차 소스"
        case .tomatoSauce1, .tomatoSauce2: "토마토 소스"
        case .tomatoPastaSauce: "토마토파스타소스"
        case .kecap: "케찹"
        case .mustard: "머스타드"
            
        case .oysterSauce: "굴소스"
        case .chickenStock: "치킨스톡"
        }
    }
}
