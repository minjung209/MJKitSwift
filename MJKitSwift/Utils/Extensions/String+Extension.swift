//
//  String+Extension.swift
//  SwiftInternalDB
//
//  Created by MJ on 12/04/2019.
//  Copyright © 2019 MJ. All rights reserved.
//

import UIKit

enum FormatName {
	
	case FM_YYYYMMDD
	case FM_YYYYMMDD_INDOT
	case FM_YYYYMMDD_INBAR
	case FM_YYYYMMDD_SLASH
	case FM_YYYYMMDD_KORLANG
	case FM_YYYYMM
	case FM_YYYYMM_INDOT
	case FM_YYYYMM_INBAR
	case FM_YYYYMM_SLASH
	case FM_YYYYMM_KORLANG
	case FM_MMDD
	case FM_MMDD_SLASH
	case FM_YYYYMMDD_HHMMSS
	case FM_YYYYMMDDHHMMSS
}

extension String {
	
	func search(of target: String) -> Range<Index>? {
		// 찾는 결과는 `leftIndex`와 `rightIndex`사이에 들어가게 된다.
		var leftIndex = startIndex
		while true {
			// 우선 `leftIndex`의 글자가 찾고자하는 target의 첫글자와 일치하는 곳까지 커서를 전진한다.
			guard self[leftIndex] == target[target.startIndex] else {
				leftIndex = index(after:leftIndex)
				if leftIndex >= endIndex { return nil }
				continue
			}
			// `leftIndex`의 글자가 일치하는 곳이후부터 `rightIndex`를 늘려가면서 일치여부를 찾는다.
			var rightIndex = index(after:leftIndex)
			var targetIndex = target.index(after:target.startIndex)
			while self[rightIndex] == target[targetIndex] {
				// target의 전체 구간이 일치함이 확인되는 경우
				guard distance(from:leftIndex, to:rightIndex) < target.characters.count - 1
					else {
						return leftIndex..<index(after:rightIndex)
				}
				rightIndex = index(after:rightIndex)
				targetIndex = target.index(after:targetIndex)
				// 만약 일치한 구간을 찾지못하고 범위를 벗어나는 경우
				if rightIndex >= endIndex {
					return nil
				}
				
			}
			leftIndex = index(after:leftIndex)
		}
	}
	
	static func stringByDateFormat(_ date:Date, changeFM stFormat:FormatName) -> String {
		
		var setF:String = ""
		let checkFormat:FormatName = stFormat
		
		switch checkFormat {
		case .FM_YYYYMMDD:
			setF = "yyyyMMdd"
			break
		case .FM_YYYYMMDD_INDOT:
			setF = "yyyy.MM.dd"
			break
		case .FM_YYYYMMDD_INBAR:
			setF = "yyyy-MM-dd"
			break
		case .FM_YYYYMMDD_SLASH:
			setF = "yyyy/MM/dd"
			break
		case .FM_YYYYMMDD_KORLANG:
			setF = "yyyy년MM월dd일"
			break
		case .FM_YYYYMM:
			setF = "yyyyMM"
			break
		case .FM_YYYYMM_INDOT:
			setF = "yyyy.MM"
			break
		case .FM_YYYYMM_INBAR:
			setF = "yyyy-MM"
			break
		case .FM_YYYYMM_SLASH:
			setF = "yyyy/MM"
			break
		case .FM_YYYYMM_KORLANG:
			setF = "yyyy년 MM월"
			break
		case .FM_MMDD:
			setF = "MMdd"
			break
		case .FM_MMDD_SLASH:
			setF = "MM/dd"
			break
		case .FM_YYYYMMDD_HHMMSS:
			setF = "yyyy-MM-dd HH:mm:ss"
			break
		case .FM_YYYYMMDDHHMMSS:
			setF = "yyyyMMddHHmmss"
			break
		}
		
		let format:DateFormatter = DateFormatter.init()
		format.dateFormat = setF
		format.timeZone = TimeZone.init(identifier: "Asia/Seoul")
		
		let resultDate:String = format.string(from: date)

		return resultDate
	}
	
	
	/// @brief : 입력한 문자를 원하는 날짜 포맷을 적용한 문자로 변환해주는 메소드입니다.
	/// - Parameters:
	///   - date: String으로 변환하려는 날짜
	///   - stFormat: 날짜 포맷
	/// - Returns: 날짜 포맷을 적용한 문자
	static func stringByCustomDateFormat(_ date:Date, changeFM stFormat:String) -> String {

		let format:DateFormatter = DateFormatter.init()
		format.dateFormat = stFormat
		format.timeZone = TimeZone.init(identifier: "Asia/Seoul")
		let resultDate:String = format.string(from: date)
		return resultDate
	}
	
	
	//----------------------------//
	//MARK: - 정규식 표현
	//----------------------------//
	
	/// 입력한 스트링이 이메일 형식인지 아닌지 판별해주는 메소드 입니다.
	func isValidEmailAddress() -> Bool {
		
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}" //이메일을 검증하는 정규 표현식
		let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: self)
	}
	
	// 이메일 정규식2 ( @.패턴 )
	func isValidateEmail() -> Bool {
		let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
		let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return predicate.evaluate(with: self)
	}
	
	
	//	 패스워드 정규식 (최소 8자이상 15자 이하, 영문 + 숫자 조합인지 검증)
    func isValidatePassword() -> Bool {
//        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,15}$" //최소 8자이상 15자 이하, 대문자, 소문자, 숫자 조합인지 검증)
		let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9]).{8,15}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
		let resultValue:Bool = predicate.evaluate(with: self)
        return resultValue
    }
	
	// 이름 정규식 (영문, 한글 입력 가능하며 1~20자 까지 입력 가능)
	func isVaildateName() -> Bool {
		
		let nameRegEx = "[A-Za-zㄱ-ㅎㅏ-ㅣ가-힣0-9]{1,20}" //이름은 영문, 한글 1~20자 내외
		let predicate = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
		let resultValue:Bool = predicate.evaluate(with: self)
		return resultValue
		
	}

}
