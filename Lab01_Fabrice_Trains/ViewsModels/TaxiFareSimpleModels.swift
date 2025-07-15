//
//  TaxiFareSimpleModels.swift
//  Lab01_Fabrice_Trains
//
//  Created by Fabrice Kouonang on 2025-07-14.
//
import Foundation
import CoreML
import Observation
@Observable
class TaxiFareSimpleModels{
    var fare: Double=0
    var predictedPrice: Double?
    private var model: TaxiFareSimple?
    init(){
        do {
            self.model = try TaxiFareSimple(configuration: .init())
        }
        catch {
            print("Error loading model: \(error)")
        }
    }
    func predictPrice() {
        guard let model = model else { return }
        
        do {
            let input=TaxiFareSimpleInput(fare:fare)
            let prediction = try model.prediction(input: input)
            self.predictedPrice = prediction.total_fare
        }
            catch {
                print("Error predicting: \(error)")
        }
    }
}

