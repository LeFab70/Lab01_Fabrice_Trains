//
//  TaxiFareMultiMultiModels.swift
//  Lab01_Fabrice_Trains
//
//  Created by Fabrice Kouonang on 2025-07-14.
//

import Foundation
import CoreML
import Observation

@Observable
class TaxiFareMultiMultiModels  {
    
    var fare:Double = 0
    var tip:Int64 = 0
    var miscellaneousFees:Double = 0
    var predictedPrice:Double?
    private var model:TaxiFareMulti?
    init(){
        do {
            model = try TaxiFareMulti(configuration: .init())
        } catch {
            print("Error loading model: \(error)")
        }
    }
    
    func predictPrice(){
        guard let model = model else { return }
       
        do {
            let input = TaxiFareMultiInput(fare: fare, tip: tip, miscellaneous_fees: miscellaneousFees)
            let prediction = try model.prediction(input: input)
            self.predictedPrice = prediction.total_fare
        } catch {
            print("Error predicting: \(error)")
        }
    }
    
    
}
