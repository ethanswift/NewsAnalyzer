//
//  Doc.swift
//  Objectify
//
//  Created by ehsan sat on 4/22/20.
//  Copyright © 2020 ehsan sat. All rights reserved.
//

import Foundation

class Doc {
    var docSentimentPolarity: String = ""
    var docSentimentResultString: String = ""
    var docSentimentValue: Double = 0.0
    var subjectivity: String = ""
    var magnitude: Double = 0.0
    init(docSentimentPolarity: String, docSentimentResultString: String, docSentimentValue: Double, subjectivity: String, magnitude: Double) {
        self.docSentimentPolarity = docSentimentPolarity
        self.docSentimentResultString = docSentimentResultString
        self.docSentimentValue = docSentimentValue
        self.subjectivity = subjectivity
        self.magnitude = magnitude
    }
}
