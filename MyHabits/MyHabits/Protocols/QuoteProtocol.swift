//
//  QuoteProtocol.swift
//  MyHabits
//
//  Created by Александр Глазков on 09.03.2021.
//

protocol QuoteProtocol: AnyObject {
    func startLoadQuote(interval: Double, completion: @escaping (String?, String?) -> Void)
    func stopLoadQuote() -> Void
}
